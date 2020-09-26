#! /usr/bin/pwsh

[CmdletBinding()]
param(
    [parameter(Position = 0, Mandatory = $true, ParameterSetName = 'QueryString')]
    [parameter(Position = 0, Mandatory = $true, ParameterSetName = 'QueryFile')]
    [guid] 
    $TenantId,

    [parameter(Position = 1, Mandatory = $true, ParameterSetName = 'QueryString')]    
    [parameter(Position = 1, Mandatory = $true, ParameterSetName = 'QueryFile')]    
    [guid] 
    $ServicePrincipalId,
        
    [parameter(Position = 2, Mandatory = $true, ParameterSetName = 'QueryString')]    
    [parameter(Position = 2, Mandatory = $true, ParameterSetName = 'QueryFile')]    
    [string] 
    $ServicePrincipalSecret,
    
    [parameter(Position = 3, Mandatory = $true, ParameterSetName = 'QueryString')]
    [parameter(Position = 3, Mandatory = $true, ParameterSetName = 'QueryFile')]
    [string] 
    $SqlServerName,

    [parameter(Position = 4, Mandatory = $true, ParameterSetName = 'QueryString')]
    [parameter(Position = 4, Mandatory = $true, ParameterSetName = 'QueryFile')]
    [string] 
    $SqlDbName,
    
    [parameter(Position = 5, Mandatory = $true, ParameterSetName = 'QueryString')]
    [string] 
    $Query,

    [parameter(Position = 5, Mandatory = $true, ParameterSetName = 'QueryFile')]
    [string] 
    $QueryFile,

    [parameter(Position = 6, Mandatory = $false, ParameterSetName = 'QueryString')]
    [parameter(Position = 6, Mandatory = $false, ParameterSetName = 'QueryFile')]
    [string] 
    $ReturnResult = "No"
)	

$ClientSecret = ConvertTo-SecureString  $ServicePrincipalSecret -AsPlainText -Force
$token = Get-MsalToken -ClientId $ServicePrincipalId -ClientSecret $ClientSecret -TenantId $TenantId -Scope 'https://database.windows.net/.default'
$conn = New-Object System.Data.SqlClient.SQLConnection 
$conn.ConnectionString = "Data Source=$SqlServerName.database.windows.net;Initial Catalog=$sqlDbName;Connect Timeout=30"
$conn.AccessToken = $token.AccessToken
    
if ($PSCmdlet.ParameterSetName -eq "QueryString") {    
    $result = Invoke-Sqlcmd2 -SQLConnection $conn -Query $Query
}
else {		
    echo "File"
    $result = Invoke-Sqlcmd2 -SQLConnection $conn -InputFile $QueryFile
}

if ($ReturnResult.ToLower() -eq "yes") {
    echo "::set-output name=result::$($result | ConvertTo-Json)"
}

echo "::set-output name=count::$($result.Count)"