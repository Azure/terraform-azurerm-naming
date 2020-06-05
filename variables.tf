variable "prefix" {
  type        = list(string)
  default     = []
  description = "It is not recommended that you use prefix by azure you should be using a suffix for your resources."
}

variable "suffix" {
  type        = list(string)
  default     = []
  description = "It is recommended that you specify a suffix for consistency. please use only lowercase charactes when possible"
}

variable "unique-seed" {
  type    = string
  default = ""
}

variable "unique-length" {
  type    = number
  default = 4
}

variable "unique-include-numbers" {
  type    = bool
  default = true
}
