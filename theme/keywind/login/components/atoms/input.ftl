<#import "/assets/icons/eye.ftl" as iconEye>
<#import "/assets/icons/eye-slash.ftl" as iconEyeSlash>
<#import "/assets/icons/cross.ftl" as iconCross>
<#import "/assets/icons/check.ftl" as iconCheck>
<#macro
  kw
  autofocus=false
  class="block border-secondary-200 w-full mt-1 rounded-md sm:text-sm focus:border-primary-300 focus:ring focus:ring-primary-200 focus:ring-opacity-50"
  disabled=false
  hidden=false
  invalid=false
  label=""
  message=""
  name=""
  required=true
  type="text"
  validationRules=""
  showPasswordIndicators=false
  rest...
>
<#if !hidden>
  <div x-data="{ 
    value: '', 
    error: false,
    errorMessage: '',
    dirty: false,
    validate() {
      this.dirty = true;
      if (this.value === '' && ${required?c}) {
        this.error = true;
        this.errorMessage = '${msg('required')}';
        return;
      }
      
      <#if type == "email">
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(this.value)) {
        this.error = true;
        this.errorMessage = '${msg('invalidEmail')}';
        return;
      }
      </#if>
      
      <#if type == "password">
      if (this.value.length < 8) {
        this.error = true;
        this.errorMessage = '${msg('passwordMinLength')}';
        return;
      }
      // Add more password validation rules here
      </#if>
      
      this.error = false;
      this.errorMessage = '';
    }
  }"
  @input="validate()"
  >
    <label class="block text-sm font-medium text-gray-700 mb-1" for="${name}">
      ${label} <#if required><span class="text-red-500">*</span></#if>
    </label>
    
    <div class="relative">
      <#if type == "password">
        <div class="relative" x-data="{ show: false }">
          <input
            <#if autofocus>autofocus</#if>
            <#if disabled>disabled</#if>
            <#if required>required</#if>
            x-model="value"
            @blur="validate()"
            autocomplete="on"
            :class="{'border-red-300 focus:border-red-300 focus:ring-red-200': error || ${invalid?c},
                    'border-gray-300 focus:border-primary-300 focus:ring-primary-200': !error && !${invalid?c}}"
            class="${class} pr-10 focus:ring focus:ring-opacity-50"
            id="${name}"
            name="${name}"
            :type="show ? 'text' : 'password'"
            <#list rest as attrName, attrValue>
              ${attrName}="${attrValue}"
            </#list>
          >
          <button
            @click="show = !show"
            type="button"
            class="absolute text-secondary-400 right-3 top-3 sm:top-2"
          >
            <div x-show="!show">
              <@iconEye.kw class="h-5 w-5" />
            </div>
            <div x-cloak x-show="show">
              <@iconEyeSlash.kw class="h-5 w-5" />
            </div>
          </button>
        </div>
      <#else>
        <input
          <#if autofocus>autofocus</#if>
          <#if disabled>disabled</#if>
          <#if required>required</#if>
          x-model="value"
          @blur="validate()"
          :class="{'border-red-300 focus:border-red-300 focus:ring-red-200': error || ${invalid?c},
                  'border-gray-300 focus:border-primary-300 focus:ring-primary-200': !error && !${invalid?c}}"
          class="${class} focus:ring focus:ring-opacity-50"
          id="${name}"
          name="${name}"
          type="${type}"
          <#list rest as attrName, attrValue>
            ${attrName}="${attrValue}"
          </#list>
        >
        <div 
        x-show="(error || ${invalid?c}) && (dirty || ${invalid?c})"
        x-transition:enter="transition ease-out duration-300"
        x-transition:enter-start="opacity-0 transform -translate-y-2"
        x-transition:enter-end="opacity-100 transform translate-y-0"
        class="absolute right-3 top-3 sm:top-2 bg-red-50 text-red-600 text-xs rounded shadow-sm"
      >
        <div class="flex items-center">
          <svg class="h-4 w-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
          </svg>
          <span x-text="errorMessage || '${message?no_esc}'"></span>
        </div>
      </div>
      </#if>
    </div>
    <#if type == "password" && showPasswordIndicators>
      <#if name == "password-confirm">
        <div class="flex items-center p-4 gap-2 mt-1 text-xs">
          <div :class="value === document.getElementById('password').value && value !== '' ? 'text-green-600' : 'text-gray-500'">
            <div x-show="value === document.getElementById('password').value && value !== ''">
              <@iconCheck.kw class="h-4 w-4" />
            </div>
            <div x-show="value !== document.getElementById('password').value || value === ''">
              <@iconCross.kw class="h-4 w-4" />
            </div>
          </div>
          <p :class="value === document.getElementById('password').value && value !== '' ? 'text-green-600' : 'text-gray-500'">
            ${msg("passwordMatch")}
          </p>
        </div>
      <#else>
        <div class="flex flex-col p-4 gap-2 m-1 text-xs text-gray-500">
          <div class="flex items-center gap-2">
            <div :class="value.length >= 8 ? 'text-green-600' : 'text-gray-500'">
              <div x-show="value.length >= 8">
                <@iconCheck.kw class="h-4 w-4" />
              </div>
              <div x-show="value.length < 8">
                <@iconCross.kw class="h-4 w-4" />
              </div>
            </div>
            <p :class="value.length >= 8 ? 'text-green-600' : 'text-gray-500'">
              ${msg("passwordMinLength")}
            </p>
          </div>
          
          <div class="flex items-center gap-2">
            <div :class="value.match(/[A-Z]/) ? 'text-green-600' : 'text-gray-500'">
              <div x-show="value.match(/[A-Z]/)">
                <@iconCheck.kw class="h-4 w-4" />
              </div>
              <div x-show="!value.match(/[A-Z]/)">
                <@iconCross.kw class="h-4 w-4" />
              </div>
            </div>
            <p :class="value.match(/[A-Z]/) ? 'text-green-600' : 'text-gray-500'">
              ${msg("passwordUppercase")}
            </p>
          </div>
          
          <div class="flex items-center gap-2">
            <div :class="value.match(/[0-9]/) ? 'text-green-600' : 'text-gray-500'">
              <div x-show="value.match(/[0-9]/)">
                <@iconCheck.kw class="h-4 w-4" />
              </div>
              <div x-show="!value.match(/[0-9]/)">
                <@iconCross.kw class="h-4 w-4" />
              </div>
            </div>
            <p :class="value.match(/[0-9]/) ? 'text-green-600' : 'text-gray-500'">
              ${msg("passwordNumber")}
            </p>
          </div>
        </div>
      </#if>
    </#if>
  </div>
<#else>
  <input type="hidden" id="${name}" name="${name}" 
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
</#if>
</#macro>