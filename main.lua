-- main.lua

local sandbox = require "sandbox"

local gauge = {}
gauge.event = require "event"
gauge.entity = require "entity"
gauge.input = require "input"

love.load = function ()
  sandbox.allow("gauge", gauge)
  sandbox.run_file("game/main.lua")
end

love.update = function (dt)
  local input = gauge.input.update(dt)
  if input then
    gauge.event.notify("input", input)
  end
  
  gauge.entity.update(dt)
end

love.draw = function ()
  gauge.entity.draw()
end

love.focus = function (f)

end

love.quit = function ()

end
