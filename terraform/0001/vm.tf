# Creación de máquina master

resource "azurerm_linux_virtual_machine" "vmmaster" {
    name = "master"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    size = var.vm_size_master
    admin_username = "rafadmin"
    network_interface_ids = [ azurerm_network_interface.nicmaster.id ]
    disable_password_authentication = true
    admin_ssh_key {
        username = "rafadmin"
        public_key = file ("~/.ssh/id_rsa_cp2_devops.pub")
    }


    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name = "centos-8-3-free"
        product = "centos-8-3-free"
        publisher = "cognosys"
    }
  
      source_image_reference {
        publisher = "cognosys"
        offer = "centos-8-3-free"
        sku = "centos-8-3-free"
        version = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    tags = {
        environment = "lab-0001"
    }

}


# Creación de máquinas virtuales worker01 y worker02

resource "azurerm_linux_virtual_machine" "vmsworkers" {
    name = "${var.workers[count.index]}"
    count = length(var.workers)
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    size = var.vm_size_workers
    admin_username = "rafadmin"
    network_interface_ids = [ azurerm_network_interface.nicworkers[count.index].id ]
    disable_password_authentication = true

    admin_ssh_key {
        username = "rafadmin"
        public_key = file ("~/.ssh/id_rsa_cp2_devops.pub")
    }

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name = "centos-8-3-free"
        product = "centos-8-3-free"
        publisher = "cognosys"
          }

    source_image_reference {
        publisher = "cognosys"
        offer = "centos-8-3-free"
        sku = "centos-8-3-free"
        version = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    tags = {
        environment = "lab-0001"
    }
}


