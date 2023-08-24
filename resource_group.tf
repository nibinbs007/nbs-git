resource "azurerm_resource_group" "cmt-git" {
  name     = var.resource_group_name
  location = var.location_name
}