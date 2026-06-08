# :wind_face: Keywind

Keywind is a component-based Keycloak Login Theme built with [Tailwind CSS](https://github.com/tailwindlabs/tailwindcss) and [Alpine.js](https://github.com/alpinejs/alpine).

![Preview](./preview.png)

### Styled Pages

- Error
- Login
- Login Config TOTP
- Login IDP Link Confirm
- Login OAuth Grant
- Login OTP
- Login Page Expired
- Login Password
- Login Recovery Authn Code Config
- Login Recovery Authn Code Input
- Login Reset Password
- Login Update Password
- Login Update Profile
- Login Username
- Login X.509 Info
- Logout Confirm
- Register
- Select Authenticator
- Terms and Conditions
- WebAuthn Authenticate
- WebAuthn Error
- WebAuthn Register

### Identity Provider Icons

- Apple
- Bitbucket
- Discord
- Facebook
- GitHub
- GitLab
- Google
- Instagram
- LinkedIn
- Microsoft
- OpenID
- Red Hat OpenShift
- PayPal
- Slack
- Stack Overflow
- Twitter

## Installation

Keywind has been designed with component-based architecture from the start, and **you can customize as little or as much Keywind as you need**:

1. [Deploy Keywind Login Theme](https://www.keycloak.org/docs/latest/server_development/#deploying-themes)
2. [Create your own Login Theme](https://www.keycloak.org/docs/latest/server_development/#creating-a-theme)
3. Specify parent theme in [theme properties](https://www.keycloak.org/docs/latest/server_development/#theme-properties):

```
parent=keywind
```

4. Brand and customize components with [FreeMarker](https://freemarker.apache.org/docs/dgui_quickstart_template.html)

## Customization

### Theme

When you do need to customize a palette, you can configure your colors under the `colors` key in the `theme` section of Tailwind config file:

`tailwind.config.js`

```js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: colors.red,
      },
    },
  },
};
```

Read more about Tailwind CSS configuration in the [documentation](https://tailwindcss.com/docs/configuration).

### Components

You can update Keywind components in your own child theme. For example, create a copy of the `body` component and change the background:

`theme/mytheme/login/components/atoms/body.ftl`

```
<#macro kw>
  <body class="bg-primary-100">
    <#nested>
  </body>
</#macro>
```

## Development

Use this flow while editing templates, Tailwind classes, or theme assets:

```bash
pnpm install
pnpm build
mvn clean package
docker compose up --build
```

`pnpm build` regenerates the compiled Tailwind CSS and updates the hashed asset references under `theme/keywind/login/resources/dist`. Run it whenever you add or rename Tailwind classes in FreeMarker templates or update `tailwind.config.js`.

`mvn clean package` runs the FreeMarker template test suite and packages the theme sources into a JAR.

`docker compose up --build` starts Keycloak with the local theme mounted from this repository and rebuilds the container image so custom providers from `plugins/` are baked in.

## Production

Before creating a deployable artifact, run the same build and validation steps:

```bash
pnpm build
mvn clean package
docker compose up --build
```

For production use, make sure the generated theme assets are committed or packaged with your release, and use the Docker image built by Compose so provider JARs are installed during the Keycloak image build.
