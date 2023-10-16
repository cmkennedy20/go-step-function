resource "aws_security_group" "ec2_security_group" {
  name        = "ec2-security-group"
  description = "Allow incoming connections to EC2"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "alb_security_group" {
  name        = "alb-security-group"
  description = "Allow incoming connections to ALB"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "ado_sg" {
  name        = "ado-sg"
  description = "Security group allowing outbound access to the Azure DevOps REST API"
  vpc_id      = var.vpc_id
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["13.107.6.0/24", "13.107.9.0/24", "13.107.42.0/24", "13.107.43.0/24"]
  }
}

output "sg_ec2" {
  value       = [aws_security_group.ec2_security_group.id]
  description = "Security group for ec2"
}

output "sg_alb" {
  value       = [aws_security_group.alb_security_group.id]
  description = "Security group for ALB"
}

output "sg_ado_outbound" {
  value       = aws_security_group.ado_sg.id
  description = "Security group for outbound connections to ADO"
}