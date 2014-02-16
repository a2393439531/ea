<#include "../../../common/freemarker/include_self.ftl">
<script type="text/javascript" src="<@context/>common/video/swfobject.js"></script>
<#macro richmedia x>
    <table>
	    <tr>
	 	<#if x.attachfilepath?exists&& x.attachfilepath!="">
	 	 	<td>
	 	 		文件下载：<a href="<@context/>file/${x.attachfilepath?if_exists}" target=_blank>${x.attachfilename?if_exists}</a>
	 	 	</td>
		</#if>      	    
	 	<#if x.imagefilepath?exists&& x.imagefilepath!="">
	 	 	<td>
	 	 	<img   border =0  style="<#if x.imagewidth?exists&&x.imageheight!="">width:${x.imagewidth?if_exists}px</#if>  <#if x.imageheight?exists&&x.imageheight!="">;height:${x.imageheight?if_exists}</#if>px"  src="<@context/>file/${x.imagefilepath?if_exists}" />  			
		    </td>
		</#if>               
		<#if x.videofilepath?exists&&x.videofilepath!=""> 
			<td>                                        
				<object classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000 codebase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0 width=${x.videowidth?default("250")} height=${x.videoheight?default("150")}>
					<param name=movie value=<@context/>common/video/vcastr22.swf>
					<param name=quality value=high>
					<param name=allowFullScreen value=true />                                
					<param name=FlashVars value='LogoText=aa&IsAutoPlay=1&IsContinue=1&vcastr_file=<@context/>file/${x.videofilepath?if_exists}' />
				</object>
			 </td>	
		</#if>
		</tr>
	</table>  
</#macro>

<#macro SiteSingleData   datalist>
    <#list datalist as x>
        <#if x.imagefilepath?exists||x.videofilepath?exists||x.align?exists>
            <#if x.align?exists><#assign align=x.align/>
            <#else><#assign align="down"/>    
            </#if>
        <#else>
            <#assign align=""/>    
        </#if>
       
		<table>
        <#switch align>
            <#case "left">
                <tr>
                    <td  valign=top> <@richmedia x/></td>
                    <td  valign=top style="padding-left:20px">${x.name?if_exists}</td>
                </tr>                                      
             <#break>
             <#case "right">
                 <tr>
                     <td  valign=top style="padding-right:20px">${x.name?if_exists}</td>
                     <td  valign=top><@richmedia x/></td>
                 </tr>                                      
             <#break>
             <#case "down">
                 <tr>
                     <td  valign=top>${x.name?if_exists}</td>
                 </tr>
                 <tr>
                     <td  ><@richmedia x/></td>
                 </tr>                                                                       
             <#break>
             <#case "up">
                 <tr>
                      <td   colspan=2><@richmedia x/></td>
                 </tr>
                 <tr>
                     <td  valign=top>${x.name?if_exists}</td>
                 </tr>                                      
             <#break>
             <#default>
                 <tr>
                     <td align=left valign=top>
                    	 ${x.name?if_exists}              
                     </td>
                 </tr>                                   
        </#switch>                  
		</table>
    </#list>
</#macro>     
<body style = "margin:20 auto;">
<div id="container" style="margin: 0 auto; width:500px;">
<p align=center><b>${rhs["rule"].name}</b></p>
	<@SiteSingleData datalist= rhs["rule"].getRuledetails()/>
</div>
</body>
