//terraform init
//terraform plan
//terraform apply
//terraform destroy
terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}
provider "cloudflare" {
  api_token = "lm1Zcp2vSFF8-sBrzY3V9rq7YOciwdD_hyHwS9zE"
}

data "cloudflare_zone" "this" {
  name = "dota2.pp.ua"
}


provider "aws" {
 region = "eu-north-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
resource "aws_instance" "nmd221" {
 availability_zone = "eu-north-1a"
 ami = "ami-0014ce3e52359afbd"
 instance_type = "t3.micro"
 key_name = "ubuntu"
 vpc_security_group_ids = [aws_security_group.default.id] 
 ebs_block_device {
   device_name = "/dev/sda1"
   volume_size = 8
   volume_type = "standard"
 }
 tags = {
    Name = "Apache-Server"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y docker.io
              sudo systemctl enable docker --now
              sudo usermod -aG docker $USER
              echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | \ sudo tee /etc/apt/sources.list.d/docker.list
              curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
              sudo apt install -y docker-ce docker-ce-cli containerd.io
              docker run -d -p 80:80 oksesaneka22/nginx:123
              EOF
}

resource "aws_security_group" "default" {
    ingress{
        description = "Allow ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        description = "allow 80"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}
resource "cloudflare_record" "foobar" {
  zone_id = data.cloudflare_zone.this.id
  name    = "@"
  value   = aws_instance.nmd221.public_ip
  type    = "A"
  proxied = true
}

output "record" {
  value = cloudflare_record.foobar.hostname
}

output "metadata" {
  value       = cloudflare_record.foobar.metadata
  sensitive   = true
}
