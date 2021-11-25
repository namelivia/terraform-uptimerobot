variable "api_key" {
  type = string
  description = "Your api key for uptimerobot"
}

variable "monitors" {
  description = "List of uptimerobot monitors"
  type = map(object({
    name = string
    url = string
    keyword = string
  }))
}
