resource_group_name = "appgroup"
location            = "Central India"
appvnet_name        = "appvnet"
address_space       = "10.0.0.0/16"
app_subnet_count    = 2
network_security_group_rules = [
  {
    priority               = 300
    destination_port_range = "22"
  },
  {
    priority               = 310
    destination_port_range = "80"
  }
]