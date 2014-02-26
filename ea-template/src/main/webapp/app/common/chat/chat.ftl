<#include "../../../common/freemarker/include_header.ftl">
<head>
<script type='text/javascript'>
      function $() { return document.getElementById(arguments[0]); }
      function $F() { return document.getElementById(arguments[0]).value; }
      function getKeyCode(ev) { if (window.event) return window.event.keyCode; return ev.keyCode; } 
      function xhr(method,uri,body,handler) {
        //alert(method + ":" + uri + ":" + body + ":" + handler);
    	var req=(window.XMLHttpRequest)?new XMLHttpRequest():new ActiveXObject('Microsoft.XMLHTTP');
        req.onreadystatechange=function() { if (req.readyState==4 && handler) { eval('var o='+req.responseText);handler(o);} }
        req.open(method,uri,true);
        req.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        req.send(body);
      };
      function send(action,user,message,handler){
        if (message) message=message.replace('%','%25').replace('&','%26').replace('=','%3D');
        if (user) user=user.replace('%','%25').replace('&','%26').replace('=','%3D');
        xhr('POST','./chat','action='+action+'&user='+user+'&message='+message,handler);
      };
      
      var room = {
        join: function(name) {
          this._username=name;
          $('join').className='hidden';
          $('joined').className='';
          $('phrase').focus();
          send('join', room._username,null);
          send('chat', room._username,'has joined!');
          send('poll', room._username,null, room._poll);
        },
        chat: function(text) {
          if (text != null && text.length>0 )
              send('chat',room._username,text);
        },
        _poll: function(m) {
          //console.debug(m);
          if (m.chat){
            var chat=document.getElementById('chat');
            var spanFrom = document.createElement('span');
            spanFrom.className='from';
            spanFrom.innerHTML=m.from+':&nbsp;';
            var spanText = document.createElement('span');
            spanText.className='text';
            spanText.innerHTML=m.chat;
            var lineBreak = document.createElement('br');
            chat.appendChild(spanFrom);
            chat.appendChild(spanText);
            chat.appendChild(lineBreak);
            chat.scrollTop = chat.scrollHeight - chat.clientHeight;   
          }
          if (m.action=='poll')
            send('poll', room._username,null, room._poll);
        },
        _end:''
      };
    </script>
    <style type='text/css'>
    div { border: 0px solid black; }
    div#chat { clear: both;  overflow: auto; background-color: #f0f0f0; padding: 4px;  }
    div#input { clear: both;  padding: 4px; background-color: #e0e0e0; border-top: 0px }
    input#phrase { width:30em; background-color: #e0f0f0; }
    input#username { width:14em; background-color: #e0f0f0; }
    div.hidden { display: none; }
    span.from { font-weight: bold; }
    span.alert { font-style: italic; }
    </style>
</head>
<html>
<body >
<div class="panel panel-default">
        <div class="panel-heading"><strong>聊天室</strong></div>
        <div id="chat" class="panel-body" style="height:300px;">
        </div>
        
 <div id='input'>
  <div id='join' class=''>
    Username:&nbsp;<input id='username' type='text' value="${Session["userlogined"].name?if_exists}"/><input id='joinBa' class='button' type='submit' name='join' value='Join'/>
  </div>
  <div id='joined' class=''>
    Chat:&nbsp;<input id='phrase' type='text'/>
    <input id='sendB' class='button' type='submit' name='join' value='Send'/>
  </div>
</div>
</div>

<script type='text/javascript'>
$('username').setAttribute('autocomplete','OFF');
$('username').onkeyup = function(ev) { var keyc=getKeyCode(ev); if (keyc==13 || keyc==10) { room.join($F('username')); return false; } return true; } ;        
$('joinBa').onclick = function(event) { room.join($F('username')); return false; };
$('phrase').setAttribute('autocomplete','OFF');
$('phrase').onkeyup = function(ev) {   var keyc=getKeyCode(ev); if (keyc==13 || keyc==10) { room.chat($F('phrase')); $('phrase').value=''; return false; } return true; };
$('sendB').onclick = function(event) { room.chat($F('phrase')); $('phrase').value=''; return false; };
$('joinBa').click();
</script>
</body>
</html>
