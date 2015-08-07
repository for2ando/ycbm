// Constants

/*
jQuery(function() {
  $('.containerpane').splitPane();
});
*/

function bookmarks2dom(bmRoot, depth) {
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
      li.appendChild(document.createTextNode(bmNode.title));
      if (bmNode.children.length > 0) {
        var ul = bookmarks2dom(bmNode, depth + 1);
        if (ul != null) {
     console.log(ul);
     console.log(ul.parentNode);
          li.appendChild(ul);
        }
      }
      domRoot.appendChild(li);
    }
  }
  return domRoot;
}

window.onload = function() {
  chrome.bookmarks.getTree(function(root) {
    var ul = bookmarks2dom(root[0], 1)
    $('#mainfolders').append(ul);
    var tree = $("#mainfolders").dynatree({
      persist: true,
      
    });
  });
}

