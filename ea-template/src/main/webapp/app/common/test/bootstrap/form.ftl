<#include "include_bootstrap.ftl">

  
  
<form class="well form-search">
        <input type="text" class="input-medium search-query">
        <button type="submit" class="btn">确定</button> 在frame 里面，无法显示圆角
        
        
        <div class="control-group">
		    <label class="control-label" for="appendedPrependedInput">后置按钮</label>
		    <div class="controls">
		      <div class="input-append">
		        <input class="span2" id="appendedPrependedInput" size="16" type="text"><button class="btn" type="button">执行</button>
		      </div>
		    </div>
		  </div>
		 
</form>

<div class="row">
    <div class="span8">
        <div class="control-group">
		    <label class="control-label" for="appendedPrependedInput">后置按钮</label>
		    <div class="controls">
		      <div class="input-append">
		        <input class="span2" id="appendedPrependedInput" size="16" type="text"><button class="btn" type="button">执行</button>
		      </div>
		    </div>
		  </div>
 	</div>
</div>


  <div class="row">
    <div class="span8">
      <form class="form-horizontal">
             <label class="control-label" for="appendedPrependedInput">后置按钮</label>
            <div class="controls">
              <div class="input-append">
                <input class="span2" id="appendedPrependedInput" size="16" type="text"><button class="btn" type="button">执行</button>
              </div>
            </div>
         
       </form>
    </div>
  </div>

         <div class="control-group">
            <label class="control-label">别名指定尺寸</label>
            <div class="controls docs-input-sizes">
              <input class="input-mini" type="text" placeholder=".input-mini">
              <input class="input-small" type="text" placeholder=".input-small">
              <input class="input-medium" type="text" placeholder=".input-medium">
	      <input class="input-big" type="text" placeholder=".input-big">
              <p class="help-block">
		静态类指定的尺寸与栅格系统的尺寸并不匹配，且自适应响应式样式，只对几种控件有效(比如 <code>input</code> 和 <code>select</code>).
	      </p>
            </div>

<#--
  <div class="row">
    <div class="span8">
      <form class="form-horizontal">
        <fieldset>
          <legend>扩展表单控件</legend>
          <div class="control-group">
            <label class="control-label">栅格指定尺寸</label>
            <div class="controls docs-input-sizes">
              <input class="span1" type="text" placeholder=".span1">
              <input class="span2" type="text" placeholder=".span2">
              <input class="span3" type="text" placeholder=".span3">
              <select class="span1">
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
              </select>
              <select class="span2">
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
              </select>
              <select class="span3">
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
              </select>
              <p class="help-block">
		同样是使用 <code>.span*</code> 类来指定输入框大小
	      </p>
            </div>
          </div>

          <div class="control-group">
            <label class="control-label">别名指定尺寸</label>
            <div class="controls docs-input-sizes">
              <input class="input-mini" type="text" placeholder=".input-mini">
              <input class="input-small" type="text" placeholder=".input-small">
              <input class="input-medium" type="text" placeholder=".input-medium">
	      <input class="input-big" type="text" placeholder=".input-big">
              <p class="help-block">
		静态类指定的尺寸与栅格系统的尺寸并不匹配，且自适应响应式样式，只对几种控件有效(比如 <code>input</code> 和 <code>select</code>).
	      </p>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="prependedInput">前置文本</label>
            <div class="controls">
              <div class="input-prepend">
                <span class="add-on">@</span><input class="span2" id="prependedInput" size="16" type="text">
              </div>
              <p class="help-block">这里显示帮助信息</p>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="appendedInput">后置文本</label>
            <div class="controls">
              <div class="input-append">
                <input class="span2" id="appendedInput" size="16" type="text"><span class="add-on">.00</span>
              </div>
              <span class="help-inline">这里显示帮助信息</span>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="appendedPrependedInput">前置+后置文本</label>
            <div class="controls">
              <div class="input-prepend input-append">
                <span class="add-on">$</span><input class="span2" id="appendedPrependedInput" size="16" type="text"><span class="add-on">.00</span>
              </div>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="appendedPrependedInput">后置按钮</label>
            <div class="controls">
              <div class="input-append">
                <input class="span2" id="appendedPrependedInput" size="16" type="text"><button class="btn" type="button">执行</button>
              </div>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="inlineCheckboxes">行级复选框</label>
            <div class="controls">
              <label class="checkbox inline">
                <input type="checkbox" id="inlineCheckbox1" value="option1"> 1
              </label>
              <label class="checkbox inline">
                <input type="checkbox" id="inlineCheckbox2" value="option2"> 2
              </label>
              <label class="checkbox inline">
                <input type="checkbox" id="inlineCheckbox3" value="option3"> 3
              </label>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="optionsCheckboxList">多复选框</label>
            <div class="controls">
              <label class="checkbox">
                <input type="checkbox" name="optionsCheckboxList1" value="option1">
		第一个选项，最好给出将其做为首选的理由
              </label>
              <label class="checkbox">
                <input type="checkbox" name="optionsCheckboxList2" value="option2">
		第二个选项，同样可选并包含在表单结果中
              </label>
              <label class="checkbox">
                <input type="checkbox" name="optionsCheckboxList3" value="option3">
		第三个选项，同样可选并包含在表单结果中
              </label>
              <p class="help-block"><strong>注意</strong>
		建议使用label标签将option选项包裹起来，这样可以提供更大的点击区域，提升表单可用性。
	      </p>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">单选钮</label>
            <div class="controls">
              <label class="radio">
                <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
		第一个选项，最好给出将其做为首选的理由
              </label>
              <label class="radio">
                <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
		第二个选项，如果选译该选项就会取消第一个选项。
              </label>
            </div>
          </div>
          <div class="form-actions">
            <button type="submit" class="btn btn-default">提交更改</button>
            <button class="btn">取消</button>
          </div>
        </fieldset>
      </form>
    </div>
    <div class="span4">
      <h3>前置 &amp; 后置输入框</h3>
      <p>
	带前置/后置文本的输入组更有助于我们为输入框提供更多内容。在左侧的例子中，我们用@表示Twiiter某人，用$表示货币。
      </p>
      <hr>
      <h3>单选框和复选框</h3>
      <p>
	在1.4版本之前，Bootstrap罗列单选框和复选框时，要将它嵌套到到其他标记内。
	从2.0版开始，只须用 <code>&lt;label class="checkbox"&gt;</code> 包含 <code>&lt;input type="checkbox"&gt;</code> 即可。
      </p>
      <p>
	Bootstrap也支持行级单选框和复选框。只要对 <code>.checkbox</code> 或 <code>.radio</code> 应用 <code>.inline</code> 即可。
      </p>
      <hr>
      <h4>行级表单的前置/后置文本</h4>
      <p>
	在行级表单中使用前置/后置文本的输入框时，一定要确认 <code>.add-on</code> 和 <code>input</code> 在同一行，之间不得有空行和间隔。
      </p>
      <hr>
      <h4>表单帮助/提示文本</h4>
      <p>
	对表单中的输入框添加帮助/提示文本时，添加 <code>&lt;span class="help-inline"&gt;</code> 就是使用行级帮助文本；
	在输入框后添加 <code>&lt;p class="help-block"&gt;</code>  就是使用块状帮助文本。
      </p>
    </div>
  </div>
</section>
-->
