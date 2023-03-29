provider "google" {
 credentials = "{\"type\":\"service_account\"}"
 region      = "us-central1"
}

resource "google_compute_instance" "instance1" {
 name         = "instance1"
 machine_type = "n1-standard-32" # <<<<< Try changing this to n1-standard-8 to compare the costs
 zone         = "us-central1-a"

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

 scheduling {
   preemptible = true
 }

  guest_accelerator {
    type = "nvidia-tesla-t4" # <<<<< Try changing this to nvidia-tesla-p4 to compare the costs
    count = 4
  }

  network_interface {
    network = "default"

    access_config {
    }
  }
}

resource "aws_instance" "web_app_2" {
  ami           = "ami-674cbc1e"
  instance_type = "m5.8xlarge"              # <<<<< Try changing this to m5.8xlarge to compare the costs

  root_block_device {
    volume_size = 50
  }

  ebs_block_device {
    device_name = "my_data"
    volume_type = "io1"                     # <<<<< Try changing this to gp2 to compare costs
    volume_size = 500
    iops        = 800
  }
}

resource "google_dns_record_set" "frontend" {
  name = "frontend.123"
  type = "A"
  ttl  = 300
  rrdatas = ["123.123.123.123]"]
  managed_zone = "zone"
}
