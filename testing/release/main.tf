resource "azurerm_resource_group" "rg" {
  name     = uuid()
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "virtual-network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

module "private_dns" {
  source              = "../../terraform-azurerm-private-dns-zone"
  name                = "${azurerm_resource_group.rg.name}.com"
  resource_group_name = azurerm_resource_group.rg.name
  a_records = [
    { name = "@", ttl = 300, records = ["192.168.10.1"], tags = {
      "tag1" = "value1",
      "tag2" = "value2",
    } }
  ]
  aaaa_records = [
    { name = "@", ttl = 300, records = ["2001:0db8:85a3:0000:0000:8a2e:0370:7334"] }
  ]
  cname_records = [
    { name = "testing", ttl = 300, record = "testing.com" }
  ]
  mx_records = [
    { name = "example", ttl = 3600, records = [
      { preference = 10, exchange = "mx1.contoso.com" },
      { preference = 20, exchange = "backupmx.contoso.com" }
    ] }
  ]
  ptr_records = [
    { name = "15", ttl = 300, records = ["test.example.com", "test2.example.com"] }
  ]
  srv_records = [
    { name = "example", ttl = 3600, records = [
      { priority = 10, weight = 20, port = 80, target = "srv1.contoso.com" },
      { priority = 20, weight = 30, port = 80, target = "srv2.contoso.com" }
    ] }
  ]
  txt_records = [
    { name = "test", ttl = 300, records = ["v=spf1 mx ~all", "v=spf2 mx ~all"] }
  ]
  private_links = [
    { name = azurerm_virtual_network.vnet.name, virtual_network_id = azurerm_virtual_network.vnet.id }
  ]
}
