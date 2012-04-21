-- map.lua
local M = {}

M.new = function(arg)
  local map = nil
  _,map = pcall(arg.data)

  -- map properties
  for k,v in pairs(map.properties) do
    local property = assert(loadstring(v))
    _,map.properties[k] = pcall(property)
  end
  
  -- tileset properties
  for _,tileset in ipairs(map.tilesets) do
    local tiles = {}
    for _,tile in ipairs(tileset.tiles) do
      tiles[tile.id] = tile.properties
    end
    tileset.tiles = tiles
  end
  
  -- getTile(x, y)
  M.getTile = function (x, y)
    local index = x + (y * map.layers[0].width)
    local tile_id = map.layers[0].data[index]
    return map.properties[tile_id] || {}
  end
end

return M
