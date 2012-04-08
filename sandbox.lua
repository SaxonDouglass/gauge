-- sandbox.lua
local M = {}

local env = {} -- add functions you know are safe here

M.allow = function(key, value)
  env[key] = value
end

M.run_file = function(untrusted_file)
  local f = assert(io.open(untrusted_file, "r"))
  local untrusted_code = f:read("*all")
  f:close()
  
  return M.run_string(untrusted_code)
end

M.run_string = function(untrusted_code)
  if untrusted_code:byte(1) == 27 then return nil,
    "binary bytecode prohibited" end
  local untrusted_function, message = loadstring(untrusted_code)
  if not untrusted_function then return nil, message end
  setfenv(untrusted_function, env)
  return pcall(untrusted_function)
end

return M
