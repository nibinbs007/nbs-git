#calling in existing resource group name
variable "resource_group_name" {
  default = "RG-EDMS-IPL-Cloud-HPB"
}

variable "location_name" {
  default = "southeastasia"
}

locals {
  tag = {
    email = "sheena_nibin_bahulayan@tech.gov.sg"
    Environment = "Dev"
  }
}
variable "address_space" {
  type = map
}