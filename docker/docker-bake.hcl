variable "services" {
  default = {
    "svc-bob" = {
      "exclusions" = [
        "two",
      ]
    }
    "svc-callie" = {
      "exclusions" = [
        "one",
      ]
    }
    "svc-vee" = {
      "exclusions" = [
      ]
    }
    "svc-carlton" = {
      "exclusions" = [
        "two",
      ]
    }
  }
}

variable "to_build"  {default = []}

group "default" { targets = filter(services, "one") }

target "default" {
  dockerfile-inline = "FROM alpine"
  matrix = {
    #svc = filter(services, "one")
    svc = keys(services)
  }
  name = svc
  tags = [svc]
}

function "filter" {
  params = [svcs, val]

  result = flatten([for k, v in svcs : contains(v.exclusions, val) ? [] : [k]])
}

