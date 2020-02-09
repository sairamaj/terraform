# APIGEE_ACCESS_TOKEN="my-access-token"
# APIGEE_ORG=sairamaj-eval

variable "org" { default = "sairamaj-eval" }
variable "env" { default = "test" }

provider "apigee" {
  
}

data "archive_file" "bundle" {
   type         = "zip"
   source_dir   = "${path.module}/proxy_files"
   output_path  = "${path.module}/proxy_files_bundle/apiproxy.zip"
}

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
   #revision     = "${apigee_api_proxy.saitechtips_proxy.revision}"
   revision = "latest"
}

resource "apigee_product" "saitechtips_product" {
   name = "saitechtips-product"
   approval_type = "auto"
   api_resources = ["/"]
   proxies = ["${apigee_api_proxy.saitechtips_proxy.name}"]
}

resource "apigee_developer" "saitechtips_developer" {
   email = "saitechtips@test.com"                                  # required
   first_name = "SaiTech"                                            # required
   last_name = "Sample"                                           # required
   user_name = "saitechtips"                                            # required

   attributes = {                                                         # optional
      DisplayName = "SaiTechApp"C:\dev\sairamaj\service-simulator
      Notes = "App used for accessing sai tech api"
	  custom_attribute_name = "some custom attribute here."
   }
}

resource "apigee_developer_app" "saitechtips_developer_app" {
   name = "saitechtips_developer_app"                                    # required
   developer_email = "${apigee_developer.saitechtips_developer.email}"   # developer email must exist
   api_products = ["${apigee_product.saitechtips_product.name}"]         # list must exist 
}

# A company
# resource "apigee_company" "helloworld_company" {
#    name = "helloworld_company"                                          # required
# }