variable "prefix" {
  type        = list(string)
  default     = []
  description = "It is not recommended that you use prefix by azure you should be using a suffix for your resources."
}

variable "suffix" {
  type        = list(string)
  default     = []
  description = "It is recommended that you specify a suffix for consistency. please use only lowercase characters when possible"
}

variable "suffix-padding" {
  type        = number
  default     = 0
  description = "A padding length for the resource name which can be used to add your original unique string to the suffix. please use name_with_pad or name_unique_with_pad"
}

variable "unique-seed" {
  description = "Custom value for the random characters to be used"
  type        = string
  default     = ""
}

variable "unique-length" {
  description = "Max length of the uniqueness suffix to be added"
  type        = number
  default     = 4
}

variable "unique-include-numbers" {
  description = "If you want to include numbers in the unique generation"
  type        = bool
  default     = true
}

variable "suffix-hash-length" {
  description = "A length of the hash string for short_name or short_name_unique"
  type        = number
  default     = 16
}
