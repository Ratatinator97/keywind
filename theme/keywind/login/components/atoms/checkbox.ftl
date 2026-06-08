<#macro kw checked=false label="" name="" required=false rest...>
  <#assign isRequired = required?is_boolean?then(required, required?has_content && required != "false")>
  <div class="flex items-center">
    <input
      <#if checked>checked</#if>

      class="border-secondary-200 h-4 rounded text-primary-600 w-4 focus:ring-primary-200 focus:ring-opacity-50"
      id="${name}"
      name="${name}"
      type="checkbox"

      <#list rest as attrName, attrValue>
        ${attrName}="${attrValue}"
      </#list>
    >
    <label class="ml-2 text-secondary-600 text-sm" for="${name}">
      ${label?no_esc}
      <#if isRequired>
        <span class="text-red-500">*</span>
      </#if>
    </label>
  </div>
</#macro>
