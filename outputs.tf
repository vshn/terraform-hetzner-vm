output "server_names" {
  value = [for s in hcloud_server.this : s.name]
}

output "private_ips" {
  value = [for s in hcloud_server.this : s.ipv4_address]
}
