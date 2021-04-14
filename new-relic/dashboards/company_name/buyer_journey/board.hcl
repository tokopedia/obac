name = "Example Exec Dashboard Testing"

row {
  group "Company Name" {
    section "Directorate Name A" {
      column {
        node {
          type = "red_module"
          name = "Sample"
          monitor = "monitors/directorate/_sample/conditions/home-page"
        }

        node {
          type = "red_module"
          name = "Sample Upstream"
          monitor = "monitors/directorate/_sample/conditions/home-page"
        }
      }
    }

    section "Directorate Name B" {
      column {
        node {
          type = "red_module"
          name = "Sample"
          monitor = "monitors/directorate/_sample/conditions/home-page"
        }

        node {
          type = "red_module"
          name = "Sample Upstream"
          monitor = "monitors/directorate/_sample/conditions/home-page"
        }
      }
    }

    section "Directorate Name C" {
      column {
        node {
          type = "red_module"
          name = "Sample"
          monitor = "monitors/directorate/_sample/conditions/home-page"
        }

        node {
          type = "red_module"
          name = "Sample Upstream"
          monitor = "monitors/directorate/_sample/conditions/home-page"
        }

        node {
          type = "red_module"
          name = "Sample Upstream"
          monitor = "monitors/directorate/_sample/conditions/home-page"
        }

        node {
          type = "red_module"
          name = "Sample Upstream"
          monitor = "monitors/directorate/_sample/conditions/home-page"
        }
      }
    }
  }
}