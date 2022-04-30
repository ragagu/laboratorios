# Creación de red virtual

resource "azurerm_virtual_network" "myNet" {
    name = "lab-0001-vnet"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = "lab-0001"
    }
}

# Creación de subnet

resource "azurerm_subnet" "mySubnet" {
    name = "subnet-lab-0001"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.myNet.name
    address_prefixes = ["10.0.1.0/24"]
}

# Creación de interfaz de red para VM master

resource "azurerm_network_interface" "nicmaster" {
    name = "nic-master"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

      ip_configuration {
      name = "ipconf-master"
      subnet_id = azurerm_subnet.mySubnet.id
      private_ip_address_allocation = "Static"
      private_ip_address = "10.0.1.10"
      public_ip_address_id = azurerm_public_ip.myPublicIpMaster.id
}

      tags = {
          environment = "lab-0001"
      }
}

# Creación de interfaces de red para VMs worker01 y worker02

resource "azurerm_network_interface" "nicworkers" {
    name = "nic-${var.workers[count.index]}"
    count = length(var.workers)
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

      ip_configuration {
      name = "ipconf-${var.workers[count.index]}"
      subnet_id = azurerm_subnet.mySubnet.id
      private_ip_address_allocation = "Static"
      private_ip_address = "10.0.1.${count.index + 11}"
      public_ip_address_id = azurerm_public_ip.myPublicIpWorkers[count.index].id
}

      tags = {
          environment = "lab-0001"
      }
}

# IP pública VM master

resource "azurerm_public_ip" "myPublicIpMaster" {
    name = "publicip-master"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method = "Dynamic"
    sku = "Basic"

      tags = {
          environment = "lab-lab0001"
      }
}

# IP pública VMs worker01 y worker02

resource "azurerm_public_ip" "myPublicIpWorkers" {
    name = "publicip-${var.workers[count.index]}"
    count = length(var.workers)
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method = "Dynamic"
    sku = "Basic"

      tags = {
          environment = "lab-0001"
      }
}

