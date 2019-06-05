<!-- The definition of bookmarkmanager tag -->

<bookmarkmanager>
  <ul ref='maintoolbar' class="toolbar">
    <li class="toolbaritem">
      <lc>%YetAnotherBookmarkManager</lc>
    </li>
    <li class="toolbaritem">
      <input type='text' name='search' placeholder={placeholder} />
    </li>
  </ul>
  
  <div ref="maincontainer" class="split-pane fixed-left">
    <folders ref="mainfolders" class="split-pane-component"></folders>
    <div ref="maindivider" class="split-pane-divider"></div>
    <contents ref="maincontents" class="maincontents split-pane-component"></contents>
  </div>
  
<!--  <script type="text/javascript" src="../js/main.js"></script>-->
  
  <style>
    .toolbar {
      padding: 0;
    }
    .toolbaritem {
      display: inline;
    }
    li.toolbaritem:first-of-type {
      font-size: 150%;
      margin: 0 0 0 1ex;
    }
    li.toolbaritem:last-of-type {
      float: right;
    }
    
    .split-pane {
      height: 100%;
    }
    .split-pane-divider {
      background: #f6f6f6;
    }
    
    [ref='maintoolbar'] {
      margin-top: 8pt;
      margin-bottom: 8pt;
    }
    [ref='mainfolders'] {
      width: 200px;
      bottom: 0;
    }
    [ref='maindivider'] {
      left: 200px; /* same as the width of ref=mainfolders */
      width: 4px;
    }
    [ref='maincontents'] {
      left: 200px !important; /* same as the width of ref=mainfolders */
      margin-left: 0px;  /* same as the width of #maindivider */
    }
  </style>
  
  self = this
  
  var folders_opts = {
    folders_onmount: folders_onmount,
    folder__onfocus: folder_onfocus
    //folder__onfocus: function(bkmkNode) { self.folder_onfocus(bkmkNode) }
  }
  
  function folders_onmount(callback) {
    chrome.bookmarks.getTree(callback)
  }
  
  function folder_onfocus(bkmkNode) {
    console.log('folder_onfocus invoked.')
    console.log('self.ref keys=' + Object.keys(self.ref('maincontents')))
    console.log('self.ref len=' + self.ref('maincontents').length)
    console.log('self.ref=' + self.ref('maincontents')[0])
    console.log('self.ref0 keys=' + Object.keys(self.ref('maincontents')[0]))
    console.log('self.ref0 tag=' + self.ref('maincontents')[0].tagName)
    console.log('self.ref0 class=' + self.ref('maincontents')[0].className)
    console.log('self.ref0 ref=' + self.ref('maincontents')[0].ref)
    console.log('self.ref0 title=' + self.ref('maincontents')[0].title)
    console.log('self.ref0 __ref=' + self.ref('maincontents')[0].__ref)
    console.log('self.ref0 __ref keys=' + Object.keys(self.ref('maincontents')[0].__ref))
    console.log('self.ref0 __ref.title=' + self.ref('maincontents')[0].__ref.title)
    console.log('self.ref0 _tag=' + self.ref('maincontents')[0]._tag)
    console.log('self.ref0 _tag keys=' + Object.keys(self.ref('maincontents')[0]._tag))
    console.log('self.ref0 _tag.title=' + self.ref('maincontents')[0]._tag.title)
    console.log('trigger=' + self.ref('maincontents')[0].trigger)
    self.ref('maincontents')[0].trigger('display', bkmkNode)
  }
  
  this.placeholder = lc('%SearchBookmarks')
  
  this.on('mount', function() {
    console.log('bookmarkmanager mounted.')
    console.log('self0 keys=' + Object.keys(self))
    console.log('self0.ref=' + self.ref('maincontents'))
    console.log('self0.ref keys=' + Object.keys(self.ref('maincontents')))
    console.log('self0.ref len=' + self.ref('maincontents').length)
    console.log('self0.ref0 keys=' + Object.keys(self.ref('maincontents')[0]))
    riot.mount('folders', folders_opts)
    //riot.mount('contents')
    //riot.mount('menubutton')
  })
  
</bookmarkmanager>
