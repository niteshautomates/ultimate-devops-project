variable "role_name" {
  description = "This is name for IAM role"
  type        = string
  default     = "EC2AssumeRole"
}


variable "force_detach_policies" {
  type        = bool
  default     = true
  description = "Forcefully detach policy from IAM role before deleting"
}

variable "assume_role_policy" {
  description = "Policy that grants an entity permission to assume the role"
  type        = any
  default     = "dummy"
}

variable "description" {
  type    = string
  default = "The description of the IAM role"
}

variable "max_session_duration" {
  description = "Max duration for IAM role"
  type        = number
  default     = 3600
}

variable "custom_iam_policies" {
  description = "The Custom IAM policies to attached with the IAM role"
  type = list(object({
    name            = string
    description     = string
    policy_document = string
  }))
  default = []
}


variable "path" {
  type        = string
  description = "The Path to the Role"
  default     = "/"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags"
}


variable "managed_iam_ploicies" {
  type        = list(string)
  default     = []
  description = "The list of managed policies that needs to be attached to the IAM Role"
}
