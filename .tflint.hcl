#config {
  #call_module_type = "local"
#}

plugin "aws" {
  enabled = true
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  version = "0.32.0"

  deep_check = false
}
