hs.application.enableSpotlightForNameSearches(true)

local blockSize = 50

function getCurrentWindow()
  return hs.window.focusedWindow()
end

function getScreen()
  return hs.window.focusedWindow():screen():frame()
end

function centerToTopLeft(details)
  local center = details.center
  local size = details.size

  return {
    x = center.x - (size.w / 2),
    y = center.y - (size.h / 2),
  }
end

function moveWindow(window, details)
  local size = {
    w = details.width or window:size().w,
    h = details.height or window:size().h,
  }

  local column = details.column or 2.5
  local columns = details.columns or 4
  local row = details.row or 1
  local rows = details.rows or 1

  local columnWidth = getScreen().w / columns
  local rowHeight = getScreen().h / rows

  local center = {
    x = (columnWidth * column) - (columnWidth / 2),
    y = (rowHeight * row) - (rowHeight / 2),
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
hs.hotkey.bind({"control", "option"}, "1", function()
  moveWindow(getCurrentWindow(), {
    column = 1,
    width = (getScreen().w / 4),
    height = 1080,
  })
end)

hs.hotkey.bind({"control", "option"}, "2", function()
  moveWindow(getCurrentWindow(), {
    column = 2,
    width = (getScreen().w / 4),
    height = 1080,
  })
end)

hs.hotkey.bind({"control", "option"}, "3", function()
  moveWindow(getCurrentWindow(), {
    column = 3,
    width = (getScreen().w / 4),
    height = 1080,
  })
end)

hs.hotkey.bind({"control", "option"}, "4", function()
  moveWindow(getCurrentWindow(), {
    column = 4,
    width = (getScreen().w / 4),
    height = 1080,
  })
end)

hs.hotkey.bind({"control", "option"}, "return", function()
  moveWindow(getCurrentWindow(), {
    column = 2.5,
    width = getScreen().w,
    height = getScreen().h,
  })
end)

hs.hotkey.bind({"control", "shift", "option"}, "return", function()
  local screen = getScreen()

  for _, window in ipairs(hs.window.allWindows()) do
    moveWindow(window, {
      column = 2.5,
      width = screen.w,
      height = screen.h,
    })
  end
end)

hs.hotkey.bind({"control", "option"}, "c", function()
  moveWindow(getCurrentWindow(), {
    column = 2.5,
    width = 960,
    height = 540,
  })
end)

hs.hotkey.bind({"control", "option"}, "m", function()
  moveWindow(getCurrentWindow(), {
    column = 2.5,
    width = 1920,
    height = 1080,
  })
end)

hs.hotkey.bind({"control", "shift", "option"}, "m", function()
  for _, window in ipairs(hs.window.allWindows()) do
    moveWindow(window, {
      column = 2.5,
      width = 1920,
      height = 1080,
    })
  end
end)

hs.hotkey.bind({"control", "option"}, "f", function()
  local screen = getScreen()
  local columnWidth = (screen.w - 1920) / 2

  local center = {
    x = (columnWidth / 2),
    y = screen.h / 2,
  }

  local size = {
    w = (columnWidth - 160),
    h = 1080,
  }

  updateWindow(getCurrentWindow(), {
    center = center,
    size = size,
  })
end)

hs.hotkey.bind({"control", "option"}, "l", function()
  local screen = getScreen()
  local columnWidth = (screen.w - 1920) / 2

  local center = {
    x = screen.w - (columnWidth / 2),
    y = screen.h / 2,
  }

  local size = {
    w = (columnWidth - 160),
    h = 1080,
  }

  updateWindow(getCurrentWindow(), {
    center = center,
    size = size,
  })
end)

hs.hotkey.bind({"control", "option"}, "n", function()
  hs.application.open('Octo')
end)

hs.hotkey.bind({"control", "option"}, "up", function()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.h = frame.h / 2

  window:setFrame(frame, 0)
end)

hs.hotkey.bind({"control", "option"}, "down", function()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.h = frame.h / 2
  frame.y = frame.y + frame.h

  window:setFrame(frame, 0)
end)

hs.hotkey.bind({"control", "shift", "option"}, "left", function()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.x = frame.x - blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind({"control", "shift", "option"}, "right", function()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.x = frame.x + blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind({"control", "shift", "option"}, "down", function()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.y = frame.y - blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind({"control", "shift", "option"}, "up", function()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.y = frame.y + blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind({"control", "option"}, "left", function()
  local screen = getScreen()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.w = frame.w - blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind({"control", "option"}, "right", function()
  local screen = getScreen()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.w = frame.w + blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind({"control", "option"}, "down", function()
  local screen = getScreen()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.h = frame.h - blockSize

  window:setFrame(frame, 0)
end)

hs.hotkey.bind({"control", "option"}, "up", function()
  local screen = getScreen()
  local window = getCurrentWindow()
  local frame = window:frame()

  frame.h = frame.h + blockSize

  window:setFrame(frame, 0)
end)
