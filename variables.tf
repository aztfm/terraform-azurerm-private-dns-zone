variable "name" {
  type        = string
  description = "The name of the private DNS zone."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the private DNS zone."
}

variable "soa_record" {
  type        = map(string)
  default     = null
  description = "Enables you to manage DNS SOA Record within Azure Private DNS."
  # soa_record = { email = "", expire_time = "", minimum_ttl = "", refresh_time = "", retry_time = "", ttl = "", tags = {} }
}

variable "a_records" {
  type        = any
  default     = []
  description = "Enables you to manage DNS A Records within Azure Private DNS."
  # a_records = [{ name = "", ttl = "", records = [""], tags = {} }]
}

variable "aaaa_records" {
  type        = any
  default     = []
  description = "Enables you to manage DNS A Records within Azure Private DNS."
  # aaaa_records = [{ name = "", ttl = "", records = [""], tags = {} }]
}

variable "cname_records" {
  type        = any
  default     = []
  description = "Enables you to manage DNS CNAME Records within Azure Private DNS."
  # cname_records = [{ name = "", ttl = "", record = "", tags = {} }]
}

variable "mx_records" {
  type        = any
  default     = []
  description = "Enables you to manage DNS MX Records within Azure Private DNS."
  # mx_records = [{ name = "", ttl = "", records = [{ preference = "", exchange = "" }], tags = {} }]
}

variable "ptr_records" {
  type        = any
  default     = []
  description = "Enables you to manage DNS PTR Records within Azure Private DNS."
  # ptr_records = [{ name = "", ttl = "", records = [""], tags = {} }]
}

variable "srv_records" {
  type        = any
  default     = []
  description = "Enables you to manage DNS SRV Records within Azure Private DNS."
  # srv_records = [{ name = "", ttl = "", records = [{ priority = "", weight = "", port = "", target = "" }], tags = {} }]
}

variable "txt_records" {
  type        = any
  default     = []
  description = "Enables you to manage DNS TXT Records within Azure Private DNS."
  # srv_records = [{ name = "", ttl = "", records = [""], tags = {} }]
}

variable "private_links" {
  type        = any
  default     = []
  description = "Enables you to manage Private DNS zone Virtual Network Links. "
  # private_links = [{ name = "", virtual_network_id = "", registration_enabled = "", tags = {} }]
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource."
}

