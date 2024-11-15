Rails.application.routes.draw do
  root "index#index"

  get "index", to: "index#index", as: "index"

  get "service", to: "service#service", as: "service"

  get "tracking", to: "tracking#tracking", as: "tracking"

  get "about", to: "about#about", as: "about"

  get "contact", to: "contact#contact", as: "contact"

  get "faq", to: "faq#faq", as: "faq"

  get "quote", to: "quote#quote", as: "quote"
end
