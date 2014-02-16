<#include "common/freemarker/include_header.ftl">
<style>
html,
body {
  height: 100%;
  /* The html and body elements cannot have any padding or margin. */
}

/* Wrapper for page content to push down footer */
#wrap {
  min-height: 100%;
  height: auto;
  /* Negative indent footer by its height */
  margin: 0 auto -60px;
  /* Pad bottom by footer height */
  padding: 0 0 60px;
}

/* Set the fixed height of the footer here */
#footer {
  height: 60px;
  background-color: #f5f5f5;
}


/* Custom page CSS
-------------------------------------------------- */
/* Not required for template or sticky footer method. */

#wrap > .container {
  padding: 60px 15px 0;
}
.container .text-muted {
  margin: 20px 0;
}

#footer > .container {
  padding-left: 15px;
  padding-right: 15px;
}

code {
  font-size: 80%;
}
</style>
<body>

    <!-- Wrap all page content here -->
    <div id="wrap">

      <!-- Fixed navbar -->
      <div class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
          <div class="navbar-header">
            <a class="navbar-brand" href="#">logo</a>顶部固定
          </div>
          
        </div>
      </div>

      <!-- Begin page content -->
      <div class="container">
        <div class="page-header">
          <h1>固定顶部和底部r</h1>
        </div>
        <p class="lead">Pin a fixed-height footer to the bottom of the viewport in desktop browsers with this custom HTML and CSS. A fixed navbar has been added within <code>#wrap</code> with <code>padding-top: 60px;</code> on the <code>.container</code>.</p>
        <p>Back to <a href="../sticky-footer">the default sticky footer</a> minus the navbar.</p>
      </div>
    </div>

    <div id="footer">
      <div class="container">
        <p class="text-muted">底部</p>
      </div>
    </div>

