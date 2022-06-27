process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const { merge } = require('shakapacker')
const webpackConfig = require('./base')

module.exports = merge(webpackConfig, {
  resolve: {
    alias: {
      vue: 'vue/dist/vue.min'
    }
  }
})
