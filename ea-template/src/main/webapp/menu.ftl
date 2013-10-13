<#include "common/freemarker/include_header.ftl">
<div class="container-fluid">
	<div class="well" style="padding: 12px 0;">
		<ul class="nav nav-list">
		  <li class="nav-header">hotel管理系统</li>
		 
		  <li onclick="menu_active(this)">	<a href="hotel_hotel_list_hotel.do" target="mainFrame">日常管理</a></li>

		  <li onclick="menu_active(this)"><a href="ea_user_list.do" target="mainFrame">客户管理</a></li>   
		  <#--
		  <li onclick="menu_active(this)"> <a href="hotel_finance_report_month.do" target="mainFrame">新客户入住</a></li>
		  <li onclick="menu_active(this)"> <a href="hotel_finance_report_month.do" target="mainFrame">缴费</a></li>
		  <li onclick="menu_active(this)"> <a href="hotel_finance_report_month.do" target="mainFrame">退房</a></li>
		  -->
		  <li onclick="menu_active(this)"> <a href="report_hotelrpt_fee.do" target="mainFrame">运营报表</a></li>
	
		 
		</ul>
	</div><!--/.well -->
</div>
<script>
function menu_active(obj){
	$(".active").removeClass("active");
	$(obj).addClass("active")
}
</script>

