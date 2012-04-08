-- input.lua

local M = {
  context = {}
}

local manager = {
  contexts = {}
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
  
  table.insert(manager.contexts, object)
  table.sort(manager.contexts,
    function (a, b)
      return a.priority() > b.priority()
    end
  )
  return object
end

M.update = function (dt)
  local raw_input = {
    keyboard = {
      space = love.keyboard.isDown(" "),
      up = love.keyboard.isDown("up"),
      down = love.keyboard.isDown("down"),
      right = love.keyboard.isDown("right"),
      left = love.keyboard.isDown("left"),
    }
  }
  local map_input = {
    actions = {},
    states = {},
    ranges = {}
  }

  for _,context in ipairs(manager.contexts) do
    if context.active() then
      raw_input, map_input = context.map(raw_input, map_input)
    end
  end

  if next(map_input.actions) == nil and
      next(map_input.states) == nil and
      next(map_input.ranges) == nil then
    return nil
  end

  return map_input
end

return M
