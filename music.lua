-- music.lua

local M = {}

M.new = function(arg)
  local static = false
  if arg.static then static = true end
  local source = love.audio.newSource(arg.file, static)

  if arg.volume then source:setVolume(arg.volume) end
  if arg.loop then source:setLooping(arg.loop) end

  local object = {
    play = function ()
      love.audio.play(source)
    end,
    volume = function (v)
      source:setVolume(v)
    end
  }
  
  return object
end

return M
