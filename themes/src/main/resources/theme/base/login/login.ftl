<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                        <#if !usernameHidden??>
                            <div class="${properties.kcFormGroupClass!}">
                                <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                                <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off"
                                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                />



                                <#if messagesPerField.existsError('username','password')>
                                    <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                                </#if>

                            </div>
                        </#if>

                        <div class="${properties.kcFormGroupClass!}">
                            <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>

                            <input tabindex="2" id="password" class="${properties.kcInputClass!}" name="password" type="password" autocomplete="off"
                                   aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                            />

                            <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                                <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                        </span>
                            </#if>

                        </div>

                        <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                            <div id="kc-form-options">
                                <#if realm.rememberMe && !usernameHidden??>
                                    <div class="checkbox">
                                        <label>
                                            <#if login.rememberMe??>
                                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                            <#else>
                                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                            </#if>
                                        </label>
                                    </div>
                                </#if>
                            </div>
                            <div class="${properties.kcFormOptionsWrapperClass!}">
                                <#if realm.resetPasswordAllowed>
                                    <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                                </#if>
                            </div>

                        </div>

                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                            <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                        </div>
                    </form>
                </#if>
            </div>

        </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <hr/>
                <h4>${msg("identity-provider-login-label")}</h4>

                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <li>
                            <button id="show-provider-login" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>">
                                <#if p.iconClasses?has_content>
                                    <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                    <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                                <#else>
                                    <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                                </#if>
                            </button>
                        </li>
                    </#list>
                </ul>

                <div class="sliding-window" id="provider-login">
                    <form id="my-form" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                        <br><br>
                        <label for="username">TC IDENTITY NO:</label>
                        <input type="text" id="tc" name="tc" required><br><br>

                        <label for="gsmNo">GSM NO:</label>
                        <input type="text" id="gsm" name="gsm" required><br><br>

                        <label>OPERATOR:</label>
                        <input type="radio" id="turkcell" name="operator" value="TURKCELL">
                        <label for="turkcell">TURKCELL</label>

                        <input type="radio" id="avea" name="operator" value="AVEA">
                        <label for="avea">AVEA</label>

                        <input type="radio" id="vodafone" name="operator" value="VODAFONE">
                        <label for="vodafone">VODAFONE</label>

                        <hr>
                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                            <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                        </div>

                        <!-- <button type="submit" id="mobileSignButton">Mobil İmza İle Gir</button> -->
                    </form>

                    <br>
                    <button id="printOpButton">İstek At</button>
                    <br>
                </div>
            </div>
            <script>

                const showProviderLoginButton = document.getElementById('show-provider-login');
                const providerLoginWindow = document.getElementById('provider-login');

                providerLoginWindow.style.display = 'none';
                showProviderLoginButton.addEventListener('click', () => {
                    // Toggle sliding window visibility
                    providerLoginWindow.style.display = providerLoginWindow.style.display === 'block' ? 'none' : 'block';
                    providerLoginWindow.scrollIntoView({ behavior: 'smooth' }); // Scroll to the sliding window
                });


                var operatorRadios = document.getElementsByName('operator');


                var myButton = document.getElementById('printOpButton');
                myButton.addEventListener('click', function() {
                    // Loop through the radio buttons and find the selected one
                    for (var i = 0; i < operatorRadios.length; i++) {
                        if (operatorRadios[i].checked) {

                            const operator =operatorRadios[i].value;
                            const konu= "AuthNET - Mobil Imza Login";
                            const telNo = document.getElementById('gsm').value.toString();
                            const tcKimlikNo =document.getElementById('tc').value.toString();

                            console.log(konu, telNo, tcKimlikNo, operator)


                            //make request
                            const url = "https://www.belgenet.com.tr/mobil-imza-service/mobilImzaLogin";


                            // const operator ="TURKCELL";

                            const requestData = {
                                konu: konu,
                                operator: operator,
                                telNo: telNo,
                                tcKimlikNo: tcKimlikNo
                            };

                            const requestOptions = {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                body: JSON.stringify(requestData)
                            };


                            fetch(url, requestOptions)
                                .then(response => response.json())
                                .then(data => {
                                    console.log('Response:', data);
                                })
                                .catch(error => {
                                    console.error('Error:', error);
                                });

                            break;
                        }
                    }
                });

            </script>

        </#if>
    </#if>

</@layout.registrationLayout>