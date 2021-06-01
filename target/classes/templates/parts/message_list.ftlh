<#include "security.ftlh">
<#import "page.ftlh" as p>

<@p.message_page url page/>
<div class="row row-cols-10 row-cols-md-4 g-4" data-masonry='{"percentPosition": true }'>

    <#list page.content as message>
        <div class="col-lg-3 col-md-4 col-sm-8">
            <div class="card p-x-1 p-top-1">
                <div>
                    <#if message.filename??>
                        <img src="/img/${message.filename}" class="card-img-top"/>
                    </#if>
                </div>
                <p class="card-text mx-2 mt-2">${message.text}</p>
                <p class="card-text mx-2"><i>#${message.tag}</i></p>
                <div class="card-footer">
                    <div class="row justify-content-end">
                        <div class="col-4">
                            <a href="/user-messages/${message.author.id}">${message.authorName}</a>
                        </div>
                        <#if message.author.id == currentId>
                            <div class="col-4">
                                <a class="btn btn-block btn-secondary"
                                   href="/user-messages/${message.author.id}?message=${message.id}"
                                   style="color: #f1f5f1">
                                    Изменить
                                </a>
                            </div>
                        <#else>
                            <div class="col-4"></div>
                        </#if>
                        <#if message.author.id == currentId || isAdmin>
                            <div class="col-4">
                                <a class="btn btn-block btn-danger"
                                   href="/delete/${message.id}" style="color: #f1f5f1">
                                    Удалить
                                </a>
                            </div>
                        <#else>
                            <div class="col-4"></div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </#list>
</div>
