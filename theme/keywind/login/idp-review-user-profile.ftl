<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>
<#import "components/atoms/select.ftl" as select>
<#import "components/atoms/checkbox.ftl" as checkbox>
<#assign termsUrl = "https://www.pictalk.org/" + locale.currentLanguageTag + "/terms-of-use">
<#assign privacyUrl = "https://www.pictalk.org/" + locale.currentLanguageTag + "/privacy-policy">
<@layout.registrationLayout
  displayMessage=messagesPerField.exists('global')
  displayRequiredFields=false;
  section
>
  <#if section="header">
    ${msg("loginIdpReviewProfileTitle")}
  <#elseif section="form">
    <@form.kw action=url.loginAction method="post">
        <@input.kw
          hidden=(user.getEmail()?has_content)
          autocomplete="email"
          invalid=messagesPerField.existsError("email")
          label=msg("email")
          message=kcSanitize(messagesPerField.get("email"))
          name="email"
          type="email"
          value=(user.getEmail())!''
        />
  
      <@input.kw
        hidden=(user.getFirstName()?has_content)
        autocomplete="given-name"
        autofocus=true
        invalid=messagesPerField.existsError("firstName")
        label=msg("firstName")
        message=kcSanitize(messagesPerField.get("firstName"))
        name="firstName"
        type="text"
        value=(user.getFirstName())!''
      />
      <@input.kw
        hidden=(user.getLastName()?has_content)
        autocomplete="family-name"
        invalid=messagesPerField.existsError("lastName")
        label=msg("lastName")
        message=kcSanitize(messagesPerField.get("lastName"))
        name="lastName"
        type="text"
        value=(user.getLastName())!''
      />
      <@select.kw
        label=msg("sourceMedium")
        name="sourceMedium"
        required=true
        options=[
        {"value": "search", "label": msg("search")},
        {"value": "social", "label": msg("social")},
        {"value": "friend", "label": msg("friend")},
        {"value": "other", "label": msg("other")}
        ] />
      <@select.kw
        label=msg("userType")
        name="userType"
        required=true
        options=[
        {"value": "parent", "label": msg("parent")},
        {"value": "liberal", "label": msg("liberal")},
        {"value": "structure", "label": msg("structure")},
        {"value": "school", "label": msg("school")},
        {"value": "other", "label": msg("other")}
        ] />
      <input type="hidden" id="user.attributes.locale" name="user.attributes.locale" value="${locale.currentLanguageTag}">
      <@checkbox.kw
        label=msg("termsAccepted", "<a href='" + termsUrl + "' target='_blank' class='text-primary-600 hover:underline'>" + msg("terms") + "</a>" , "<a href='" + privacyUrl + "' target='_blank' class='text-primary-600 hover:underline'>" + msg("privacy") + "</a>" )
        name="termsAccepted"
        required="required" />
      <@checkbox.kw
        label=msg("marketingOptIn")
        name="marketingOptIn"
        checked=true />
      <@checkbox.kw
        label=msg("analyticsConsent")
        name="analyticsConsent"
        checked=true />
      <#if !realm.registrationEmailAsUsername>
        <@input.kw
          autocomplete="username"
          invalid=messagesPerField.existsError("username")
          label=msg("username")
          message=kcSanitize(messagesPerField.get("username"))
          name="username"
          type="text"
          value=(user.getUsername())!''
        />
      </#if>

      <div class="${properties.kcFormGroupClass!}">
        <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
          <div class="${properties.kcFormOptionsWrapperClass!}">
          </div>
        </div>

        <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
          <@button.kw color="primary" type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}">
            ${msg("doSubmit")}
          </@button.kw>
        </div>
      </div>
    </@form.kw>
  <#elseif section="nav">
    <@link.kw color="secondary" href=url.loginUrl size="small">
      ${kcSanitize(msg("backToLogin"))?no_esc}
    </@link.kw>
  </#if>
</@layout.registrationLayout>