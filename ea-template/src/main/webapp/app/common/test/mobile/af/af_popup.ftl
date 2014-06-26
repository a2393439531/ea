<#include "include_af_header.ftl">
<div id="afui"><div id="content">
<div id="mypopup" title="弹框" class="panel"  selected="true">
 <a class="button" onClick="showPopup1()">Alert style diaglog</a><br>
<a class="button" onClick="showPopup2()">Detailed ineraction</a><br>
<a class="button" onClick="showPopup3()">HTML markup</a>
</div></div></div>

<script>
function showPopup1() {
	$("#afui").popup("I'm replacing an alert box");
}

function showPopup2() {
	$("#afui").popup({
		title: "Alert! Alert!",
		message: "This is a test of the emergency alert system!! Don't PANIC!",
		cancelText: "Cancel me",
		cancelCallback: function () {console.log("cancelled");},
		doneText: "I'm done!",
		doneCallback: function () {console.log("Done for!");},
		cancelOnly: false
	});
	}

function showPopup3() {
	$("#afui").popup({
    	title: "Login",
        message: "Username: <input type='text' class='af-ui-forms'><br>Password: <input type='text' class='af-ui-forms' style='webkit-text-security:disc'>",
        cancelText: "Cancel",
        cancelCallback: function () {},
        doneText: "Login",
        doneCallback: function () {
        	alert("Logging in")
        },
        cancelOnly: false
    });
}
</script>