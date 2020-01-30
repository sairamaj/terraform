# variable "org" { default = "sairamaj-eval" }
variable "env" { default = "test" }

provider "apigee" {
  
}

# data "archive_file" "bundle" {
#    type         = "zip"
#    source_dir   = "${path.module}/proxy_files"
#    output_path  = "${path.module}/proxy_files_bundle/apiproxy.zip"
# }
# resource "apigee_api_proxy" "helloworld_proxy" {
#    name  = "helloworld2"                         # The proxy name.
#    bundle       = "${data.archive_file.bundle.output_path}" # Apigee APIs require a zip bundle to import a proxy.
#    bundle_sha   = "${data.archive_file.bundle.output_sha}"  # The SHA is used to detect changes for plan/apply.   
# }

resource "apigee_developer" "helloworld_developer" {
   email = "helloworld_email@test.com"                                  # required
   first_name = "helloworld"                                            # required
   last_name = "thelloworld1"                                           # required
   user_name = "helloworld1"                                            # required

   attributes = {                                                         # optional
      DisplayName = "my_awesome_app_updated"
      Notes = "notes_for_developer_app_updated"
	  custom_attribute_name = "custom_attribute_value"
   }
}

# A company
# resource "apigee_company" "helloworld_company" {
#    name = "helloworld_company"                                          # required
# }