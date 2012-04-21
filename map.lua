-- map.lua
local M = {}

M.new = function(arg)
  local map = nil
  _,map = pcall(arg.data)
  local scale = arg.scale or 1

  local object = {}

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
  
  -- render info
  local tileset = {}
  tileset.image = love.graphics.newImage(map.tilesets[1].image)
  tileset.image:setFilter("nearest", "nearest")
  tileset.quads = {}
  local max_tiles = map.tilesets[1].tilewidth * map.tilesets[1].tileheight
  for i=1,max_tiles do
    tileset.quads[i] = love.graphics.newQuad(
      ((i - 1) % map.tilesets[1].tilewidth) * scale,
      math.floor((i - 1) / map.tilesets[1].tilewidth) * scale,
      scale, scale, map.tilesets[1].imagewidth,
      map.tilesets[1].imageheight
    )
  end
  local batch = love.graphics.newSpriteBatch(map.tilesets[1].image,
    map.width * map.height)
  batch:clear()
  for x=1,map.width do
      for y=1,map.height do
          batch:addq(tileset.quads[map[x][y]],
              (x-1)*tileset.size, (y-1)*tileset.size)
      end
  end

  -- getTile(x, y)
  object.getTile = function (x, y)
    local index = x + (y * map.layers[1].width)
    local tile_id = map.layers[1].data[index]
    return map.tilesets[1].tile[tile_id] or {}
  end
  
  -- render()
  object.render = function ()
    love.graphics.draw(batch,
      0, 0, -- x, y
      0, -- rotation
      scale, scale, -- scale_x, scale_y
      0, 0, -- origin_x, origin_y
      0, 0 -- shearing_x, shearing_y
    )
  end
  
  return object
end

return M
