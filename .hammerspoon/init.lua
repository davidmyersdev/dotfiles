-- Docs
--
-- Type annotations:
--   - https://github.com/LuaLS/lua-language-server/wiki/Annotations

hs.loadSpoon("EmmyLua")
hs.loadSpoon("ReloadConfiguration")

hs.application.enableSpotlightForNameSearches(true)
hs.window.animationDuration = 0

spoon.ReloadConfiguration:start()

local blockSize = 50
local normalHeight = 1080
local normalWidth = 1920
-- todo: Add a way to switch between these sizes dynamically...
local smallerHeight = 945
local smallerWidth = 1512

-- Active dimensions of center window.
local currentHeight = normalHeight
local currentWidth = normalWidth

local hyper = { "command", "control", "option", "shift" }
local triplet = { "control", "option", "command" }
local scaler = { "control", "shift", "option" }

hs.hotkey.bind(hyper, "5", function()
  local timestamp = os.date("%Y-%m-%d-%H-%M-%S")

  hs.window.focusedWindow():snapshot(true):saveToFile("~/Desktop/" .. timestamp .. ".png")
end)

hs.hotkey.bind(hyper, "t", function()
  local windows = hs.fnutils.map(hs.window.filter.new():getWindows(), function(win)
    if win ~= hs.window.focusedWindow() then
      return {
        text = win:title(),
        subText = win:application():title(),
        image = hs.image.imageFromAppBundle(win:application():bundleID()),
        id = win:id()
      }
    end
  end)

  local chooser = hs.chooser.new(function(choice)
    if choice ~= nil then
      local layout = {}
      local focused = hs.window.focusedWindow()
      local toRead  = hs.window.find(choice.id)
      if hs.eventtap.checkKeyboardModifiers()['alt'] then
        hs.layout.apply({
          {nil, focused, focused:screen(), hs.layout.left70, 0, 0},
          {nil, toRead, focused:screen(), hs.layout.right30, 0, 0}
        })
      else
        hs.layout.apply({
          {nil, focused, focused:screen(), hs.layout.left50, 0, 0},
          {nil, toRead, focused:screen(), hs.layout.right50, 0, 0}
        })
      end
      toRead:raise()
    end
  end)

  chooser
    :placeholderText("Choose window for 50/50 split. Hold ⎇ for 70/30.")
    :searchSubText(true)
    :choices(windows)
    :show()
end)

hs.hotkey.bind(triplet, "1", function()
  currentHeight = normalHeight
  currentWidth = normalWidth
end)

hs.hotkey.bind(triplet, "2", function()
  currentHeight = smallerHeight
  currentWidth = smallerWidth
end)

local centerToTopLeft
local getCurrentScreen
local getCurrentScreenFrame
local getCurrentScreenWindows
local getCurrentSpaceId
local getCurrentWindow
local getScreen
local moveWindow
local setWindowPosition
local setWindowSize
local updateWindow

--- Derived from: https://github.com/Hammerspoon/hammerspoon/issues/3224#issuecomment-2155567633
---
--- @param window hs.window
local function disableAnimations(window)
  local app = window:application()

  if not app then
    print("No application found for window: " .. window:title())
    return
  end

  local axApp = hs.axuielement.applicationElement(app)

  if not axApp then
    print("No AX application found for: " .. app:name())
    return
  end

  if axApp.AXEnhancedUserInterface then
    print("yes: " .. app:name())

    axApp.AXEnhancedUserInterface = false
  else
    print("no: " .. app:name())
  end
end


function getCurrentScreen()
  return getScreen(getCurrentWindow())
end

function getCurrentScreenFrame()
  return getCurrentScreen():frame()
end

function getCurrentScreenWindows()
  local currentScreen = getCurrentScreen()
  local windows = {}

  for _, window in ipairs(hs.window.allWindows()) do
    if getScreen(window) == currentScreen
    then
      table.insert(windows, window)
    end
  end

  return windows
end

function getCurrentSpaceId()
  return hs.spaces.focusedSpace()
end

