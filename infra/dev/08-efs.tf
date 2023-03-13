# EFS File System
resource "aws_efs_file_system" "efs" {
  creation_token = "ghost-blog-efs"

  tags = {
    Name = "ghost-blog-efs"
  }
}

# EFS Mount Targets
resource "aws_efs_mount_target" "mount_target" {
  for_each = toset(var.subnet_ids)

  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = each.key
  security_groups = [
    aws_security_group.sg_ecs.id,
    aws_security_group.sg_alb.id,
    aws_security_group.sg_ec2.id,
  ]
}