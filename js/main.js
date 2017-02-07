// Constants

function bookmarks2foldersTree(bmRoot, depth) {
  if (depth > 2) return null;
  var domRoot = document.createElement("ul");
  if (bmRoot.parentId == null) { //isroot
    domRoot.setAttribute("title", "root")
    //domRoot.setAttribute("style", "display: none;");
  }
  for (i in bmRoot.children) {
    var bmNode = bmRoot.children[i]
    if (bmNode.url == null) { //isfolder
      var li = document.createElement("li");
      li.setAttribute("title", bmNode.title);
      li.setAttribute("class", "folder");
      li.setAttribute("lazy", "true");
      li.appendChild(document.createTextNode(bmNode.title));
      if (bmNode.children.length > 0) {
        var ul = bookmarks2foldersTree(bmNode, depth + 1);
        if (ul != null) {
          li.appendChild(ul);
        }
      }
      domRoot.appendChild(li);
    }
  }
  return domRoot;
}

function Buffer() {
  this.str = ''
  this.clear = function() {
    this.str= '';
  }
  this.append = function(ch) {
    this.str += ch;
    setTimeout(this.clear, 5000);
  }
}

function getNext() {
  var next;
  if (self.isExpanded()) {
    next = self.getFirstChild();
    if (next != null) return next;
  }
  next = self.getNextSibling();
  if (next != null) return next;
  next = self.getParent();
  if (next != null) {
    return next.getNextSibling();
  }
  return null;
}

function findFirstWithSelf(str) {
  
}

function jumpTo(str) {
  var current = $("#mainfolders").fancytree("getActiveNode");
  console.log("active: " + current.title);
  console.log("jumpTo: " + str);
  var next = current.findFirst("/^" + str);
  next.setActive();
  //next.setFocus();
}

function mainfolders_keydown(event, data) {
  console.log(event);
  console.log(event.which);
  cc = event.which;
  //if (46 <= cc && cc <= 57 || 65 <= cc && cc <= 90
}

function mainfolders_keypress(event, data) {
  console.log(event);
  console.log(event.which);
  var cc = String.fromCharCode(event.which);
  console.log(cc);
  if (cc >= ' ') {
    var buffer = $("#mainfolders").data('buffer');
    buffer.append(cc);
    jumpTo(buffer.str);
  }
}

/*
window.onload = function() {
  chrome.bookmarks.getTree(function(root) {
    var ul = bookmarks2foldersTree(root[0], 1)
    $('#mainfolders').append(ul);
    var tree = $("#mainfolders").fancytree({
      persist: true,
      //keydown: mainfolders_keydown,
    });
    var fancytreeClass = $("#mainfolders").fancytree("getRootNode").prototype.constructor;
    //fancytreeClass.prototype.getNext = getNext;
    //fancytreeClass.prototype.findFirstWithSelf = findFirstWithSelf;
    //fancytreeClass.prototype.findFirstWithSelf = function() {};
    $("#mainfolders").data('buffer', new Buffer());
    $("#mainfolders").keypress(mainfolders_keypress);
  });
}
*/
