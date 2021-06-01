<#import "parts/common.ftlh" as c>

<@c.page>

    <form class="form-signin text-center" action="/user" method="post">
        <h3 class="mb-3"><b>Изменить пользователя</b></h3>
        <div class="form-floating mb-3 text-center">
            <input type="text" class="form-control"
                   id="inputUsername" name="username" value="${user.username}" name="username"
                   placeholder="Введите новое имя пользователя">
            <label for="inputUsername">Имя пользователя</label>
            <#if usernameError??>
                <div class="invalid-feedback">${usernameError}</div>
            </#if>
        </div>
        <div class="form-floating mb-3">
            <#list roles as role>
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox"
                           name="${role}"
                           id="flexRoleSwitch" ${user.roles?seq_contains(role)?string("checked", "")}>
                    <label class="form-check-label" for="flexRoleSwitch">${role}</label>
                </div>
            </#list>
        </div>
        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <button type="submit" class="btn btn-primary">Сохранить</button>
    </form>

</@c.page>