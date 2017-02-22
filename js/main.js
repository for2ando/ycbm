// main.js

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

var BUFFER_TIMEOUT = 2000

function Buffer() {
  this.str = ''
  this.timeoutId = null
  this.clear = function() {
    this.str= ''
    console.log("cleared")
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

function mainfolders_keydown(evt, data) {
  console.log("code,key:  '" + evt.code + "','" + evt.key + "'," + evt.location)
  
  //// incremental node-search (forward match)
  var buffer = $('#mainfolders', this.root).data('kbdBuffer')
  if (evt.key.length == 1) { // length == 1 means that evt.key is printable char.
    var fncyTree = $('#mainfolders', this.root).fancytree('getTree')
    //console.log('active-node: ', fncyTree.activeNode.title)
    //console.log('focused-node: ', fncyTree.focusNode.title)
    buffer.append(evt.key)
    var nextNode = findNode(fncyTree.activeNode, buffer.str, true)
    if (nextNode != null) { nextNode.setActive() } else { console.log("notfound") }
  } else {
    buffer.clear()
  }
}
