#calling in existing resource group name
variable "resource_group_name" {
  default = "RG-EDMS-IPL-Cloud-HPB"
}

variable "location_name" {
  default = "southeastasia"
}

locals {
  tag = {
    email = "nibin.bahulayansheena@ncs.com.sg"
    Project = "HPB"
    Environment = "Dev"
  }
}
variable "address_space" {
  type = map
}