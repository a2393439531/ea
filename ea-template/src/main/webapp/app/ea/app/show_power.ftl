<#include "../../../common/freemarker/include_header.ftl">
<#include "../view/macro_view.ftl">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script language="javascript" src="<@context/>app/ea/view/view_organize.js"></script>
<body>
<p style="color:#ccc">
职责职责职责职责职责职责职责职责
<br>责职责职责职责职责职责职责职责
<br>责职责职责职责职责职责职责职责<br>责职责职责职责职责职责职责职责
<br>责职责职责职责职责职责职责职责
<br>责职责职责职责职责职责职责职责
<br>责职责职责职责职责职责职责职责
<br>责职责职责职责职责职责职责职责

</p>
<span style="color:green"></span>
	<div class="zz">
		<script language="javascript"> 
			var n1=new OrgNode();
			n1.Text="<@roletext rhs["role"] />";
			n1.Description="";
			n1.Link="";
			<@digui_role_v rhs["role"].getChildRoles()?sort_by("sortNob"),"n1" ,30 ,'no'/>
			var OrgShows=new OrgShow(n1);
			OrgShows.Top=1;
			OrgShows.Left=20;
			OrgShows.IntervalWidth=2;
			OrgShows.IntervalHeight=50;
			OrgShows.ShowType=1; //2代表文字是竖的
			OrgShows.BoxHeight=22; //高度
			OrgShows.BoxWidth=174; //宽度
			OrgShows.LineSize=2;  //设置线条大小
			OrgShows.LineColor="#000";  //设置线条颜色
			OrgShows.Run();
		</script>
	</div>	    
</body>
