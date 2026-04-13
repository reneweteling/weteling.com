const { environment } = require('@rails/webpacker')

// Override postcss-loader to v4 with PostCSS 8 (required by Tailwind CSS 3)
// Webpacker 5 bundles postcss-loader 3 + PostCSS 7, which is incompatible
const postcssLoader = {
  loader: require.resolve('postcss-loader'),
  options: {
    postcssOptions: {
      plugins: [
        require('tailwindcss'),
        require('autoprefixer'),
      ],
    },
  },
}

// Replace postcss-loader in all relevant loaders
;['css', 'moduleCss', 'sass', 'moduleSass'].forEach((loaderName) => {
  const loader = environment.loaders.get(loaderName)
  if (loader && loader.use) {
    loader.use = loader.use.map((item) => {
      if (typeof item === 'object' && item.loader && item.loader.includes('postcss-loader')) {
        return postcssLoader
      }
      if (typeof item === 'string' && item.includes('postcss-loader')) {
        return postcssLoader
      }
      return item
    })
  }
})

module.exports = environment
