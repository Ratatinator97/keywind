<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>

<@layout.registrationLayout displayMessage=false; section>
  <#if section="header">
    ${msg("termsTitle")}
  <#elseif section="form">
    <div class="overflow-auto h-56">
    ${kcSanitize(msg("termsText"))?no_esc}
    </div>
    <div class="overflow-auto h-56">
    ${kcSanitize(msg("privacyText"))?no_esc}
    </div>
    <@form.kw action=url.loginAction method="post">
      <@buttonGroup.kw>
        <@button.kw color="primary" name="accept" type="submit">
          ${msg("doAccept")}
        </@button.kw>
        <@button.kw color="secondary" name="cancel" type="submit">
          ${msg("doDecline")}
        </@button.kw>
      </@buttonGroup.kw>
    </@form.kw>
  </#if>
</@layout.registrationLayout>
