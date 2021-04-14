name = "Tech OKR Dashboard - Service Availability"

row {
  group "TOKOPEDIA" {
    section "PG" {
      column {
        node {
          type = "sr_module"
          name = "Shop Registration Success Rate"
          monitor = "monitors/merchant-acquisition/_executive/shop-registration"
        }
        node {
          type = "sr_module"
          name = "Seller Dashboard Success Rate"
          monitor = "monitors/merchant-growth/_executive/seller-dashboard-layout"
        }
        node {
          type = "sr_module"
          name = "Add Product Success Rate"
          monitor = "monitors/merchant-acquisition/_executive/add-product"
        }
        node {
          type = "sr_module"
          name = "Edit Product Success Rate"
          monitor = "monitors/merchant-acquisition/_executive/edit-product"
        }
        node {
          type = "sr_module"
          name = "Accept Order Success Rate"
          monitor = "monitors/merchant-growth/_executive/accept-order"
        }
        node {
          type = "sr_module"
          name = "Seller Order List Success Rate"
          monitor = "monitors/merchant-growth/_executive/seller-order-list"
        }
        node {
          type = "sr_module"
          name = "PDP Success Rate"
          monitor = "monitors/pdp/_executive/pdp"
        }
        node {
          type = "sr_module"
          name = "Flash Sale page Success Rate"
          monitor = "monitors/merchant-growth/_executive/flash-sale-page"
        }
      }
    }

    section "Logistics" {
      column {
        node {
          type = "sr_module"
          name = "Input AWB Bills Success Rate"
          monitor = "monitors/logistic/_executive/input-awb-bills"
        }
        node {
          type = "sr_module"
          name = "Get Rates Success Rate"
          monitor = "monitors/logistic/_executive/get-rates"
        }
        node {
          type = "sr_module"
          name = "Get delivery tracking Success Rate"
          monitor = "monitors/logistic/_executive/get-delivery-tracking"
        }
        node {
          type = "sr_module"
          name = "Request Pickup Success Rate"
          monitor = "monitors/logistic/_executive/request-pickup"
        }
      }
    }

    section "Ads" {
      column {
        node {
          type = "sr_module"
          name = "TopAds Home Display Success Rate"
          monitor = "monitors/topads/_executive/topads-home-display"
        }
        node {
          type = "sr_module"
          name = "TopAds Search Display Product Success Rate"
          monitor = "monitors/topads/_executive/topads-search-display-product"
        }
        node {
          type = "sr_module"
          name = "Ad Manager: Create Ad"
          monitor = "monitors/topads/_executive/ad-manager-create-ad"
        }
      }
    }

    section "DG" {
      column {
        node {
          type = "sr_module"
          name = "Get Category Versioning List - Success Rate"
          monitor = "monitors/digital-bills-and-topup/_executive/category-versioning-list"
        }
        node {
          type = "sr_module"
          name = "Recharge Catalog Menu - Success Rate"
          monitor = "monitors/digital-bills-and-topup/_executive/get-catalog-menu"
        }
        node {
          type = "sr_module"
          name = "Recharge Favorite Recommendation - Success Rate"
          monitor = "monitors/digital-bills-and-topup/_executive/get-favorite-recommendation"
        }
        node {
          type = "sr_module"
          name = "Recharge Category Detail - Success Rate"
          monitor = "monitors/digital-bills-and-topup/_executive/get-category-detail"
        }
        node {
          type = "sr_module"
          name = "Recharge Catalog Menu Detail - Success Rate"
          monitor = "monitors/digital-bills-and-topup/_executive/get-catalog-menu-detail"
        }
        node {
          type = "sr_module"
          name = "Recharge Catalog Body - Success Rate"
          monitor = "monitors/digital-bills-and-topup/_executive/get-catalog-body"
        }
        node {
          type = "sr_module"
          name = "Recharge Subhomepage Section - Success Rate"
          monitor = "monitors/digital-bills-and-topup/_executive/get-subhomepage"
        }
        node {
          type = "sr_module"
          name = "Add to Cart - Success Rate"
          monitor = "monitors/digital-bills-and-topup/_executive/add-to-cart"
        }
        node {
          type = "sr_module"
          name = "Digital Checkout"
          monitor = "monitors/digital-bills-and-topup/_executive/checkout"
        }
      }
    }

    section "FT" {
    }

    section "Payment" {
      column {
        node {
          type = "sr_module"
          name = "Payment Page Success Rate"
          monitor = "monitors/payment/_executive/payment"
        }
        node {
          type = "sr_module"
          name = "Payment Success Rate"
          monitor = "monitors/payment/_executive/payment-page"
        }
      }
    }

    section "New Retail" {
      column {
        node {
          type = "sr_module"
          name = "Checkout Digital Mitra"
          monitor = "monitors/new-retail/_executive/check-digital-mitra"
        }
        node {
          type = "sr_module"
          name = "Checkout Digital Mitra"
          monitor = "monitors/new-retail/_executive/check-digital-mitra"
        }
      }
    }

    section "Account & User Platform" {
      column {
        node {
          type = "sr_module"
          name = "User Register Success Rate"
          monitor = "monitors/accounts-and-user-platform/_executive/user-register"
        }
        node {
          type = "sr_module"
          name = "User Login Success Rate"
          monitor = "monitors/accounts-and-user-platform/_executive/user-login"
        }
        node {
          type = "sr_module"
          name = "Auth API Success Rate"
          monitor = "monitors/accounts-and-user-platform/_executive/auth-api"
        }
        node {
          type = "sr_module"
          name = "Shop Registration Success Rate"
          monitor = "monitors/merchant-acquisition/_executive/shop-registration"
        }
        node {
          type = "sr_module"
          name = "SellerApp Login Success Rate"
          monitor = "monitors/accounts-and-user-platform/_executive/seller-applogin"
        }
      }
    }

    section "Communication & Media" {
      column {
        node {
          type = "sr_module"
          name = "TopChat Open Chat Reply Success Rate"
          monitor = "monitors/communication-and-media/_executive/topchat-open-chat-reply"
        }
        node {
          type = "sr_module"
          name = "TopChat Reply Success Rate"
          monitor = "monitors/communication-and-media/_executive/topchat-reply"
        }
      }
    }

    section "Search" {
      column {
        node {
          type = "sr_module"
          name = "Search Product Success Rate"
          monitor = "monitor/search/_executive/search-product"
        }
      }
    }

    section "Home & Browse" {
      column {
        node {
          type = "sr_module"
          name = "Homepage Success Rate"
          monitor = "monitors/home-and-browse/_executive/homepage"
        }
        node {
          type = "sr_module"
          name = "Product Recommendation"
          monitor = "monitors/home-and-browse/_executive/recommendation"
        }
      }
    }

    section "Buyer Growth Platform" {
      column {
        node {
          type = "sr_module"
          name = "Lucky Egg Widget Success Rate"
          monitor = "monitors/buyer-growth-platform/_executive/lucky-egg-widget"
        }
        node {
          type = "sr_module"
          name = "TokoPoints Get Balance"
          monitor = "monitors/buyer-growth-platform/_executive/tokopoints-get-balance"
        }
        node {
          type = "sr_module"
          name = "Promo MP Validate Success Rate"
          monitor = "monitors/buyer-growth-platform/_executive/promo-mp-validate"
        }
        node {
          type = "sr_module"
          name = "Promo Global Validate Success Rate"
          monitor = "monitors/buyer-growth-platform/_executive/promo-global-validate"
        }
        node {
          type = "sr_module"
          name = "Promo Redemption Success Rate"
          monitor = "monitors/buyer-growth-platform/_executive/promo-redemption"
        }
      }
    }

    section "Purchase Platform" {
      column {
        node {
          type = "sr_module"
          name = "ATC Success Rate"
          monitor = "monitors/purchase-platform/_executive/atc"
        }
        node {
          type = "sr_module"
          name = "Cart Success Rate"
          monitor = "monitors/purchase-platform/_executive/cart"
        }
        node {
          type = "sr_module"
          name = "Checkout Success Rate"
          monitor = "monitors/purchase-platform/_executive/checkout"
        }
      }
    }
  }
}
