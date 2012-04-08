-- entity.lua
local M = {}

local manager = {
  entities = {}
}

M.new = function (arg)
  local self = arg
  
  local object = {
    draw = function ()
      love.graphics.circle("fill", self.position.x, self.position.y, 16, 16)
    end,
    update = function (dt)
      self.velocity.x = self.velocity.x + dt*self.acceleration.x
      self.velocity.y = self.velocity.y + dt*self.acceleration.y
      self.position.x = self.position.x + dt*self.velocity.x
      self.position.y = self.position.y + dt*self.velocity.y
    end,
    position = function (arg)
      self.position.x = arg.x or self.position.x
      self.position.y = arg.y or self.position.y
      return self.position
    end,
    velocity = function (arg)
      self.velocity.x = arg.x or self.velocity.x
      self.velocity.y = arg.y or self.velocity.y
      return self.velocity
    end,
    acceleration = function (arg)
      self.acceleration.x = arg.x or self.acceleration.x
      self.acceleration.y = arg.y or self.acceleration.y
      return self.acceleration
    end,
    bearing = function ()
      local hypotenuse = math.sqrt( math.pow(self.velocity.x,2) + math.pow(self.velocity.y,2) )
      return math.acos( self.velocity.x/hypotenuse )
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
