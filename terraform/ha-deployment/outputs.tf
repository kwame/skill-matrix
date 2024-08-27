output "vpc_id" {
  value = aws_vpc.main.id
}

output "jumpbox_public_ip" {
  value = aws_instance.jumpbox.public_ip
}

output "load_balancer_dns" {
  value = aws_lb.app_lb.dns_name
}

