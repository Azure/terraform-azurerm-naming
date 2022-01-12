variable "context" {
  type = any
  default = {
    enabled                = true
    suffix                 = null
    prefix                 = null
    unique-seed            = null
    unique-length          = null
    unique-include-numbers = null
    tags                   = {}
  }
}

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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`)."
}

variable "unique_seed" {
  description = "Custom value for the random characters to be used"
  type        = string
  default     = null
}

variable "unique_length" {
  description = "Max length of the uniqueness suffix to be added"
  type        = number
  default     = null
}

variable "unique_include_numbers" {
  description = "If you want to include numbers in the unique generation"
  type        = bool
  default     = null
}
