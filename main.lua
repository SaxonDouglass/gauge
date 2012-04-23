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
  local native_mode = modes[1]
  love.graphics.setMode(native_mode.width, native_mode.height, true)

  local game_state = gauge.state.new()
  local pause_state = gauge.state.new()
  gauge.event.subscribe("loadMap", function (arg)
    if love.filesystem.exists(arg.file) then
      game_state.map = gauge.map.new({
        data = loadfile(arg.file)
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
    love.graphics.translate(
      (love.graphics.getWidth() / 2) - game_state.camera.position.x,
      (love.graphics.getHeight() / 2) - game_state.camera.position.y)
    if game_state.map then
      game_state.map.render()
    end
    gauge.entity.render()
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
    speed = 0.02,
    max_distance = 150,
    scale = 1,
    zoom = false
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
  local trusted_code = sandbox.new(untrusted_code, {gauge=gauge, math=math, print=print, tween=tween})
  trusted_code()
end

love.update = function (dt)
  if dt > 1/60 then dt = 1/60 end

  local input = gauge.input.update(dt)
  if input then
    gauge.event.notify("input", input)
  end
  
  tween.update(dt)
  gauge.state.get().update(dt)
end

love.draw = function ()
  love.graphics.scale(gauge.state.get().camera.scale)
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
