resource "null_resource" "hellworld" {

  provisioner "local-exec" {
    command     = "\"Hello World\" | Out-File c:\\temp\\test.txt"
    interpreter = ["PowerShell", "-Command"]
  }
}
