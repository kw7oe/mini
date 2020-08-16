job "mini" {
  datacenters = ["dc1"]
  type = "service"

  group "web" {
    count = 1

    task "plug_cowboy" {
      driver = "raw_exec"

      artifact {
        destination = "local/mini"
      }

      env {
        PORT = "${NOMAD_PORT_http}"
      }

      config {
        command = "local/mini/bin/mini"
        args = ["start" ]
      }

      resources {
        cpu    = 512 # 250 MHz
        memory = 256 # 128 MB

        network {
          mbits = 10
          port "http" {}
        }
      }
    }
  }
}
