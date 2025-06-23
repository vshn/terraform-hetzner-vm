output "server_names" {
  value = [for s in hcloud_server.vm : s.name]
}

output "private_ips" {
  value = [for s in hcloud_server.vm: s.ipv4_address]
}
