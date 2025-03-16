@echo off
echo Initializing Terraform...
terraform init
echo Applying Terraform changes...
terraform apply -auto-approve
echo Deployment completed!
pause
