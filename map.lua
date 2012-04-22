-- map.lua
local entity = require "entity"

local M = {}

M.new = function(arg)
  local map = nil
  _,map = pcall(arg.data)
  local scale = arg.scale or 1
  local tilelayer = nil
  local objectgroup = nil

  local object = {}
  
  -- find layers
  for i,layer in ipairs(map.layers) do
    if layer.type == "tilelayer" then
      tilelayer = i
    elseif layer.type == "objectgroup" then
      objectgroup = i
    end
  end

  -- map properties
  for k,v in pairs(map.properties) do
    local property = assert(loadstring(v))
    _,map.properties[k] = pcall("return " .. property)
  end
  
  -- tileset properties
  for _,tileset in ipairs(map.tilesets) do
    local tiles = {}
    for _,tile in ipairs(tileset.tiles) do
      tiles[tile.id + 1] = tile.properties
    end
    tileset.tiles = tiles
  end
  
  -- tile data
  local data = {}
  for x=1,map.layers[1].width do
    data[x] = {}
    for y=1,map.layers[1].height do
      data[x][y] = map.layers[1].data[x + ((y - 1) * map.layers[tilelayer].width)]
    end
  end
  map.layers[1].data = data
  
  -- entities
  for _,object in ipairs(map.layers[objectgroup].objects) do
    local position = { x = object.x, y = object.y }
    object.position = position
    entity.new(object)
  end
  
  -- render info
  local tileset = {}
  tileset.image = love.graphics.newImage(map.tilesets[1].image)
  tileset.image:setFilter("nearest", "nearest")
  tileset.quads = {}
  local max_tiles = map.tilesets[tilelayer].tilewidth * map.tilesets[1].tileheight
  local tiles_x = map.tilesets[tilelayer].imagewidth / map.tilesets[1].tilewidth
  for i=1,max_tiles do
    tileset.quads[i] = love.graphics.newQuad(
      ((i - 1) % tiles_x) * map.tilesets[tilelayer].tilewidth,
      math.floor((i - 1) / tiles_x) * map.tilesets[tilelayer].tileheight,
      map.tilesets[tilelayer].tilewidth, map.tilesets[tilelayer].tileheight,
      map.tilesets[tilelayer].imagewidth,
      map.tilesets[tilelayer].imageheight
    )
  end
  local batch = love.graphics.newSpriteBatch(tileset.image,
    map.width * map.height)
  batch:clear()
  for x=1,map.layers[tilelayer].width do
    for y=1,map.layers[tilelayer].height do
      if map.layers[tilelayer].data[x][y] > 0 then
        batch:addq(tileset.quads[map.layers[tilelayer].data[x][y]],
          (x-1)*map.tilesets[tilelayer].tilewidth,
          (y-1)*map.tilesets[tilelayer].tilewidth)
      end
    end
  end

  -- getTileIndices(arg)
  object.getTileIndices = function (arg)
    return {x = math.ceil(arg.x / (map.tilesets[tilelayer].tilewidth * scale)),
            y = math.ceil(arg.y / (map.tilesets[tilelayer].tileheight * scale))}
  end

  -- getTileProperties(arg)
  object.getTileProperties = function (arg)
    if arg.x < 1 or arg.y < 1 or
        arg.x > map.layers[tilelayer].width or
        arg.y > map.layers[tilelayer].height then
      return { solid = true }
    end
    local tile_id = map.layers[tilelayer].data[arg.x][arg.y]
    local properties = {}
    if map.tilesets[tilelayer].tiles[tile_id] then
      for k,v in pairs(map.tilesets[tilelayer].tiles[tile_id]) do
        local f = assert(loadstring("return " .. v))
        _,properties[k] = pcall(f)
      end
    end
    return properties
  end
  
  -- getTileBounds(arg)
  object.getTileBounds = function (arg)
    return {
      top = (arg.y - 1) * (map.tilesets[tilelayer].tileheight * scale),
      left = (arg.x - 1) * (map.tilesets[tilelayer].tilewidth * scale),
      bottom = arg.y * (map.tilesets[tilelayer].tileheight * scale),
      right = arg.x * (map.tilesets[tilelayer].tilewidth * scale)
    }
  end
  
  -- render()
  object.render = function ()
    love.graphics.setColor({255,255,255})
    love.graphics.draw(batch,
      0, 0, -- x, y
      0, -- rotation
      scale, scale, -- scale_x, scale_y
      0, 0, -- origin_x, origin_y
      0, 0 -- shearing_x, shearing_y
    )
  end
  
  -- scale(s)
  object.scale = function(s)
    s = s or 1
    scale = scale * s
    return scale
  end
  
  return object
end

return M
