﻿terraform {
  required_version = ">=1.2.5"
  backend "s3" { }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.31.0"
    }
  }
}
