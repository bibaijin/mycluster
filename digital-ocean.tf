variable "do_token" {}
variable "do_ssh_keys" {
  type = "list"
}
variable "do_domain_name" {}
variable "do_region" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "k8s-node1" {
  image = "ubuntu-16-04-x64"
  name = "k8s-node1"
  region = "${var.do_region}"
  size = "1gb"
  ipv6 = true
  private_networking = true
  ssh_keys = "${var.do_ssh_keys}"
}

resource "digitalocean_floating_ip" "default" {
  droplet_id = "${digitalocean_droplet.k8s-node1.id}"
  region = "${var.do_region}"
}

resource "digitalocean_domain" "default" {
  name = "${var.do_domain_name}"
  ip_address = "${digitalocean_floating_ip.default.ip_address}"
}