locals {
  project                 = var.project
  environment             = var.environment
  postgres_admin_username = "genomicsetladmin"

  tags = {
    Author     = "Matko Soric"
    AuthorMail = "soric.matko@gmail.com"
  }
}