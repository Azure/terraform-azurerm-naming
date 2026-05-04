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

variable "resource-slug-overrides" {
  description = "Optional per-resource slug override map keyed by module output name."
  type        = map(string)
  default     = {}
  nullable    = false

  validation {
    condition     = alltrue([for slug in values(var.resource-slug-overrides) : slug != null && trimspace(slug) != ""])
    error_message = "resource-slug-overrides values must be non-null and not empty or whitespace-only."
  }
}
