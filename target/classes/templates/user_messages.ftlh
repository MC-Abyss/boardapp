<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="text-center mb-3">
        <h3>${userAuthor.username}</h3>
    </div>
    <#if !isCurrentUser>
        <#if isSubscriber>
            <div class="text-center mb-3">
                <a href="/user/unsubscribe/${userAuthor.id}" class="btn btn-outline-primary" style="background-color: #f1f5f1; color: #0e720b; border-color: #0e720b;">Отписаться</a>
            </div>
        <#else>
            <div class="text-center mb-3">
                <a href="/user/subscribe/${userAuthor.id}" class="btn btn-primary">Подписаться</a>
            </div>
        </#if>
    </#if>
    <div class="row mb-3 justify-content-around">
        <div class="col-3">
            <div class="card bg-light text-center">
                <h5 class="card-title">Подписки</h5>
                <h3 class="card-text"><a href="/user/subscriptions/${userAuthor.id}/">${subscriptionsCount}</a></h3>
            </div>
        </div>
        <div class="col-3">
            <div class="card bg-light text-center">
                <h5 class="card-title">Подписчики</h5>
                <h3 class="card-text"><a href="/user/subscribers/${userAuthor.id}/">${subscribersCount}</a></h3>
            </div>
        </div>

        <div class="col-3">
            <div class="card bg-light text-center">
                <h5 class="card-title">Email</h5>
                <h3 class="card-text">${userAuthor.getEmail()}</h3>
            </div>
        </div>
    </div>
    <#if isCurrentUser>
        <#include "parts/edit_message.ftlh"/>
    </#if>
    <#include "parts/message_list.ftlh"/>
</@c.page>