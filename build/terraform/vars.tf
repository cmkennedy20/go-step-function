variable "TF_VAR_access_key" {
  type        = string
  description = "The AWS access key"
}

variable "TF_VAR_private_key" {
  type        = string
  description = "The AWS private key"
}

variable "TF_VAR_region" {
  type        = string
  description = "The AWS Region"
  default     = "us-east-1"
}

variable "TF_VAR_azs" {
  type        = list(string)
  description = "Availability Zones"
}

variable "TF_VAR_pat" {
  type        = string
  description = "PAT Token used to access ADO"
}

variable "TF_VAR_url" {
  type        = string
  description = "The URL to the ADO organization"
}

variable "TF_VAR_pool" {
  type        = string
  description = "The ADO build agent pool name"
}

variable "localstack" {
  type        = string
  description = "The localstack hostname"
}
