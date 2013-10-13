
<#include "../../../common/freemarker/include_header.ftl">
<#include "../../../common/freemarker/macro_demo.ftl">
 
<form action="report_hotelrpt_fee_bytime.do" method="post" class="well form-horizontal">

开始时间<input style="width:70px" name=begindate  value="${rhs["begindate"]?if_exists}" onclick="javascript:WdatePicker({dateFmt:'yyyy-MM-dd'});"/> 
结束时间<input style="width:70px"  name=enddate   value="${rhs["enddate"]?if_exists}"onclick="javascript:WdatePicker({dateFmt:'yyyy-MM-dd'});"/>

	<input type="submit" class="btn btn-primary" value="查询"/>
</form>
<br>
<a href="#" onclick="return hs.htmlExpand(this)">
	明细显示
</a>

<div class="highslide-maincontent">
	 	<table   class="table  table-condensed">
		<tr>
			<th>日期</th>
			<th>房费</th>
			<th>电费</th>
			<th>水费</th>
			<th>网费</th>
            <th>押金</th>
			<th>金额</th>
			<th>电使用数</th>
			<th>水使用数</th>			
		    <th>备注</th>
		</tr>
		<#assign sum_fee=0 />
		<#assign sum_hfee=0 />
		<#assign sum_efee=0 />
		<#assign sum_wfee=0 />
		<#assign sum_nfee=0 />
		<#assign sum_evalue=0 />
		<#assign sum_depositfee=0 />
		<#assign sum_wvalue=0 />
		<#list rhs["feelist"] as x>   
			<tr title="${x.operationname?if_exists}录入">
			    <td>${x.feedate?if_exists}</td>
			    <td>${x.hfee?if_exists}</td>
			    <td>${x.efee?if_exists}</td>
			    <td>${x.wfee?if_exists}</td>
			    <td>${x.nfee?if_exists}</td>
			    <td>${x.depositfee?if_exists}</td>
			    <td>${x.fee?if_exists}</td>
			    <td>${x.enumber?if_exists}</td>
			    <td>${x.wnumber?if_exists}</td>
			    
			    <td>${x.remark?if_exists}</td>
			</tr>
 		 <#assign sum_fee=sum_fee +x.fee?number/>
    	 <#assign sum_efee=sum_efee +x.efee?number/>
    	 <#assign sum_hfee=sum_hfee +x.hfee?number/>
    	 <#assign sum_wfee=sum_wfee +x.wfee?number/>
    	 <#assign sum_nfee=sum_nfee +x.nfee?number/>
    	 <#assign sum_depositfee=sum_depositfee +x.depositfee?number/>
    	 <#assign sum_evalue=sum_evalue +x.evalue?number/>
    	 <#assign sum_wvalue=sum_wvalue +x.wvalue?number/>
		</#list>
		<tr>
		  <td>总计</td><td>${sum_hfee}元</td><td>${sum_efee}元</td><td>${sum_wfee}元</td><td>${sum_nfee}元</td><td>${sum_depositfee}元</td><td>${sum_fee}元</td>
		  <td>${sum_evalue}度</td><td>${sum_wvalue}吨</td><td></td>
		</tr>
	</table>
</div>

<br>总收入 ：${sum_fee}元
<br>房费收入：${sum_hfee}元
<br>网费收入${sum_nfee}元
<br>电费收入：${sum_efee}元
<br>水费收入：${sum_wfee}元
<br>押金收入：${sum_depositfee}元
<hr>
电总度数：${sum_evalue}度  &nbsp;&nbsp;&nbsp;水总吨数：${sum_wvalue}吨

