
<#--<script src="<@context/>common/jquery191/jquery.min.js"></script>
<script src="<@context/>common/jquery-plugins/pin/jquery.pin.js"></script>
<#include "../../../common/freemarker/include_header.ftl">

-->
<!DOCTYPE html>
<html>
  <head>
    <title>jQuery Pin</title>

    <meta charset="utf-8">
    <meta name="description" content="jQuery Pin是一个可以将页面上的元素“钉”在容器内部某个位置的jQuery插件">

    <link href='http://fonts.googleapis.com/css?family=Alfa+Slab+One' rel='stylesheet'>
    <link href='http://fonts.googleapis.com/css?family=Neuton:400,700,400italic' rel='stylesheet'>
    <link href='http://fonts.googleapis.com/css?family=Anonymous+Pro' rel='stylesheet'>
    <link href='http://fonts.googleapis.com/css?family=Cabin+Sketch' rel='stylesheet' type='text/css'>
    <link href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css" rel="stylesheet">
    <link href="style.css" rel="stylesheet">
    <style>
    body
    {
      font-family: 'Microsoft yahei', 'Neuton', serif;
    }
    </style>
    
    <!-- This is an example of jQuery.pin in use. Check the very bottom for the javascript. -->

  </head>
  <body>
    <header class="clearfix">
      <div class="wrapper">
        <h1 class="logo"><span>jQuery</span>.Pin</h1>
        <img src="images/pin.png" class="pin" width="400"/>aaaaa
      </div>
    </header>
    <div class="wrapper">
      <h2 class="sub">Make your stuff stick! <br>把“它”钉在那里！</h2>
      <section class="container clearfix">   
        <div class="row">
          <div class="left-col">
            <p class="lead">
              是否曾经希望将某个页面元素<strong>钉</strong> 在某段文本旁边？是否需要让某个元素一直挂在某个位置而不管是否滚动条滚动？
            </p>

            <p>
              <strong>jQuery.Pin</strong> 能帮你完成这些需求。它能将任意页面元素“钉”在某个容器顶部，而且在尺寸小的屏幕上能够自动禁用这种效果。
            </p>
            <h2>下载此jQuery插件</h2>
            <p>
              从 <a href="https://github.com/webpop/jquery.pin">Github 代码库</a> 下载 <a href="https://raw.github.com/webpop/jquery.pin/gh-pages/jquery.pin.js">jquery.pin.js</a>文件。然后在页面底部引入jQuery 和 jQuery.pin即可。
              </p>
            <h2>“钉”住某个元素</h2>
            <pre><code>$(".pinned").pin()</code></pre>
            <h2>将某元素“钉”在容器内</h2>
            <pre><code>$(".pinned").pin({
      containerSelector: ".container"
})</code></pre>
            <h2>在小尺寸的屏幕上禁用Pin效果</h2>
            <pre><code>$(".pinned").pin({
      minWidth: 940
})</pre></code>
          </div>
          <div class="right-col">
            <div class="pinned note-container">
              <div class="note">
                <h3>Pin it!</h3>
                <p>Great for pinned navigations — or just about anything you want to stick.</p>
                <p>Developed by <a href="http://www.webpop.com">Webpop</a>.</p>
              </div>
            </div>
          </div>
        </div>
      </section>
      <section class="gallery">
        <h2>案例</h2>
        <div class="container clearfix">
          <div class="row">
            <div class="left-col">
              <figure class="cat">
                <img src="http://lorempixel.com/700/800/cats" width="700" height="800"/>
                <div class="handwritten cat-indicator"><i class="icon-hand-up"></i> 这只小猫很可爱</div>
              </figure>              
            </div>
            <div class="right-col">
              <div class="pinned">
                <div class="panel">
                  <h4>Its a cat!</h4>
                  <p>This description hangs around</p>
                </div>
                <div class="handwritten pinned-indicator"><i class="icon-hand-up"></i> 它被“钉”在这儿了</div>
              </div>
            </div>
            <div class="handwritten container-indicator">这是容器<i class="icon-hand-down"></i></div>
          </div>
        </div>

      </section>

      <section class="left-nav">
        <div class="container clearfix">
          <div class="row">
            <div class="left-col">
              <ul class="nav pinned">
                <li><a href="#link-one">Link one</a></li>
                <li><a href="#link-two">Link two</a></li>
                <li><a href="#link-three">Link three</a></li>
              </ul>
            </div>
            <div class="right-col">
              <h2>看到固定在左侧的菜单了吗?</h2>
              <p class="lead">Just like the Webpop documentation? <strong>Pin</strong> it and relax.</p>
              <p id="link-one">Macaroon donut tiramisu gummies. Jelly halvah oat cake pastry lemon drops apple pie tart. Muffin tart donut tiramisu. Lollipop tiramisu danish cupcake topping macaroon powder. Topping candy carrot cake halvah tiramisu sesame snaps donut lollipop jelly beans. Cotton candy biscuit jelly-o jelly-o. Gummies jelly beans croissant powder. Chocolate cake marzipan halvah cupcake pudding sesame snaps.</p>
              <p id="link-two">Ice cream chocolate bar sweet roll chupa chups gummies soufflé lemon drops chocolate bar. Pie donut tiramisu gingerbread candy canes carrot cake sweet lollipop tart. Danish wafer pudding oat cake croissant oat cake cupcake. Dessert brownie halvah bear claw oat cake sesame snaps pudding lollipop. Tiramisu bear claw sesame snaps cheesecake powder. Topping gummies soufflé fruitcake cake pudding wafer. Candy pie tiramisu jelly beans.</p>
              <p id="link-three">Donut sweet jelly chocolate cake icing topping croissant bonbon wafer. Tootsie roll lemon drops tiramisu muffin croissant danish. Sesame snaps soufflé wypas cookie tiramisu. Biscuit biscuit croissant fruitcake danish caramels jelly beans. Wafer muffin gingerbread cookie macaroon. Pastry lollipop croissant sweet cotton candy chocolate cake jelly-o sugar plum. Carrot cake gingerbread ice cream pastry. Gummi bears soufflé bonbon ice cream cake biscuit brownie powder. Gummi bears cake chocolate bar pastry topping gummi bears marzipan soufflé danish.</p>
              <p>Brownie topping cake oat cake liquorice bear claw candy canes tiramisu apple pie. Pudding oat cake sugar plum sweet roll gingerbread. Cake jelly-o candy canes dragée. Tiramisu sugar plum cupcake cotton candy tootsie roll sweet. Jujubes gingerbread donut fruitcake cheesecake sweet roll soufflé. Tootsie roll donut sesame snaps marzipan candy carrot cake chocolate cake. Tootsie roll applicake chupa chups. Caramels wafer gummies chocolate pastry liquorice apple pie chocolate chocolate. Fruitcake lollipop cupcake apple pie pie dessert powder cotton candy bear claw. Dragée muffin caramels gummi bears sesame snaps wypas cheesecake oat cake.</p>
              <p>Gummies jelly-o oat cake. Oat cake dessert muffin apple pie carrot cake halvah chocolate cake. Ice cream faworki fruitcake. Lemon drops fruitcake marshmallow oat cake apple pie. Jelly danish pastry liquorice halvah tart gingerbread. Soufflé sweet soufflé biscuit sesame snaps jelly beans liquorice dessert apple pie. Cake ice cream candy toffee croissant sesame snaps topping candy. Halvah dessert macaroon sweet halvah marzipan caramels cake.</p>
            </div>
          </div>
        </div>
      </section>
    </div>

    <div class="wrapper text-center">
      <a href="https://github.com/webpop/jquery.pin" class="button">下载jQuery.Pin!</a>
      <small>What are you waiting for?</small>
      <p>jQuery.Pin 由<a href="http://www.bootcss.com/">Bootstrap中文网</a>翻译整理</p>
    </div>

    <footer>
      <div class="wrapper">
        <div class="container clearfix">
          <div class="left-col">
            <a href="http://mathias-biilmann.net">&copy; Mathias Biilmann, 2013</a>
          </div>
          <div class="right-col text-right">
            <a href="http://www.webpop.com">A Webpop Production</a>
          </div>

        </div>
      </div>

    </footer>

    <a href="https://github.com/webpop/jquery.pin"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_right_gray_6d6d6d.png" alt="Fork me on GitHub"></a>


    <!-- Include jQuery and jquery.pin -->
    <script src="jquery.min.js"></script>
    <script src="jquery.pin.js"></script>
    <script src="projects.js"></script>

    <!-- PIN ALL THE THINGS! -->
    <script>
      $(".pinned").pin({containerSelector: ".container", minWidth: 940});
    </script>
    <!-- That's all - pretty easy, right? -->
    
    
    
    <!-- Analytics -->
    
  </body>
</html>
