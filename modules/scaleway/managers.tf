resource "scaleway_ip" "swarm_manager_ip" {
  count = 1
}

resource "scaleway_server" "swarm_manager" {
  count          = 1
  name           = "${terraform.workspace}-manager-${count.index + 1}"
  image          = "${data.scaleway_image.docker.id}"
  type           = "${var.manager_instance_type}"
  security_group = "${scaleway_security_group.swarm_managers.id}"
  public_ip      = "${element(scaleway_ip.swarm_manager_ip.*.ip, count.index)}"

  connection {
    host = "${element(scaleway_ip.swarm_manager_ip.*.ip, count.index)}"
    type = "ssh"
    user = "root"
    private_key = "${file("${var.ssh_private_key_path}")}"
  }
  
  provisioner "remote-exec" {
    inline = [
      "mkdir /certs"
    ]
  }

  provisioner "local-exec" {
    command = "chmod +x ${path.module}/scripts/tlsgen-base.sh && ${path.module}/scripts/tlsgen-base.sh"
  }

  provisioner "local-exec" {
    command = "chmod +x ${path.module}/scripts/tlsgen-node.sh && ${path.module}/scripts/tlsgen-node.sh ${self.private_ip} ${self.public_ip}"
  }
  provisioner "file" {
    source = "./certs/ca.pem"
    destination = "/certs/ca.pem"
  }
  provisioner "file" {
    source = "./certs/${self.private_ip}/server-key.pem"
    destination = "/certs/swarm-priv-key.pem"
  }
  provisioner "file" {
    source = "./certs/${self.private_ip}/server-cert.pem"
    destination = "/certs/swarm-cert.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /etc/systemd/system/docker.service.d",
    ]
  }

  provisioner "file" {
    content     = "${data.template_file.docker_conf.rendered}"
    destination = "/etc/systemd/system/docker.service.d/docker.conf"
  }

  provisioner "file" {
    content     = "${data.template_file.ssh_conf.rendered}"
    destination = "/etc/ssh/sshd_config"
  }

  provisioner "remote-exec" {
    inline = [
      "docker swarm init --advertise-addr ${self.private_ip}",
    ]
  }
}