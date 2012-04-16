-- state.lua

local M = {}

local stack = {}

M.get = function ()
  return stack[#stack]
end

M.new = function (arg)
  return {
    render = function () end,
    update = function () end
  }
end

M.pop = function ()
  return table.remove(stack)
end

M.push = function (state)
  table.insert(stack, state)
end

return M
