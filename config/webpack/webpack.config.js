const { webpackConfig, merge } = require('shakapacker')
const vueConfig = require('./loaders/vue')
const dotenvConfig = require('./loaders/dotenv');

// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.

module.exports = merge(dotenvConfig, vueConfig, webpackConfig)
