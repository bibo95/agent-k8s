##############################################################################
# Terraform Providers
##############################################################################


terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~>1.42.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9" 
    }
  }
  required_version = ">=1.0"
  # experiments      = [module_variable_optional_attrs]
}
