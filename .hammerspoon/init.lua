function center(frame)
  frame.x = (screen().w - frame.w) / 2
  frame.y = (screen().h - frame.h) / 2

  return frame
end

function clearAnimation()
  hs.window.animationDuration = 0
end

function left(frame)
  frame.x = ((screen().w / 4) - frame.w) / 2
  frame.y = (screen().h - frame.h) / 2

  return frame
end

function resize(frame, dimensions)
  frame.w = dimensions.w
  frame.h = dimensions.h

  return frame
end

function right(frame)
  frame.x = screen().w - ((screen().w / 8)) - (frame.w / 2)
  frame.y = (screen().h - frame.h) / 2

  return frame
end

function window(details)
  local app = hs.window.focusedWindow()
  local frame = app:frame()

  if details.dimensions ~= nil
  then
    frame = resize(frame, details.dimensions)
  end

  if details.position ~= nil
  then
    frame = _G[details.position](frame)
  end

  clearAnimation()
  app:setFrame(frame)
end

function screen()
  return hs.window.focusedWindow():screen():frame()
end

hs.hotkey.bind({"control", "option"}, "return", function()
  window({
    position = "center",
    dimensions = screen(),
  })
end)

hs.hotkey.bind({"control", "option"}, "f", function()
  window({
    position = "left",
    dimensions = {
      w = 760,
      h = 1080,
    },
  })
end)

hs.hotkey.bind({"control", "option"}, "l", function()
  window({
    position = "right",
    dimensions = {
      w = 760,
      h = 1080,
    },
  })
end)

hs.hotkey.bind({"control", "option"}, "m", function()
  window({
    position = "center",
    dimensions = {
      w = 1920,
      h = 1080,
    },
  })
end)
