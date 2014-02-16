<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<link href="view/view.css" rel="stylesheet">
<#--只能显示一种特效-->
<script type="text/javascript" src="../../common/highslide-4113/highslide/highslide-with-gallery.js"></script>
<link rel="stylesheet" type="text/css" href="../../common/highslide-4113/highslide/highslide.css" />

<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="../highslide/highslide-ie6.css" />
<![endif]-->
<!--
    2) Optionally override the settings defined at the top
    of the highslide.js file. The parameter hs.graphicsDir is important!
-->
<script type="text/javascript">
   

	hs.graphicsDir = '../../common/highslide-4113/highslide/graphics/';
	hs.align = 'center';
	hs.transitions = ['expand', 'crossfade'];
	hs.fadeInOut = true;
	hs.outlineType = 'rounded-white';
	hs.headingEval = 'this.a.title';
	hs.numberPosition = 'heading';
	hs.useBox = true;
	hs.width = 600;
	hs.height = 400;
	hs.showCredits = false;
	//hs.dimmingOpacity = 0.8;
	// Add the slideshow providing the controlbar and the thumbstrip
	hs.addSlideshow({
		//slideshowGroup: 'group1',
		interval: 5000,
		repeat: false,
		useControls: true,
		fixedControls: 'fit',
		overlayOptions: {
			position: 'top right',
			offsetX: 200,
			offsetY: -65
		},
		thumbstrip: {
			position: 'rightpanel',
			mode: 'float',
			relativeTo: 'expander',
			width: '210px'
		}
	});

	// Make all images animate to the one visible thumbnail
	var miniGalleryOptions1 = {
		thumbnailId: 'thumb1'
	}
</script>
<script language="javascript" src="view/view_organize.js"></script>
<#include "macro_view.ftl">	

</head>
<body>


<a href="#" onclick="return hs.htmlExpand(this, { contentId: 'highslide-duty' } )"class="highslide">显示职责</a>
<a href="#" onclick="return hs.htmlExpand(this, { contentId: 'highslide-phone' } )"class="highslide">显示联系方式</a>


<b>
<#--
<a href="#" onclick="return hs.htmlExpand(this, { contentId: 'highslide-version' } )"class="highslide">显示企业愿景</a>
-->

   <div class="highslide-html-content" id="highslide-duty">
	<div class="highslide-header">
		<ul>
			<li class="highslide-move">职责说明
				<a href="#" onclick="return false"></a>
			</li>
		</ul>
	</div>
	<div class="highslide-body">
		<table   class="table  table-condensed" >
			<tr>
			    <td align=left valign=top style="border:1px solid #ccc;"><b>${rhs["role"].name}</b></td>
			    <td align=left valign=top style="border:1px solid #ccc;">${rhs["role"].positiondescription?if_exists}</td>
			</tr>
			<@list_role rhs["role"].getChildRoles()/>
		</table>	</div>
    <div class="highslide-footer">
        <div>
            <span class="highslide-resize" title="Resize">
            </span>
        </div>
    </div>
</div>

<div class="highslide-html-content" id="highslide-phone">
	<div class="highslide-header">
		<ul>
			<li class="highslide-move">联系方式
				<a href="#" onclick="return false"></a>
			</li>
		</ul>
	</div>
	<div class="highslide-body">
		<table   class="table  table-condensed" >
	    <thead>
			<tr>
				<th align=left>姓名</th>
		        <th align=left>手机</th>
		        <th align=left>QQ</th>
				<th align=left>邮箱</th>
			</tr>
		</thead>		
			<#list rhs["role"].allUserUnderRole() as user>
			<tr>
			    <td align=left valign=top width=80px>${user.name}</td>
			    <td align=left valign=top>${user.phoneNumber?if_exists}</td>
			    <td align=left valign=top>${user.qq?if_exists}</td>
			    <td align=left valign=top>${user.email?if_exists}</td>
			</tr>
			</#list>
		</table>	
	</div>
    <div class="highslide-footer">
        <div>
            <span class="highslide-resize" title="Resize">
            </span>
        </div>
    </div>
