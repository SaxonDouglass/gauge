-- input.lua

local M = {
  context = {}
}

local contexts = {}
local raw = {
  key = {
    down = {},
    pressed = {},
    released = {}
  },
  joystick = {
    down = {},
    pressed = {},
    released = {},
    axis = {}
  }
}

M.context.new = function (arg)
  local self = {
    active = arg.active or false,
    priority = arg.priority or 0
  }
  
  local object = {}
  
  object.active = function (active)
    self.active = active or self.active
    return self.active
  end
  
  object.priority = function (priority)
    self.priority = priority or self.priority
    return self.priority
  end

  object.map = function (raw_input, map_input)
    return raw_input, map_input
  end
  
  table.insert(contexts, object)
  table.sort(contexts,
    function (a, b)
      return a.priority() > b.priority()
    end
  )
  return object
end

M.keyPressed = function(key)
  raw.key.down[key] = true
  raw.key.pressed[key] = true
end

M.keyReleased = function(key)
  raw.key.down[key] = nil
  raw.key.released[key] = true
end

M.joystickPressed = function(joystick, button)
  raw.joystick.down[button] = true
  raw.joystick.pressed[button] = true
end

M.joystickReleased = function(joystick, button)
  raw.joystick.down[button] = nill
  raw.joystick.released[button] = true
end

M.update = function (dt)
  local map = {
    actions = {},
    states = {},
    ranges = {}
  }
  
  if love.joystick.getNumJoysticks() > 0 then
    for i=1,love.joystick.getNumAxes(1) do
      raw.joystick.axis[i] = love.joystick.getAxis(1, i)
    end
  end

  for _,context in ipairs(contexts) do
    if context.active() then
      map = context.map(raw, map)
    end
  end
  
  raw.key.pressed = {}
  raw.key.released = {}
  raw.joystick.pressed = {}
  raw.joystick.released = {}

  if next(map.actions) == nil and
      next(map.states) == nil and
      next(map.ranges) == nil then
    return nil
  end

  return map
end

return M
