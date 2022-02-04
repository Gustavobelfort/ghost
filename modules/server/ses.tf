# Creates an identity for the sender email
resource "aws_ses_email_identity" "sender" {
  email = var.sender_email
}

# Creates an identity for the recipient email
resource "aws_ses_email_identity" "recipient" {
  email = var.recipient_email
}
