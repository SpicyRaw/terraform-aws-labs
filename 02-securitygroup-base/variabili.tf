#Variabile per ip
variable "my_ip" {
  description = "IP pubblico per SSH, formato x.x.x.x/32"
  type        = string
}

#Variabile per porte con molteplici ingress rules

variable "http" {
  description = "Porta HHTP"
  type        = number
}

variable "https" {
  description = "Porta HTTPS"
  type        = number
}

variable "ssh" {
  description = "Porta SSH"
  type        = number
}

#Variabile per molteplice porte con un solo blocco di ingress rules dynamic block
variable "sg-demo-dynamics" {
  type = list(number)
  default = [ 80,443,22,8200,8300,9000,9300,9500]
}