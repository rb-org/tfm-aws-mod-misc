
{
	"schemaVersion": "2.2",
	"description": "Install/Update Chef",
	"mainSteps": [
		{
			"action": "aws:runShellScript",
			"name": "InstallChefClient",
			"precondition": {
				"StringEquals": [
					"platformType",
					"Linux"
				]
			},
			"inputs": {
				"runCommand": [
          "#!/bin/bash",
          "# Variables",


          "  # Install Chef",
          "  #!/bin/bash",
          "  dtap=\"excp\"",

          "  instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)",
          "  app_role=$(aws ec2 describe-instances --instance-ids $instance_id --region eu-west-1 --query 'Reservations[*].Instances[*].[Tags[?Key==`AppRole`].Value]' --output text)",
          "  app_id=$(aws ec2 describe-instances --instance-ids $instance_id --region eu-west-1 --query 'Reservations[*].Instances[*].[Tags[?Key==`AppID`].Value]' --output text)",
          "  wkspc=$(aws ec2 describe-instances --instance-ids $instance_id --region eu-west-1 --query 'Reservations[*].Instances[*].[Tags[?Key==`Workspace`].Value]' --output text)",
          "  workload=$(aws ec2 describe-instances --instance-ids $instance_id --region eu-west-1 --query 'Reservations[*].Instances[*].[Tags[?Key==`Workload`].Value]' --output text)",
          "  chef_role=$(echo \"$workload-$app_role-$app_id\" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')",
          "  chef_env=$(aws ec2 describe-instances --instance-ids $instance_id --region eu-west-1 --query 'Reservations[*].Instances[*].[Tags[?Key==`ChefEnv`].Value]' --output text)",
          "  server_count=$(aws ec2 describe-instances --instance-ids $instance_id --region eu-west-1 --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value]' --output text | awk -F'-' '{print $4}')",

          "  # Initial varuabkes and debug information",
          "  chef_local_dir='/etc/chef'",
          "  chef_client=$(aws ssm get-parameters --with-decryption --names ${chef_client_version} --query 'Parameters[0].Value' --region eu-west-1 --output text)",
          "  chef_org_name=$(aws ssm get-parameters --with-decryption --names ${chef_org} --query 'Parameters[0].Value' --region eu-west-1 --output text)",
          "  data_token=$(aws ssm get-parameters --with-decryption --names ${data_token} --query 'Parameters[0].Value' --region eu-west-1 --output text)",

          "  chef_svr_fqdn=$(aws ssm get-parameters --with-decryption --names ${chef_server_fqdn} --query 'Parameters[0].Value' --region eu-west-1 --output text)",
          "  chef_automate_fqdn=$(aws ssm get-parameters --with-decryption --names ${chef_automate_fqdn} --query 'Parameters[0].Value' --region eu-west-1 --output text)",

          "  svrName=$(aws ec2 describe-instances --instance-ids $instance_id --region eu-west-1 --query 'Reservations[*].Instances[*].[Tags[?Key==`MachineName`].Value]' --output text)",

          "  base_role=\"${chef_base_role}\"",

          "  # Store the validation key in /etc/chef/validator.pem",
          "  echo \"Storing validation key in $chef_local_dir/$chef_org-validator.pem\"",
          "  mkdir $chef_local_dir /var/log/chef &>/dev/null",
          "  aws ssm get-parameters --with-decryption --names ${chef_validator_pem} --query 'Parameters[0].Value' --region eu-west-1 --output text| sudo tee $chef_local_dir/$chef_org-validator.pem",

          "  # Store the encrypted_data_bag_secret",
          "  echo \"Storing data bag secret in $chef_local_dir/encrypted_data_bag_secret\"",
          "  aws ssm get-parameters --with-decryption --names ${chef_encrypted_data_bag_secret} --query 'Parameters[0].Value' --region eu-west-1 --output text| sudo tee $chef_local_dir/encrypted_data_bag_secret",

          "  # Cook a minimal client.rb for getting the chef-client registered",
          "  printf '%s\n' \\",
          "  \"log_level                 :info",
          "  file_cache_path           '$chef_local_dir/cache'",
          "  file_backup_path          '$chef_local_dir/backup'",
          "  cache_options             ({:path => '$chef_local_dir/cache/checksums', :skip_expires => true})",
          "  node_name                 '$svrName'",
          "  trusted_certs_dir         '$chef_local_dir/trusted_certs'",
          "  log_location              '$chef_local_dir/chef-client.log'",
          "  chef_server_url           'https://$chef_svr_fqdn/organizations/$chef_org_name'",
          "  validation_client_name    '$chef_org_name-validator'",
          "  client_key                '$chef_local_dir/client.pem'",
          "  validation_key            '$chef_local_dir/$chef_org_name-validator.pem'",
          "  ssl_verify_mode           :verify_none",
          "  verify_api_cert           false",
          "  environment               '$chef_env'",
          "  encrypted_data_bag_secret '$chef_local_dir/encrypted_data_bag_secret'\" | sudo tee $chef_local_dir/client.rb",

          "  # Create config file ",
          "  printf '%s\n' \\",
          "\"    node_name             '$svrName'",
          "      chef_server_url         'https://$chef_svr_fqdn/organizations/$chef_org'",
          "      client_key              '$chef_local_dir/client.pem'\" | sudo tee $chef_local_dir/config.rb",

          "  # Cook the first boot file",
          "  printf '%s\n' \\",
          "     \"{\n  \\\"run_list\\\":\\\"role[$chef_role]\\\" \n} \" | sudo tee /etc/chef/first-boot.json",

          "  # Install chef-client through omnibus (if not already available)",
          "  if [ ! -f /usr/bin/chef-client ]; then",
          "    curl -sLO https://omnitruck.chef.io/install.sh && sudo bash ./install.sh -v $chef_client && rm install.sh",
          "    echo \"Installation of chef complete\"",
          "  else",
          "    echo \"Existing chef found and is being used\"",
          "    echo \"Existing chef version: $(chef-client --version)\"",
          "  fi",



          "  # Kick off the first chef run",
          "  echo \"Executing the first chef-client run\"",
          "  if [ -f /usr/bin/chef-client ]; then",
          "    count=0",
          "    try=2",
          "    while [ $count -lt $try ]; do",
          "      # /usr/bin/chef-client -j $chef_local_dir/first-boot.json",
          "      /usr/bin/chef-client -r role[$base_role]",
          "      if [ $? -eq 0 ]; then",
          "        echo \"SUCCESS\"",
          "        let count=$try",
          "        echo \"Setting the Chef Role\"",
          "        /usr/bin/knife node run_list set $svrName 'role[$chef_role]' -c $configFile",
          "        /usr/bin/chef-client -j $chef_local_dir/first-boot.json",
          "        echo \"Executing Chef Role\"",
          "      else",
          "        let count=count+1",
          "        echo \"chef-client execution failed, will try $try times count: $count\"",
          "        if [ $count -eq $try ]; then",
          "          echo \"FAILURE\"",
          "        fi",
          "      fi",
          "    done",
          "  fi",
          "}"
          ]
			}
		}
	]
}