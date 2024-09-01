#---------------userdata-------------------#

variable "user_data_windows" {
  default = <<-EOF
    <powershell>
        # Create a new local user
        $username = "alina"
        $password = "0528508841qwe!@#"

        New-LocalUser -Name $username -Password (ConvertTo-SecureString -AsPlainText $password -Force)
         -PasswordNeverExpires $true -UserMayNotChangePassword $true -FullName "Example User" -Description "An example local user"

        # Add the user to the Administrators group
        Add-LocalGroupMember -Group "Administrators" -Member $username

        # Your additional PowerShell script or commands go here
        Install-WindowsFeature -Name Web-Server -IncludeManagementTools
    </powershell>
EOF
}

variable "user_data_linux" {
  default = <<-EOF
      #!/bin/bash
      yum update -y
      yum install httpd -y
      echo "Hello from linux IP: $(hostname -i)" > /var/www/html/index.html
      service httpd start
      systemctl restart httpd
    EOF
}

variable "ec2_s3_only" {
  default = <<-EOF
      #!/bin/bash
      mkdir -p /root/awsfolder/ && echo "Hello from S3"> /root/awsfolder/S3File.txt
      aws s3 cp /root/awsfolder s3://devsecops-shlomo-tf/ --region eu-central-1 --recursive
    EOF 
}


variable "asg_app" {
  default = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ec2-user

    cat <<EOFDockerfile > /root/Dockerfile
    FROM public.ecr.aws/amazonlinux/amazonlinux

    RUN yum update -y && \
        yum install -y httpd

    RUN echo "Hello from Container IP,:$(hostname -i)" > /var/www/html/index.html

    EXPOSE 80

    CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
    EOFDockerfile

    docker build -t web-server /root
    docker run -d -p 80:80 --name web-server web-server
    EOF
}

# variable "asg-game" {
#   default = <<-EOF
#     #!/bin/bash
#     yum update -y
#     yum install -y docker
#     systemctl start docker
#     systemctl enable docker
#     usermod -aG docker ec2-user

#     docker pull shlomobarzili/blackjack:latest /root
#     docker run -d -p 80:80 shlomobarzili/blackjack:latest
#     EOF
# }

variable "asg-game" {
  default = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ec2-user

    # pull and run he most recent image from docker hub.
    # docker pull shlomobarzili/blackjack:$(curl -s https://hub.docker.com/v2/repositories/shlomobarzili/blackjack/tags/?page_size=1 | grep -oP '"name":\s*"\K[^"]+')
    # docker run -d -p 80:80 shlomobarzili/blackjack:$(curl -s https://hub.docker.com/v2/repositories/shlomobarzili/blackjack/tags/?page_size=1 | grep -oP '"name":\s*"\K[^"]+')

    docker pull shlomobarzili/blackjack:latest
    docker run -d -p 80:80 shlomobarzili/blackjack:latest
    EOF
}
