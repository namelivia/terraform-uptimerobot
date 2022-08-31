terraform {
  required_version = ">= 1.0.11"
  required_providers {
    uptimerobot = {
      source = "vexxhost/uptimerobot"
      version = "0.8.0"
    }
  }
}

provider "uptimerobot" {
  api_key = "${var.api_key}"
}

data "uptimerobot_account" "account" {
}

data "uptimerobot_alert_contact" "default_alert_contact" {
  friendly_name = "${data.uptimerobot_account.account.email}"
}

resource "uptimerobot_monitor" "monitor" {
  for_each = var.monitors
  friendly_name = each.value.name
  type          = "keyword"
  url           = each.value.url
  interval      = 300
  keyword_type = "not exists"
  keyword_value = each.value.keyword

  alert_contact {
    id = "${data.uptimerobot_alert_contact.default_alert_contact.id}"
  }
}
