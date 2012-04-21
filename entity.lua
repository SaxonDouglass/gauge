-- entity.lua
local state = require "state"
local M = {}

local manager = {
  entities = {}
}

M.new = function (arg)
  local self = arg
  
  self.width = self.width or 30
  self.height = self.height or 30
  
  local collide = function (map, x1, y1, x2, y2)
    local i1 = map.getTileIndices({x = x1, y = y1})
    local i2 = map.getTileIndices({x = x2, y = y2})
    for x=i1.x,i2.x do
      for y=i1.y,i2.y do
        if map.getTileProperties({x = x, y = y}).solid == true then
          return true
        end
      end
    end
    return false
  end
  
  local object = {}
  object.falling = true
  object.render = function ()
    love.graphics.setColor({0,255,0})
    love.graphics.rectangle("fill", self.position.x, self.position.y, self.width, self.height)
    --love.graphics.circle("fill", self.position.x + self.width/2, self.position.y + self.height/2, self.width/2, 16)
  end
  object.update = function (dt)
    self.velocity.x = self.velocity.x + dt*self.acceleration.x
    self.velocity.y = self.velocity.y + dt*self.acceleration.y
    self.position.x = self.position.x + dt*self.velocity.x
    self.position.y = self.position.y + dt*self.velocity.y
    local map = state.get().map
    if map then
      -- Vertical collisions (slightly dodgy stuff here)
      if self.velocity.y < 0 then
        if collide(map, self.position.x + 0.1*self.width, self.position.y, self.position.x + 0.9*self.width, self.position.y) then
          self.position.y = map.getTileBounds(map.getTileIndices(self.position)).bottom + 0.01*self.height
          self.velocity.y = 0
        end
      elseif self.velocity.y > 0 then
        if collide(map, self.position.x + 0.1*self.width, self.position.y + self.height, self.position.x + 0.9*self.width, self.position.y + self.height) then
          self.position.y = map.getTileBounds(map.getTileIndices({x = self.position.x, y = self.position.y + self.height})).top - self.height
          self.velocity.y = 0
          object.falling = false
        else
          object.falling = true
        end
      end
      
      -- Horizontal collisions
      if self.velocity.x < 0 then
        if collide(map, self.position.x, self.position.y, self.position.x, self.position.y + self.height) then
          self.position.x = map.getTileBounds(map.getTileIndices(self.position)).right
          --self.velocity.x = 0
        end
      elseif self.velocity.x > 0 then
        if collide(map, self.position.x + self.width, self.position.y, self.position.x + self.width, self.position.y + self.height) then
          self.position.x = map.getTileBounds(map.getTileIndices({x = self.position.x + self.width, y = self.position.y})).left - self.width
          --self.velocity.x = 0
        end
      end
    end
  end
  object.position = function (arg)
    arg = arg or {}
    self.position.x = arg.x or self.position.x
    self.position.y = arg.y or self.position.y
    return self.position
  end
  object.velocity = function (arg)
    arg = arg or {}
    self.velocity.x = arg.x or self.velocity.x
    self.velocity.y = arg.y or self.velocity.y
    return self.velocity
  end
  object.acceleration = function (arg)
    arg = arg or {}
    self.acceleration.x = arg.x or self.acceleration.x
    self.acceleration.y = arg.y or self.acceleration.y
    return self.acceleration
  end
  object.bearing = function ()
    local hypotenuse = math.sqrt( math.pow(self.velocity.x,2) + math.pow(self.velocity.y,2) )
    return math.acos( self.velocity.x/hypotenuse )
  end
  table.insert(manager.entities, object)
  
  return object
end

M.render = function ()
  for _,entity in ipairs(manager.entities) do
    entity.render()
  end
end

M.update = function (dt)
  for _,entity in ipairs(manager.entities) do
    entity.update(dt)
  end
end





return M
