
resource "kubernetes_config_map" "autosys_configmap" {
  metadata {
    name      = "autosys-config"
    namespace = var.namespace
  }

  data = {
    AUTOSYS_NAMESPACE          = var.namespace
    AUTOSYS_APPCODE          = var.appcode
    AUTOSYS_ECOSYSTEM     = var.ecosystem
    AUTOSYS_ENVIRONMENT = var.environment
  }


}


