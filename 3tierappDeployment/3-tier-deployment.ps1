################################################
# ARM Template Deployment by Powershell       ##
# Author: Lingaraj Raul                       ##
################################################

param(
  [Parameter(Mandatory=$true)]
  $SubscriptionId,

  [Parameter(Mandatory=$true)]
  $tenantId,

  [Parameter(Mandatory=$true)]
  $Location,
  
  [Parameter(Mandatory=$true)]
  $ResourceGroupName,

  [Parameter(Mandatory=$true)]
  $username
  
)

$password = Read-Host "Enter azure Password" -AsSecureString

$credential = New-Object System.Management.Automation.PsCredential($username, $password)

#connect to azure
Connect-AzAccount -Credential $credential -Tenant $tenantid

# set to specific Subscription
Select-AzSubscription $subscriptionid

#create a Resource Group
New-AzResourceGroup -Name $ResourceGroupName -Location $Location -Force

Write-Host "Deploying Networking Layer"
New-AzResourceGroupDeployment `
    -Name 'Network-deployment' `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile "Vnet-subnet.json"

Write-Host "Deploying Backend Tier"
New-AzResourceGroupDeployment `
    -Name 'BackEnd-deployment' `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile "sqlDB.json" `


Write-Host "Deploying Middle Tier"
New-AzResourceGroupDeployment `
        -Name 'Middle-Tier-deployment' `
        -ResourceGroupName $ResourceGroupName `
        -TemplateFile "FunctionApp-StorageAC.json"

Write-Host "Deploying FrontEnd Tier"
New-AzResourceGroupDeployment `
        -Name 'FrontEnd-Tier-deployment' `
        -ResourceGroupName $ResourceGroupName `
        -TemplateFile "webapp.json"
