<#include "include_jq_header.ftl">
<div data-role="page">
  <div data-role="content">
  	<form>
  		<label for="text-basic">Text input:</label>
		<input type="text" name="text-basic" placeholder="Text input"  id="text-basic" value="">
		<label for="tel">Tel:</label>
		<input type="tel" name="tel" id="tel" value="">
		<label for="textarea">Textarea:</label>
		<textarea cols="40" rows="8" name="textarea" id="textarea"></textarea>
		<label for="password">Password:</label>
		<input type="password" name="password" id="password" value="" autocomplete="off">
		<label for="slider2">Flip switch:</label>
		<select name="slider2" id="slider2" data-role="slider">
		    <option value="off">Off</option>
		    <option value="on">On</option>
		</select>
  	</form>
  </div>

</div> 


