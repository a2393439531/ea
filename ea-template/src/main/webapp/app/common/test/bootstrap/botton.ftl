
       <a href=#  class="btn btn-xs btn-default">连接</a>
        <button type="button" class="btn btn-xs btn-default">Default</button>
        <button type="button" class="btn btn-xs btn-primary">primary-Primary</button>
        <button type="button" class="btn btn-xs btn-success">Success</button>
        <button type="button" class="btn btn-xs btn-info">Info</button>
        <button type="button" class="btn btn-xs btn-warning">Warning</button>
        <button type="button" class="btn btn-xs btn-danger">Danger</button>
        <button type="button" class="btn btn-xs btn-link">Link</button>
    <br>
图标按钮
   <div class="bs-example">
      <div class="btn-toolbar" role="toolbar">
        <div class="btn-group">
          <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-align-left"></span></button>
          <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-align-center"></span></button>
          <button type="button" class="btn btn-default "><span class="glyphicon glyphicon-align-right"></span></button>
          <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-align-justify"></span></button>
        </div>
      </div>
      <div class="btn-toolbar" role="toolbar">
        <button type="button" class="btn btn-default btn-lg"><span class="glyphicon glyphicon-star"></span> Star</button>
        <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-star"></span> Star</button>
        <button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-star"></span> Star</button>
        <button type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-star"></span> Star</button>
      </div>
    </div>   
  <br>  
    
	        
        
      <br> 按钮-符合父的大小
      <div class="well" style="max-width: 300px; margin: 0 auto 10px;">
        <button type="button" class="btn btn-primary btn-xs btn-block">Block level button</button>
        <button type="button" class="btn btn-default btn-xs btn-block">Block level button</button>
      </div>
	  <div class="row">
	 	  <div class="col-md-6">  关闭按钮
	 		 <button type="button" class="close" aria-hidden="true">&times;</button>
		  </div>
	  	  <div class="col-md-6">下拉<span class="caret"></span></div>
	   </div>
                            按钮组  btn-group-xs  btn-group-sm  btn-group-lg
		<div class="btn-group btn-group-xs">
		  <button type="button" class="btn btn-default">Left</button>
		  <button type="button" class="btn btn-default">Middle</button>
		  <button type="button" class="btn btn-default">Right</button>
		</div>	   
		<br> 
      	  下拉按钮（需要1.10.2-jquery.min.js和bootstrap.min.js,jquery必须在其它之前）
		<div class="btn-group btn-group-xs">
		  <button type="button" class="btn btn-default">1</button>
		  <button type="button" class="btn btn-default">2</button>
		
		  <div class="btn-group btn-group-xs">
		    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
		      Dropdown
		      <span class="caret"></span>
		    </button>
		    <ul class="dropdown-menu">
		      <li><a href="#">Dropdown link</a></li>
		      <li><a href="#">Dropdown link</a></li>
		    </ul>
		  </div>
		</div>
		<br>
		垂直按钮下拉
		
	   <div class="bs-example">
	      <div class="btn-group-vertical btn-group-xs">
	        <button type="button" class="btn btn-default">Button</button>
	        
	        <div class="btn-group btn-group-xs">
	          <button id="btnGroupVerticalDrop1" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
	            Dropdown
	            <span class="caret"></span>
	          </button>
	          <ul class="dropdown-menu" role="menu" aria-labelledby="btnGroupVerticalDrop1">
	            <li><a href="#">Dropdown link</a></li>
	            <li><a href="#">Dropdown link</a></li>
	          </ul>
	        </div>
	        <button type="button" class="btn btn-default">Button</button>
	     
	      
	      </div>
	    </div>		
		