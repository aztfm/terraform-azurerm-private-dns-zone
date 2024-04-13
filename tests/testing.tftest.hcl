provider "azurerm" {
  features {}
}

run "setup" {
  module {
    source = "./tests/environment"
  }
}

variables {
  soa_record = { email = "test.com", ttl = 1800, expire_time = 1210100, minimum_ttl = 30, refresh_time = 1800, retry_time = 2400 }
  a_records = [
    { name = "test1", ttl = 3600, records = ["192.168.10.1"], tags = { "hello" = "world" } },
    { name = "test2", ttl = 1800, records = ["192.168.10.2", "192.168.10.3"] }
  ]
  aaaa_records = [
    { name = "test1", ttl = 1800, records = ["2001:0db8:85a3:0000:0000:8a2e:0370:7334"], tags = { "hello" = "world" } },
    { name = "test2", ttl = 3600, records = ["2001:0db8:3333:4444:5555:6666:7777:8888", "2001:db8:3333:4444:CCCC:DDDD:EEEE:FFFF"] }
  ]
  cname_records = [
    { name = "test11", ttl = 3600, record = "testing1.com", tags = { "hello" = "world" } },
    { name = "test22", ttl = 1800, record = "testing2.com" }
  ]
  mx_records = [
    { name = "test1", ttl = 3600, records = [
      { preference = 10, exchange = "mx1.contoso.com" },
      { preference = 20, exchange = "backupmx.contoso.com" }
    ] },
    { name = "test2", ttl = 1800, tags = { "hello" = "world" }, records = [
      { preference = 30, exchange = "matrix.contoso.com" }
    ] }
  ]
  ptr_records = [
    { name = "test1", ttl = 1800, records = ["test.example.com", "test2.example.com"] },
    { name = "test2", ttl = 3600, records = ["test3.example.com"], tags = { "hello" = "world" } }
  ]
  srv_records = [
    { name = "test1", ttl = 3600, records = [
      { priority = 10, weight = 20, port = 80, target = "srv1.contoso.com" },
      { priority = 20, weight = 30, port = 80, target = "srv2.contoso.com" }
    ] },
    { name = "test2", ttl = 1800, records = [
      { priority = 30, weight = 40, port = 40, target = "srv3.contoso.com" }
    ] }
  ]
  txt_records = [
    { name = "test1", ttl = 1800, records = ["v=spf1 mx ~all", "v=spf2 mx ~all"] },
    { name = "test2", ttl = 3600, records = ["v=spf3 mx ~all"] }
  ]
}