</div>


<div class="highslide-gallery">
	<a class='highslide' id="thumb1" href='../../file/photo/${rhs["role"].allUserUnderRole()[0].imgfilename?if_exists}' onclick="return hs.expand(this, miniGalleryOptions1)" title="Two cabins">
		<img src='../../file/photo/${rhs["role"].allUserUnderRole()[0].imgfilename?if_exists}' alt=''/></a>
	<div class="hidden-container">
	<#list rhs["role"].allUserUnderRole() as user>
		    <a class='highslide' href='../../file/photo/${user.imgfilename?if_exists}' onclick="return hs.expand(this)"	title="Ptarmigan">
			<img src='../../file/photo/${user.imgfilename?if_exists}' alt=''/></a>
	</#list>
	</div>
</div>

<br>
<div class="zz" >

<script language="javascript"> 
	var n1=new OrgNode();
	n1.Text="<@roletext rhs["role"] />";
	n1.Description="管理人数${rhs["role"].allUserUnderRole()?size}";
	n1.Link="#";
	n1.BoxHeight=2; 
	<#list rhs["role"].getChildRoles() as role>
		     var role${role_index+1}=new OrgNode();
			 role${role_index+1}.Text="<@roletext role />";
			 role${role_index+1}.Description="管理人数${role.allUserUnderRole()?size}"
			 role${role_index+1}.Link="view_organize_node_view_v.do?id=${role.id}&width=${RequestParameters["width"]}&height=${RequestParameters["width"]}";
			 n1.Nodes.Add(role${role_index+1});
		<@digui_role_v role.getChildRoles()?sort_by("sortNob"),'role'+(role_index+1),80/>
	</#list>
	var OrgShows=new OrgShow(n1);
	OrgShows.Top=55;
	OrgShows.Left=20;
	OrgShows.IntervalWidth=20;
	OrgShows.IntervalHeight=30;  //行的间隔
	OrgShows.ShowType=1; //2代表文字是竖的
	OrgShows.BoxHeight=50; //高度
	OrgShows.LineSize=2;  //设置线条大小
	OrgShows.LineColor="#cccccc";  //设置线条颜色
	OrgShows.Run();

</script>
</div>	    

</body>
</html>
<#---
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<link href="view/view.css" rel="stylesheet">
<script language="javascript" src="view/view_organize.js"></script>
<#include "macro_view.ftl">	
<#include "include_display_info.ftl">	

<br>
<div class="zz" >

<script language="javascript"> 
	var n1=new OrgNode();
	n1.Text="<@roletext rhs["role"] />";
	n1.Description="管理人数${rhs["role"].allUserUnderRole()?size}";
	n1.Link="#";
	n1.BoxHeight=2; 
	<#list rhs["role"].getChildRoles() as role>
		     var role${role_index+1}=new OrgNode();
			 role${role_index+1}.Text="<@roletext role />";
			 role${role_index+1}.Description="管理人数${role.allUserUnderRole()?size}"
			 role${role_index+1}.Link="view_organize_node_view_v.do?id=${role.id}&width=${RequestParameters["width"]}&height=${RequestParameters["width"]}";
			 n1.Nodes.Add(role${role_index+1});
		<@digui_role_v role.getChildRoles()?sort_by("sortNob"),'role'+(role_index+1),80/>
	</#list>
	var OrgShows=new OrgShow(n1);
	OrgShows.Top=55;
	OrgShows.Left=20;
	OrgShows.IntervalWidth=20;
	OrgShows.IntervalHeight=30;  //行的间隔
	OrgShows.ShowType=1; //2代表文字是竖的
	OrgShows.BoxHeight=50; //高度
	OrgShows.LineSize=2;  //设置线条大小
	OrgShows.LineColor="#cccccc";  //设置线条颜色
	OrgShows.Run();

</script>
</div>	    
-->
