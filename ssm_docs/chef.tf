##################
# Remove Chef
##################
resource "aws_ssm_document" "remove_chef" {
  name          = "${local.remove_chef_doc_name}"
  document_type = "Command"
  content       = "${file("${path.module}/files/remove_chef.json")}"
}

#######################
# Enable Chef - Windows
#######################
data "template_file" "enable_chef_win" {
  template = "${file("${path.module}/files/enable_chef_win.json.tpl")}"

  vars {
    chef_client_version            = "${local.chef_client_version_location}"
    chef_org                       = "${local.chef_org_location}"
    data_token                     = "${local.chef_data_token_location}"
    chef_automate_fqdn             = "${local.chef_automate_fqdn_location}"
    chef_server_fqdn               = "${local.chef_server_fqdn_location}"
    chef_base_role                 = "${var.chef_base_role}"
    chef_validator_pem             = "${local.chef_validator_pem_location}"
    chef_encrypted_data_bag_secret = "${local.chef_encrypted_data_bag_secret_location}"
    username                       = "${data.aws_ssm_parameter.domain_join_account.value}"
    password                       = "${data.aws_ssm_parameter.domain_join_password.value}"
    computers_ou                   = "${local.computers_ou}"
    domain                         = "${var.ad_domain}"
  }
}

resource "aws_ssm_document" "enable_chef_win" {
  name            = "${local.enable_chef_doc_name_win}"
  document_type   = "Command"
  content         = "${data.template_file.enable_chef_win.rendered}"
  document_format = "JSON"
}

resource "aws_ssm_association" "enable_chef_win" {
  name                = "${aws_ssm_document.enable_chef_win.name}"
  association_name    = "InstallChefClientWindows"
  schedule_expression = "cron(0 0 12 ? * * *)"

  targets = [{
    key    = "tag:ChefEnabled"
    values = ["true"]
  }]

  output_location {
    s3_bucket_name = "${local.output_bucket_name}"
    s3_key_prefix  = "chef-install"
  }
}

#######################
# Enable Chef - Linux
#######################
data "template_file" "enable_chef_tux" {
  template = "${file("${path.module}/files/enable_chef_tux.json.tpl")}"

  vars {
    chef_client_version            = "${local.chef_client_version_location}"
    chef_org                       = "${local.chef_org_location}"
    data_token                     = "${local.chef_data_token_location}"
    chef_automate_fqdn             = "${local.chef_automate_fqdn_location}"
    chef_server_fqdn               = "${local.chef_server_fqdn_location}"
    chef_base_role                 = "${var.chef_base_role}"
    chef_validator_pem             = "${local.chef_validator_pem_location}"
    chef_encrypted_data_bag_secret = "${local.chef_encrypted_data_bag_secret_location}"
  }
}

resource "aws_ssm_document" "enable_chef_tux" {
  name            = "${local.enable_chef_doc_name_tux}"
  document_type   = "Command"
  content         = "${data.template_file.enable_chef_tux.rendered}"
  document_format = "JSON"
}

resource "aws_ssm_association" "enable_chef_tux" {
  name                = "${aws_ssm_document.enable_chef_tux.name}"
  association_name    = "InstallChefClientLinux"
  schedule_expression = "cron(0 0 12 ? * * *)"

  targets = [{
    key    = "tag:ChefEnabled"
    values = ["true"]
  }]

  output_location {
    s3_bucket_name = "${local.output_bucket_name}"
    s3_key_prefix  = "chef-install"
  }
}
