# Variable aplicable a todos los recursos

variable "location" {
  type = string
  description = "Región donde se crearán los recursos de Azure"
  default = "West Europe"
}

# Variable aplicable solo a la VM master

variable "vm_size_master" {
  type = string
  description = "Talla para la VM master"
  default = "Standard_B2s" # 2vCPU, 4GB RAM
}

# Variables aplicables a las VMs worker01 y worker02

variable "vm_size_workers" {
  type = string
  description = "Talla de la VM"
  default = "Standard_B1ms" # 1vCPU, 2GB RAM
}

variable "workers" {
  type = list(string)
  description = "Despliegue de VMs worker01 y worker 02"
  default = ["worker01", "worker02"]
}
