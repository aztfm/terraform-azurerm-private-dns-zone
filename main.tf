resource "azurerm_private_dns_zone" "dns" {
  name                = var.name
  resource_group_name = var.resource_group_name
  dynamic "soa_record" {
    for_each = var.soa_record != null ? [""] : []
    content {
      email        = var.soa_record.email
      expire_time  = lookup(var.soa_record, "expire_time", null)
      minimum_ttl  = lookup(var.soa_record, "minimum_ttl", null)
      refresh_time = lookup(var.soa_record, "refresh_time", null)
      retry_time   = lookup(var.soa_record, "retry_time", null)
      ttl          = lookup(var.soa_record, "ttl", null)
      tags         = lookup(var.soa_record, "tags", null)
    }
  }
  tags = var.tags
}

resource "azurerm_private_dns_a_record" "a_records" {
  for_each            = { for a_record in var.a_records : a_record.name => a_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.dns.resource_group_name
  zone_name           = azurerm_private_dns_zone.dns.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_aaaa_record" "aaaa_records" {
  for_each            = { for aaaa_record in var.aaaa_records : aaaa_record.name => aaaa_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.dns.resource_group_name
  zone_name           = azurerm_private_dns_zone.dns.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_cname_record" "cname_records" {
  for_each            = { for cname_record in var.cname_records : cname_record.name => cname_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.dns.resource_group_name
  zone_name           = azurerm_private_dns_zone.dns.name
  ttl                 = each.value.ttl
  record              = each.value.record
  tags                = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_mx_record" "mx_records" {
  for_each            = { for mx_record in var.mx_records : mx_record.name => mx_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.dns.resource_group_name
  zone_name           = azurerm_private_dns_zone.dns.name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      preference = record.value.preference
      exchange   = record.value.exchange
    }
  }
  tags = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_ptr_record" "ptr_records" {
  for_each            = { for ptr_record in var.ptr_records : ptr_record.name => ptr_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.dns.resource_group_name
  zone_name           = azurerm_private_dns_zone.dns.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_srv_record" "srv_records" {
  for_each            = { for srv_record in var.srv_records : srv_record.name => srv_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.dns.resource_group_name
  zone_name           = azurerm_private_dns_zone.dns.name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      priority = record.value.priority
      weight   = record.value.weight
      port     = record.value.port
      target   = record.value.target
    }
  }
  tags = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_txt_record" "txt_records" {
  for_each            = { for txt_record in var.txt_records : txt_record.name => txt_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.dns.resource_group_name
  zone_name           = azurerm_private_dns_zone.dns.name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value
    }
  }
  tags = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_links" {
  for_each              = { for private_link in var.private_links : private_link.name => private_link }
  name                  = each.value.name
  resource_group_name   = azurerm_private_dns_zone.dns.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = each.value.virtual_network_id
  registration_enabled  = lookup(each.value, "registration_enabled", null)
  tags                  = lookup(each.value, "tags", null)
}
