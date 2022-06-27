const { webpackConfig, merge } = require('shakapacker');
const customConfig = {
  module: {
    rules: [
      {
        test: require.resolve('jquery'),
        loader: 'expose-loader',
        options: {
          exposes: ['$', 'jQuery']
        }
      }
    ]
  }
};

module.exports = merge(webpackConfig, customConfig);
