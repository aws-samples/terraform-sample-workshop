// Terraform remote statate
data "terraform_remote_state" "vpc" {
 backend     = "s3"

 config = {
   bucket = "<YOUR BUCKET NAME GOES HERE>" // Your bucket name
   key    = "environments/providers/aws/prd/infraestructure/vpc/main.tf"
   region = "us-east-1"
 }
}