resource "random_integer" "random_project_id" {
  min = 100000
  max = 999999

  keepers = {
    project_prefix = var.project_prefix
  }
}

data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

resource "google_project" "target" {
  name       = "${var.project_prefix}-${var.env}"
  project_id = "${var.project_prefix}-${var.env}-${random_integer.random_project_id.result}"

  billing_account     = data.google_billing_account.acct.id
  auto_create_network = false
}

resource "time_sleep" "wait_30_seconds" {
  depends_on      = [google_project.target]
  create_duration = "30s"
}

resource "google_project_service" "services" {
  for_each   = toset(var.gcp_services_list)
  project    = google_project.target.project_id
  service    = each.value
  depends_on = [time_sleep.wait_30_seconds]
}

resource "google_storage_bucket" "target_tf_state" {
  name     = "tf-state-${google_project.target.project_id}"
  project  = google_project.target.project_id
  location = "NORTHAMERICA-NORTHEAST1"

  public_access_prevention = "enforced"
}
