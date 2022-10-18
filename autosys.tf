
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
    
    "apiVersion" = "autosys.ddp.bp2i/v1alpha1"
    "kind"       = "AutosysAgent"

    "metadata" = {
      "name"      = "autosys-agent-${var.namespace}"
      "namespace" = "${var.namespace}"
    }

    "spec" = {
      "contact" = {
        "email" = "paris_bp2i_scheduling_products_open_at_bnpparibas.com"
      }
      "identification" = {
        "appcode" = "${var.appcode}"
        "ecosystem" = "${var.ecosystem}"
        "tier" = "PA"
        "environment" = "DEV"
      }
      "illumio" = {
        "app" = "A_${var.appcode}-CA-AUTOSYS_0-DEFAULT"
        "env" = "E_DEV"
        "loc" = "L_EMEA_T2_BNPP_DMZR-VPC-BIZ"
        "role" = "R_RESTRICTED_AD_KUBE_OTHER-SOFT"
      }
      "resources" = {
          "limits" = {
            "cpu" = "200m"
            "memory" = "256Mi"
          }
          "requests" = {
            "cpu" = "50m"
            "memory" = "128Mi"
          }
      } 
      "splunk" = {
        "index" = "cloud_bp2i_autosys"
        "source" = "all.autosys.json"
      }
    }
    
  }
}

data "kubernetes_resource" "example" {
  apiVersion = "autosys.ddp.bp2i/v1alpha1"
  kind        = "AutosysAgent"

  metadata {
    name      = "autosys-agent-${var.namespace}"
    namespace = "${var.namespace}"
  }
 
   depends_on = [kubernetes_manifest.autosys_agent]
}

output "test" {
  value = data.kubernetes_resource.example
}

