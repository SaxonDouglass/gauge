-- event.lua
local M = {}

local manager = {
  events = {}
}

M.notify = function(event, data)
  if not manager.events[event] then return end
  for _,callback in ipairs(manager.events[event]) do
    callback(data)
  end
end

M.subscribe = function(event, callback)
  if not manager.events[event] then
    manager.events[event] = {}
  end
  table.insert(manager.events[event], callback)
end

return M
