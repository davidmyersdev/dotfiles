function getCurrentWindow()
  return hs.window.focusedWindow()
end

function getScreen()
  return hs.window.focusedWindow():screen():frame()
end

function moveWindow(window, details)
  local frame = window:frame()

  frame.w = details.width
  frame.h = details.height

  local columns = details.columns or 4
  local rows = details.rows or 1
  local column = details.column or 2.5
  local row = details.row or 1

  local columnWidth = getScreen().w / columns
  local rowHeight = getScreen().h / rows

  frame.x = (columnWidth * column) - (columnWidth / 2) - (frame.w / 2)
  frame.y = (rowHeight * row) - (rowHeight / 2) - (frame.h / 2)

  hs.window.animationDuration = 0

  window:setFrame(frame)
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

hs.hotkey.bind({"control", "shift", "option"}, "left", function()
  moveWindow(getCurrentWindow(), {
    column = 1,
    columns = 2,
    width = (getScreen().w / 2),
    height = getScreen().h,
  })
end)

hs.hotkey.bind({"control", "shift", "option"}, "right", function()
  moveWindow(getCurrentWindow(), {
    column = 2,
    columns = 2,
    width = (getScreen().w / 2),
    height = getScreen().h,
  })
end)

hs.hotkey.bind({"control", "option"}, "left", function()
  moveWindow(getCurrentWindow(), {
    column = 2,
    width = (getScreen().w / 4),
    height = 1080,
  })
end)

hs.hotkey.bind({"control", "option"}, "right", function()
  moveWindow(getCurrentWindow(), {
    column = 3,
    width = (getScreen().w / 4),
    height = 1080,
  })
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
  moveWindow(getCurrentWindow(), {
    column = 1,
    width = 760,
    height = 1080,
  })
end)

hs.hotkey.bind({"control", "option"}, "l", function()
  moveWindow(getCurrentWindow(), {
    column = 4,
    width = 760,
    height = 1080,
  })
end)
