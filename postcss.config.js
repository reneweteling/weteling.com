module.exports = {
  plugins: [
    require('postcss-import'),
    require('tailwindcss'),
    require('autoprefixer'),
    require('postcss-flexbugs-fixes'),
    require('postcss-custom-properties')({
      preserve: false,
      importFrom: [
        'app/javascript/src/fullcalendar-vars.css'
      ]
    }),
  ]
}
