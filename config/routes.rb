Rails.application.routes.draw do
  root "index#index"

  get "index", to: "index#index", as: "index"
  post "index", to: "index#create", as: "index_contact_form_submit"

  get "service", to: "service#service", as: "service"

  get "tracking", to: "tracking#tracking", as: "tracking"

  get "about", to: "about#about", as: "about"

  get "contact", to: "contact#contact", as: "contact"
  post "contact", to: "contact#create", as: "contact_form_submit"

  get "faq", to: "faq#faq", as: "faq"

  get "quote", to: "quote#quote", as: "quote"
  post "quote", to: "quote#create", as: "quote_form_submit"

  get "privacy", to: "privacy#privacy", as: "privacy"
end
