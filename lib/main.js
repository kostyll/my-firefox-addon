var buttons = require('sdk/ui/button/action');
var tabs = require("sdk/tabs");
var ss = require("sdk/simple-storage");
var selection = require("sdk/selection");

if (!ss.storage.pages)
  ss.storage.pages = [];

var button = buttons.ActionButton({
  id: "google-link",
  label: "Visit Google",
  icon: {
    "16": "./earth.png",
    "32": "./earth.png",
    "64": "./earth.png",
  },
  onClick: handleClick
});

require("sdk/tabs").on("ready", function(tab) {
  ss.storage.pages.push(tab.url);
});

require("sdk/ui/button/action").ActionButton({
  id: "read",
  label: "Read",
  icon: "./folder.png",
  onClick: function() {
    // alert("folder was clicked!");
    console.log(ss.storage.pages);
  }
});

function handleClick(state) {
  tabs.open("google.com");
}

function myListener() {
  console.log("A selection has been made.");
  if (selection.text)
    console.log(selection.text);
}
selection.on('select', myListener);

var panel = require("sdk/panel").Panel({
  width: 600,
  height: 400,
  contentURL: "https://en.wikipedia.org/w/index.php?title=Jetpack&useformat=mobile"
});

require("sdk/ui/button/action").ActionButton({
  id: "panel",
  label: "Read",
  icon: "./folder.png",
  onClick: function() {
    panel.show();
  }
});
