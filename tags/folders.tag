<!-- The definition of folders tag -->

<folders>
  <p>Here is a folders pane.</p>
  <div ref='treeroot'></div>
  
  this.on('mount', function() {
    this.root.addEventListener('keydown', opts.onkeydown, false)
    var self = this
    opts.onmount(function(bkmkTree) {
      var ul = bookmarksToUList(bkmkTree[0], 1)
      self.refs.treeroot.append(ul)
      var fncyTree = $('[ref="treeroot"]', this.root).fancytree({
        autoActivate: false,
        extensions: ['persist'],
        persist: {
          store: 'local'
        }
      })
      $('[ref="treeroot"]', this.root).data('kbdBuffer', new Buffer)
    })
  })
</folders>
