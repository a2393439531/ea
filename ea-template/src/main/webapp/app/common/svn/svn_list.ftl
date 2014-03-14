<#include "../../../common/freemarker/include_header.ftl">
<link href="<@context/>common/jquery-easyui-1.3.5/themes/default/easyui.css" rel="stylesheet">
<link href="<@context/>common/jquery-easyui-1.3.5/themes/icon.css" rel="stylesheet">
<script type="text/javascript" src="<@context/>common/jquery-easyui-1.3.5/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<@context/>common/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>
<script type="text/javascript">
    $(function() {
       $('#test').treegrid({
           title : 'SVN列表',
           nowrap : false,
           rownumbers : true,
           collapsible : false,
           fitColumns:true,
           url : 'svn?pid=',
           idField : 'url',
           treeField : 'url',
           frozenColumns : [ [ {
              title : '路径',
              field : 'url',
              width : 470,
              formatter : function(value) {
                  return '<span style="color:red">' + decodeURI(value.substr(value.lastIndexOf("/"))) + '</span>';
              }
           } ] ],
           columns : [ [ {
              field : 'name',
              title : '名称',
              width : 220
           }, {
              field : 'size',
              title : '文件大小',
              width : 40,
           }, {
              field : 'revision',
              title : '版本号',
              width : 60,
           }, {
              field : 'author',
              title : '作者',
              width : 100,
           }, {
              field : 'date',
              title : '修改日期',
              width : 100,
           }, {
              field : 'commitMessage',
              title : '注释',
              width : 100,
           }, {
              field : 'kind',
              title : '操作',
              width : 240,
              align : 'center',
              formatter : function(value) {
            	  var op;
            	  if(value=='file'){
            		  op = '<a onclick="download()" class="btn btn-xs btn-primary" style=" cursor: pointer;">下载</a>';
            	  }else{
            		  op = ' <form enctype="multipart/form-data" action="commit" method="post" id="uploadForm" > '+
            		  '<input type="file"  name="imglistUpload" />'+
            		  '<input type="hidden" name="url" id="url" />'+
            		  '<a onclick="commitFile()" class="btn btn-xs btn-primary" style="float:right; cursor: pointer;">提交文件</a>'+
            		  '</form>';
            		  
            	  }
                  return op;
              }
           }] ],
           onBeforeExpand : function(row, param) {
           //alert(decodeURI(encodeURI(row.url)));
              $(this).treegrid('options').url = 'svn?pid='+decodeURI(encodeURI(row.url));
           }
       });
    });
   
    function download(){
       setTimeout(function(){
           var node = $('#test').treegrid('getSelected');
           if(node !=null)
               window.open("download?url="+encodeURI(decodeURI(node.url))+"&size="+node.size+"&name="+encodeURI(decodeURI(node.name))+"&revision="+node.revision);
       },200);
      
    }
   function commitFile(){
	   setTimeout(function(){
           var node = $('#test').treegrid('getSelected');
           if(node !=null){
        	   document.getElementById('url').value =  encodeURI(decodeURI(node.url));
        	   $("#uploadForm").submit();
           }
       },200);
   }
    
    function viewHistory(){
       setTimeout(function(){
           var node = $('#test').treegrid('getSelected');
           if(node != null) {
              window.open("history.jsp?uri="+encodeURI(decodeURI(node.url)),"_blank","height=400,width=700,status=yes,toolbar=no,menubar=no,location=no");
           }
       }, 200);
    }
</script>
 
</head>
<body style="padding:10px;">

 <div class="panel panel-primary">
	        <div class="panel-heading"><strong>文档管理</strong></div>
	        <div class="panel-body">
	          <table id="test"></table>
	        </div>
	      </div>
</body>
</html>
