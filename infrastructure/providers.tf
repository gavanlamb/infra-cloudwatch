provider "aws" {
  region  = var.region
  
  default_tags {
    tags = {
      Application = "Expensely"
      Team = "Expensely Core"
      ManagedBy = "Terraform"
      Environment = var.environment
    }
  }
}
