const colors = require('tailwindcss/colors');

/**
 * @type { import('tailwindcss').Config }
 */
module.exports = {
  content: ['./theme/**/*.ftl'],
  experimental: {
    optimizeUniversalDefaults: true,
  },
  plugins: [require('@tailwindcss/forms')],
  theme: {
    extend: {
      colors: {
        primary: {
          '50': '#ecefff',
          '100': '#dde1ff',
          '200': '#c2c9ff',
          '300': '#9ca4ff',
          '400': '#7675ff',
          '500': '#7164ff',
          '600': '#5536f5',
          '700': '#492ad8',
          '800': '#3b25ae',
          '900': '#332689',
          '950': '#201650',
      },
        secondary: colors.gray,
        provider: {
          pictalk: '#FF5757',
          bitbucket: '#0052CC',
          discord: '#5865F2',
          facebook: '#1877F2',
          github: '#181717',
          gitlab: '#FC6D26',
          google: '#4285F4',
          instagram: '#E4405F',
          linkedin: '#0A66C2',
          microsoft: '#5E5E5E',
          oidc: '#F78C40',
          openshift: '#EE0000',
          paypal: '#00457C',
          slack: '#4A154B',
          stackoverflow: '#F58025',
          twitter: '#1DA1F2',
        },
      },
    },
  },
};
