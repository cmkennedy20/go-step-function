# Create the zip file

locals {
  remove_agent_path     = "/opt/lambda_home/remove-agent.zip"
  instance_refresh_path = "/opt/lambda_home/instance-refresh.zip"
}

# Create the Lambda function
resource "aws_lambda_function" "remove_agent_lambda" {
  function_name    = "remove-agents-function"
  runtime          = "nodejs18.x"
  handler          = "index.handler"
  filename         = local.remove_agent_path
  source_code_hash = filebase64sha256(local.remove_agent_path)
  role             = var.lambda_iam
  environment {
    variables = {

    }
  }
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.sg_outbound]
  }
}

# resource "aws_cloudwatch_log_group" "instance_refresh_log_group" {
#   name = "/aws/lambda/instance_refresh_lambda"
#   retention_in_days = 7  # Or your desired retention period
# }

# resource "aws_cloudwatch_log_group" "remove_agent_log_group" {
#   name = "/aws/lambda/remove_agent_lambda"
#   retention_in_days = 7  # Or your desired retention period
# }

# resource "aws_cloudwatch_log_subscription_filter" "instance_refresh_filter" {
#   name            = "instance-refresh-filter"
#   log_group_name = aws_cloudwatch_log_group.instance_refresh_log_group.name
#   filter_pattern = ""  # You can define a filter pattern if needed
#   depends_on = [ aws_cloudwatch_log_group.instance_refresh_log_group ]
#   destination_arn = aws_lambda_function.instance_refresh_lambda.arn
# }

# resource "aws_cloudwatch_log_subscription_filter" "remove_agent_filter" {
#   name            = "remove-agent-filter"
#   log_group_name = aws_cloudwatch_log_group.remove_agent_log_group.name
#   filter_pattern = ""  # You can define a filter pattern if needed
#   depends_on = [ aws_cloudwatch_log_group.remove_agent_log_group ]
#   destination_arn = aws_lambda_function.remove_agent_lambda.arn
# }
