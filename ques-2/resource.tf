resource "google_compute_network" "custom-vpc" {
  name = "custom-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "custom-vpc-subnet" {
  name          = "custom-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.custom-vpc.id
  depends_on    = [google_compute_network.custom-vpc]
}

resource "google_compute_firewall" "custom-firewall" {
  name    = "custom-firewall"
  network = google_compute_network.custom-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["allow-ssh"]

  source_ranges = ["103.212.144.34/32"]

  depends_on = [google_compute_subnetwork.custom-vpc-subnet]
}

resource "google_compute_instance" "custom-vm" {
  count	       = "2"
  name         = "custom-vm-${count.index+1}"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = "custom-vpc"
    subnetwork = "custom-subnet"
    access_config {
    }
  }

  metadata_startup_script = "yum install nginx -y"
  depends_on    = [google_compute_subnetwork.custom-vpc-subnet]
}

resource "google_sql_database_instance" "custom-sql" {
name = "custom-sql-new"
database_version = "MYSQL_5_7"
deletion_protection = "false"
region = "us-central1"
settings {
tier = "db-n1-standard-1"
}
}
resource "google_sql_database" "database" {
name = "custom-database"
instance = "${google_sql_database_instance.custom-sql.name}"
charset = "utf8"
collation = "utf8_general_ci"
}

resource "google_sql_user" "users" {
name = "root"
instance = "${google_sql_database_instance.custom-sql.name}"
host = "%"
password = "agbch6fs"
}
