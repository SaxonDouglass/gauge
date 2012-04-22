-- entity.lua
local state = require "state"
local event = require "event"
local M = {}

local manager = {
  entities = {},
  types = {},
  deleteQueue = {},
}

M.scale = 1;

M.new = function (arg)
  -- Default properties
  local self = {
    width = 30,
    height = 30,
    position = {x = 0, y = 0},
    velocity = {x = 0, y = 0},
    acceleration = {x = 0, y = 0},
    scaled = true
  }
  
  -- Add type-specific properties and defaults
  if arg.type then
    local type = manager.types[arg.type]
    if type then
      for k,v in pairs(type) do
        self[k] = v
      end
    end
  end
  
  -- Instance-specific default overrides
  for k,v in pairs(arg) do
    self[k] = v
  end
  
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
  object.delete = false
  if self.render then
    object.render = function () 
      self.render(object, self)
    end
  else
    object.render = function ()
      love.graphics.setColor({0,255,0})
      local position = object.position()
      love.graphics.rectangle("fill", position.x, position.y, object.width(), object.height())
    end
  end
  object.update = function (dt)
    self.velocity.x = self.velocity.x + dt*self.acceleration.x
    self.velocity.y = self.velocity.y + dt*self.acceleration.y
    self.position.x = self.position.x + dt*self.velocity.x
    self.position.y = self.position.y + dt*self.velocity.y
    local map = state.get().map
    local position = object.position()
    local width = object.width()
    local height = object.height()
    if map then
      -- Vertical collisions (slightly dodgy stuff here)
      if self.velocity.y < 0 then
        if collide(map, position.x + 0.1*width, position.y, position.x + 0.9*width, position.y) then
          self.position.y = (map.getTileBounds(map.getTileIndices(position)).bottom + 0.01*height)
          --if self.scaled then
            self.position.y = self.position.y/M.scale
          --end
          self.velocity.y = 0
          if collide(map, position.x + 0.1*width, position.y + height, position.x + 0.9*width, position.y + height) then
            event.notify("entityStuck",object)
          end
        end
      elseif self.velocity.y > 0 then
        if collide(map, position.x + 0.1*width, position.y + height, position.x + 0.9*width, position.y + height) then
          self.position.y = (map.getTileBounds(map.getTileIndices({x = position.x, y = position.y + height})).top - height)
          --if self.scaled then
            self.position.y = self.position.y/M.scale
          --end
          self.velocity.y = 0
          object.falling = false
          if collide(map, position.x + 0.1*width, position.y, position.x + 0.9*width, position.y) then
            event.notify("entityStuck",object)
          end
        else
          object.falling = true
        end
      end
      
      position = object.position()
      -- Horizontal collisions
      if self.velocity.x < 0 then
        if collide(map, position.x, position.y, position.x, position.y + height) then
          self.position.x = (map.getTileBounds(map.getTileIndices(position)).right)
          --if self.scaled then
            self.position.x = self.position.x/M.scale
          --end
          --velocity.x = 0
          if collide(map, position.x + width, position.y, position.x + width, position.y + height) then
            event.notify("entityStuck",object)
          end
        end
      elseif self.velocity.x > 0 then
        if collide(map, position.x + width, position.y, position.x + width, position.y + height) then
          self.position.x = (map.getTileBounds(map.getTileIndices({x = position.x + width, y = position.y})).left - width)
          --if self.scaled then
            self.position.x = self.position.x/M.scale
          --end
          --self.velocity.x = 0
          if collide(map, position.x, position.y, position.x, position.y + height) then
            event.notify("entityStuck",object)
          end
        end
      end
    end
    
    if self.update then
      self.update(object, self, dt)
    end
  end
  object.type = function ()
    return self.type
  end
  -- object.scale = function (s)
  --   self.scale = self.scale*s
  --   self.position.x = self.position.x*s
  --   self.position.y = self.position.y*s
  --   self.velocity.x = self.velocity.x*s
  --   self.velocity.y = self.velocity.y*s
  --   self.acceleration.x = self.acceleration.x*s
  --   self.acceleration.y = self.acceleration.y*s
  --   self.width = self.width*s
  --   self.height = self.height*s
  -- end
  object.position = function (arg)
    arg = arg or {} 
    if arg.x then
      --if self.scaled then
        self.position.x = arg.x/M.scale
      --else
      --  self.position.x = arg.x
      --end
    end
    if arg.y then
      --if self.scaled then
        self.position.y = arg.y/M.scale
      --else
      --  self.position.y = arg.y
      --end
    end
    --if self.scaled then
      return {x=self.position.x*M.scale,y=self.position.y*M.scale}
    --else
    --  return self.position
    --end
  end
  object.velocity = function (arg)
    arg = arg or {}
    if arg.x then
      --if self.scaled then
        self.velocity.x = arg.x/M.scale
      --else
      --  self.velocity.x = arg.x
      --end
    end
    if arg.y then
      --if self.scaled then
        self.velocity.y = arg.y/M.scale
      --else
      --  self.velocity.y = arg.y
      --end
    end
    --if self.scaled then
      return {x=self.velocity.x*M.scale,y=self.velocity.y*M.scale}
    --else
    --  return self.velocity
    --end
  end
  object.acceleration = function (arg)
    arg = arg or {}
    if arg.x then
      --if self.scaled then
        self.acceleration.x = arg.x/M.scale
      --else
      --  self.acceleration.x = arg.x
      --end
    end
    if arg.y then
      --if self.scaled then
        self.acceleration.y = arg.y/M.scale
      --else
      --  self.acceleration.y = arg.y
      --end
    end
    --if self.scaled then
      return {x=self.acceleration.x*M.scale,y=self.acceleration.y*M.scale}
    --else
    --  return self.acceleration
    --end
  end
  object.bearing = function ()
    local hypotenuse = math.sqrt( math.pow(self.velocity.x,2) + math.pow(self.velocity.y,2) )
    return math.acos( self.velocity.x/hypotenuse )
  end
  object.height = function ()
    if self.scaled then
      return self.height*M.scale
    else
      return self.height
    end
  end
  object.width = function ()
    if self.scaled then
      return self.width*M.scale
    else
      return self.width
    end
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
  for i = 1,#manager.entities do
    for j = i,#manager.entities do
      e1 = manager.entities[i]
      l1 = e1.position().x
      r1 = e1.position().x + e1.width()
      t1 = e1.position().y
      b1 = e1.position().y + e1.height()
      e2 = manager.entities[j]
      l2 = e2.position().x
      r2 = e2.position().x + e2.width()
      t2 = e2.position().y
      b2 = e2.position().y + e2.height()
      if r1 >= l2 and r2 >= l1 and b1 >= t2 and b2 >= t1 then
        event.notify("entityCollision",{e1,e2})
        event.notify("entityCollision",{e2,e1})
      end
    end
  end
  
  for i,entity in ipairs(manager.entities) do
    if entity.delete then
      table.remove(manager.entities,i)
    end
  end
