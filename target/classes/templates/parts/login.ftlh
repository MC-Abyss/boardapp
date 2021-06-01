<#macro login path isRegisterForm>
    <form class="form-signin text-center" action="${path}" method="post">
        <#if isRegisterForm>
            <h3 class="mb-3"><b>Зарегестрировать нового пользователя</b></h3>
        <#else>
            <h3 class="mb-3"><b>Войти</b></h3>
        </#if>
        <div class="form-floating mb-3">
            <input type="text" class="form-control ${(usernameError??)?string('is-invalid', '')}"
                   id="inputUsername" name="username" value="<#if user??>${user.username}</#if>"
                   placeholder="Enter username">
            <label for="inputUsername">Имя пользователя</label>
            <#if usernameError??>
                <div class="invalid-feedback">${usernameError}</div>
            </#if>
        </div>
        <#if isRegisterForm>
            <div class="form-floating mb-3">
                <input type="email" class="form-control ${(emailError??)?string('is-invalid', '')}"
                       id="inputEmail" name="email" value="<#if user??>${user.email}</#if>"
                       placeholder="example@example.com">
                <label for="inputEmail">Email</label>
                <#if emailError??>
                    <div class="invalid-feedback">${emailError}</div>
                </#if>
            </div>
        </#if>
        <div class="form-floating mb-3">
            <input type="password" class="form-control ${(passwordError??)?string('is-invalid', '')}"
                   id="inputPassword" name="password" placeholder="Enter password">
            <label for="inputPassword">Пароль</label>
            <#if passwordError??>
                <div class="invalid-feedback">${passwordError}</div>
            </#if>
        </div>
        <#if isRegisterForm>
            <div class="form-floating mb-3">
                <input type="password" class="form-control ${(password2Error??)?string('is-invalid', '')}"
                       id="inputPassword2" name="password2" placeholder="Enter password">
                <label for="inputPassword2">Подтверждение пароля</label>
                <#if password2Error??>
                    <div class="invalid-feedback">${password2Error}</div>
                </#if>
            </div>
        </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary"><#if isRegisterForm>Создать<#else>Войти</#if></button>
        <#if !isRegisterForm>
            <div><a href="/register">Регистрация</a></div>
        </#if>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <button type="submit" class="btn btn-primary">Выйти</button>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    </form>
</#macro>