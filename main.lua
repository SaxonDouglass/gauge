local event = require "event"
local sandbox = require "sandbox"

love.load = function()
  local t = function()
    print("hi!")
  end
  event.subscribe("test", t)

  sandbox.allow("event", event)
  sandbox.run_file("game/main.lua")
end
