const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/views/index/index.html.erb',
    './app/views/index/*.*'
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
