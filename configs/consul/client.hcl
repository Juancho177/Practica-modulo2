datacenter = "dc1"
server = false
data_dir = "/var/lib/consul"
bind_addr = "0.0.0.0"
advertise_addr = "{{IP}}"   # ← la reemplazarás con 10.10.0.11 o 10.10.0.12
client_addr = "0.0.0.0"
retry_join = ["10.10.0.10"]
dns_config {
  enable_truncate = true
  only_passing = true
}
