provider "google" {
credentials = file("/root/sa.json")
project = "beaming-grid-327314"
region = "us-central1-a"
zone = "us-central1-a"
}
