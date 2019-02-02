  {
	"schemaVersion": "2.2",
	"description": "Join a Windows server to an existing Active Directory domain.",
	"mainSteps": [
        {
		"action": "aws:runPowerShellScript",
        "name": "JoinWindowsServerToDomain",
        "precondition": {
          "StringEquals": [
            "platformType",
            "Windows"
          ]
        },
        "inputs":
        {
            "runCommand": [
              "# Join to Domain",
              "if ( -not (gwmi win32_computersystem).partofdomain ) {",
              "  resolve-dnsname -name ${domain} ",
              "  if ($error -match \"DNS name does not exist\") {exit 1} else {",
              "   $secPassword = ConvertTo-SecureString \"${password}\" -AsPlainText -Force",
              "   $DomainUserCreds = New-Object System.Management.Automation.PSCredential \"${username}@${domain}\", $secPassword",
              "",
              "   Add-Computer -DomainName \"${domain}\" -OUPath \"${computers_ou}\" -Credential $DomainUserCreds",
              "   # Need to add a delay to reboot to allow SSM to complete its run and not fail.",
              "   shutdown -r -f -t 30",
              "}}"
            ]
        }
    }]
  }
