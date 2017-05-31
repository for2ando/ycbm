<!-- The definition of bookmarkmanager tag -->

<bookmarkmanager>
  <ul class="toolbar">
    <li class="toolbaritem"><lc>%YetAnotherBookmarkManager</lc></li>
    <li class="toolbaritem">
      <input type='text' name='search' placeholder={lc('%SearchBookmarks')} />
    </li>
  </ul>
  
  <div class="split-pane fixed-left" id="maincontainer">
    <folders id="mainfolders" class="split-pane-component"></folders>
    <div class="split-pane-divider" id="maindivider"></div>
    <contents class="split-pane-component"></contents>
  </div>
  
  <style>
    .toolbar {
      margin: 0;
    }
    .toolbaritem {
      display: inline;
    }
    li.toolbaritem:first-of-type {
      font-size: 150%;
    }
    li.toolbaritem:last-of-type {
      float:right;
    }
    
    .split-pane {
      height: 100%;
    }
    .split-pane-divider {
      background: #aaf;
    }
    
    #mainfolders {
      width: 200px;
      bottom: 0;
    }
    #maindivider {
      left: 200px; /* same as the width of #mainfolders */
      width: 4px;
    }
    #maincontents {
      left: 200px; /* same as the width of #mainfolders */
      margin-left: 4px;  /* same as the width of #maindivider */
    }
  </style>
  
  var mainfolders_opts = {
    onmount: mainfolders_onmount
  }
  
  function mainfolders_onmount(callback) {
    chrome.bookmarks.getTree(callback)
  }
  
  this.on('mount', function() {
    riot.mount('#mainfolders', mainfolders_opts)
    riot.mount('lc')
  })
</bookmarkmanager>
