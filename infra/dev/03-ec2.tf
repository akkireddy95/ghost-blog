# EC2 Instances
resource "aws_instance" "ecs_instance" {
  for_each = var.ecs_instance_configurations

  ami           = each.value.ami_id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name
  subnet_id     = each.value.subnet_id

  # Attach to ECS Cluster
  tags = {
    Name = "${var.ecs_cluster_name}-instance-${each.key}"
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
  vpc_security_group_ids = each.value.security_group_ids

  # Allow inbound traffic from ALB
  provisioner "remote-exec" {
    inline = [
      "sudo iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT",
      "sudo iptables -A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT",
      "sudo iptables-save | sudo tee /etc/sysconfig/iptables"
    ]
  }
}
