variable "provider_role_arn" {
  type = string
}

provider "aws" {
  region  = var.region
  assume_role {
    role_arn = var.provider_role_arn
  }
  
  default_tags {
    tags = {
      Application = "Expensely"
      Team = "Expensely Core"
      ManagedBy = "Terraform"
      Environment = var.environment
    }
  }
}
