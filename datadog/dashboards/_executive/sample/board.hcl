name = "Dashboard - Service Availability"

row {
  group "CONFIDENTIAL COMPANY NAME" {
    section "Directorate A" {
      column {
        node {
          type = "sr_module"
          name = "Signup Success Rate"
          monitor = "monitors/sample/_executive/test-monitor"
        }

      }
    }

    section "Directorate B" {
      column {

        node {
          type = "sr_module"
          name = "Logout Success Rate"
          monitor = "monitors/sample/_executive/test-monitor"
        }
      }
    }
  }
}
