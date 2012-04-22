-- music.lua

local M = {}

M.new = function(arg)
  local source = love.audio.newSource(arg.file)

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
