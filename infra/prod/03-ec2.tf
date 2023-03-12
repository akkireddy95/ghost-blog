# EC2 Instances
resource "aws_instance" "ecs_instance" {
  count         = var.ecs_instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = element(var.subnet_ids, count.index % length(var.subnet_ids))

  # Attach to ECS Cluster
  tags = {
    Name = "${var.ecs_cluster_name}-instance-${count.index + 1}"
  }

  # Associate with ALB Target Group
  lifecycle {
    create_before_destroy = true
  }

  # ECS Agent Configuration
  user_data = <<-EOF
              #!/bin/bash
              echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config
              EOF

  # Attach Security Group
  vpc_security_group_ids = var.security_group_ids

  # Allow inbound traffic from ALB
  provisioner "remote-exec" {
    inline = [
      "sudo iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT",
      "sudo iptables -A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT",
      "sudo iptables-save | sudo tee /etc/sysconfig/iptables"
    ]
  }
}

# Output
output "ecs_instance_public_ip" {
  value = aws_instance.ecs_instance.*.public_ip
}
