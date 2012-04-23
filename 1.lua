return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 13,
  height = 6,
  tilewidth = 128,
  tileheight = 128,
  properties = {},
  tilesets = {
    {
      name = "default",
      firstgid = 1,
      tilewidth = 128,
      tileheight = 128,
      spacing = 0,
      margin = 0,
      image = "Magic-Forest.png",
      imagewidth = 1408,
      imageheight = 1152,
      properties = {},
      tiles = {
        {
          id = 22,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 23,
          properties = {
            ["solid"] = "true"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 13,
      height = 6,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47,
        48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47,
        59, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58,
        70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 69,
        81, 21, 22, 0, 0, 20, 0, 0, 0, 21, 22, 0, 80,
        23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23
      }
    },
    {
      type = "objectgroup",
      name = "Object Layer 1",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "player_spawn",
          x = 512,
          y = 512,
          width = 128,
          height = 128,
          properties = {}
        },
        {
          name = "",
          type = "door",
          x = 1024,
          y = 512,
          width = 128,
          height = 128,
          properties = {}
        }
      }
    }
  }
}
