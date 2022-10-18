
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

resource "kubernetes_manifest" "autosys_agent" {
  manifest = {
    apiVersion = "apiextensions.k8s.io/v1"
    kind       = "AutosysAgent"

    metadata {
      name      = "autosys-agent-${var.namespace}"
      namespace = "${var.namespace}"
    
      labels = {
        app = "autosys-agent-${var.namespace}"
        appcode = "${var.appcode}"
        codeap = "${var.appcode}"
        opscontact = "mohamed_eloirrak_at_bnpparibas.com"
        tier = "PA"
      }
    }

 
  
}