run "plan" {
  command = plan

  variables {
    name                = "${run.setup.workspace_id}.com"
    resource_group_name = run.setup.resource_group_name
    virtual_network_links = [
      { name = "${run.setup.workspace_id}1", virtual_network_id = run.setup.virtual_network_id_1, registration_enabled = true },
      { name = "${run.setup.workspace_id}2", virtual_network_id = run.setup.virtual_network_id_2 },
    ]
  }

  assert {
    condition     = azurerm_private_dns_zone.pdz.name == var.name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_zone.pdz.resource_group_name == run.setup.resource_group_name
    error_message = ""
  }

  ##### REGISTRO SOA
  
  assert {
    condition     = azurerm_private_dns_zone.pdz.soa_record[0].email == var.soa_record.email
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_zone.pdz.soa_record[0].ttl == var.soa_record.ttl
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_zone.pdz.soa_record[0].expire_time == var.soa_record.expire_time
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_zone.pdz.soa_record[0].minimum_ttl == var.soa_record.minimum_ttl
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_zone.pdz.soa_record[0].refresh_time == var.soa_record.refresh_time
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_zone.pdz.soa_record[0].retry_time == var.soa_record.retry_time
    error_message = ""
  }

  ##### REGISTROS A

  assert {
    condition     = azurerm_private_dns_a_record.a_records["test1"].name == var.a_records[0].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_a_record.a_records["test1"].ttl == var.a_records[0].ttl
    error_message = ""
  }

  assert {
    condition     = tolist(azurerm_private_dns_a_record.a_records["test1"].records) == var.a_records[0].records
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_a_record.a_records["test1"].tags == var.a_records[0].tags
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_a_record.a_records["test2"].name == var.a_records[1].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_a_record.a_records["test2"].ttl == var.a_records[1].ttl
    error_message = ""
  }

  assert {
    condition     = tolist(azurerm_private_dns_a_record.a_records["test2"].records) == var.a_records[1].records
    error_message = ""
  }

  ##### REGISTROS AAAA

  assert {
    condition     = azurerm_private_dns_aaaa_record.aaaa_records["test1"].name == var.aaaa_records[0].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_aaaa_record.aaaa_records["test1"].ttl == var.aaaa_records[0].ttl
    error_message = ""
  }

  assert {
    condition     = tolist(azurerm_private_dns_aaaa_record.aaaa_records["test1"].records) == var.aaaa_records[0].records
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_aaaa_record.aaaa_records["test1"].tags == var.aaaa_records[0].tags
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_aaaa_record.aaaa_records["test2"].name == var.aaaa_records[1].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_aaaa_record.aaaa_records["test2"].ttl == var.aaaa_records[1].ttl
    error_message = ""
  }

  assert {
    condition     = tolist(azurerm_private_dns_aaaa_record.aaaa_records["test2"].records) == var.aaaa_records[1].records
    error_message = ""
  }

  ##### REGISTROS CNAME

  assert {
    condition     = azurerm_private_dns_cname_record.cname_records["test11"].name == var.cname_records[0].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_cname_record.cname_records["test11"].ttl == var.cname_records[0].ttl
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_cname_record.cname_records["test11"].record == var.cname_records[0].record
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_cname_record.cname_records["test11"].tags == var.cname_records[0].tags
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_cname_record.cname_records["test22"].name == var.cname_records[1].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_cname_record.cname_records["test22"].ttl == var.cname_records[1].ttl
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_cname_record.cname_records["test22"].record == var.cname_records[1].record
    error_message = ""
  }

  ##### REGISTROS MX

  assert {
    condition     = azurerm_private_dns_mx_record.mx_records["test1"].name == var.mx_records[0].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_mx_record.mx_records["test1"].ttl == var.mx_records[0].ttl
    error_message = ""
  }

  assert {
    condition     = ({ for mx in azurerm_private_dns_mx_record.mx_records["test1"].record : mx.preference => mx })[10].preference == var.mx_records[0].records[0].preference
    error_message = ""
  }

  assert {
    condition     = ({ for mx in azurerm_private_dns_mx_record.mx_records["test1"].record : mx.preference => mx })[10].exchange == var.mx_records[0].records[0].exchange
    error_message = ""
  }

  assert {
    condition     = ({ for mx in azurerm_private_dns_mx_record.mx_records["test1"].record : mx.preference => mx })[20].preference == var.mx_records[0].records[1].preference
    error_message = ""
  }

  assert {
    condition     = ({ for mx in azurerm_private_dns_mx_record.mx_records["test1"].record : mx.preference => mx })[20].exchange == var.mx_records[0].records[1].exchange
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_mx_record.mx_records["test2"].name == var.mx_records[1].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_mx_record.mx_records["test2"].ttl == var.mx_records[1].ttl
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_mx_record.mx_records["test2"].tags == var.mx_records[1].tags
    error_message = ""
  }

  assert {
    condition     = ({ for mx in azurerm_private_dns_mx_record.mx_records["test2"].record : mx.preference => mx })[30].preference == var.mx_records[1].records[0].preference
    error_message = ""
  }

  assert {
    condition     = ({ for mx in azurerm_private_dns_mx_record.mx_records["test2"].record : mx.preference => mx })[30].exchange == var.mx_records[1].records[0].exchange
    error_message = ""
  }

  ##### REGISTROS PTR

  assert {
    condition     = azurerm_private_dns_ptr_record.ptr_records["test1"].name == var.ptr_records[0].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_ptr_record.ptr_records["test1"].ttl == var.ptr_records[0].ttl
    error_message = ""
  }

  assert {
    condition     = tolist(azurerm_private_dns_ptr_record.ptr_records["test1"].records) == var.ptr_records[0].records
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_ptr_record.ptr_records["test1"].tags == var.ptr_records[0].tags
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_ptr_record.ptr_records["test2"].name == var.ptr_records[1].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_ptr_record.ptr_records["test2"].ttl == var.ptr_records[1].ttl
    error_message = ""
  }

  assert {
    condition     = tolist(azurerm_private_dns_ptr_record.ptr_records["test2"].records) == var.ptr_records[1].records
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_ptr_record.ptr_records["test2"].tags == var.ptr_records[1].tags
    error_message = ""
  }

  ##### REGISTROS SRV

  assert {
    condition     = azurerm_private_dns_srv_record.srv_records["test1"].name == var.srv_records[0].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_srv_record.srv_records["test1"].ttl == var.srv_records[0].ttl
    error_message = ""
  }

  assert {
    condition     = ({ for srv in azurerm_private_dns_srv_record.srv_records["test1"].record : srv.priority => srv })[10].priority == var.srv_records[0].records[0].priority
    error_message = ""
  }

  assert {
    condition     = ({ for srv in azurerm_private_dns_srv_record.srv_records["test1"].record : srv.priority => srv })[10].weight == var.srv_records[0].records[0].weight
    error_message = ""
  }

  assert {
    condition     = ({ for srv in azurerm_private_dns_srv_record.srv_records["test1"].record : srv.priority => srv })[10].port == var.srv_records[0].records[0].port
    error_message = ""
  }

  assert {
    condition     = ({ for srv in azurerm_private_dns_srv_record.srv_records["test1"].record : srv.priority => srv })[10].target == var.srv_records[0].records[0].target
    error_message = ""
  }

  assert {
    condition     = ({ for srv in azurerm_private_dns_srv_record.srv_records["test1"].record : srv.priority => srv })[20].priority == var.srv_records[0].records[1].priority
    error_message = ""
  }

  assert {
    condition     = ({ for srv in azurerm_private_dns_srv_record.srv_records["test1"].record : srv.priority => srv })[20].weight == var.srv_records[0].records[1].weight
    error_message = ""
  }

  assert {
    condition     = ({ for srv in azurerm_private_dns_srv_record.srv_records["test1"].record : srv.priority => srv })[20].port == var.srv_records[0].records[1].port
    error_message = ""
  }

  assert {
    condition     = ({ for srv in azurerm_private_dns_srv_record.srv_records["test1"].record : srv.priority => srv })[20].target == var.srv_records[0].records[1].target
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_srv_record.srv_records["test2"].name == var.srv_records[1].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_srv_record.srv_records["test2"].ttl == var.srv_records[1].ttl
    error_message = ""
  }

  assert {
    condition     = ({ for srv in azurerm_private_dns_srv_record.srv_records["test2"].record : srv.priority => srv })[30].priority == var.srv_records[1].records[0].priority
    error_message = ""
  }

  assert {
    condition     = ({ for srv in azurerm_private_dns_srv_record.srv_records["test2"].record : srv.priority => srv })[30].weight == var.srv_records[1].records[0].weight
    error_message = ""
  }

  assert {
    condition     = ({ for srv in azurerm_private_dns_srv_record.srv_records["test2"].record : srv.priority => srv })[30].port == var.srv_records[1].records[0].port
    error_message = ""
  }

  assert {
    condition     = ({ for srv in azurerm_private_dns_srv_record.srv_records["test2"].record : srv.priority => srv })[30].target == var.srv_records[1].records[0].target
    error_message = ""
  }

  ##### REGISTROS TXT

  assert {
    condition     = azurerm_private_dns_txt_record.txt_records["test1"].name == var.txt_records[0].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_txt_record.txt_records["test1"].ttl == var.txt_records[0].ttl
    error_message = ""
  }

  assert {
    condition     = tolist([for txt in azurerm_private_dns_txt_record.txt_records["test1"].record : txt.value]) == var.txt_records[0].records
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_txt_record.txt_records["test1"].tags == var.txt_records[0].tags
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_txt_record.txt_records["test2"].name == var.txt_records[1].name
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_txt_record.txt_records["test2"].ttl == var.txt_records[1].ttl
    error_message = ""
  }

  assert {
    condition     = tolist([for txt in azurerm_private_dns_txt_record.txt_records["test2"].record : txt.value]) == var.txt_records[1].records
    error_message = ""
  }

  assert {
    condition     = azurerm_private_dns_txt_record.txt_records["test2"].tags == var.txt_records[1].tags
    error_message = ""
  }
}

// run "apply" {
//   command = apply

//   variables {
//     name                = "${run.setup.workspace_id}.com"
//     resource_group_name = run.setup.resource_group_name
//   }
// }
