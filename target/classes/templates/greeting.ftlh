<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="text-center">
        <h3> Приветствуем, <#if user??>${user.getUsername()}<#else>гость</#if></h3>
        <h5>Это приложение, предназначенное для продажи, покупки и обмена настольными играми между
            пользователями. <#if !user??>Для продолжения необходимо зарегестрироваться.</#if></h5>
        <div>
            <img src="/img/index.png" class="img-fluid" style="max-width: 600px">
        </div>
    </div>
</@c.page>