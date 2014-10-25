
# var ss = require("sdk/simple-storage");

# if (!ss.storage.pages)
#   ss.storage.pages = [];

# require("sdk/tabs").on("ready", function(tab) {
#   ss.storage.pages.push(tab.url);
# });

# require("sdk/ui/button/action").ActionButton({
#   id: "read",
#   label: "Read",
#   icon: "./folder.png",
#   onClick: function() {
#     // alert("folder was clicked!");
#     console.log(ss.storage.pages);
#   }
# });
handleClick = (state) ->
  tabs.open "127.0.0.1:8090"
  return
myListener = ->
  console.log "A selection has been made."
  console.log "title of active tab is " + tabs.activeTab.url
  console.log selection.text  if selection.text
  popup_selection.port.emit "text-update",
    text: selection.text
    url: tabs.activeTab.url

  return
buttons = require("sdk/ui/button/action")
tabs = require("sdk/tabs")
data = require("sdk/self").data
selection = require("sdk/selection")
button = buttons.ActionButton(
  id: "localhost-link"
  label: "Visit localhost"
  icon:
    16: "./earth.png"
    32: "./earth.png"
    64: "./earth.png"

  onClick: handleClick
)
selection.on "select", myListener

# var panel = require("sdk/panel").Panel({
#   width: 600,
#   height: 400,
#   contentURL: "https://en.wikipedia.org/w/index.php?title=Jetpack&useformat=mobile"
# });

# require("sdk/ui/button/action").ActionButton({
#   id: "panel",
#   label: "Read",
#   icon: "./folder.png",
#   onClick: function() {
#     panel.show();
#   }
# });
popup_selection = require("sdk/panel").Panel(
  width: 600
  height: 300
  contentURL: data.url("popup_selection.html")
  contentScriptFile: [
    data.url("notice-api.js")
    data.url("popup_selection.js")
  ]
)
require("sdk/ui/button/action").ActionButton
  id: "popup_selection"
  label: "Read"
  icon: "./folder.png"
  onClick: ->
    popup_selection.show()
    return

