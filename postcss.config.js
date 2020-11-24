module.exports = {
  plugins: [
    require('postcss-custom-properties')({
      preserve: false, // completely reduce all css vars
      importFrom: [
        'app/javascript/src/fullcalendar-vars.css' // look here for the new values
      ]
    }),
    require('postcss-calc'),
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}
