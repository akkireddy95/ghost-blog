resource "aws_s3_bucket" "ghost_blog_bucket" {
  bucket = "ghost-blog-bucket"

  tags = {
    Name        = "Ghost Blog Bucket"
    Environment = "dev"
  }
}

resource "aws_iam_user" "ghost_blog_user" {
  name = "ghost-blog-user"
}

resource "aws_s3_bucket_policy" "ghost_blog_bucket_policy" {
  bucket = aws_s3_bucket.ghost_blog_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "GrantFullAccessToGhostBlogUser"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_user.ghost_blog_user.arn
        }
        Action   = "s3:*"
        Resource = "${aws_s3_bucket.ghost_blog_bucket.arn}/*"
      }
    ]
  })
}
