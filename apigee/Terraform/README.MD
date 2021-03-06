[Apigee terraform](https://github.com/zambien/terraform-provider-apigee)

## To run

### Get Access token
```powershell
param(
   [parameter(mandatory=$true)]
   [PSCredential]
   $Credentials 
)

<#
POST https://api.authorization-server.com/token
  grant_type=password&
  username=USERNAME&
  password=PASSWORD&
  client_id=CLIENT_ID
  some times client_secret may be used as well.
#>

$p = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Credentials.Password)
$Password = [system.runtime.interopservices.marshal]::PtrToStringAuto($p)

$basicAuthValue = 'Basic ZWRnZWNsaTplZGdlY2xpc2VjcmV0'	# This is standard header Apigee needs it.
$headers = @{ Authorization = $basicAuthValue }
$uri = 'https://login.apigee.com/oauth/token'
$body = @{}
$body["grant_type"] = "password"
$body["username"] = $Credentials.UserName
$body["password"] = $Password 

# Authorization: Basic c2FpcmFtYWpAaG90bWFpbC5jb206c3NTUzEyMzR+
# get access token.
$response = Invoke-WebRequest -Method Post -Uri $uri -Body $body -Headers $headers
$tokenInfo = ConvertFrom-Json $response.Content
$tokenInfo.access_token
```
### Set environment variable
set APIGEE_ACCESS_TOKEN=access token here

### Run deployer from deployer directory
```cmd
main.py samples\apigee
```

### ApiGee references
[Proxy configuration](https://docs.apigee.com/api-platform/reference/api-proxy-configuration-reference)
Bundle structure
  - BaseConfiguration
  - Proxies(app=> apigee)
  - Targes (apigee =>backend)

  ### Issues
  * Error: [ERROR] resourceApiProxyCreate error importing api_proxy: json: cannot unmarshal object into Go struct field ErrorResponse.message of type string
    * Check the variables (one of mistake was having quotes during the environment variables)
    * Also check the access token
### Sharing API Proxies with developers
It is called Publishing
* Creating Product ( set of API Proxies)
* Registering Developers
  * Custom Portal
  * Api Edge registration form
  * Api Edge UI on behalf of developer.
* Registering Apps
