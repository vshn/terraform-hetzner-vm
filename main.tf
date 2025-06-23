resource "hcloud_server" "vm" {
  count       = var.instance_count
  name        = "${var.name_prefix}${count.index + 1}.${var.stage}"
  image       = var.image
  server_type = var.server_type
  keep_disk   = true
  location    = var.location
  ssh_keys    = var.ssh_keys
  user_data   = templatefile("${path.module}/cloud-init.tftpl", {
    host = "${var.name_prefix}${count.index + 1}",
    fqdn = "${var.name_prefix}${count.index + 1}.${var.stage}.${var.domain}"
  })

  public_net {
    ipv4_enabled = var.public_net_config.ipv4_enabled
    ipv6_enabled = var.public_net_config.ipv6_enabled
  }

  network {
    network_id = var.network_id
    ip         = "${var.network_prefix}.${count.index + var.ip_offset}"
  }

  lifecycle {
    ignore_changes = [ssh_keys]
  }

  depends_on = [var.depends_on_resource]
}

resource "hcloud_volume" "disk" {
  count    = var.instance_count
  name     = "${var.name_prefix}_disk${count.index}"
  location = var.location
  size     = var.volume_size
}

resource "hcloud_volume_attachment" "volume_attachment" {
  count     = var.instance_count
  volume_id = hcloud_volume.disk[count.index].id
  server_id = hcloud_server.vm[count.index].id
  automount = true
}
