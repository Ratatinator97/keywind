<#macro kw
  class="block border-secondary-200 mt-1 rounded-md w-full focus:border-primary-300 focus:ring focus:ring-primary-200 focus:ring-opacity-50 sm:text-sm"
  disabled=false
  invalid=false
  label=""
  message=""
  name=""
  options=[]
  required=false
  rest...
>
  <div>
    <label class="sr-only" for="${name}">
      ${label}
    </label>
    <select
      <#if disabled>disabled</#if>
      <#if required>required</#if>

      aria-invalid="${invalid?c}"
      class="${class}"
      id="${name}"
      name="${name}"

      <#list rest as attrName, attrValue>
        ${attrName}="${attrValue}"
      </#list>
    >
      <option value="" disabled selected="selected">${label}</option>
      <#list options as option>
        <option value="${option.value}">${option.label}</option>
      </#list>
    </select>
    <#if invalid?? && message??>
      <div class="mt-2 text-red-600 text-sm">
        ${message?no_esc}
      </div>
    </#if>
  </div>
</#macro>