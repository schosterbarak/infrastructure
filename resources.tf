resource "local_file" "kubeconfig" {
    file_permission = 0400
    filename = "kubeconfig"
    content  = module.scaleway.kubeconfig
}