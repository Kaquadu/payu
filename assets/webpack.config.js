const path = require('path');
const glob = require('glob');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const CompressionPlugin = require('compression-webpack-plugin')
const Webpack = require('webpack')
const MinifyPlugin = require('babel-minify-webpack-plugin');

module.exports = (env, options) => ({
  optimization: {
    minimize: true,
    minimizer: [
      new MinifyPlugin(),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
  entry: {
    'app': ['./js/app.js'].concat(glob.sync('./vendor/**/*.js'))
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '../priv/static/js')
  },
  module: {
    rules: [{
      test: /\.js$/,
      exclude: /node_modules/,
      use: {
        loader: 'babel-loader'
      }
    },
    {
      // test: /\.css$/,
      // use: [MiniCssExtractPlugin.loader, 'css-loader']
      test: /\.scss$/,
      use: [
        MiniCssExtractPlugin.loader,
        {
          loader: 'css-loader',
          options: {}
        },
        {
          loader: 'sass-loader',
          options: {}
        }
      ]
    }
    ]
  },
  plugins: [
    // new MiniCssExtractPlugin({ filename: '../css/app.css' }),
    new MiniCssExtractPlugin({
      filename: '../css/[name].css'
    }),
    new CopyWebpackPlugin([{
      from: 'static/',
      to: '../'
    }]),
    new CompressionPlugin,
    new Webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      'window.jQuery': 'jquery'
    })
  ]
});
