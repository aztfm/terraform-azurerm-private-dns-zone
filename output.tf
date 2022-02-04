output "id" {
  value       = azurerm_private_dns_zone.dns.id
  description = "The Private DNS Zone ID."
}

output "name" {
  value       = azurerm_private_dns_zone.dns.name
  description = "The name of the Private DNS zone."
}

output "resource_group_name" {
  value       = azurerm_private_dns_zone.dns.resource_group_name
  description = "The name of the resource group in which to create the Private DNS zone."
}

output "number_of_record_sets" {
  value       = azurerm_private_dns_zone.dns.number_of_record_sets
  description = "The current number of record sets in this Private DNS zone."
}

output "max_number_of_record_sets" {
  value       = azurerm_private_dns_zone.dns.max_number_of_record_sets
  description = "The maximum number of record sets that can be created in this Private DNS zone."
}

output "max_number_of_virtual_network_links" {
  value       = azurerm_private_dns_zone.dns.max_number_of_virtual_network_links
  description = "The maximum number of virtual networks that can be linked to this Private DNS zone."
}

output "max_number_of_virtual_network_links_with_registration" {
  value       = azurerm_private_dns_zone.dns.max_number_of_virtual_network_links_with_registration
  description = "The maximum number of virtual networks that can be linked to this Private DNS zone with registration enabled."
}

output "soa_record_fqdn" {
  value       = azurerm_private_dns_zone.dns.soa_record[0].fqdn
  description = "The fqdn for the SOA record."
}

output "soa_record_email" {
  value       = azurerm_private_dns_zone.dns.soa_record[0].email
  description = "The email contact for the SOA record."
}

output "soa_record_host_name" {
  value       = azurerm_private_dns_zone.dns.soa_record[0].host_name
  description = "The host name for the SOA record."
}

output "soa_record_refresh_time" {
  value       = azurerm_private_dns_zone.dns.soa_record[0].refresh_time
  description = "The refresh time for the SOA record."
}

output "soa_record_retry_time" {
  value       = azurerm_private_dns_zone.dns.soa_record[0].retry_time
  description = "The retry time for the SOA record."
}

output "soa_record_expire_time" {
  value       = azurerm_private_dns_zone.dns.soa_record[0].expire_time
  description = "The expire time for the SOA record."
}

output "soa_record_ttl" {
  value       = azurerm_private_dns_zone.dns.soa_record[0].ttl
  description = "The Time To Live of the SOA Record in seconds."
}

output "soa_record_minimum_ttl" {
  value       = azurerm_private_dns_zone.dns.soa_record[0].minimum_ttl
  description = "The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration."
}

output "soa_record_serial_number" {
  value       = azurerm_private_dns_zone.dns.soa_record[0].serial_number
  description = "The serical number for the SOA record."
}

output "soa_record_tags" {
  value       = azurerm_private_dns_zone.dns.soa_record[0].tags
  description = "The tags of the SOA record."
}

output "a_records" {
  value       = { for a_record in azurerm_private_dns_a_record.a_records : a_record.name => a_record }
  description = "Blocks containing configuration of each A record."
  # module.MODULE_NAME.a_records["A_RECORD_NAME"].id
}

output "aaaa_records" {
  value       = { for aaaa_record in azurerm_private_dns_aaaa_record.aaaa_records : aaaa_record.name => aaaa_record }
  description = "Blocks containing configuration of each AAAA record."
  # module.MODULE_NAME.aaaa_records["AAAA_RECORD_NAME"].id
}

output "cname_records" {
  value       = { for cname_record in azurerm_private_dns_cname_record.cname_records : cname_record.name => cname_record }
  description = "Blocks containing configuration of each CNAME record."
  # module.MODULE_NAME.cname_records["CNAME_RECORD_NAME"].id
}

output "mx_records" {
  value       = { for mx_record in azurerm_private_dns_mx_record.mx_records : mx_record.name => mx_record }
  description = "Blocks containing configuration of each MX record."
  # module.MODULE_NAME.mx_records["MX_RECORD_NAME"].id
}

output "ptr_records" {
  value       = { for ptr_record in azurerm_private_dns_ptr_record.ptr_records : ptr_record.name => ptr_record }
  description = "Blocks containing configuration of each PTR record."
  # module.MODULE_NAME.ptr_records["PTS_RECORD_NAME"].id
}

output "srv_records" {
  value       = { for srv_record in azurerm_private_dns_srv_record.srv_records : srv_record.name => srv_record }
  description = "Blocks containing configuration of each SRV record."
  # module.MODULE_NAME.srv_records["SRV_RECORD_NAME"].id
}

output "txt_records" {
  value       = { for txt_record in azurerm_private_dns_txt_record.txt_records : txt_record.name => txt_record }
  description = "Blocks containing configuration of each TXT record."
  # module.MODULE_NAME.txt_records["TXT_RECORD_NAME"].id
}

output "TEXT" {
  value       = azurerm_private_dns_zone_virtual_network_link.private_links #{ for private_link in azurerm_private_dns_zone_virtual_network_link.private_links : private_link.name => private_link }
  description = ""
  # module.MODULE_NAME.subnets["SUBNET_NAME"].id
}

output "tags" {
  value       = azurerm_private_dns_zone.dns.tags
  description = "The tags assigned to the resource."
}
