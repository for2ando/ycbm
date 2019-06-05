<!-- The definition of folders tag -->

<folders>
  <div ref='toolbar' class='toolbar'>
    <menubutton ref='foldersmenubutton'
                title={title}>
      <ul ref='menu'>
        <li><a href='#'><lc>%FoldersMenuAddNewFolder</lc></a></li>
        <li><a href='#'><lc>%FoldersMenuImportBookmarks</lc></a></li>
        <li><a href='#'><lc>%FoldersMenuExportBookmarks</lc></a></li>
      </ul>
    </menubutton>
  </div>
  <div ref='treeroot'></div>
  
  <style>
    [ref='toolbar'] {
      height: 20pt;
      background-color: #f6f6f6;
    }
    [ref='toolbar'] [ref='foldersmenubutton'].ui-button {
      height: 100%;
      position: relative;
      left: 2px;
    }
    [ref='toolbar'] [ref='foldersmenubutton'].ui-state-default {
      background-image: none;
      background-color: #f6f6f6;
    }
    [ref='toolbar'] [ref='foldersmenubutton'] .ui-button-text {
      padding-top: 0;
      padding-bottom: 0;
    }
    [ref='toolbar'] [ref='foldersmenubutton'] [ref='menu'].ui-menu {
      z-index: 0;
      width: 250px;
    }
    [ref='treeroot'] {
      position: relative;
      z-index: -1;
    }
  </style>
  
  this.title = lc('%FoldersMenuButton')
  
  this.on('mount', function() {
    //riot.mount('[ref="foldersmenubutton"]')
    
    this.root.addEventListener('keydown', this.folders_keydown, false)
    
    var self = this
    opts.folders_onmount(function(bkmkTree) {
      var ul = bookmarksToUList(bkmkTree[0], 1)
      self.refs.treeroot.append(ul)
      var fncyTree = self.ref('treeroot').fancytree({
        autoActivate: false,
        extensions: ['persist'],
        persist: {
          store: 'local'
        },
        focus: function(evt, evdata) {
          opts.folder__onfocus(evdata.node)
        }
      })
      self.ref('treeroot').data('kbdBuffer', new Buffer)
    })
  })
  
  this.on('update', function() {
    console.log('<folders> update')
  })
  
  function bookmarksToUList(bmRoot, depth) {
    if (depth > 2) return null
    var domRoot = document.createElement('ul')
    if (bmRoot.parentId == null) { //isroot
      domRoot.setAttribute('title', 'root')
      //domRoot.setAttribute('style', 'display: none;')
    }
    for (i in bmRoot.children) {
      var bmNode = bmRoot.children[i]
      if (bmNode.url == null) { //isfolder
        var li = document.createElement('li')
        li.setAttribute('title', bmNode.title)
        li.setAttribute('class', 'folder')
        li.setAttribute('lazy', 'true')
        li.appendChild(document.createTextNode(bmNode.title))
        if (bmNode.children.length > 0) {
          var ul = bookmarksToUList(bmNode, depth + 1)
          if (ul != null) {
            li.appendChild(ul)
          }
        }
        domRoot.appendChild(li)
      }
    }
    return domRoot
  }
  
  folders_keydown(evt, data) {
    //console.log("code,key:  '" + evt.code + "','" + evt.key + "'," + evt.location)
    
    //// incremental node-search (forward match)
    var buffer = this.ref('treeroot').data('kbdBuffer')
    if (evt.key.length == 1) {
      // evt.key.length == 1 means that evt.key is printable char.
      var fncyTree = this.ref('treeroot').fancytree('getTree')
      buffer.append(evt.key)
      var nextNode = findNode(fncyTree.activeNode, buffer.str, true)
      if (nextNode != null) { nextNode.setFocus() } //else { console.log("notfound") }
    } else {
      buffer.clear()
    }
  }
  
  var BUFFER_TIMEOUT = 2000
  
  function Buffer() {
    this.str = ''
    this.timeoutId = null
    this.clear = function() {
      this.str = ''
      //console.log("cleared")
    }
    this.append = function(ch) {
      this.str += ch
      if (this.timeoutId != null) { clearTimeout(this.timeoutId) }
      var thisBuffer = this
      this.timeoutId = setTimeout(function() { thisBuffer.clear() }, BUFFER_TIMEOUT)
    }
  }
  
  function nextNode(node, cyclicp) {
    var next
    if (node.isExpanded()) {
      next = node.getFirstChild()
      if (next != null) return next
    }
    next = node.getNextSibling()
    if (next != null) return next
    next = node.getParent()
    if (next != null) {
      next = next.getNextSibling()
      if (next != null) return next
      return node.tree.rootNode.getFirstChild()
    }
    return null
  }
  
  function findNode(startNode, str, cyclicp) {
    console.log("search: '" + str + "'")
    re = new RegExp('^' + str, 'i')
    node = nextNode(startNode, cyclicp)
    while (node != null) {// && node != startNode) {
      if (node.title.match(re)) return node
      if (node == startNode) return null
      node = nextNode(node, cyclicp)
    }
    return null
  }
</folders>
