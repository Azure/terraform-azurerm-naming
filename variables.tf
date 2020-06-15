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
  description = "Custom value for the randon charecters to be used"
  type        = string
  default     = ""
}

variable "unique-length" {
  description = "Max length of the uniquiness suffix to be added"
  type        = number
  default     = 4
}

variable "unique-include-numbers" {
  description = "If you want to iunclude numbers in the unique generation"
  type        = bool
  default     = true
}
