# Azure Virtual Network Peering - Terraform Module
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/aztfm/terraform-azurerm-private-dns-zone/Release?label=Testing&logo=GitHub)
[![Terraform Registry](https://img.shields.io/badge/Terraform-registry-blueviolet.svg?logo=terraform)](https://registry.terraform.io/modules/aztfm/private-dns-zone/azurerm/)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/aztfm/terraform-azurerm-private-dns-zone?label=Release)

## Version compatibility

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 1.x.x       | >= 0.13.x         | >= 2.0.0        |

## Parameters

The following parameters are supported:

| Name                  | Description                                                             |        Type         | Default | Required |
| --------------------- | ----------------------------------------------------------------------- | :-----------------: | :-----: | :------: |
| name                  | The name of the private DNS zone.                                       |      `string`       |   n/a   |   yes    |
| resource\_group\_name | The name of the resource group in which to create the private DNS zone. |      `string`       |   n/a   |   yes    |
| soa\_record           | Enables you to manage DNS SOA Record within Azure Private DNS.          |    `map(string)`    | `null`  |    no    |
| a\_records            | Enables you to manage DNS A Records within Azure Private DNS.           | `list(map(string))` |  `[]`   |    no    |
| aaaa\_records         | Enables you to manage DNS A Records within Azure Private DNS.           | `list(map(string))` |  `[]`   |    no    |
| cname\_records        | Enables you to manage DNS CNAME Records within Azure Private DNS.       | `list(map(string))` |  `[]`   |    no    |
| mx\_records           | Enables you to manage DNS MX Records within Azure Private DNS.          | `list(map(string))` |  `[]`   |    no    |
| ptr\_records          | Enables you to manage DNS PTR Records within Azure Private DNS.         | `list(map(string))` |  `[]`   |    no    |
| srv\_records          | Enables you to manage DNS SRV Records within Azure Private DNS.         | `list(map(string))` |  `[]`   |    no    |
| txt\_records          | Enables you to manage DNS TXT Records within Azure Private DNS.         | `list(map(string))` |  `[]`   |    no    |
| private\_links        | Enables you to manage Private DNS zone Virtual Network Links.           | `list(map(string))` |  `[]`   |    no    |
| tags                  | A mapping of tags to assign to the resource.                            |    `map(string)`    |  `{}`   |    no    |


The `soa_record` supports the following:

| Name          | Description                                                                                                        |     Type      | Default | Required |
| ------------- | ------------------------------------------------------------------------------------------------------------------ | :-----------: | :-----: | :------: |
| email         | The email contact for the SOA record.                                                                              |   `string`    |   n/a   |   yes    |
| expire\_time  | The expire time for the SOA record.                                                                                |   `number`    | `null`  |    no    |
| minimum\_ttl  | The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration. |   `number`    | `null`  |    no    |
| refresh\_time | The refresh time for the SOA record.                                                                               |   `number`    | `null`  |    no    |
| retry\_time   | The Time To Live of the SOA Record in seconds.                                                                     |   `number`    | `null`  |    no    |
| ttl           | The Time To Live of the SOA Record in seconds.                                                                     |   `number`    | `null`  |    no    |
| tags          | A mapping of tags to assign to the resource.                                                                       | `map(string)` | `null`  |    no    |

The `a_records` supports the following:

| Name    | Description                                          |      Type      | Default | Required |
| ------- | ---------------------------------------------------- | :------------: | :-----: | :------: |
| name    | The name of the DNS A Record.                        |    `string`    |   n/a   |   yes    |
| ttl     | The Time To Live (TTL) of the DNS record in seconds. |    `number`    |   n/a   |   yes    |
| records | List of IPv4 Addresses.                              | `list(string)` |   n/a   |   yes    |
| tags    | A mapping of tags to assign to the resource.         | `map(string)`  |  `{}`   |    no    |

The `aaaa_records` supports the following:

| Name    | Description                                          |      Type      | Default | Required |
| ------- | ---------------------------------------------------- | :------------: | :-----: | :------: |
| name    | The name of the DNS AAAA Record.                     |    `string`    |   n/a   |   yes    |
| ttl     | The Time To Live (TTL) of the DNS record in seconds. |    `number`    |   n/a   |   yes    |
| records | A list of IPv6 Addresses.                            | `list(string)` |   n/a   |   yes    |
| tags    | A mapping of tags to assign to the resource.         | `map(string)`  |  `{}`   |    no    |

The `cname_records` supports the following:

| Name    | Description                                          |     Type      | Default | Required |
| ------- | ---------------------------------------------------- | :-----------: | :-----: | :------: |
| name    | The name of the DNS CNAME Record.                    |   `string`    |   n/a   |   yes    |
| ttl     | The Time To Live (TTL) of the DNS record in seconds. |   `number`    |   n/a   |   yes    |
| records | The target of the CNAME.                             |   `string`    |   n/a   |   yes    |
| tags    | A mapping of tags to assign to the resource.         | `map(string)` |  `{}`   |    no    |

The `mx_records` supports the following:

| Name    | Description                                          |     Type      | Default | Required |
| ------- | ---------------------------------------------------- | :-----------: | :-----: | :------: |
| name    | The name of the DNS MX Record.                       |   `string`    |   n/a   |   yes    |
| ttl     | The Time To Live (TTL) of the DNS record in seconds. |   `number`    |   n/a   |   yes    |
| records |                                                      |               |         |          |
| tags    | A mapping of tags to assign to the resource.         | `map(string)` |  `{}`   |    no    |

The `mx_records.records` supports the following:

| Name       | Description                                      |   Type   | Default | Required |
| ---------- | ------------------------------------------------ | :------: | :-----: | :------: |
| preference | The preference of the MX record.                 | `number` |   n/a   |   yes    |
| exchange   | The FQDN of the exchange to MX record points to. | `string` |   n/a   |   yes    |

The `ptr_records` supports the following:

| Name    | Description                                          |      Type      | Default | Required |
| ------- | ---------------------------------------------------- | :------------: | :-----: | :------: |
| name    | The name of the DNS PTR Record.                      |    `string`    |   n/a   |   yes    |
| ttl     | The Time To Live (TTL) of the DNS record in seconds. |    `number`    |   n/a   |   yes    |
| records | List of Fully Qualified Domain Names.                | `list(string)` |   n/a   |   yes    |
| tags    | A mapping of tags to assign to the resource.         | `map(string)`  |  `{}`   |    no    |

The `srv_records` supports the following:

| Name    | Description                                          |     Type      | Default | Required |
| ------- | ---------------------------------------------------- | :-----------: | :-----: | :------: |
| name    | The name of the DNS SRV Record.                      |   `string`    |   n/a   |   yes    |
| ttl     | The Time To Live (TTL) of the DNS record in seconds. |   `number`    |   n/a   |   yes    |
| records |                                                      |               |   n/a   |   yes    |
| tags    | A mapping of tags to assign to the resource.         | `map(string)` |  `{}`   |    no    |

The `srv_records.records` supports the following:

| Name     | Description                           |   Type   | Default | Required |
| -------- | ------------------------------------- | :------: | :-----: | :------: |
| priority | The priority of the SRV record.       | `number` |   n/a   |   yes    |
| weight   | The Weight of the SRV record.         | `number` |   n/a   |   yes    |
| port     | The Port the service is listening on. | `number` |   n/a   |   yes    |
| target   | The FQDN of the service.              | `string` |   n/a   |   yes    |

The `txt_records` supports the following:

| Name    | Description                                  |     Type      | Default | Required |
| ------- | -------------------------------------------- | :-----------: | :-----: | :------: |
| name    |                                              |   `string`    |   n/a   |   yes    |
| ttl     |                                              |               |         |          |
| records |                                              |               |         |          |
| tags    | A mapping of tags to assign to the resource. | `map(string)` |  `{}`   |    no    |

The `private_links` supports the following:

| Name                 | Description                                  |     Type      | Default | Required |
| -------------------- | -------------------------------------------- | :-----------: | :-----: | :------: |
| name                 |                                              |   `string`    |   n/a   |   yes    |
| virtual_network_id   |                                              |               |         |          |
| registration_enabled |                                              |               |         |          |
| tags                 | A mapping of tags to assign to the resource. | `map(string)` |  `{}`   |    no    |

## Outputs

The following outputs are exported:

| Name     | Description                                      |
| -------- | ------------------------------------------------ |
| peerings | Blocks containing configuration of each peering. |
