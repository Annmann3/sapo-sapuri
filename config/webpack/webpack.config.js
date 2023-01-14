const { webpackConfig, merge } = require('shakapacker')
const vueConfig = require('./loaders/vue')

// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.

module.exports = merge(vueConfig, webpackConfig)
