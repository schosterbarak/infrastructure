// --- scaleway variables -------------

variable "scaleway_accesstoken" {}

variable "scaleway_secrettoken" {}

variable "scaleway_org" {}

variable "scaleway_zone" {
    default = "fr-par-1"
}

variable "scaleway_region" {
    default = "fr-par"
}

// --- cloudflare variables -----------

variable "cloudflare_token" {}

variable "cloudflared_tunnel_token" {}

// --- github variables ---------------

variable "github_token" {}

variable "github_org" {}