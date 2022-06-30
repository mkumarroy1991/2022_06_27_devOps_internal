module "jenkins_vm" {
    source = "gcs:;https://www.googleapis.com/storage/v1/roi-materials/terraform"
    project_id = "roidtc-june22-u113"
    ip_address = "116.75.95.193"
}