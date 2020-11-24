process.env.NODE_ENV = process.env.NODE_ENV || 'production'

// need to do this to get teh freakin calendar working
process.env.NODE_ENV = 'development'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()
