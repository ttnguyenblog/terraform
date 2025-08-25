provider "aws" {
  region = var.region

  assume_role {
    role_arn = var.role_arn
  }
  allowed_account_ids = var.allowed_account_ids
}


provider "aws" {
  region = var.region
  alias = "platform_account"
}