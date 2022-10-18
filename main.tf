
##############################################################################
# IBM Cloud Provider
##############################################################################
provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.location
  ibmcloud_timeout = 60
}

##############################################################################


##############################################################################
# Resource Group where VPC is created
##############################################################################
data "ibm_resource_group" "resource_group" {
  name = var.resource_group_name
}


##############################################################################
# Kubetnetes provider setup
##############################################################################

data "ibm_container_cluster_config" "config" {
  cluster_name_id   = var.cluster_id
  config_dir        = local.config_dir
  resource_group_id = data.ibm_resource_group.resource_group.id
}

provider "kubernetes" {
  config_path = data.ibm_container_cluster_config.config.config_file_path
}
