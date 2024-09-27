<#macro kw rest...>
  <form
    class="my-4 space-y-4"

    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </form>
</#macro>
