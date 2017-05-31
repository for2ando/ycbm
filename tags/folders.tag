<!-- The definition of folders tag -->

<folders>
  <p>Here is a folders pane.</p>
  <div ref='treeroot'></div>
  
  this.on('mount', function() {
    this.root.addEventListener('keydown', folders_keydown, false)
    var self = this
    opts.onmount(function(bkmkTree) {
      var ul = bookmarksToUList(bkmkTree[0], 1)
      self.refs.treeroot.append(ul)
      var fncyTree = $('[ref="treeroot"]', self.root).fancytree({
        autoActivate: false,
        extensions: ['persist'],
        persist: {
          store: 'local'
        }
      })
      $('[ref="treeroot"]', self.root).data('kbdBuffer', new Buffer)
    })
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
  
  function folders_keydown(evt, data) {
    //console.log("code,key:  '" + evt.code + "','" + evt.key + "'," + evt.location)
    
    //// incremental node-search (forward match)
    var buffer = $('[ref="treeroot"]', this.root).data('kbdBuffer')
    if (evt.key.length == 1) { // length == 1 means that evt.key is printable char.
      var fncyTree = $('[ref="treeroot"]', this.root).fancytree('getTree')
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
