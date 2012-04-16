-- sandbox.lua

local M = {}

M.new = function (f, env)
  return function ()
    setfenv(f, env)
    return pcall(f)
  end
end

return M
