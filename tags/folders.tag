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
  
  function folders_keydown(evt, data) {
    console.log("code,key:  '" + evt.code + "','" + evt.key + "'," + evt.location)
    
    //// incremental node-search (forward match)
    var buffer = $('[ref="treeroot"]', this.root).data('kbdBuffer')
    if (evt.key.length == 1) { // length == 1 means that evt.key is printable char.
      var fncyTree = $('[ref="treeroot"]', this.root).fancytree('getTree')
      //console.log('active-node: ', fncyTree.activeNode.title)
      //console.log('focused-node: ', fncyTree.focusNode.title)
      buffer.append(evt.key)
      var nextNode = findNode(fncyTree.activeNode, buffer.str, true)
      if (nextNode != null) { nextNode.setFocus() } else { console.log("notfound") }
    } else {
      buffer.clear()
    }
  }
  
</folders>
