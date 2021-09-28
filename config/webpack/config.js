var path = require('path');
var webpack = require('webpack');

module.exports = {
    entry: {
        // 外部ライブラリを読み込むvendorとページごとのjs作成
        'vendor': ['bootstrap-loader', 'backbone-fetch-cache'],
        'app/index': path.join(__dirname, '/src/app/index.js')
    },
    output: {
        filename: path.join(__dirname, '/build/[name].js')
    },

    /* 他の設定（ここでは省略） */

    plugins: [
        // この設定をするとvendorの中身は他のentryでは読み込まれない
        new webpack.optimize.CommonsChunkPlugin('vendor', 'build/vendor.js'),
        // webpack.ProvidePluginを使用すると、指定した変数名でライブラリを使用できるようになる
        // 以下の例だと、$, jQuery, window.jQueryでjqueryを使用することができる
        new webpack.ProvidePlugin({
            $: 'jquery',
            jQuery: 'jquery',
            'window.jQuery': 'jquery'
        }),
        new webpack.ProvidePlugin({
            kb: 'knockback'
        }),
        new webpack.ProvidePlugin({
            moment: 'moment'
        })
    ],
    resolve: {
        extensions: ['', '.js']
    }
};