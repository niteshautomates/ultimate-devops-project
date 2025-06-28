variable "deletion_window_in_days" {
  type = number
  default = 7
}

variable "tags" {
  type = map(string)
}

variable "project_name" {
  type = string
  description = "Project Name"
}

