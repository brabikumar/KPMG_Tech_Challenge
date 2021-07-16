####################################
# Get Metadate of VM Instance     ##
# Author: Lingaraj Raul           ##
####################################


$tenantid = Read-Host "Enter Tenantid"
$subscriptionid = Read-Host "Enter subscriptionid"

$username = Read-Host "Enter Username"
$password = Read-Host "Enter Password" -AsSecureString


$credential = New-Object System.Management.Automation.PsCredential($username, $password)

# connect to azure
Connect-AzAccount -Credential $credential -Tenant $tenantid

# set to specific Subscription
Select-AzSubscription $subscriptionid

#provide the Resource group name
$rg = Read-Host "Enter resource group name"

# Get all VMs on the subm
$vms = Get-AzVM -ResourceGroupName $rg

#consider one vm instance
$vm= $vms[0]

#Get the metadata of the VM

$vmmetadata= $vm.ToPSVirtualMachine()

# Instance Metadata output as JSON
$output= $vmmetadata | ConvertTo-Json -Verbose

$output | Out-File -FilePath 'C:\Raj_Working_Folder\Azure Powershell\vmmetadata.json'
