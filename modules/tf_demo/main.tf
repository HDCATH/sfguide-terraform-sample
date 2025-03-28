# The terraform_schema is intended exclusively for Terraform development and testing purposes.

# Schema Definition
resource "snowflake_schema" "tf_demo" {
  database = var.db_name
  name = var.schema_name
  is_transient = false
  with_managed_access = true
  data_retention_time_in_days = 7
}

# Schema Berechtigungen
resource "snowflake_grant_privileges_to_account_role" "schema_usage" {
  for_each = toset([
    "KFSWE_PARTICIPANT",
    "TF_DEMO_SVC_ROLE"
  ])
  account_role_name = each.value
  privileges = ["USAGE"]
  on_schema {
    schema_name = "${snowflake_schema.tf_demo.database}.${snowflake_schema.tf_demo.name}" # note this is a fully qualified name!
  }
}

# Grant on all existing tables in schema 
resource "snowflake_grant_privileges_to_account_role" "schema_all_tables" {
  for_each = toset([
    "KFSWE_PARTICIPANT",
    "TF_DEMO_SVC_ROLE"
  ])
  account_role_name = each.value
  privileges = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE"]
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema = "${snowflake_schema.tf_demo.database}.${snowflake_schema.tf_demo.name}"  # note this is a fully qualified name!
    }
  }
}


resource "snowflake_grant_privileges_to_account_role" "schema_create_table" {
  for_each = toset([
    "KFSWE_PARTICIPANT",
    "TF_DEMO_SVC_ROLE"
  ])
  account_role_name = each.value
  privileges = ["CREATE TABLE"]
  on_schema {
    schema_name = "${snowflake_schema.tf_demo.database}.${snowflake_schema.tf_demo.name}" # note this is a fully qualified name!
  }
}


# Grant on all future tables in schema
resource "snowflake_grant_privileges_to_account_role" "schema_future_tables" {
  for_each = toset([
   "KFSWE_PARTICIPANT",
    "TF_DEMO_SVC_ROLE"
  ])
  account_role_name = each.value
  privileges = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE"]
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema = "${snowflake_schema.tf_demo.database}.${snowflake_schema.tf_demo.name}" # note this is a fully qualified name!
    }
  }
}
