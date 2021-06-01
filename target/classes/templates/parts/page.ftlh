<#macro message_page url page>
    <#if page.getTotalPages() gt 7>
        <#assign
            totalPages = page.getTotalPages()
            pageNumber = page.getNumber() + 1
            head = (pageNumber gt 4)?then([1,-1], [1,2,3])
            tail = (pageNumber lt totalPAges - 3 )?then([-1, totalPages], [totalPages-2, totalPages-1, totalPages])
            pagesBefore = (pageNumber gt 4 && pageNumber lt totalPages - 1)?then([pageNumber - 2, pageNumber - 1], [])
            pagesAfter = (pageNumber gt 2 && pageNumber lt totalPages - 3)?then([pageNumber + 1, pageNumber + 2], [])
            body = head + bodyBefore + (pageNumber gt 3 && pageNumber lt totalPages - 2)?then([pageNumber], []) + bodyAfter + tail
        >
    <#elseif page.getTotalPages() gte 0>
        <#assign body = 1..page.getTotalPages()>
    <#else>
        <#assign body = [0]>
    </#if>
    <div class="pageselector">

        <ul class="pagination justify-content-center">
            <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1">Количество объявлений</a>
            </li>
            <#list [4, 12, 24, 40] as c>
                <#if c == page.getSize()>
                    <li class="page-item active">
                        <a class="page-link" href="#" style="background-color: #0e720b; color: #f1f5f1; border-color: #44a03f;">${c}</a>
                    </li>
                <#else>
                    <li class="page-item">
                        <a class="page-link" href="${url}?page=${0}&size=${c}<#if filter??>&filter=${filter}</#if>">${c}</a>
                    </li>
                </#if>
            </#list>
        </ul>

        <ul class="pagination justify-content-center">
            <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1">Страница</a>
            </li>
            <#if body?first != 0>
                <#list body as p>
                    <#if (p-1) == page.getNumber()>
                        <li class="page-item active" >
                            <a class="page-link" href="#" style="background-color: #0e720b; color: #f1f5f1; border-color: #44a03f;">${p}</a>
                        </li>
                    <#elseif p == -1>
                        <li class="page-item disabled">
                            <a class="page-link" href="#">...</a>
                        </li>
                    <#else>
                        <li class="page-item">
                            <a class="page-link" href="${url}?page=${p-1}&size=${page.getSize()}<#if filter??>&filter=${filter}</#if>">${p}</a>
                        </li>
                    </#if>
                </#list>
            </#if>
        </ul>
    </div>
</#macro>