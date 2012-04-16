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

M.update = function (dt)
  local map = {
    actions = {},
    states = {},
    ranges = {}
  }

  for _,context in ipairs(contexts) do
    if context.active() then
      map = context.map(raw, map)
    end
  end
  
  raw.key.pressed = {}
  raw.key.released = {}

  if next(map.actions) == nil and
      next(map.states) == nil and
      next(map.ranges) == nil then
    return nil
  end

  return map
end

return M
