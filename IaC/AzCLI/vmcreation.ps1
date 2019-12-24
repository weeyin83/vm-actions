# This IaC script provisions a VM within Azure
#
[CmdletBinding()]
param(
    [Parameter(Mandatory = $True)]
    [string]
    $servicePrincipal,

    [Parameter(Mandatory = $True)]
    [string]
    $servicePrincipalSecret,

    [Parameter(Mandatory = $True)]
    [string]
    $servicePrincipalTenantId,

    [Parameter(Mandatory = $True)]
    [string]
    $azureSubscriptionName,

    [Parameter(Mandatory = $True)]
    [string]
    $resourceGroupName,

    [Parameter(Mandatory = $True)]
    [string]
    $resourceGroupNameRegion,

    [Parameter(Mandatory = $True)]  
    [string]
    $serverName,

    [Parameter(Mandatory = $True)]  
    [string]
    $adminLogin,

    [Parameter(Mandatory = $True)]  
    [string]
    $adminPassword,
    
    [Parameter(Mandatory = $True)]  
    [string]
    $startip,

    [Parameter(Mandatory = $True)]  
    [string]
    $endip,

    [Parameter(Mandatory = $True)]  
    [string]
    $dbName,

    [Parameter(Mandatory = $True)]  
    [string]
    $webAppName,

    [Parameter(Mandatory = $True)]  
    [string]
    $environment
)


#region Login
# This logs in a service principal
#
Write-Output "Logging in to Azure with a service principal..."
az login `
    --service-principal `
    --username $servicePrincipal `
    --password $servicePrincipalSecret `
    --tenant $servicePrincipalTenantId
Write-Output "Done"
Write-Output ""

# This sets the subscription to the subscription I need all my apps to
# run in
#
Write-Output "Setting default azure subscription..."
az account set `
    --subscription $azureSubscriptionName
Write-Output "Done"
Write-Output ""
#endregion

    #region Create Resource Group
    # # This creates the resource group used to house all of Mercury Health
    # #
    Write-Output "Creating resource group $resourceGroupName in region $resourceGroupNameRegion..."
    az group create `
        --name $resourceGroupName `
        --location $resourceGroupNameRegion
    Write-Output "Done creating resource group"
    Write-Output ""
    #endregion


        #region Create VM
    # Create a VM in the resource group
    # 
    Write-Output "Creating VM..."
    try {
        az vm create  `
    --resource-group $resourceGroupName `
    --name $serverName `
    --image win2016datacenter `
    --admin-username $adminLogin `
    --admin-password $adminPassword
    }
    catch {
    Write-Output "VM already exists"
    }
    Write-Output "Done creating VM"
    Write-Output ""
    #endregion