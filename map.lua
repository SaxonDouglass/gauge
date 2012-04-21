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
  
  -- tile data
  local data = {}
  for x=1,map.layers[1].width do
    data[x] = {}
    for y=1,map.layers[1].height do
      data[x][y] = map.layers[1].data[x + ((y - 1) * map.layers[1].width)]
    end
  end
  map.layers[1].data = data
  
  -- render info
  local tileset = {}
  tileset.image = love.graphics.newImage(map.tilesets[1].image)
  tileset.image:setFilter("nearest", "nearest")
  tileset.quads = {}
  local max_tiles = map.tilesets[1].tilewidth * map.tilesets[1].tileheight
  local tiles_x = map.tilesets[1].imagewidth / map.tilesets[1].tilewidth
  for i=1,max_tiles do
    tileset.quads[i] = love.graphics.newQuad(
      ((i - 1) % tiles_x) * map.tilesets[1].tilewidth,
      math.floor((i - 1) / tiles_x) * map.tilesets[1].tileheight,
      map.tilesets[1].tilewidth, map.tilesets[1].tileheight, map.tilesets[1].imagewidth,
      map.tilesets[1].imageheight
    )
  end
  local batch = love.graphics.newSpriteBatch(tileset.image,
    map.width * map.height)
  batch:clear()
  for x=1,map.layers[1].width do
    for y=1,map.layers[1].height do
      if map.layers[1].data[x][y] > 0 then
        batch:addq(tileset.quads[map.layers[1].data[x][y]],
          (x-1)*map.tilesets[1].tilewidth, (y-1)*map.tilesets[1].tilewidth)
      end
    end
  end

  -- getTile(x, y)
  object.getTile = function (x, y)
    local tile_id = map.layers[1].data[x][y]
    return map.tilesets[1].tile[tile_id] or {}
  end
  
  -- worldToLocal(x, y)
  object.worldToLocal = function (x, y)
    return x / (map.tilesets[1].tilewidth * scale),
      y / (map.tilesets[1].tileheight * scale)
  end

  -- localToWorld(x, y)
  object.localToWorld = function (x, y)
    return x * (map.tilesets[1].tilewidth * scale),
      y * (map.tilesets[1].tileheight * scale)
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
