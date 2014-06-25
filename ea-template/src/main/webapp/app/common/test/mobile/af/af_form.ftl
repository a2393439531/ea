<#include "include_af_header.ftl">
<div id="afforms" title="Form Styles" class="panel" data-footer='none' data-header="none" selected="true">
	<form>
		<label for="test1">First Name</label><input id="test1" type="text" placeholder="test">
    	<label for="test2">Search</label><input  id="test2" type="search" placeholder="search">
        <label for="test3">Info Name</label><textarea  id="test3" rows="6" placeholder="Enter your address"></textarea>
        <label>Checkbox</label><input id="aaaaa" type="checkbox" name="test2" value="1"><label for="aaaaa">Male</label>
	    <input id="bbbbb" type="checkbox" name="test2" value="2"><label for="bbbbb">Female</label>
	    <input id="ccccc" type="checkbox" name="test2" value="3"><label for="ccccc">N/A </label>
	    <br style="clear:both">
	    <label>Radio</label><input id="aaaa" type="radio" name="test" value="1"><label for="aaaa">Male</label>
        <input id="bbbb" type="radio" name="test" value="2"><label for="bbbb">Female</label>
        <input id="cccc" type="radio" name="test" value="3"><label for="cccc">N/A </label>
        <br style="clear:both">
        <label>Gender</label><input id="toggle1" type="checkbox" name="toggle1" value="1" class="toggle"><label for="toggle1" data-on="On" data-off="Off"><span></span></label>
        <input type="submit" class="button" value="Submit" style='float:right;'>
    </form>
</div>