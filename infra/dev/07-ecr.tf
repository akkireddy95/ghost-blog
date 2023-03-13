# ECR repository for the Ghost blog Docker image
resource "aws_ecr_repository" "ghost_blog" {
  name = var.ecr_repository_name
}

# Allow ECS service security group to access the ECR repository
resource "aws_ecr_repository_policy" "ghost_blog_access_policy" {
  repository = aws_ecr_repository.ghost_blog.name

  count = length(var.ecs_security_group_ingress_rules)

  policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = var.allowed_ecr_actions
      },
      {
        Effect = "Allow",
        Principal = {
          AWS = "*"
        },
        Action = [
          "ecr:PutImage"
        ],
        Condition = {
          StringEquals = {
            "aws:SourceVpc" : aws_vpc.vpc.id
          }
        }
      },
      {
        Effect = "Allow",
        Principal = {
          AWS = "*"
        },
        Action = [
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        Condition = {
          StringEquals = {
            "aws:SourceVpc" : aws_vpc.vpc.id,
            "aws:SourceSecurityGroup" : aws_security_group.ecs_service_security_group[count.index].id
          }
        }
      }
    ]
  })
}

# Add ECS service security group to the ECR repository access policy
resource "null_resource" "ecs_service_security_group" {
  depends_on = [
    aws_security_group.ecs_service_security_group
  ]

  provisioner "local-exec" {
    command = <<EOT
      aws ecr set-repository-policy \
        --repository ${aws_ecr_repository.ghost_blog.name} \
        --policy-text '${aws_ecr_repository_policy.ghost_blog_access_policy.*.policy}'
    EOT
  }
}
