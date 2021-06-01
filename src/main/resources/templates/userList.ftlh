<#import "parts/common.ftlh" as c>

<@c.page>
    <table class="table table-striped">
        <thead>
        <tr>
            <th scope="col">Имя пользователя</th>
            <th scope="col">Роли</th>
            <th scope="col">Изменить</th>
        </tr>
        </thead>
        <tbody>
        <#list user_list as user>
            <tr>
                <td>${user.username}</td>
                <td>
                    <#list user.roles as role>
                        ${role}<#sep> | </#list>
                </td>
                <td><a href="/user/${user.id}">изменить</a></td>
            </tr>
        </#list>
        </tbody>
    </table>

</@c.page>