variable "db_password" {
  description = "Password for the managed RDS MySQL database"
  type        = string
  sensitive   = true
}
