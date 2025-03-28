terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "0.98.0"
    }
  }
}

provider "snowflake" {
  role = "SYSADMIN"
#  account_name = "HMSANALYTICAL_PARTNER"
#  organization_name = "A4293653100271"
}
