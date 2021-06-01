<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>
    <i>${message!}</i>
    <@l.login "/register" true/>
</@c.page>