resource "null_resource" "hellworld" {

  provisioner "local-exec" {
    command     = "\"Hello World1:  ${var.name} with age:${var.age}\" | Out-File c:\\temp\\test.txt"
    interpreter = ["PowerShell", "-Command"]
  }
}
