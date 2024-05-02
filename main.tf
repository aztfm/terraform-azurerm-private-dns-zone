resource "azurerm_private_dns_zone" "pdz" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags

  dynamic "soa_record" {
    for_each = var.soa_record != null ? [""] : []

    content {
      email        = var.soa_record.email
      tags         = var.soa_record.tags
      expire_time  = var.soa_record.expire_time
      minimum_ttl  = var.soa_record.minimum_ttl
      refresh_time = var.soa_record.refresh_time
      retry_time   = var.soa_record.retry_time
      ttl          = var.soa_record.ttl
    }
  }
}

resource "azurerm_private_dns_a_record" "a_records" {
  for_each            = { for a_record in var.a_records : a_record.name => a_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.pdz.resource_group_name
  zone_name           = azurerm_private_dns_zone.pdz.name
  tags                = each.value.tags
  ttl                 = each.value.ttl
  records             = each.value.records
}

resource "azurerm_private_dns_aaaa_record" "aaaa_records" {
  for_each            = { for aaaa_record in var.aaaa_records : aaaa_record.name => aaaa_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.pdz.resource_group_name
  zone_name           = azurerm_private_dns_zone.pdz.name
  tags                = each.value.tags
  ttl                 = each.value.ttl
  records             = each.value.records
}

resource "azurerm_private_dns_cname_record" "cname_records" {
  for_each            = { for cname_record in var.cname_records : cname_record.name => cname_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.pdz.resource_group_name
  zone_name           = azurerm_private_dns_zone.pdz.name
  tags                = each.value.tags
  ttl                 = each.value.ttl
  record              = each.value.record
}

resource "azurerm_private_dns_mx_record" "mx_records" {
  for_each            = { for mx_record in var.mx_records : mx_record.name => mx_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.pdz.resource_group_name
  zone_name           = azurerm_private_dns_zone.pdz.name
  tags                = each.value.tags
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = each.value.records

    content {
      preference = record.value.preference
      exchange   = record.value.exchange
    }
  }
}

resource "azurerm_private_dns_ptr_record" "ptr_records" {
  for_each            = { for ptr_record in var.ptr_records : ptr_record.name => ptr_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.pdz.resource_group_name
  zone_name           = azurerm_private_dns_zone.pdz.name
  tags                = each.value.tags
  ttl                 = each.value.ttl
  records             = each.value.records
}

resource "azurerm_private_dns_srv_record" "srv_records" {
  for_each            = { for srv_record in var.srv_records : srv_record.name => srv_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.pdz.resource_group_name
  zone_name           = azurerm_private_dns_zone.pdz.name
  tags                = lookup(each.value, "tags", null)
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
}

resource "azurerm_private_dns_txt_record" "txt_records" {
  for_each            = { for txt_record in var.txt_records : txt_record.name => txt_record }
  name                = each.value.name
  resource_group_name = azurerm_private_dns_zone.pdz.resource_group_name
  zone_name           = azurerm_private_dns_zone.pdz.name
  tags                = lookup(each.value, "tags", null)
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = each.value.records

    content {
      value = record.value
    }
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "links" {
  for_each              = { for private_link in var.virtual_network_links : private_link.name => private_link }
  name                  = each.value.name
  resource_group_name   = azurerm_private_dns_zone.pdz.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.pdz.name
  virtual_network_id    = each.value.virtual_network_id
  tags                  = each.value.tags
  registration_enabled  = each.value.registration_enabled
}
