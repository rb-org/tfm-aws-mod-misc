variable "ad_domain" {
  default = "exactonline.local"
}

variable "computers_ou" {
  default = ""
}

variable "domain_join_account_location" {
  default = ""
}

variable "domain_join_password_location" {
  default = ""
}

variable "chef_client_version_location" {
  default = ""
}

variable "chef_org_location" {
  default = ""
}

variable "chef_data_token_location" {
  default = ""
}

variable "chef_automate_fqdn_location" {
  default = ""
}

variable "chef_server_fqdn_location" {
  default = ""
}

variable "chef_base_role" {
  default = "base"
}

variable "chef_validator_pem_location" {
  default = ""
}

variable "chef_encrypted_data_bag_secret_location" {
  default = ""
}

variable "output_bucket_name" {
  default = ""
}

variable "ssm_doc_bucket_id" {
  default = ""
}
