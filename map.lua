local M = {}

M.new = function(arg)
    mapfile = love.filesystem.load(levels[level])()
    
    map = mapfile.layers[1]
    
    map.colour = loadstring("return " .. mapfile.properties.colour)()

    for x=1,map.width do
        map[x] = {}
        for y=1,map.height do
            map[x][y] = map.data[x + (map.width * (y - 1))]
        end
    end
    
    map.batch = love.graphics.newSpriteBatch(tileset.image,
        map.width * map.height)
    
    map.batch:clear()
    for x=1,map.width do
        for y=1,map.height do
            if mapGetProp("player", x, y) then
                map[x][y] = 1
                player.x = x
                player.y = y
                player.frame = 1
            elseif mapGetProp("enemy", x, y) then
                map[x][y] = 1
                enemies.new(x, y)
            elseif mapGetProp("pip", x, y) then
                map[x][y] = 1
                pips.new(x, y)
            end
        
            map.batch:addq(tileset.quads[map[x][y]],
                (x-1)*tileset.size, (y-1)*tileset.size)
        end
    end
end