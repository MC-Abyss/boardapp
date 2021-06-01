<#include "security.ftlh">
<#import "login.ftlh" as l>
<header>
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="/" style="color: #f1f5f1">BoardApp</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation" style="background-color: #0e720b; color: #f1f5f1; border-color: #44a03f;">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/">Домашняя страница</a>
                </li>
                <#if user?? && isActive??>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/main">Объявления</a>
                </li>
                </#if>
                <#if user?? && isActive??>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/subscriptions">Подписки</a>
                </li>
                </#if>
                <#if user?? && isActive??>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/user-messages/${currentId}">Мои объявления</a>
                </li>
                </#if>
                <#if isAdmin>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/user">Пользователи</a>
                </li>
                </#if>
                <#if user?? && isActive??>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/user/profile">Профиль</a>
                    </li>
                </#if>
                <#if user?? && isActive??>
                    <li class="nav-item">
                        <form class="d-flex" method="get" action="/main">
                            <input class="form-control me-2" type="search" name="filter" placeholder="Поиск" aria-label="Поиск" value="${filter?ifExists}">
                            <button class="btn btn-primary" type="submit">Поиск</button>
                        </form>
                    </li>
                </#if>
            </ul>


            <div class="navbar-text me-3">${name}</div>
            <#if user??>
                <@l.logout/>
            <#else>
                <a href="/login" class="btn btn-primary">Войти</a>
            </#if>
        </div>
    </div>
</nav>
</header>
