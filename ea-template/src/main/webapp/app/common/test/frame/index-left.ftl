<script language="JavaScript">
var w=200;
function closenavi() {
w-=10;
if (w>-10) {window.parent.testframeset.cols = ''+w+',*';repeat=setTimeout("closenavi()",10);}
else {clearTimeout(repeat);w=200;}
}

function initIt(){
        divCount = document.all.tags("DIV");
        for (i=0; i<divCount.length; i++) {
            obj = divCount(i);
            if (obj.className == "child" || obj.className == "child1") obj.style.display = "none";
        }
}
</script>
</head>

<img src="icon-close.gif" width="16" height="15" class="button" onClick="closenavi()" vspace="2" alt="关闭左栏">

