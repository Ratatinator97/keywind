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
  displayMessage=!messagesPerField.existsError("firstName", "lastName" , "email" , "username" , "password" , "password-confirm" )
  ;
  section>
  <#if section="header">
    ${msg("registerTitle")}
    <#elseif section="form">
      <div x-data="{ 
        step: 1,
        formValid: false,
        validateForm() {
          if (this.step === 1) {
            const inputs = document.querySelectorAll('input[required]');
            const password = document.getElementById('password')?.value || '';
            const passwordConfirm = document.getElementById('password-confirm')?.value || '';
            const passwordsMatch = password === passwordConfirm && password !== '';
            
            const inputsValid = Array.from(inputs).every(input => {
              const inputComponent = input.closest('[x-data]');
              if (!inputComponent) return input.value.length > 0;
              
              const errorState = inputComponent.__x?.data?.error ?? false;
              return !errorState && input.value.length > 0;
            });
            
            this.formValid = inputsValid && passwordsMatch;
          } else if (this.step === 2) {
            const sourceMedium = document.querySelector('select[name=\'sourceMedium\']')?.value;
            const userType = document.querySelector('select[name=\'userType\']')?.value;
            
            const termsAccepted = document.querySelector('input[name=\'termsAccepted\']')?.checked;
            const marketingOptIn = document.querySelector('input[name=\'marketingOptIn\']')?.value;
            
            this.formValid = termsAccepted;
          }
        }
      }">
        <@form.kw action=url.registrationAction method="post" @input="validateForm()">
          <!-- Step 1: Basic Information -->
          <div class="flex gap-2 justify-between h-2 w-full">
            <div class="h-full bg-primary-600 grow rounded-sm"></div>
            <div x-show="step ===2" class="h-full grow rounded-sm bg-primary-600"></div>
            <div x-show="step ===1" class="h-full grow rounded-sm bg-gray-200"></div>
          </div>
          <div x-show="step === 1">
            <div class="min-h-72">
              <@input.kw
                autocomplete="given-name"
                autofocus=true
                invalid=messagesPerField.existsError("firstName")
                label=msg("firstName")
                message=kcSanitize(messagesPerField.get("firstName"))
                name="firstName"
                type="text"
                value=(register.formData.firstName)!'' />
              <@input.kw
                autocomplete="family-name"
                invalid=messagesPerField.existsError("lastName")
                label=msg("lastName")
                message=kcSanitize(messagesPerField.get("lastName"))
                name="lastName"
                type="text"
                value=(register.formData.lastName)!'' />
              <@input.kw
                autocomplete="email"
                invalid=messagesPerField.existsError("email")
                label=msg("email")
                message=kcSanitize(messagesPerField.get("email"))
                name="email"
                type="email"
                value=(register.formData.email)!'' />
              <#if !realm.registrationEmailAsUsername>
                <@input.kw
                  autocomplete="username"
                  invalid=messagesPerField.existsError("username")
                  label=msg("username")
                  message=kcSanitize(messagesPerField.get("username"))
                  name="username"
                  type="text"
                  value=(register.formData.username)!'' />
              </#if>
              <#if passwordRequired??>
                <@input.kw
                  autocomplete="new-password"
                  invalid=messagesPerField.existsError("password", "password-confirm" )
                  label=msg("password")
                  showPasswordIndicators=true
                  message=kcSanitize(messagesPerField.getFirstError("password", "password-confirm" ))
                  name="password"
                  type="password" />
                <@input.kw
                  autocomplete="new-password"
                  invalid=messagesPerField.existsError("password-confirm")
                  label=msg("passwordConfirm")
                  showPasswordIndicators=true
                  message=kcSanitize(messagesPerField.get("password-confirm"))
                  name="password-confirm"
                  type="password" />
              </#if>
            </div>
            <@button.kw 
              color="primary" 
              type="button" 
              class="my-2" 
              @click="step = 2; validateForm();" 
              disabled="!formValid"
            >
            ${msg("continue")}
          </@button.kw>
          </div>
          
          <!-- Step 2: Additional Information -->
          <div x-show="step === 2">
            <div class="min-h-72">
              <@select.kw
                label=msg("sourceMedium")
                name="sourceMedium"
                options=[
                {"value": "search", "label": msg("search")},
                {"value": "social", "label": msg("social")},
                {"value": "friend", "label": msg("friend")},
                {"value": "other", "label": msg("other")}
                ] />
              <@select.kw
                label=msg("userType")
                name="userType"
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
                required=true />
              <@checkbox.kw
                label=msg("marketingOptIn")
                name="marketingOptIn"
                checked=true
                 />
              <#if recaptchaRequired??>
                <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}" data-size="compact"></div>
              </#if>
            </div>
            <@buttonGroup.kw>
              <@button.kw disabled="!formValid" color="primary" type="submit">
                ${msg("doRegister")}
              </@button.kw>
              <@button.kw  color="secondary" type="button" @click="step = 1">
                ${msg("back")}
              </@button.kw>
            </@buttonGroup.kw>
          </div>
        </@form.kw>
      </div>
      <#elseif section="nav">
        <@link.kw color="secondary" href=url.loginUrl size="small">
          ${kcSanitize(msg("backToLogin"))?no_esc}
        </@link.kw>
  </#if>
</@layout.registrationLayout>