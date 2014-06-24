<#include "common/freemarker/include_header.ftl">
<body style="padding: 10px; ">
<strong>动态显示的状态数据</strong><br>

   <div class="bs-example">
      <ul class="nav nav-pills">
        <li class="active"><a href="#">Home <span class="badge">42</span></a></li>
        <li><a href="#">Profile</a></li>
        <li><a href="#">Messages <span class="badge">3</span></a></li>
      </ul>
      <br>
      <ul class="nav nav-pills nav-stacked" style="max-width: 260px;">
        <li class="active">
          <a href="#">
            <span class="badge pull-right">42</span>
            Home
          </a>
        </li>
        <li><a href="#">Profile</a></li>
        <li>
          <a href="#">
            <span class="badge pull-right">3</span>
            Messages
          </a>
        </li>
      </ul>
      <br>
      <button class="btn btn-primary" type="button">
        Messages <span class="badge">4</span>
      </button>
    </div>
</body>




