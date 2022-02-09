function center()
  local app = hs.window.focusedWindow()
  local appFrame = app:frame()
  local screen = app:screen()
  local screenFrame = screen:frame()

  appFrame.x = (screenFrame.w - appFrame.w) / 2
  appFrame.y = (screenFrame.h - appFrame.h) / 2

  app:setFrame(appFrame)
end

function centerLeft()
  local app = hs.window.focusedWindow()
  local appFrame = app:frame()
  local screen = app:screen()
  local screenFrame = screen:frame()

  appFrame.x = ((screenFrame.w / 4) - appFrame.w) / 2
  appFrame.y = (screenFrame.h - appFrame.h) / 2

  app:setFrame(appFrame)
end

function centerRight()
  local app = hs.window.focusedWindow()
  local appFrame = app:frame()
  local screen = app:screen()
  local screenFrame = screen:frame()

  appFrame.x = screenFrame.w - ((screenFrame.w / 8)) - (appFrame.w / 2)
  appFrame.y = (screenFrame.h - appFrame.h) / 2

  app:setFrame(appFrame)
end

function resize(width, height)
  local app = hs.window.focusedWindow()
  local appFrame = app:frame()

  appFrame.w = width
  appFrame.h = height

  app:setFrame(appFrame)
end

hs.hotkey.bind({"control", "option"}, "m", function()
  resize(1920, 1080)
  center()
end)

hs.hotkey.bind({"control", "option"}, "f", function()
  resize(760, 1080)
  centerLeft()
end)

hs.hotkey.bind({"control", "option"}, "l", function()
  resize(760, 1080)
  centerRight()
end)
