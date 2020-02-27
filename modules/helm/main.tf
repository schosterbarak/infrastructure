#
# This module contains all code pertaining to Helm packages we want installed on kubernetes
# This will also typically impact all pods running on k8s, so that's why it's centrally managed.
#

provider "helm" {
  kubernetes {
    load_config_file       = false
    host                   = var.host
    token                  = var.token
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
    config_context         = var.cluster_name
    
    # for helm v2
    install_tiller = "true"
    service_account = "tiller"
  }
}
