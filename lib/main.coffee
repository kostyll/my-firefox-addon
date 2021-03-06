buttons = require("sdk/ui/button/action")
tabs = require("sdk/tabs")
data = require("sdk/self").data
selection = require("sdk/selection")
panel = require("sdk/panel")

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
    title: tabs.activeTab.title

  return

buttons.ActionButton(
  id: "localhost-link"
  label: "Visit localhost"
  icon:
    16: "./earth.png"
    32: "./earth.png"
    64: "./earth.png"

  onClick: handleClick
)

selection.on "select", myListener

popup_selection = panel.Panel(
  width: 700
  height: 600
  contentURL: data.url("popup_selection.html")
  contentScriptFile: [
    # including md5 hashing library
    data.url("thirdparty/md5lib/js/md5.js")
    # including jaml modules
    data.url("thirdparty/jaml/src/Jaml.js")
    data.url("thirdparty/jaml/src/Node.js")
    data.url("thirdparty/jaml/src/Template.js")

    # inclugin common jquery and bootstrap libraries

    data.url("thirdparty/jquery-git2.js")
    data.url("thirdparty/bootstrap.min.js")

    # including buautiful tags library
    data.url("thirdparty/bs2-tagsinput/dist/bootstrap-tagsinput.js")

    # including indexedDB OOP wrapper library
    data.url("thirdparty/db.js/src/db.js")

    # including summary module
    data.url("thirdparty/summary.js/dist/summary.js")

    # including logic
    data.url("notice-api.js")

    # including popup window logic
    data.url("popup_selection.js")
  ]
)

buttons.ActionButton
  id: "popup_selection"
  label: "Read"
  icon: "./folder.png"
  onClick: ->
    popup_selection.show()
    return

