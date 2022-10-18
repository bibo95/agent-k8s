
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



resource "time_sleep" "wait_for_service" {
  create_duration = "60s"
  depends_on = [kubernetes_manifest.autosys_agent]
}

data "kubernetes_service" "autosys_agent" {
  metadata {
    name = "autosys-agent-${var.namespace}"
    namespace = "${var.namespace}"
  }
  depends_on = [time_sleep.wait_for_service]
}

output "output" {
  value = data.kubernetes_service.autosys_agent.spec[0].port[0].node_port
}

#data "null_data_source" "values" {
#  inputs = {
#    node_port = data.kubernetes_service.autosys_agent.spec
#  }
#}

#output "node_port" {
#  value = data.null_data_source.values.outputs["node_port"]
#}


