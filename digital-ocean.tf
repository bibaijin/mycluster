variable "do_token" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "k8s-node1" {
  image = "debian-9-x64"
  name = "k8s-node1"
  region = "sgp1"
  size = "512mb"
  ipv6 = true
  private_networking = true
  ssh_keys = [11847042]
}

resource "digitalocean_domain" "default" {
  name = "bibaijin.me"
  ip_address = "${digitalocean_droplet.k8s-node1.ipv4_address"
}