locals {
  name_prefix                             = "${terraform.workspace}"
  split_domain                            = ["${split(".", var.ad_domain)}"]
  computers_ou                            = "${var.computers_ou == "" ? "OU=computers,OU=aws,DC=${local.split_domain[0]},DC=${local.split_domain[1]}" : var.computers_ou}"
  remove_chef_doc_name                    = "${local.name_prefix}-remove-chef-client"
  windows_domain_join_doc_name            = "${local.name_prefix}-windows-domain-join"
  enable_chef_doc_name_win                = "${local.name_prefix}-enable-chef-client-win"
  enable_chef_doc_name_tux                = "${local.name_prefix}-enable-chef-client-tux"
  install_scaleft_doc_name                = "${local.name_prefix}-install-scaleft"
  domain_join_account_location            = "${var.domain_join_account_location == "" ? "/${terraform.workspace}/bootstrap/service/auto_join_domain_account" : var.domain_join_account_location}"
  domain_join_password_location           = "${var.domain_join_password_location == "" ? "/${terraform.workspace}/bootstrap/service/auto_join_domain_password" : var.domain_join_password_location}"
  chef_client_version_location            = "${var.chef_client_version_location == "" ? "/${terraform.workspace}/bootstrap/chef/excp/client_version" : var.chef_client_version_location}"
  chef_org_location                       = "${var.chef_org_location == "" ? "/${terraform.workspace}/bootstrap/chef/excp/chef_org" : var.chef_org_location}"
  chef_data_token_location                = "${var.chef_data_token_location == "" ? "/${terraform.workspace}/bootstrap/chef/excp/data_token" : var.chef_data_token_location}"
  chef_automate_fqdn_location             = "${var.chef_automate_fqdn_location =="" ? "/${terraform.workspace}/bootstrap/chef/excp/automate_fqdn" : var.chef_automate_fqdn_location}"
  chef_server_fqdn_location               = "${var.chef_server_fqdn_location == "" ? "/${terraform.workspace}/bootstrap/chef/excp/server_fqdn" : var.chef_server_fqdn_location}"
  chef_validator_pem_location             = "${var.chef_validator_pem_location == "" ? "/${terraform.workspace}/bootstrap/chef/excp/validator_pem" : var.chef_validator_pem_location}"
  chef_encrypted_data_bag_secret_location = "${var.chef_encrypted_data_bag_secret_location == "" ? "/${terraform.workspace}/bootstrap/chef/excp/encrypted_data_bag_secret" : var.chef_encrypted_data_bag_secret_location}"

  #output_bucket_name = "${var.output_bucket_name == "" ? "${terraform.workspace}-ssm-doc-logs" : var.output_bucket_name}"
  output_bucket_name = "${var.output_bucket_name == "" ? "${var.ssm_doc_bucket_id}": var.output_bucket_name}"
}
