variable "region" {
  type    = string
  default = "asia-southeast2"
}

variable "project_id" {
  type    = string
  default = "constant-jigsaw-414207"
}

variable "zone" {
  type    = string
  default = "asia-southeast2-a"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "gce_ssh_user" {
  type    = string
  default = "haydar"
}

variable "gce_ssh_pub_key_file" {
  type    = string
  default = "/Users/haydar/Documents/belajar/kly-technical-test/ssh-key/kly-test.pub"
}