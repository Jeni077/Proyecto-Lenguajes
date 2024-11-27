const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { override, babelInclude } = require('customize-cra');

module.exports = override(
  (config, env) => {
    // Cambiar la carpeta de salida en producción
    if (env === 'production') {
      config.output.path = path.resolve(__dirname, 'build');
    }

    // Modificar reglas de Babel si es necesario
    config.module.rules.push({
      test: /\.mjs$/,
      include: /node_modules/,
      type: 'javascript/auto',
    });

    // Añadir HtmlWebpackPlugin para index.html
    config.plugins.push(
      new HtmlWebpackPlugin({
        template: path.resolve(__dirname, 'public', 'index.html'),
      })
    );

    // Configurar el Proxy para el desarrollo
    if (env === 'development') {
      config.devServer = {
        ...config.devServer,
        proxy: {
          '/api': {
            target: 'http://localhost:5000', // Reemplaza con el puerto del servidor Node.js si es diferente
            changeOrigin: true,
            pathRewrite: { '^/api': '' },
          },
        },
      };
    }

    // Alias de resolución de archivos
    config.resolve = {
      ...config.resolve,
      alias: {
        '@components': path.resolve(__dirname, 'src', 'components'),
        '@assets': path.resolve(__dirname, 'src', 'assets'),
      },
    };

    return config;
  },
  // Configuración adicional de Babel
  babelInclude([
    path.resolve('src'),
    path.resolve('node_modules/some-library'), // Añade otras librerías si las necesitas en Babel
  ])
);
