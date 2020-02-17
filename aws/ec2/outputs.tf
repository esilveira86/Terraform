output "public_ip" {
  description = "Lista de endereços IP públicos atribuídos a instância."
  value       = aws_instance.web.public_ip
}

output "private_ip" {
  description = "Lista de endereços IP privados atribuídos a instância."
  value       = aws_instance.web.public_ip
}

output "public_dns" {
  description = "Lista de nomes DNS públicos atribuídos à instaância."
  value       = aws_instance.web.public_dns
}