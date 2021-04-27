name = "User Buyer Journey HaloDoc"

row {
  group "Halodoc" {
    section "Home Page" {
      column {
        node {
          type = "red_module"
          name = "Medicine Category"
          monitor = "monitors/directorate/homepage/conditions/medicine-category"
        }

        node {
          type = "red_module"
          name = "Slug Multi Get All"
          monitor = "monitors/directorate/homepage/conditions/slug-multi-get-all"
        }
      }
    }

    section "Discovery" {
      column {

        node {
          type = "red_module"
          name = "Search Product"
          monitor = "monitors/directorate/discovery/conditions/search"
        }

        node {
          type = "red_module"
          name = "Category Slug"
          monitor = "monitors/directorate/discovery/conditions/category-search"
        }

        node {
          type = "red_module"
          name = "Slug"
          monitor = "monitors/directorate/discovery/conditions/slug"
        }
      }
    }

    section "Product Directorate" {
      column {
        node {
          type = "red_module"
          name = "Product Inventory"
          monitor = "monitors/directorate/product/conditions/inventory"
        }

        node {
          type = "red_module"
          name = "Product Detail"
          monitor = "monitors/directorate/product/conditions/product-detail"
        }

        node {
          type = "red_module"
          name = "Product Detail Slug"
          monitor = "monitors/directorate/product/conditions/product-detail-slug"
        }

        node {
          type = "red_module"
          name = "Product Similar"
          monitor = "monitors/directorate/product/conditions/product-similar"
        }
      }
    }

    section "User Platform Directorate" {
      column {
        node {
          type = "red_module"
          name = "Validate OTP"
          monitor = "monitors/directorate/users-platform/conditions/validate-otp"
        }

        node {
          type = "red_module"
          name = "OTP Login"
          monitor = "monitors/directorate/users-platform/conditions/otp-login"
        }
      }

      column {
        node {
          type = "red_module"
          name = "Logout"
          monitor = "monitors/directorate/users-platform/conditions/logout"
        }
      }
    }

    section "Home After Login" {
      column {
        node {
          type = "red_module"
          name = "Profiles"
          monitor = "monitors/directorate/home-after-login/conditions/profiles"
        }

        node {
          type = "red_module"
          name = "User Status"
          monitor = "monitors/directorate/home-after-login/conditions/user-status"
        }

        node {
          type = "red_module"
          name = "User Config"
          monitor = "monitors/directorate/home-after-login/conditions/user-configs"
        }

        node {
          type = "red_module"
          name = "Insurance Policies"
          monitor = "monitors/directorate/home-after-login/conditions/insurance-policies"
        }
      }
    }

    section "Appointment" {
      column {
        node {
          type = "red_module"
          name = "Patient"
          monitor = "monitors/directorate/appointment/conditions/patients"
        }

        node {
          type = "red_module"
          name = "Get Patient Slot"
          monitor = "monitors/directorate/appointment/conditions/get-patient-slot"
        }
      }

      column {
        node {
          type = "red_module"
          name = "Doctor Slot"
          monitor = "monitors/directorate/appointment/conditions/doctor-slot"
        }

        node {
          type = "red_module"
          name = "Doctor Availability"
          monitor = "monitors/directorate/appointment/conditions/doctor-availability"
        }
      }
    }
  }
}