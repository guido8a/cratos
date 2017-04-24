<g:form name="frm-rubro" action="save" method="post" >
    <g:hiddenField name="id" value="${rubroInstance?.id}" />
    <g:hiddenField name="version" value="${rubroInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-rubro").validate();

        $("#frm-rubro").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
