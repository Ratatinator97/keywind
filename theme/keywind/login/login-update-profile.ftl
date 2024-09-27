<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/checkbox.ftl" as checkbox>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/select.ftl" as select>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username'); section>
    <#if section = "header">
        ${msg("loginProfileTitle")}
    <#elseif section = "form">
        <@form.kw action=url.loginAction method="post">
            <#if user.editUsernameAllowed>
                <@input.kw
                    autocomplete="username"
                    invalid=messagesPerField.existsError('username')
                    label=msg("username")
                    message=kcSanitize(messagesPerField.get('username'))
                    name="username"
                    type="text"
                    value=(user.username!'')
                />
            </#if>
            <@input.kw
                autocomplete="given-name"
                invalid=messagesPerField.existsError('firstName')
                label=msg("firstName")
                message=kcSanitize(messagesPerField.get('firstName'))
                name="firstName"
                type="text"
                value=(user.firstName!'')
            />
            <@input.kw
                autocomplete="family-name"
                invalid=messagesPerField.existsError('lastName')
                label=msg("lastName")
                message=kcSanitize(messagesPerField.get('lastName'))
                name="lastName"
                type="text"
                value=(user.lastName!'')
            />
            <@input.kw
                autocomplete="email"
                invalid=messagesPerField.existsError('email')
                label=msg("email")
                message=kcSanitize(messagesPerField.get('email'))
                name="email"
                type="email"
                value=(user.email!'')
            />
            <input type="hidden" id="user.attributes.locale" name="user.attributes.locale" value="${locale.currentLanguageTag}">
            <!-- Additional fields -->
            <@select.kw
                label=msg("userType")
                name="user.attributes.userType"
                options=[
                    {"value": "parent", "label": msg("parent")},
                    {"value": "liberal", "label": msg("liberal")},
                    {"value": "structure", "label": msg("structure")},
                    {"value": "school", "label": msg("school")},
                    {"value": "other", "label": msg("other")}
                ]
                value=(user.attributes.userType?first)!''
            />
            <@select.kw
                label=msg("sourceMedium")
                name="user.attributes.sourceMedium"
                options=[
                    {"value": "search", "label": msg("search")},
                    {"value": "social", "label": msg("social")},
                    {"value": "friend", "label": msg("friend")},
                    {"value": "other", "label": msg("other")}
                ]
                value=(user.attributes.sourceMedium?first)!''
            />
            <#if user?? && user.attributes?? && user.attributes.marketingOptIn??>
                <@checkbox.kw
                    label=msg("marketingOptIn")
                    name="user.attributes.marketingOptIn"
                    checked=(user.attributes.marketingOptIn?first == 'true')
                />
            <#else>
                <@checkbox.kw
                    label=msg("marketingOptIn")
                    name="user.attributes.marketingOptIn"
                    checked=false
                />
            </#if>

            <#if user.editUsernameAllowed>
                <div class="${properties.kcFormGroupClass!}">
                    <div id="kc-username-message" class="${properties.kcLabelWrapperClass!}">
                        <#if !user.editUsernameAllowed>
                            ${msg("usernameEditDisabled")}
                        </#if>
                    </div>
                </div>
            </#if>

            <@button.kw type="submit">
                ${msg("doSubmit")}
            </@button.kw>
        </@form.kw>
    </#if>
</@layout.registrationLayout>