
<#include "common/freemarker/include_header.ftl">
<body style="padding: 10px; ">
&nbsp;&nbsp;&nbsp;<a href="lang.do?lang=en"  class="btn btn-sm btn-primary" target=_blank>login登录数据初始化</a> 

	<span class="label label-success">在进行demo测试前，请使用帐号： xixi  密码：abc123  进行登录.</span> 
<br>  
	<div class="panel panel-default">    
		<div class="panel-heading"><strong>业务系统</strong></div>
		<div class="panel-body">
			<a href="exam_paper_create.do?method=newpaper" target=_blank class="btn btn-xs btn-default">直接生成试卷</a>
			<a href="exam_item_import_itembyxls.do" target=_blank class="btn btn-xs btn-default">根据Excel生成试卷</a>
			<a href="exam_template_save.do?method=show" target=_blank class="btn btn-xs btn-default">根据模板生成试卷</a><br/><br/>
			<strong>1. 考试系统</strong><br/>
			<pre>
a). 生成试卷分为两种方式：通过在线生成模板和导入题目excel<br/>
	1). 通过Excel导入题型。导入题型后，会默认以文件名来新建模板(所有题目会被添加为必做题并且不会有随机题)和试卷。<br/>
	2). 在线定义模板，包括模板名称、模板知识领域、必做和随机的各类题型。<br/>
	3). 在线定义试卷，首先选定模板，然后定义各类题型的分数、知识领域、考试时间、通过分。<br/>
b). 能够在线分配试卷给用户考试。<br/>
c). 能够在线定义试卷组，当用户所答的分数大于试卷组中试卷所定义的通过分，则系统会继续拿出试卷组中的下一张试卷来开始作答。否则考试结束。<br/>
d). 能够在线答题，可以选择一次整张作答和一题一题作答，前者需要回答完毕并且提交，才有分数。后者每做一题则计算一次分数，可以中途退出，然后继续做，和试卷组概念挂钩。<br/>
e). 能够在线阅卷，当所分配的试卷是含有填空和主观题的时候，系统并不会自动判卷，需要人工来进行打分。<br/>
f). 能够查询考试的历史，结果根据试卷来分类，倒叙排序，即，最近一次考试成绩会排在最上面。<br/>
			</pre>
		</div>
	</div>
	

</body>
</html>




