//
// background.js
//

chrome.browserAction.onClicked.addListener(function(tab){
  chrome.tabs.create({url:"main.html"}, function(tab){});
});

