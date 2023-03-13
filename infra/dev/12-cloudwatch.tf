#CloudWatch log group
resource "aws_cloudwatch_log_group" "log_group" {
  name = var.cw_log_group_name
}

#CloudWatch log stream
resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = var.cw_log_stream_name
  log_group_name = aws_cloudwatch_log_group.log_group.name
}

resource "aws_s3_bucket" "logging_bucket" {
  bucket = "my-logging-bucket"
}

