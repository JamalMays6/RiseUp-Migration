output "public_ip" {
  value       = azurerm_public_ip.pip.ip_address
  description = "Public IP of the VM"
}

output "ssh_command" {
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.pip.ip_address}"
  description = "SSH command to connect to the VM"
}
