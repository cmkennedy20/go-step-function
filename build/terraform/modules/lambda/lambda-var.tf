variable "lambda_iam" {
  type        = string
  description = "ARN of the Lambda IAM role"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet's to run the Lambda's on"
}

variable "sg_outbound" {
  type        = string
  description = "Outbound SG"
}
