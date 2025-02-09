variable "services" {
  default = {
    "svc-bob" = {
      "exclusions" = [
        "one",
        "two",
      ]
    }
    "svc-callie" = {
      "exclusions" = [
        "one",
        "two",
      ]
    }
    "svc-vee" = {
      "exclusions" = [
        "one",
        "two",
      ]
    }
    "svc-carlton" = {
      "exclusions" = [
        "one",
        "two",
      ]
    }
  }
}

variable "to_build"  {default = []}

#group "default" { targets = keys(services) }
group "default" { targets = filter() }

target "default" {
  dockerfile-inline = "FROM alpine"
  matrix = {
    svc = filter()
  }
  name = svc
  tags = [svc]
}

function "filter" {
  params = []

  # Turns out the docker bake documentation is wrong - you can indeed reference
  # user-defined functions from within user-defined functions. Still can't make
  # one function recurse, but we can work around that.
  #result = collect("svc-vee", ["svc-carlton", "svc-bob", "svc-callie"])
  result = tock()
}

function "tick" {
  params = []
  result = ["service-vee"]
}

function "tock" {
  params = []
  result = tick()
}
