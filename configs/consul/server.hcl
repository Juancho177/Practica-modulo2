datacenter = "dc1"
server = true
bootstrap_expect = 1
data_dir = "/var/lib/consul"
bind_addr = "0.0.0.0"
advertise_addr = "10.10.0.10"
client_addr = "0.0.0.0"
ui_config { enabled = true }
dns_config {
  enable_truncate = true
  only_passing = true
}
