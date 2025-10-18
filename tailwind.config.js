import colors from 'tailwindcss/colors';

export default {
  content: ['./theme/**/*.ftl',
    './src/**/*.{ftl,html,js,ts}',
    './resources/**/*.{ftl,html,js,ts}',
  ],
  experimental: {
    optimizeUniversalDefaults: true,
  },
  plugins: [require('@tailwindcss/forms')],
  theme: {
    extend: {
      colors: {
        primary:  {
          '50': '#fef4f2',
          '100': '#fef4f2',
          '200': '#fde8e3',
          '300': '#fcd5cc',
          '400': '#f9b7a8',
          '500': '#f38d76',
          '600': '#e75b3c',
          '700': '#d54b2d',
          '800': '#b33c22',
          '900': '#943520',
          '950': '#7b3121',
      },
        secondary: colors.gray,

        provider: {
          apple: '#000000',
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
