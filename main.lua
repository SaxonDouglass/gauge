local sandbox = require "sandbox"

local gauge = {}
gauge.event = require "event"
gauge.entity = require "entity"

love.load = function ()
  sandbox.allow("gauge", gauge)
  sandbox.run_file("game/main.lua")
end

love.update = function (dt)
  gauge.entity.update(dt)
end

love.draw = function ()
  gauge.entity.draw()
end

love.mousepressed = function (x, y, button)

end

love.mousereleased = function (x, y, button)

end

love.keypressed = function (key, unicode)

end

love.keyreleased = function (key, unicode)

end

love.focus = function (f)

end

love.quit = function ()

end
