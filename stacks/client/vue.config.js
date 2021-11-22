module.exports = {
    publicPath: '',

    css: {
        sourceMap: true,
        loaderOptions: {
            sass: {
                // eslint-disable-next-line global-require
                implementation: require('sass'), // Prefer `dart-sass`
                additionalData: `
                    @import "@/sass";
                `,
            },
        },
    },
}
