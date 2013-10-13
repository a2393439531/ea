<#--
<#if Session["userlogined"]?exists&&Session["userlogined"].account=='admin'>
<script type="text/javascript" language="javascript">
    document.location="pframe.ftl";
</script>
</#if>
-->


<frameset rows="50,*" frameborder="no" marginwidth="0" framespacing="0" id="frameset01">
	<frame src="top.ftl" name="topFrame" scrolling="No" noresize="noresize" id="topFrame"/>
	<frameset cols="270,*" framespacing="0" frameborder="no" framespacing="0" id="frameset02">
		<frame src="menu.ftl" name="leftFrame" frameborder="no" noresize="noresize" id="leftFrame" />
		<frame src="home.ftl" frameborder="0" scrolling="auto" noresize="noresize" name="mainFrame">
	</frameset>
</frameset>





