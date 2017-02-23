<!-- The definition of folders tag -->

<folders>
  <p>Here is a folders pane.</p>
  <div id='mainfolders'></div>
  
  this.on('mount', function() {
    chrome.bookmarks.getTree(function(bkmkTree) {
      var ul = bookmarksToUList(bkmkTree[0], 1)
      $('#mainfolders', this.root).append(ul)
      var fncyTree = $('#mainfolders', this.root).fancytree({
        autoActivate: false,
        extensions: ['persist'],
        persist: {
          store: 'local'
        }
      })
      $("#mainfolders", this.root).data('kbdBuffer', new Buffer)
    })
    //$('#mainfolders', this.root).get(0).addEventListener('keydown', mainfolders_keydown, false)
    this.root.addEventListener('keydown', mainfolders_keydown, false)
  })
</folders>
