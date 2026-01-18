variable "subscription_name" {
  type        = string
  description = "Azure subscription name (for your reference/documentation)."
  default     = "LOG(N) Pacific - Cyber Range 1"
}

variable "resource_group_name" {
  type        = string
  description = "Existing cyber range resource group to deploy into."
  default     = "student-rg-5a1a409ddae648ace835da2376f9b16ffc87e31769233f69fcf269fadcad2f64"
}

variable "location" {
  type        = string
  description = "Azure region for resources."
  default     = "eastus2"
}

variable "vm_name" {
  type        = string
  description = "Name of the Linux VM."
  default     = "RiseUp-Migration-Lab"
}

variable "admin_username" {
  type        = string
  description = "Linux admin username."
  default     = "LabUser"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to your existing SSH public key (id_ed25519.pub or similar)."
  default     = "C:\\Users\\jamal\\.ssh\\RiseUp-Migration-Lab.pub"
}

variable "vnet_name" {
  type        = string
  description = "Existing VNet name in the cyber range."
  default     = "Cyber-Range-VNet"
}
variable "vnet_resource_group_name" {
  type        = string
  description = "Resource group where the existing VNet lives (often different from the deployment RG in cyber ranges)."
  default     = "Cyber-Range-Admin"
}
variable "subnet_name" {
  type        = string
  description = "Existing subnet name inside the cyber range VNet (you will look this up)."
  default     = "Cyber-Range-Subnet"
}

variable "public_ip_name" {
  type        = string
  description = "Public IP resource name."
  default     = "RiseUp-Migration-Lab-ip"
}

variable "vm_size" {
  type        = string
  description = "Azure VM size."
  default     = "Standard_DS1_v2"
}

variable "allowed_admin_ip" {
  type        = string
  description = "Your public IP in CIDR notation for locked-down admin access."
  default     = "97.105.176.135/32"
}
