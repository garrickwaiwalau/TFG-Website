Rails.application.routes.draw do
  devise_for :users, path: "auth", skip: [ :registrations, :passwords ]

  root "index#index"

  get "index", to: "index#index", as: "index"
  post "index", to: "index#submit", as: "index_contact_form_submit"

  get "service", to: "service#service", as: "service"

  get "tracking", to: "tracking#tracking", as: "tracking"
  get "tracking", to: "tracking#search", as: "tracking_search"

  get "about", to: "about#about", as: "about"

  get "contact", to: "contact#contact", as: "contact"
  post "contact", to: "contact#submit", as: "contact_form_submit"

  get "faq", to: "faq#faq", as: "faq"

  get "quote", to: "quote#quote", as: "quote"
  post "quote", to: "quote#submit", as: "quote_form_submit"

  get "privacy", to: "privacy#privacy", as: "privacy"

  get "portal", to: "portal#portal", as: "portal"
  post "portal", to: "portal#upload", as: "portal_upload"
  post "portal", to: "portal#login", as: "portal_login"

  # Health check endpoint for Kamal and load balancers
  get "/up", to: proc { [ 200, {}, [ "OK" ] ] }
end
