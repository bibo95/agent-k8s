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

    spec = {
      
      contact = "paris_bp2i_scheduling_products_open_at_bnpparibas.com"
      identification = {
        appcode = "AP24664"
        codeap = "AP24664"
        ecosystem = "toto"
        tier = "PA"    
      }

      illumio = {
        app = "A_toto-CA-AUTOSYS_0-DEFAULT"
        env = "E_DEV"
        loc = "L_EMEA_T2_BNPP_DMZR-VPC-BIZ"
        role = "R_RESTRICTED_AD_KUBE_OTHER-SOFT"
      }
      
      resources = {
          limits = {
            cpu = "200m"
            memory = "256Mi"
          }
          requests = {
            cpu = "50m"
            memory = "128Mi"
          }
      }
      
      splunk = {
        index = "cloud_bp2i_autosys"
        source = "all.autosys.json"
      }

      scope = "Namespaced"
    }
  }
}