end

M.registerType = function(name, spec)
  manager.types[name] = spec
end

-- M.scale = function(s)
--   for _,entity in ipairs(manager.entities) do
--     entity.scale(s)
--   end
-- end

M.getList = function(filter)
  result = {}
  for _,entity in ipairs(manager.entities) do
    local match = true
    for k,v in pairs(filter) do
      if not entity[k] == v then
        match = false
        break
      end
    end
    if match then
      table.insert(result, entity)
    end
  end
  return result
end

M.registerType("player_spawn", {
  render = function (object, self)
  end
})
M.registerType("tinyworlder", {
  render = function (object, self)
    love.graphics.setColor({255,0,0})
    local position = object.position()
    local width = object.width()
    local height = object.height()
    love.graphics.rectangle("fill", position.x, position.y, width, height)
  end
})
M.registerType("grower", {
  render = function (object, self)
    local position = object.position()
    local width = object.width()
    local height = object.height()
    love.graphics.setColor({255,255,0})
    love.graphics.circle("fill", position.x+width/2, position.y+height/2, width/2, 16)
  end
})
M.registerType("shrinker", {
  render = function (object, self)
    local position = object.position()
    local width = object.width()
    local height = object.height()
    love.graphics.setColor({0,255,255})
    love.graphics.circle("fill", position.x+width/2, position.y+height/2, width/2, 16)
  end
})

return M
