config {
  plugin_dir = "./.tflint.d/plugins"
  module = true
  force = false
}
plugin "aws" {
    enabled = true
    version = "0.11.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}