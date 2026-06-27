variable "parameters" {
  description = "Parameters for resource groups to be created."
  type = map(object({
    name       = string
    location   = string
    lock_level = optional(string)
    tags       = optional(map(string))
  }))
}
