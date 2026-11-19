#Variabile per ip
variable "my_ip" {
  description = "IP pubblico per SSH, formato x.x.x.x/32"
  type        = string
}
variable "public_key_path" {
  type    = string
  default = "~/.ssh/lab-docker.pub"
}

variable "ssh" {
  description = "Porta SSH"
  type        = number
}

variable "http" {
  description = "Porta http"
  type        = number
}