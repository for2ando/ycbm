<!-- The definition of contents tag -->

<contents>
  <div ref='toolbar'>
    <menubutton ref='contentsmenubutton'
                title={buttontitle}>
      <ul ref='menu'>
        <li><a href='#'><lc>%BookmarksMenuAddNewBookmark</lc></a></li>
      </ul>
    </menubutton>
  </div>
  <div ref='contentsroot'></div>
  
  <style>
    [ref='toolbar'] {
      height: 20pt;
      background-color: #f6f6f6;
    }
    [ref='toolbar'] [ref='contentsmenubutton'].ui-button {
      height: 100%;
      position: relative;
      left: 4px;
    }
    [ref='toolbar'] [ref='contentsmenubutton'].ui-state-default {
      background-image: none;
      background-color: #f6f6f6;
    }
    [ref='toolbar'] [ref='contentsmenubutton'] .ui-button-text {
      padding-top: 0;
      padding-bottom: 0;
    }
    [ref='toolbar'] [ref='menu'].ui-menu {
      width: 200px;
    }
  </style>
  
  this.buttontitle = lc('%BookmarksMenuButton')
  //riot.observable(this)
  
  this.on('mount', function() {
    //riot.mount('[ref="contentsmenubutton"]')
  })
  
  this.on('display', function(bkmkNode) {
    console.log('bkmkNode=' + bkmkNode)
    if (bkmkNode == null) return;
    children = bkmkNode.children
    if (children == null || children == undefined) return;
    for (child in bkmkNode.children) {
      console.log('child: ' + child.title)
    }
  })
</contents>
