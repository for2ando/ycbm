//
// main.js
//

function lc(string) {
  return string.toLocaleString()
}

// global mixin(s)
riot.mixin({
  ref: function(str) {
    return $('[ref="' + str + '"]', this.root)
  }
})

riot.mount('bookmarkmanager')
riot.mount('lc')
//riot.update()

