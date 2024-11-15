# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "alpinejs", to: "https://cdn.jsdelivr.net/npm/alpinejs@3.14.3/dist/cdn.min.js"
# pin "tailwindcss", to: "https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css"
pin_all_from "app/javascript/controllers", under: "controllers"