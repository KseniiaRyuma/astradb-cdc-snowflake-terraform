
terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.35"
    }
    astra = {
      source = "datastax/astra"
      version = "2.1.0-rc9"
    }
  }
}

provider "astra" {
  // This can also be set via ASTRA_API_TOKEN environment variable.
  token = var.ASTRA_API_TOKEN
}

provider "snowflake" {
  alias = "sys_admin"
  role  = "ACCOUNTADMIN"
  username = var.SNOWFLAKE_USER
  account = var.SNOWFLAKE_ACCOUNT
  password = var.SNOWFLAKE_PASSWORD
  region = var.SNOWFLAKE_REGION
}

