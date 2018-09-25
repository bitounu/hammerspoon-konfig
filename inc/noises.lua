local application = require "hs.application"
local timer = require "hs.timer"
local alert = require "hs.alert"
local eventtap = require "hs.eventtap"
local popclick = require "hs.noises"

listener = nil
popclickListening = false
local scrollDownTimer = nil
function popclickHandler(evNum)
  alert.show(tostring(evNum))
  if evNum == 1 then
    scrollDownTimer = timer.doEvery(0.02, function()
      eventtap.scrollWheel({0,-10},{}, "pixel")
      end)
  elseif evNum == 2 then
    if scrollDownTimer then
      scrollDownTimer:stop()
      scrollDownTimer = nil
    end
  elseif evNum == 3 then
    if application.frontmostApplication():name() == "ReadKit" then
      eventtap.keyStroke({}, "j")
    else
      eventtap.scrollWheel({0,250},{}, "pixel")
    end
  end
end

function popclickPlayPause()
  if not popclickListening then
    listener:start()
    alert.show("listening")
  else
    listener:stop()
    alert.show("stopped listening")
  end
  popclickListening = not popclickListening
end

local function wrap(fn)
  return function(...)
    if fn then
      local ok, err = xpcall(fn, debug.traceback, ...)
      if not ok then hs.showerror(err) end
    end
  end
end

function popclickInit()
  popclickListening = false
  local fn = wrap(popclickHandler)
  local fn = popclickHandler
  listener = popclick.new(fn)
  hs.alert.show("Noise loaded")
end
