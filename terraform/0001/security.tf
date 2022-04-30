# Grupo de seguridad de red

resource "azurerm_network_security_group" "mySecGroup" {
    name = "nsg-k8s"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name = "SSH"
        priority = "1001"
        direction ="Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "lab-0001"
    }
}

# Vincular grupo de seguridad de red con interfaz de red de vm master

resource "azurerm_network_interface_security_group_association" "associationmaster" {
    network_interface_id = azurerm_network_interface.nicmaster.id
    network_security_group_id = azurerm_network_security_group.mySecGroup.id
}


# Vincular grupo de seguridad de red con interfaz de red de worker01 y worker02

resource "azurerm_network_interface_security_group_association" "associationworers" {
    count = length(var.workers)
    network_interface_id = azurerm_network_interface.nicworkers[count.index].id
    network_security_group_id = azurerm_network_security_group.mySecGroup.id
}
