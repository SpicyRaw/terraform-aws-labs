variable "my_ip" {
  description = "IP pubblico per SSH, formato x.x.x.x/32"
  type        = string
}

variable "http" {
  description = "Porta HHTP"
  type        = string
  default     = "80"
}

variable "https" {
  description = "Porta HTTPS"
  type        = string
  default     = "443"
}

variable "ssh" {
  description = "Porta SSH"
  type        = string
  default     = "22"
}