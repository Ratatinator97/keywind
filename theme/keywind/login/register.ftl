<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/checkbox.ftl" as checkbox>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>
<#import "components/atoms/select.ftl" as select>

<#assign termsUrl = "https://www.pictalk.org/" + locale.currentLanguageTag + "/terms-of-use">
<#assign privacyUrl = "https://www.pictalk.org/" + locale.currentLanguageTag + "/privacy-policy">

<@layout.registrationLayout
  displayMessage=!messagesPerField.existsError("firstName", "lastName", "email", "username", "password", "password-confirm")
  ;
  section
>
  <#if section="header">
    ${msg("registerTitle")}
  <#elseif section="form">
    <@form.kw action=url.registrationAction method="post">
      <@input.kw
        autocomplete="given-name"
        autofocus=true
        invalid=messagesPerField.existsError("firstName")
        label=msg("firstName")
        message=kcSanitize(messagesPerField.get("firstName"))
        name="firstName"
        type="text"
        value=(register.formData.firstName)!''
      />
      <@input.kw
        autocomplete="family-name"
        invalid=messagesPerField.existsError("lastName")
        label=msg("lastName")
        message=kcSanitize(messagesPerField.get("lastName"))
        name="lastName"
        type="text"
        value=(register.formData.lastName)!''
      />
      <@input.kw
        autocomplete="email"
        invalid=messagesPerField.existsError("email")
        label=msg("email")
        message=kcSanitize(messagesPerField.get("email"))
        name="email"
        type="email"
        value=(register.formData.email)!''
      />
      <#if !realm.registrationEmailAsUsername>
        <@input.kw
          autocomplete="username"
          invalid=messagesPerField.existsError("username")
          label=msg("username")
          message=kcSanitize(messagesPerField.get("username"))
          name="username"
          type="text"
          value=(register.formData.username)!''
        />
      </#if>
      <#if passwordRequired??>
        <@input.kw
          autocomplete="new-password"
          invalid=messagesPerField.existsError("password", "password-confirm")
          label=msg("password")
          message=kcSanitize(messagesPerField.getFirstError("password", "password-confirm"))
          name="password"
          type="password"
        />
        <@input.kw
          autocomplete="new-password"
          invalid=messagesPerField.existsError("password-confirm")
          label=msg("passwordConfirm")
          message=kcSanitize(messagesPerField.get("password-confirm"))
          name="password-confirm"
          type="password"
        />
      </#if>
      <@select.kw
        label=msg("sourceMedium")
        name="sourceMedium"
        required=true
        options=[
          {"value": "search", "label": "search"},
          {"value": "social", "label": "social"},
          {"value": "friend", "label": "friend"},
          {"value": "other", "label": "other"}
        ]
      />
      <input type="hidden" id="user.attributes.locale" name="user.attributes.locale" value="${locale.currentLanguageTag}">
      <@checkbox.kw
  label=msg("termsAccepted", 
    "<a href='" + termsUrl + "' target='_blank' class='text-primary-600 hover:underline'>" + msg("terms") + "</a>",
    "<a href='" + privacyUrl + "' target='_blank' class='text-primary-600 hover:underline'>" + msg("privacy") + "</a>")
  name="termsAccepted"
  required="required"
/>
      <@checkbox.kw
        label=msg("marketingOptIn")
        name="marketingOptIn"
        checked=true
      />
      <@checkbox.kw
        label=msg("analyticsConsent")
        name="analyticsConsent"
        checked=true
      />
      <#if recaptchaRequired??>
        <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}" data-size="compact"></div>
      </#if>
      <@buttonGroup.kw>
        <@button.kw color="primary" type="submit">
          ${msg("doRegister")}
        </@button.kw>
      </@buttonGroup.kw>
    </@form.kw>
  <#elseif section="nav">
    <@link.kw color="secondary" href=url.loginUrl size="small">
      ${kcSanitize(msg("backToLogin"))?no_esc}
    </@link.kw>
  </#if>
</@layout.registrationLayout>
