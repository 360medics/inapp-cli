const { defineConfig } = require('@vue/cli-service')

module.exports = defineConfig({
    filenameHashing: true,
    transpileDependencies: true,
    publicPath: '',
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
