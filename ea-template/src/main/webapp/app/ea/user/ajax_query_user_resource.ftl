
<table >  
<tr valign=top width=500px>
    <td style="border: 0px;">
        <table>
		    <thead>
				<tr><td width=70>姓名</td><td width=60>操作</td></tr>
			</thead>
			<tbody>
			<#list rhs["dataList"]?sort_by("name") as x>
				<tr >
					<td><input style="width=70" type="text"  value='${x.name?if_exists}' /></td>
					<td><a style="width=60" onclick="query_user_resources('${x.name}')" type=button  class="button" >查询</a></td>
				</tr>
			</#list> 
			</tbody>
		 </table>
    </td>
    
    <td valign=top width=250px>
    	<div id=show_query><div> 
    </td>
</tr>

<tr style="border: 0px;text-align:right;" valign=bottom width=500px>
	<span id="div_result" class=info></span>&nbsp;&nbsp;
	<#--分页操作 -->
	显示条数<input class=text size=1 value="${rhs.maxSize}" onchange="javascript:ajax_page_user1('maxSize',this.value)" />
	<#if (rhs.currentPage > 1) >[<a onclick="javascript:getPage_user1(${1})">第一页</a>]&nbsp;&nbsp;</#if>
	<#if (rhs.currentPage > 1) >[<a onclick="javascript:getPage_user1(${rhs.currentPage-1})">上一页</a>]&nbsp;&nbsp;</#if>
	<#if (rhs.currentPage < rhs.maxPage) >[<a onclick="javascript:getPage_user1(${rhs.currentPage+1})">下一页</a>]&nbsp;&nbsp;</#if>
	<#if (rhs.currentPage < rhs.maxPage) >[<a onclick="javascript:getPage_user1(${rhs.maxPage})">最后页</a>]&nbsp;&nbsp;</#if>
	第${rhs.currentPage}页&nbsp;&nbsp;
	共${rhs.maxPage}页&nbsp;&nbsp;
	总${rhs.count}条记录
</tr>

</table>





	
   
    