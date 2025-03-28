variable db_name {
  description = "Name of the db to use"
  type        = string
}

variable schema_name {
    description = "Name of the schema to use"
    type = string
}

variable env_suffix {
    description = "Suffix that distinguishes between different environments. Can be used to build environment independent names."
    type = string
}

# Authentication and parametrising information
#user = "tec_product_scc_dev_tf"
#role = "product_scc_dev_admin"
#warehouse = "product_scc_dev_tiny"
#db_name = "TF_DEMO"
#env_suffix = "DEV"