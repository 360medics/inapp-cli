const { defineConfig } = require('@vue/cli-service')

module.exports = defineConfig({
    filenameHashing: true,
    transpileDependencies: true,
    publicPath: '',
    devServer: {
        client: {
            webSocketURL: "ws://0.0.0.0:3000/ws",
        },
        host: "0.0.0.0",
    },
    css: {
        loaderOptions: {
            sass: {
                sourceMap: false,
                // eslint-disable-next-line global-require
                implementation: require('sass'), // Prefer `dart-sass`
                additionalData: `
                    @import "@/sass/helpers/";
                `,
            },
        },
    },
})
