<#import "parts/common.ftlh" as c>

<@c.page>

    <form method="post" class="text-center">
        <h4>${username}</h4>
        <div class="row mb-3 align-items-center">
            <label for="inputEmail" class="col-sm-2 col-form-label">Новый email</label>
            <div class="col-sm-4">
                <input type="email" class="form-control" id="inputEmail" name="email" value="${email!}">
            </div>
        </div>
        <div class="row mb-3 align-items-center">
            <label for="inputPassword" class="col-sm-2 col-form-label">Новый пароль</label>
            <div class="col-sm-4">
                <input type="password" class="form-control" id="inputPassword" name="password">
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">Сохранить измения</button>
    </form>
</@c.page>