-- entity.lua
local M = {}

local manager = {
  entities = {}
}

M.new = function (arg)
  local self = {
    x = arg.x,
    y = arg.y
  }
  
  local object = {
    draw = function ()
      love.graphics.circle("fill", self.x, self.y, 16, 16)
    end,
    update = function (dt)
      
    end
  }
  table.insert(manager.entities, object)
  
  return object
end

M.draw = function ()
  for _,entity in ipairs(manager.entities) do
    entity.draw()
  end
end

M.update = function (dt)
  for _,entity in ipairs(manager.entities) do
    entity.update(dt)
  end
end

return M
