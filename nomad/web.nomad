job "mini" {
  datacenters = ["dc1"]
  type = "service"

  group "web" {
    count = 3
    task "plug_cowboy" {
      driver = "raw_exec"

      artifact {
        source = "https://storage.googleapis.com/kw7oe/mini-0.1.0.tar.gz"
        destination = "local/mini"
      }

      env {
        RELEASE_NODE = "${NOMAD_ALLOC_ID}"
        PORT = "${NOMAD_PORT_http}"
      }

      config {
        command = "local/mini/bin/mini"
        args = ["start" ]
      }

      resources {
        cpu    = 250 # 250 MHz
        memory = 256 # 128 MB

        network {
          mbits = 10
          port "http" {}
        }
      }

      service {
        name = "mini-webserver"
        port = "http"
        tags = ["macbook", "urlprefix-/"]
        check {
          type     = "http"
          path     = "/version"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
