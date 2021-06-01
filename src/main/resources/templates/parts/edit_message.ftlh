
<div class="d-flex justify-content-center">
<button class="btn btn-primary mb-3 mx-auto" type="button" data-bs-toggle="collapse" data-bs-target="#messageForm"
        aria-expanded="false" aria-controls="messageForm" xmlns="http://www.w3.org/1999/html" >
    <#if message??>Изменить сообщение<#else>Добавить сообщение</#if>
</button>
</div>
<div class="d-flex justify-content-center text-center">
<div class="collapse <#if message??>show</#if>" id="messageForm">
    <form method="post" enctype="multipart/form-data">
        <div class="row mb-2">
            <div class="col-sm-12">
                <textarea class="form-control ${(textError??)?string('is-invalid', '')}" type="text" name="text"
                          placeholder="Введите текст"><#if message??>${message.text}</#if></textarea>
                <#if textError??>
                    <div class="invalid-feedback">${textError}</div>
                </#if>
            </div>
        </div>
        <div class="row mb-2">
            <div class="col-sm-12">
                <select class="form-select ${(tagError??)?string('is-invalid', '')}" name="tag">
                    <option value="Куплю" <#if message?? && message.tag=="Куплю">selected</#if>>Куплю</option>
                    <option value="Продам" <#if message?? && message.tag=="Продам">selected</#if>>Продам</option>
                    <option value="Обменяю" <#if message?? && message.tag=="Обменяю">selected</#if>>Обменяю</option>
                </select>
                <#if tagError??>
                    <div class="invalid-feedback">${tagError}</div>
                </#if>
            </div>
        </div>
        <div class="row mb-2">
            <div class="col-sm-12">
                <div class="input-group">
                    <label class="input-group-text" for="inputFile">Загрузить</label>
                    <input type="file" name="file" class="form-control" id="inputFile"/>
                </div>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <input type="hidden" name="id" value="<#if message?? && message.id??>${message.id}</#if>"/>
        <button class="btn btn-outline-primary mb-2" type="submit" style="background-color: #f1f5f1; color: #0e720b; border-color: #0e720b;">Сохранить</button>
    </form>
</div>
</div>