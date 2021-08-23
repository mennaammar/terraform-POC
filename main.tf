##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "example"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = data.aws_vpc.default.id

  #ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_cidr_blocks = ["197.48.33.53/32"]
  ingress_rules       = [ "ssh-tcp"]

    ##########Security bugs #################
     ## comment this to remediate
    # egress_rules        = ["all-all"]

}

module "ec2_with_t2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  instance_count = 1

  name          = "maf-instance-t2"
  ami           = "ami-02b4e72b17337d6c1" # the ami data source doesn't choose the correct one. ami-037aa94719126a377
  key_name = "TESTKEY"
  instance_type = "t2.micro"
  subnet_id     = tolist(data.aws_subnet_ids.all.ids)[0]

  vpc_security_group_ids      = [module.security_group.security_group_id]
  ##########Security bugs #################
  ## comment this to remediate
   #associate_public_ip_address = true
  metadata_options = {
	http_tokens = "required"
  }	
   ###################################
   ####OPA ####
   tags = {
    BU   = "IT"
    ENV = "dev"
  }
   
}
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucketmafterraformpoc"
  acl    = "private"

  versioning = {
    enabled = true
  }

  ##################################################
  ##########Security bugs #################
    block_public_policy = true
     block_public_acls = true
     restrict_public_buckets = true
     ignore_public_acls = true
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
       sse_algorithm = "AES256"
      }
    } 
   }
  
   logging = {
		target_bucket = "bucket-logging-maf-us-east" #logging-bucketmaf
	}

  
 #####################################################
}
