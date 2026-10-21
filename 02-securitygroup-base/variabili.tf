variable "my_ip" {
  description = "IP pubblico per SSH, formato x.x.x.x/32"
  type        = string
}

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