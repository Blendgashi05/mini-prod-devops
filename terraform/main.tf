provider "local" {}

resource "local_file" "k8s_values" {
  content = templatefile("${path.module}/templates/k8s-values.tpl", {
    app_version = var.app_version
    namespace   = var.namespace
    image_tag   = var.image_tag
    app_port    = var.app_port
    db_host     = var.db_host
    db_port     = var.db_port
  })

  filename = "${path.module}/../generated/k8s-values.json"
}

resource "local_file" "inventory" {
  content  = templatefile("${path.module}/templates/inventory.tpl", {})
  filename = "${path.module}/../generated/inventory.ini"
}
