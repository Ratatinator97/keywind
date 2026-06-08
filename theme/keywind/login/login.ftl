<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/checkbox.ftl" as checkbox>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>
<#import "components/molecules/identity-provider.ftl" as identityProvider>
<#import "features/labels/username.ftl" as usernameLabel>
<#assign privacyUrl = "https://www.pictalk.org/" + (lang)!"en" + "/privacy-policy">
<#assign usernameLabel><@usernameLabel.kw /></#assign>

<@layout.registrationLayout
  displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??
  displayMessage=!messagesPerField.existsError("username", "password")
  ;
  section
>
  <#if section="header">
    ${msg("loginAccountTitle")}
    <#if messagesPerField.existsError("username", "password")>
      <div class="bg-red-100 text-red-600 p-4 rounded-lg mt-2 flex items-center justify-center">
        <svg class="h-4 w-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
          <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
        </svg>
        <p class="text-sm">${msg("invalidUserMessage")}</p>
      </div>
    </#if>
  <#elseif section="form">
    <#if realm.password>
      <@form.kw
        action=url.loginAction
        method="post"
        onsubmit="login.disabled = true; return true;"
      >
        <input
          name="credentialId"
          type="hidden"
          value="<#if auth.selectedCredential?has_content>${auth.selectedCredential}</#if>"
        >
        <@input.kw
          autocomplete=realm.loginWithEmailAllowed?string("email", "username")
          autofocus=true
          disabled=usernameEditDisabled??
          invalid=messagesPerField.existsError("username", "password")
          label=usernameLabel
          message=kcSanitize(messagesPerField.getFirstError("username", "password"))
          name="username"
          type="text"
          value=(login.username)!''
        />
        <@input.kw
          invalid=messagesPerField.existsError("username", "password")
          label=msg("password")
          name="password"
          type="password"
        />
        <#if realm.rememberMe && !usernameEditDisabled?? || realm.resetPasswordAllowed>
          <div class="flex items-center justify-between">
            <#if realm.rememberMe && !usernameEditDisabled??>
              <@checkbox.kw
                checked=login.rememberMe??
                label=msg("rememberMe")
                name="rememberMe"
              />
            </#if>
            <#if realm.resetPasswordAllowed>
              <@link.kw color="primary" href=url.loginResetCredentialsUrl size="small">
                ${msg("doForgotPassword")}
              </@link.kw>
            </#if>
          </div>
        </#if>
        <@buttonGroup.kw>
          <@button.kw color="primary" name="login" type="submit">
            ${msg("doLogIn")}
          </@button.kw>
        </@buttonGroup.kw>
        <@buttonGroup.kw>
          <@button.kw color="secondary" name="login" type="submit">
            <span class="inline-flex items-center gap-3">
              <span>${msg("migrateFromPictalkAAC")}</span>
              <span class="bg-white rounded-full p-1 flex items-center justify-center">
                <svg
                  aria-hidden="true"
                  class="h-5 w-5"
                  fill="none"
                  viewBox="0 0 64 64"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <g transform="translate(0.000000,64.000000) scale(0.100000,-0.100000)" fill="#fc5859" stroke="none">
                    <path d="M220 523 c-8 -2 -34 -11 -58 -20 l-43 -15 3 -169 c3 -173 9 -196 44 -182 16 6 34 57 34 97 0 28 6 34 49 54 27 12 56 34 66 48 38 58 28 149 -18 172 -31 15 -60 21 -77 15z m38 -115 c2 -18 -4 -31 -20 -42 -12 -9 -26 -16 -30 -16 -13 0 -9 78 5 83 25 11 42 1 45 -25z"/>
                    <path d="M377 314 c-14 -14 -7 -66 13 -91 11 -14 17 -30 14 -37 -3 -6 5 1 18 17 21 24 31 27 81 27 l58 0 -3 43 -3 42 -85 3 c-47 1 -89 0 -93 -4z m173 -24 c0 -6 -33 -10 -80 -10 -47 0 -80 4 -80 10 0 6 33 10 80 10 47 0 80 -4 80 -10z m-2 -32 c-3 -7 -23 -14 -46 -16 -33 -2 -42 0 -42 12 0 12 11 16 46 16 32 0 44 -4 42 -12z"/>
                  </g>
                </svg>
              </span>
            </span>
          </@button.kw>
        </@buttonGroup.kw>
      </@form.kw>
    </#if>
  <#elseif section="info">
    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
      <@buttonGroup.kw>
          <@button.kw color="outline" name="register" type="button" onClick="window.location.href='${url.registrationUrl}'">
            ${msg("doRegister")}
          </@button.kw>
        </@buttonGroup.kw>
    </#if>
    <div class="mt-4 text-center" style="font-style: italic;">
      ${msg("privacyPolicy", "<a href='" + privacyUrl + "' target='_blank' class='text-primary-600 hover:underline'>" + msg("here") + "</a>")?no_esc}
    </div>
  <#elseif section="socialProviders">
    <#if realm.password && social.providers??>
      <@identityProvider.kw providers=social.providers />
    </#if>
  </#if>
</@layout.registrationLayout>
