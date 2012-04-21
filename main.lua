-- main.lua

local sandbox = require "sandbox"

local gauge = {}
gauge.event = require "event"
gauge.entity = require "entity"
gauge.input = require "input"
gauge.state = require "state"
gauge.map = require "map"

love.load = function ()
  local map = gauge.map.new({
    data = loadfile("test_level.lua"),
    scale = 0.5
  })
  local game_state = gauge.state.new()
  local pause_state = gauge.state.new()
  game_state.render = function ()
    love.graphics.translate(game_state.camera.x, game_state.camera.y)
    map.render()
    gauge.entity.render()
  end
  game_state.update = function (dt)
    gauge.entity.update(dt)
  end
  game_state.map = map
  game_state.camera = {
    x = 0,
    y = 0
  }
  gauge.state.push(game_state)

  local context = gauge.input.context.new({active = true})
  context.map = function (raw, map)
    if raw.key.pressed.p then
      map.actions["pause"] = true
    end
    return map
  end

  local untrusted_code = assert(loadfile("game/main.lua"))
  local trusted_code = sandbox.new(untrusted_code, {gauge=gauge, print=print})
  trusted_code()
end

love.update = function (dt)
  local input = gauge.input.update(dt)
  if input then
    gauge.event.notify("input", input)
  end
  
  gauge.state.get().update(dt)
end

love.draw = function ()
  gauge.state.get().render()
end

love.keypressed = function (key, unicode)
  gauge.input.keyPressed(key)
end

love.keyreleased = function (key, unicode)
  gauge.input.keyReleased(key)
end

love.focus = function (f)

end

love.quit = function ()

end
