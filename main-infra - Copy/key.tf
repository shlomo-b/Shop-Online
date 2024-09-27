#---------------key_pair-------------------#

# create key_pair with private key and public_key

resource "aws_key_pair" "TF-key" {
  key_name   = "TF-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "TF-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "TFkey"

}
