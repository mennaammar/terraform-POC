config {
  module = true
  force = true
  disabled_by_default = false
}
plugin "aws" {
  enabled = true
  version = "0.4.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
