<pre>
《工作流开发指南》
开发需要跟业务表相关的工作流
1. 建立业务model 和action
2. 画流程图，在启动的第一步是默认发给启动人执行任务（通常是填写业务记录）
流程定义的规则是 
keyname_modelName （这个规则是为了启动流程之后，能够直接进入第一个任务填写业务表单，需要知道其表名和ID。）
common_activiti_start_process_pre.do

清理垃圾数据，
delete from     ACT_RU_IDENTITYLINK;
delete from 	act_ru_task;
delete from 	act_ru_variable;
delete from 	act_ru_execution;
delete from 	ACT_RE_PROCDEF;
delete from 	ACT_GE_BYTEARRAY;
</pre>