#Automatic Server Build Script
locals {
  userDataScript = <<EOF
#cloud-config
system_info:
  default_user:
    name: ${var.sys_username}
repo_update: true
repo_upgrade: all
runcmd:
  - export PATH=$PATH:/usr/local/bin
  - apt-get update
  - whoami
  - apt-get upgrade -y
  - apt-get install nginx mysql-client-core-8.0 awscli -y
  - ufw allow 'Nginx Full'
  - curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash
  - apt-get install -y nodejs
  - npm install ghost-cli@latest -g
  - mkdir -p /var/www/${var.cf_zone}
  - chown ${var.sys_username}:${var.sys_username} /var/www/${var.cf_zone}
  - chmod 775 /var/www/${var.cf_zone}
  - sudo su ${var.sys_username} --command "cd /var/www/${var.cf_zone} && ghost install --url '${var.subdomain}.${var.cf_zone}' --sslemail '${var.ssl_email}' --db 'mysql' --dbhost '${var.db_host}' --dbuser 'root' --dbpass '${var.db_pass}' --dbname '${var.db_name}' --process systemd --no-prompt"
  - sudo su ${var.sys_username} --command "cd /var/www/${var.cf_zone} && ghost start"
  - sudo su ${var.sys_username} --command "crontab -l | { cat; echo "0 0 * * * /bin/bash /etc/backupScript.sh"; } | crontab -"
write_files:
  - content: |
      #!/bin/bash

      # Stop ghost for data integrity 
      cd /var/www/${var.cf_zone} && ghost stop

      function packageGhostBackupData {
        cp -rp /var/www/${var.cf_zone}/content/ /home/${var.sys_username}/${var.backup_folder}/
        cp -rp /var/www/${var.cf_zone}/config.production.json /home/${var.sys_username}/${var.backup_folder}/
        mysqldump --column-statistics=0 -h ${var.db_host} -u root ${var.db_name} -p${var.db_pass} > /home/${var.sys_username}/${var.backup_folder}/${var.db_name}.sql
        tar -zcvpf blog_backup.tar.gz /home/${var.sys_username}/${var.backup_folder}
      }

      function createRawEmail {
        # Create message
        echo '{"Data": "From:'${var.sender_email}'\nTo:'${var.recipient_email}'\nSubject:'Daily Log Summary from Ghost'\nMIME-Version: 1.0\nContent-type: Multipart/Mixed; boundary=\"NextPart\"\n\n--NextPart\nContent-Type: text/plain\n\n['Follows as an attachment the summary of Ghost logs for the day']\n\n--NextPart\nContent-Type:'${var.attachment_type}';\nContent-Disposition: attachment; filename=\"'logs.log'\";\nContent-Transfer-Encoding: base64\n\n'$(cat /var/www/${var.cf_zone}/content/logs/${var.log_file_name} | base64 )'\n--NextPart--"}' > message.json
      }

      packageGhostBackupData
      createRawEmail

      # Send email
      aws ses send-raw-email --region us-east-2 --raw-message file://message.json
      
      # Upload backup file
      aws s3 cp /home/${var.sys_username}/${var.backup_folder}/blog_backup.tar.gz s3://${var.backup_bucket_name}/${var.backup_folder}/
      
      # Cleanup files generated in the process
      rm blog_backup.tar.gz
      cd /home/${var.sys_username}/${var.backup_folder}/
      rm -rf *

      # Start ghost again
      cd /var/www/${var.cf_zone} && ghost start

    path: /etc/backupScript.sh
    permissions: '0755'
  - content: |
      /var/www/${var.cf_zone}/content/logs/*.log {
        daily
        rotate 1
        compress
        copytruncate
      }
    path: /etc/logrotate.d/ghost
    permissions: '0755'
EOF
}
