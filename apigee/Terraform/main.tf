variable "org" { default = "sairamaj-eval" }
variable "env" { default = "test" }

provider "apigee" {
  
}

data "archive_file" "bundle" {
   type         = "zip"
   source_dir   = "${path.module}/proxy_files"
   output_path  = "${path.module}/proxy_files_bundle/apiproxy.zip"
}

# resource "null_resource" "hellworld" {

#   provisioner "local-exec" {
#     command     = "\"Bundle file:  ${data.archive_file.bundle.output_path}\" | Out-File c:\\temp\\test.txt"
#     interpreter = ["PowerShell", "-Command"]
#   }
# }

resource "apigee_api_proxy" "saitechtips_proxy" {
   name  = "saitechtips"                         # The proxy name.
   bundle       = "${data.archive_file.bundle.output_path}" # Apigee APIs require a zip bundle to import a proxy.
   bundle_sha   = "${data.archive_file.bundle.output_sha}"  # The SHA is used to detect changes for plan/apply.   
}

# A proxy deployment
resource "apigee_api_proxy_deployment" "saitechtips_proxy_deployment" {
   proxy_name   = "${apigee_api_proxy.saitechtips_proxy.name}"
   org          = "${var.org}"
   env          = "${var.env}"

   # NOTE: revision = "latest" 
   # will deploy the latest revision of the api proxy 
   revision     = "${apigee_api_proxy.saitechtips_proxy.revision}"
}

# resource "apigee_developer" "helloworld_developer" {
#    email = "helloworld2_email@test.com"                                  # required
#    first_name = "helloworld2"                                            # required
#    last_name = "thelloworld2"                                           # required
#    user_name = "helloworld2"                                            # required

#    attributes = {                                                         # optional
#       DisplayName = "my_awesome_app_updated"
#       Notes = "notes_for_developer_app_updated"
# 	  custom_attribute_name = "custom_attribute_value"
#    }
# }

# A company
# resource "apigee_company" "helloworld_company" {
#    name = "helloworld_company"                                          # required
# }