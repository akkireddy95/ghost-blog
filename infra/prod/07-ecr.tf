#ECR repository for the Ghost blog Docker image

resource "aws_ecr_repository" "ghost_blog" {
  name = "ghost-blog"
}

# Allow ECS service security group to access the ECR repository

resource "aws_ecr_repository_policy" "ghost_blog_access_policy" {
  repository = aws_ecr_repository.ghost_blog.name

  policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ]
      }
    ]
  })
}

# Add ECS service security group to the ECR repository access policy

data "aws_security_group" "ecs_service_security_group" {
  name_prefix = var.ecs_service_security_group_name_prefix
}

resource "aws_ecr_repository_policy" "ghost_blog_access_policy_sg" {
  repository = aws_ecr_repository.ghost_blog.name

  policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
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
            "aws:SourceVpc": aws_vpc.vpc.id
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
            "aws:SourceVpc": aws_vpc.vpc.id,
            "aws:SourceSecurityGroup": data.aws_security_group.ecs_service_security_group.id
          }
        }
      }
    ]
  })
}
