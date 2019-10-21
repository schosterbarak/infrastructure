module "docker_master" {
    source                  = "./modules/docker_master"

    scaleway_organization   = "${var.scaleway_org}"
    scaleway_api_token      = "${var.scaleway_token}"
    scaleway_access_token   = "${var.scaleway_accesstoken}"

    ssh_root_public_key     = "${var.ssh_root_public_key}"
    ssh_root_private_key    = "${var.ssh_root_private_key}"

    ssh_tech_public_key     = "${var.ssh_tech_public_key}"

    manager_instance_count  = "${var.swarm_master_count}"
}

module "docker_worker" {
    source                  = "./modules/docker_worker"

    scaleway_organization   = "${var.scaleway_org}"
    scaleway_api_token      = "${var.scaleway_token}"
    scaleway_access_token   = "${var.scaleway_accesstoken}"

    ssh_root_public_key     = "${var.ssh_root_public_key}"
    ssh_root_private_key    = "${var.ssh_root_private_key}"

    ssh_tech_public_key     = "${var.ssh_tech_public_key}"

    worker_instance_count  = "${var.swarm_worker_count}"
}

/*
module "cloudflare" {
    source                  = "./modules/cloudflare"
    cloudflare_token        = "${var.cloudflare_token}"
}


module "github" {
    source                  = "./modules/github"

    github_token            = "${var.github_token}"
    github_organization     = "${var.github_org}"
}
*/