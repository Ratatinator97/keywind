<#import "template.ftl" as layout>
<#import "components/atoms/alert.ftl" as alert>
<#import "components/atoms/link.ftl" as link>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/form.ftl" as form>

<@layout.registrationLayout displayMessage=false; section>
  <#if section="header">
    ${kcSanitize(msg("errorTitle"))?no_esc}
  <#elseif section="form">
    <@alert.kw color="error">${kcSanitize(message.summary)?no_esc}</@alert.kw>
    
    <div class="mt-6 space-y-4">
      <@button.kw color="primary" type="button" onClick="forceDisconnect()" value=msg('doLogout')>
        ${msg("doLogout")}
      </@button.kw>
      <#if !skipLink??>
        <#if client?? && client.baseUrl?has_content>
          <@link.kw color="secondary" href=client.baseUrl size="small" class="block mt-4">
            ${kcSanitize(msg("backToApplication"))?no_esc}
          </@link.kw>
        </#if>
      </#if>
    </div>
    
    <script>
      function forceDisconnect() {
          const logoutUrl = `https://auth.pictalk.org/realms/master/protocol/openid-connect/logout`;
          window.location.href = logoutUrl;
      }
    </script>
  </#if>
</@layout.registrationLayout>