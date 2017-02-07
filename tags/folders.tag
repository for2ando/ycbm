<!-- The definition of folders tag -->

<folders>
  <p>Here is a folders pane.</p>
  <div id='mainfolders'></div>
  
  //riot.observable(this)
  
  this.on('mount', function() {
    chrome.bookmarks.getTree(function(bkmktree) {
      var ul = bookmarks2foldersTree(bkmktree[0], 1)
      $('#mainfolders', this.root).append(ul)
      var fncytree = $('#mainfolders', this.root).fancytree({
        extensions: ['persist'],
        persist: {
          store: 'local'
        }
        //keydown: mainfolders_keydown,
      })
    })
  })

</folders>
