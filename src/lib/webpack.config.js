const path = require('path')

module.exports = {
  entry: {
    agaze: path.resolve("src/lib/agaze.coffee")
  },
  module: {
    rules: [
      {
        test: /\.coffee$/,
        loader: "coffee-loader"
      },
      {
        test: /\.js$/,
        loader: 'babel-loader',
      },
    ]
  },
  resolve: {
    extensions: [".coffee", ".js"]
  }
};