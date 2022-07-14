local log = hs.logger.new("hammerspoon", "debug")

hs.alert.show("Hammerspoon - initializing")

hs.hotkey.bind({"ctrl"}, "R", function()
  hs.reload()
end)

hs.hotkey.bind({"ctrl"}, 'd', function()
  hs.alert.show("Debug")
end)

hs.hotkey.bind({"ctrl"}, 'tab', function()
  local nextScreen = hs.window.focusedWindow():screen():next()
  hs.window.focusedWindow():moveToScreen(nextScreen, 0)
end)

hs.hotkey.bind({"ctrl"}, 'l', function()
  hs.caffeinate.lockScreen()
end)

hs.hotkey.bind({"ctrl"}, "escape", function()
  hs.application.frontmostApplication():kill()
end)

hs.hotkey.bind({"ctrl"}, "f", function()
  hs.window.focusedWindow():maximize()
end)

hs.hotkey.bind({"ctrl"}, "q", function()
  hs.application.frontmostApplication():allWindows()[2]:becomeMain()
end)

function launch(name)
    log.i("Launch application: ", name)
    hs.application.launchOrFocus(name)
end

appMappings = {
    {'§', 'iTerm.app'},
    {'1', 'Google Chrome.app'},
    {'2', 'IntelliJ IDEA.app'},
    {'3', 'Sublime Text.app'},
    {'4', 'DataGrip.app'},
    {'5', 'Microsoft Excel.app'},
    {'9', 'Slack.app'},
    {'0', 'Microsoft PowerPoint.app'},
    {'m', 'Microsoft Outlook.app'},
}

for i, km in ipairs(appMappings) do
    hs.hotkey.bind({"ctrl"}, km[1], function() launch(km[2]) end)
end