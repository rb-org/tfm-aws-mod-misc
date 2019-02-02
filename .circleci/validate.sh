
#!/bin/sh

apk add --update openssl
apk add curl
# wget https://github.com/wata727/tflint/releases/download/v0.5.4/tflint_linux_amd64.zip
tflint_latest_url=$(curl -s https://github.com/wata727/tflint/releases/latest |grep -o 'https://[^"]*' | sed 's/tag/download/' )
wget "$tflint_latest_url/tflint_linux_amd64.zip"
unzip tflint_linux_amd64.zip
mkdir -p /usr/local/tflint/bin
export PATH=/usr/local/tflint/bin:$PATH
install tflint /usr/local/tflint/bin
tflint --var-file=env/${WKSPC}.tfvars --error-with-issues

validate_failed="no"
TF_DIRS=$(find $(pwd) -type f -iname "*.tf*" -exec dirname '{}' \; | grep -v ".terraform" | sort | uniq | xargs echo)
for DIR in $TF_DIRS
do
    echo Processing $DIR
    lines=$(terraform validate -input=false -check-variables=false -no-color $DIR -var-file=env/${WKSPC}.tfvars | wc -l | sed 's/[^0-9]//g')
    if [ ${lines} != "0" ]
    then
    echo "Please run terraform validate ${file}"
    validate_failed="yes"
    fi
done
if [ ${validate_failed} != "no" ]; then exit 1; fi