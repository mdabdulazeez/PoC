provider "local" {}

resource "local_file" "build_directory" {
  filename = "${path.module}/build/index.html"
  content = file("${path.module}/index.html")
}

output "website_path" {
  value = "${path.module}/build/index.html"
}
