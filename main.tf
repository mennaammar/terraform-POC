##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "example"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = [ "ssh-tcp"]
  egress_rules        = ["all-all"]

}

module "ec2_with_t2" {
  source = "./ec2_sec_group"

  instance_count = 1

  name          = "example-t2"
  ami           = "ami-02b4e72b17337d6c1" # the ami data source doesn't choose the correct one. ami-037aa94719126a377
  key_name = "TESTKEY"
  instance_type = "t2.micro"
  #cpu_credits   = "unlimited"
  
  subnet_id     = tolist(data.aws_subnet_ids.all.ids)[0]
  #  private_ip = "172.31.32.10"
  vpc_security_group_ids      = [module.security_group.security_group_id]
  associate_public_ip_address = true
   
}
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucketmenna12345"
  acl    = "private"
  
  versioning = {
    enabled = true
  }

}


