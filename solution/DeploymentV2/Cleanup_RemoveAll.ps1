#----------------------------------------------------------------------------------------------------------------
# You must be logged into the Azure CLI to run this script
#  WARNING  use only for development purposes!!! If you are not sure what this does please use terragrunt destroy instead
#----------------------------------------------------------------------------------------------------------------

Import-Module .\pwshmodules\GetSelectionFromUser.psm1 -force
Import-Module .\pwshmodules\GatherOutputsFromTerraform.psm1 -force

$environmentName = Get-SelectionFromUser -Options ('local','staging') -Prompt "Select deployment environment"
if ($environmentName -eq "Quit")
{
    Exit
}
[System.Environment]::SetEnvironmentVariable('TFenvironmentName',$environmentName)

Set-Location ".\terraform"

#------------------------------------------------------------------------------------------------------------
# Get all the outputs from terraform so we can use them in subsequent steps
#------------------------------------------------------------------------------------------------------------
Write-Host "Reading Terraform Outputs"

$tout = GatherOutputsFromTerraform -TerraformFolderPath ./terraform_layer2

#Delete Resource Group
az group delete --name $tout.resource_group_name 

#Delete App and SP for Web App Auth 
az ad app delete --id $tout.aad_webreg_id

#Delete App and SP for Function App Auth
az ad app delete --id $tout.aad_funcreg_id

#Remove Terraform State and Backend Files 
rm ./terraform.tfstate
rm ./backend.tf

<# 
If you want to delete all ADS Go Fast App Registrations owned by you.. RUN AT YOUR OWN RISK!!!:

$apps = (az ad sp list --show-mine | ConvertFrom-Json | Where-Object {$_.displayName.StartsWith("ADS GoFast")}).id
foreach($app in $apps) {az ad sp delete --id $app}




 #>