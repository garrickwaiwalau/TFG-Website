const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/views/shared/_banner.html.erb',
    './app/views/shared/_navbar.html.erb',
    './app/views/shared/_flashes.html.erb',
    './app/views/about/about.html.erb',
    './app/views/contact/contact.html.erb',
    './app/views/faq/faq.html.erb',
    './app/views/index/index.html.erb',
    './app/views/privacy/privacy.html.erb',
    './app/views/quote/quote.html.erb',
    './app/views/service/service.html.erb',
    './app/views/tracking/tracking.html.erb'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
