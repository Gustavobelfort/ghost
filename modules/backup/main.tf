#Create a s3 bucket with lifecycle policy to store the ghost periodic backups
resource "aws_s3_bucket" "versioning_bucket" {
  bucket = var.backup_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    prefix  = "${var.backup_folder}/"
    enabled = true

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = 60
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = 90
    }
  }
}

resource "aws_iam_policy" "backup_policy" {
  path        = "/"
  description = "Allow"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:ListBucket"
          ],
          "Resource" : [
            "arn:aws:s3:::${var.backup_bucket_name}"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:PutObject",
            "s3:GetObject",
            "s3:DeleteObject"
          ],
          "Resource" : [
            "arn:aws:s3:::${var.backup_bucket_name}/*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "ses:*",
          "Resource" : "*"
        }
      ]
  })
}

resource "aws_iam_role" "backup_iam_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backup_policy_attachment" {
  role       = aws_iam_role.backup_iam_role.name
  policy_arn = aws_iam_policy.backup_policy.arn
}

resource "aws_iam_instance_profile" "backup_profile" {
  role = aws_iam_role.backup_iam_role.name
}