function getCurrentWindow()
  return hs.window.focusedWindow()
end

function getScreen(window)
  return window:screen()
end

function centerToTopLeft(details)
  local center = details.center
  local size = details.size

  return {
    x = center.x - (size.w / 2),
    y = center.y - (size.h / 2),
  }
end

---@param window hs.window
function moveWindow(window, details)
  disableAnimations(window)

  local size = {
    w = details.width or window:size().w,
    h = details.height or window:size().h,
  }

  local column = details.column or 2.5
  local columns = details.columns or 4
  local row = details.row or 1
  local rows = details.rows or 1

  local screenFrame = getCurrentScreenFrame()
  local columnWidth = screenFrame.w / columns
  local rowHeight = screenFrame.h / rows

  local center = {
    x = ((columnWidth * column) - (columnWidth / 2) + screenFrame.x),
    y = ((rowHeight * row) - (rowHeight / 2)) + screenFrame.y,
  }

  local topLeft = centerToTopLeft({
    center = center,
    size = size,
  })

  updateWindow(window, {
    size = size,
    topLeft = topLeft,
  })
end

function setWindowPosition(window, details)
  local frame = window:frame()

  frame.x = details.x
  frame.y = details.y

  hs.window.animationDuration = 0

  window:setFrame(frame)
end

function setWindowSize(window, details)
  local frame = window:frame()

  frame.w = details.width
  frame.h = details.height

  hs.window.animationDuration = 0

  window:setFrame(frame)
end

---@param window hs.window
function updateWindow(window, details)
  local frame = window:frame()

  if details.center then
    local topLeft = centerToTopLeft({
      center = details.center,
      size = details.size or window:size(),
    })

    frame.x = topLeft.x
    frame.y = topLeft.y
  end

  if details.size then
    frame.w = details.size.w
    frame.h = details.size.h
  end

  if details.topLeft then
    frame.x = details.topLeft.x
    frame.y = details.topLeft.y
  end

  window:setFrame(frame, 0)
end

-- The default grid is 4 columns in a single row. E.g. | 1 | 2 | 3 | 4 |
hs.hotkey.bind(hyper, "1", function()
  hs.spaces.moveWindowToSpace(getCurrentWindow(), 1)
end)

hs.hotkey.bind(hyper, "2", function()
  hs.spaces.moveWindowToSpace(getCurrentWindow(), 2)
end)

hs.hotkey.bind(hyper, "3", function()
  hs.spaces.moveWindowToSpace(getCurrentWindow(), 3)
end)

hs.grid.setMargins(hs.geometry.size(10,10))
hs.grid.setGrid('8x5')

hs.hotkey.bind(hyper, "g",function()
  hs.grid.show()
end)

hs.hotkey.bind(hyper, "r", function()
  -- Reload the Hammerspoon config.
  hs.reload()
end)

-- hs.hotkey.bind(hyper, "z", function()
--   -- https://github.com/Hammerspoon/hammerspoon/issues/2794#issuecomment-1637453743
--   for _, app in ipairs(hs.application.runningApplications()) do
-- 		local ax = hs.axuielement.applicationElement(app)
-- 		if ax.AXEnhancedUserInterface then
-- 			print(app:name())
-- 			ax.AXEnhancedUserInterface = false
-- 		end
-- 	end
-- end)

hs.hotkey.bind(hyper, "return", function()
  moveWindow(getCurrentWindow(), {
    column = 2.5,
    width = getCurrentScreenFrame().w,
    height = getCurrentScreenFrame().h,
  })
end)

hs.hotkey.bind(scaler, "return", function()
  local screenFrame = getCurrentScreenFrame()
  local windows = getCurrentScreenWindows()

  for _, window in ipairs(windows) do
    moveWindow(window, {
      column = 2.5,
      width = screenFrame.w,
      height = screenFrame.h,
    })
  end
end)

hs.hotkey.bind(hyper, "c", function()
  moveWindow(getCurrentWindow(), {
    column = 2.5,
    width = 960,
    height = 540,
  })
end)

