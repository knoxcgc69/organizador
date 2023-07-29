const { environment } = require('@rails/webpacker')
const webpack = requiere("webpack")

Environment.plugins.prepend("Provide",
    new webpack.ProvidePlugin({
        $: "jquery",
        jQuery: "jquery",
        "window.jQuery": "jquery",
        Popper: ["popper.js", "default"]

    }
    )
)

module.exports = environment
