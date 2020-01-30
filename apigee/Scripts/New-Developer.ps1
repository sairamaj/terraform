param(
   [parameter(mandatory=$true)]
   $DevloperFileName 
)

Function Get-EnvParameterValue
{
    param(
        $Name
    )

    $Value = [System.Environment]::GetEnvironmentVariable($Name)
    if( $Value -eq  0 ){
        throw "Please set Environment for $Name"
    }

    $Value
}

$Org = Get-EnvParameterValue -Name 'APIGEE_ORG'
$AccessToken = Get-EnvParameterValue -Name 'APIGEE_ACCESS_TOKEN'
$url = "https://api.enterprise.apigee.com/v1/organizations/$Org/developers"
$Body = (Get-Content $DevloperFileName -Raw)


$AuthValue = "Bearer $AccessToken"
$headers = @{ Authorization = $AuthValue }

$Body
$Url

$response = Invoke-WebRequest -Method Post -Uri $url -Body $body -ContentType "application/json" -Headers $headers
$response
