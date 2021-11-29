const { defineConfig } = require("@vue/cli-service");
module.exports = defineConfig({
  transpileDependencies: true,
  publicPath: "",
  css: {
    sourceMap: true,
    loaderOptions: {
      sass: {
        // eslint-disable-next-line global-require
        implementation: require("sass"), // Prefer `dart-sass`
        additionalData: `
                    @import "@/sass";
                `,
      },
    },
  },
});
