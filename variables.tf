variable "name" {
  type        = string
  description = "The name of the private DNS zone."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the private DNS zone."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource."
}

variable "soa_record" {
  type = object({
    email        = string
    tags         = optional(map(string))
    expire_time  = optional(number)
    minimum_ttl  = optional(number)
    refresh_time = optional(number)
    retry_time   = optional(number)
    ttl          = optional(number)
  })
  default     = null
  description = "Enables you to manage DNS SOA Record within Azure Private DNS."
}

variable "a_records" {
  type = list(object({
    name    = string
    tags    = optional(map(string))
    ttl     = number
    records = list(string)
  }))
  default     = []
  description = "Enables you to manage DNS A Records within Azure Private DNS."
}

variable "aaaa_records" {
  type = list(object({
    name    = string
    tags    = optional(map(string))
    ttl     = number
    records = list(string)
  }))
  default     = []
  description = "Enables you to manage DNS A Records within Azure Private DNS."
}

variable "cname_records" {
  type = list(object({
    name   = string
    tags   = optional(map(string))
    ttl    = number
    record = string
  }))
  default     = []
  description = "Enables you to manage DNS CNAME Records within Azure Private DNS."
}

variable "mx_records" {
  type = list(object({
    name = string
    tags = optional(map(string))
    ttl  = number
    records = list(object({
      preference = number
      exchange   = string
    }))
  }))
  default     = []
  description = "Enables you to manage DNS MX Records within Azure Private DNS."
}

variable "ptr_records" {
  type = list(object({
    name    = string
    tags    = optional(map(string))
    ttl     = number
    records = list(string)
  }))
  default     = []
  description = "Enables you to manage DNS PTR Records within Azure Private DNS."
}

variable "srv_records" {
  type = list(object({
    name = string
    tags = optional(map(string))
    ttl  = number
    records = list(object({
      priority = number
      weight   = number
      port     = number
      target   = string
    }))
  }))
  default     = []
  description = "Enables you to manage DNS SRV Records within Azure Private DNS."
}

variable "txt_records" {
  type = list(object({
    name    = string
    tags    = optional(map(string))
    ttl     = number
    records = list(string)
  }))
  default     = []
  description = "Enables you to manage DNS TXT Records within Azure Private DNS."
}

variable "virtual_network_links" {
  type = list(object({
    name                 = string
    virtual_network_id   = string
    tags                 = optional(map(string))
    registration_enabled = optional(bool, false)
  }))
  default     = []
  description = "Enables you to manage Private DNS zone Virtual Network Links."
}
