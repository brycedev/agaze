const path = require('path')

module.exports = {
  mode: 'production',
  entry: {
    agaze: path.resolve("src/lib/agaze.coffee")
  },
  module: {
    rules: [
      {
        test: /\.coffee$/,
        loader: "coffee-loader"
      }
    ]
  },
  resolve: {
    extensions: [".coffee", ".js"]
  }
};