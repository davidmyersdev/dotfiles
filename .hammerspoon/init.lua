function screen()
  return hs.window.focusedWindow():screen():frame()
end

function window(details)
  local app = hs.window.focusedWindow()
  local frame = app:frame()

  frame.w = details.width
  frame.h = details.height

  local columns = details.columns or 4
  local rows = details.rows or 1
  local column = details.column or 2.5
  local row = details.row or 1

  local columnWidth = screen().w / columns
  local rowHeight = screen().h / rows

  frame.x = (columnWidth * column) - (columnWidth / 2) - (frame.w / 2)
  frame.y = (rowHeight * row) - (rowHeight / 2) - (frame.h / 2)

  hs.window.animationDuration = 0

  app:setFrame(frame)
end

hs.hotkey.bind({"control", "option"}, "1", function()
  window({ column = 1, width = 700, height = 1080 })
end)

hs.hotkey.bind({"control", "option"}, "2", function()
  window({ column = 2, width = 700, height = 1080 })
end)

hs.hotkey.bind({"control", "option"}, "3", function()
  window({ column = 3, width = 700, height = 1080 })
end)

hs.hotkey.bind({"control", "option"}, "4", function()
  window({ column = 4, width = 700, height = 1080 })
end)

hs.hotkey.bind({"control", "option"}, "m", function()
  window({ column = 2.5, width = 1920, height = 1080 })
end)

hs.hotkey.bind({"control", "option"}, "return", function()
  window({ column = 2.5, width = screen().w, height = screen().h })
end)

hs.hotkey.bind({"control", "option"}, "f", function()
  window({ column = 1, width = 760, height = 1080 })
end)

hs.hotkey.bind({"control", "option"}, "l", function()
  window({ column = 4, width = 760, height = 1080 })
end)
