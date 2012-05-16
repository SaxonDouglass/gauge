-- main.lua

local sandbox = require "sandbox"

local gauge = {}
gauge.event = require "event"
gauge.entity = require "entity"
gauge.input = require "input"
gauge.state = require "state"
gauge.map = require "map"
gauge.music = require "music"

local tween = require "tween"

love.load = function ()
  local context = gauge.input.context.new({active = true})
  context.map = function (raw_in, map_in)
    if raw_in.key.pressed["escape"] then
      map_in.actions["quit"] = true
    end
    return map_in
  end
  gauge.event.subscribe("input",
    function (input)
      if input.actions.quit then
        os.exit(0)
      end
    end
  )

  local modes = love.graphics.getModes()
  table.sort(modes, function(a, b)
    return a.width*a.height > b.width*b.height
  end)
  native_mode = modes[1]
  love.graphics.setMode(native_mode.width, native_mode.height, true)

  local game_state = gauge.state.new()
  gauge.event.subscribe("loadMap", function (arg)
    if love.filesystem.exists(arg.file) then
      game_state.map = gauge.map.new({
        data = love.filesystem.load(arg.file)
      })
      gauge.event.notify("input", {
        actions = {reset = true},
        states = {},
        ranges = {}
      })
    else
      gauge.event.notify("input", {
        actions = {quit = true},
        states = {},
        ranges = {}
      })
    end
  end)
  game_state.render = function ()
    love.graphics.push()
    --love.graphics.scale(game_state.camera.scale)
    if game_state.map then
      game_state.map.render()
    end
    love.graphics.translate(
      (love.graphics.getWidth() / 2) - game_state.camera.position.x,
      (love.graphics.getHeight() / 2) - game_state.camera.position.y)
    gauge.entity.render()
    love.graphics.pop()
  end
  game_state.update = function (dt)
    gauge.entity.update(dt)
  end
  game_state.map = nil
  game_state.camera = {
    position = {
      x = 0,
      y = 0
    },
    speed = 0.05,
    max_distance = 150,
    scale = 1,
    zoom = false
  }
  gauge.state.push(game_state)

  local untrusted_code = assert(love.filesystem.load("game/main.lua"))
  local trusted_code = sandbox.new(untrusted_code, {gauge=gauge, math=math, print=print, tween=tween, love=love})
  pcall(trusted_code)
end

love.update = function (dt)
  if dt > 1/60 then dt = 1/60 end

  local input = gauge.input.update(dt)
  if input then
    gauge.event.notify("input", input)
  end
  
  if dt > 0 then
    tween.update(dt)
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

love.joystickpressed = function (joystick, button)
  gauge.input.joystickPressed(joystick, button)
end

love.joystickreleased = function (joystick, button)
  gauge.input.joystickReleased(joystick, button)
end

love.focus = function (f)

end

love.quit = function ()

end