hs.hotkey.bind(hyper, "m", function()
  moveWindow(getCurrentWindow(), {
    column = 2.5,
    width = currentWidth,
    height = currentHeight,
  })
end)

hs.hotkey.bind(hyper, "i", function()
  local screen = getCurrentScreen()
  local window = getCurrentWindow()

  print("screen.w: ", screen:frame().w)
  print("screen.h: ", screen:frame().h)
  print("screen.x: ", screen:frame().x)
  print("screen.y: ", screen:frame().y)
  print("window.w: ", window:size().w)
  print("window.h: ", window:size().h)
  print("window.x: ", window:frame().x)
  print("window.y: ", window:frame().y)
end)

hs.hotkey.bind(scaler, "m", function()
  local windows = getCurrentScreenWindows()

  for _, window in ipairs(windows) do
    moveWindow(window, {
      column = 2.5,
      width = currentWidth,
      height = currentHeight,
    })
  end
end)

hs.hotkey.bind(scaler, "s", function()
  hs.window.setShadows(false)
end)

hs.hotkey.bind(hyper, "f", function()
  local screen = getCurrentScreenFrame()
  local columnWidth = (screen.w - 1920) / 2
  local window = getCurrentWindow()

  -- hs.layout.apply({
  --   { nil, window, window:screen(), hs.layout.left70, nil, nil },
  -- })

  moveWindow(window, {
    column = 1,
    width = (columnWidth - 160),
    height = currentHeight,
  })
end)

hs.hotkey.bind(hyper, "l", function()
  local screen = getCurrentScreenFrame()
  local columnWidth = (screen.w - 1920) / 2
  local window = getCurrentWindow()

  moveWindow(window, {
    column = 4,
    width = (columnWidth - 160),
    height = currentHeight,
  })
end)

hs.hotkey.bind(hyper, "n", function()
  hs.application.open('Octo')
end)

hs.hotkey.bind(hyper, "up", function()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.h = frame.h / 2

  window:setFrame(frame, 0)
end)

hs.hotkey.bind(hyper, "down", function()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.h = frame.h / 2
  frame.y = frame.y + frame.h

  window:setFrame(frame, 0)
end)

hs.hotkey.bind(scaler, "left", function()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.x = frame.x - blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind(scaler, "right", function()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.x = frame.x + blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind(scaler, "down", function()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.y = frame.y - blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind(scaler, "up", function()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.y = frame.y + blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind(triplet, "left", function()
  local screen = getCurrentScreenFrame()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.x = screen.x
  frame.y = screen.y

  frame.h = screen.h
  frame.w = screen.w / 2

  print("frame.x: ", frame.x)
  print("frame.y: ", frame.y)
  print("frame.w: ", frame.w)
  print("frame.h: ", frame.h)

  print("screen.x: ", screen.x)
  print("screen.y: ", screen.y)
  print("screen.w: ", screen.w)
  print("screen.h: ", screen.h)

  window:setFrame(frame, 0)
end)

hs.hotkey.bind(triplet, "right", function()
  local screen = getCurrentScreenFrame()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.x = screen.w / 2
  frame.y = screen.y

  frame.h = screen.h
  frame.w = screen.w / 2

  print("frame.x: ", frame.x)
  print("frame.y: ", frame.y)
  print("frame.w: ", frame.w)
  print("frame.h: ", frame.h)

  print("screen.x: ", screen.x)
  print("screen.y: ", screen.y)
  print("screen.w: ", screen.w)
  print("screen.h: ", screen.h)

  window:setFrame(frame, 0)
end)

hs.hotkey.bind(hyper, "left", function()
  local screen = getCurrentScreenFrame()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.w = frame.w - blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind(hyper, "right", function()
  local screen = getCurrentScreenFrame()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.w = frame.w + blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind(hyper, "down", function()
  local screen = getCurrentScreenFrame()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.h = frame.h - blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind(hyper, "up", function()
  local screen = getCurrentScreenFrame()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.h = frame.h + blockSize

  window:setFrame(frame, 0)
end)
