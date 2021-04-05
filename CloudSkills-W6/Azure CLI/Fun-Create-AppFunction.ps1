function Create-FunctionApp {
    param (
        [Parameter(Mandatory)]
        [string]$RGName,

        [Parameter(Mandatory)]
        [string]$name,

        [Parameter(Mandatory)]
        [string]$StorageAccountName
    )
    
    az storage account create --name $StorageAccountName `
        --resource-group $RGName

    $Plan = az functionapp plan create -g $RGName `
        -n $($name + 'plan') `
        --min-instances 1 `
        --max-burst 5 `
        --sku EP1
    $Plan

    az functionapp create -g $RGName `
        -n $name `
        -p $($name + 'plan') `
        --runtime powershell `
        -s $StorageAccountName `
        --functions-version 2
}