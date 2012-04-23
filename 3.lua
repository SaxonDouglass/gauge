return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 16,
  height = 10,
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
          id = 0,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 1,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 2,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 3,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 13,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 14,
          properties = {
            ["solid"] = "true"
          }
        },
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
        },
        {
          id = 24,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 25,
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
      width = 16,
      height = 10,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47,
        48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47,
        48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47,
        48, 0, 0, 0, 0, 0, 0, 0, 34, 35, 0, 0, 56, 23, 23, 47,
        48, 0, 0, 0, 34, 35, 0, 0, 1, 2, 0, 0, 0, 0, 0, 58,
        48, 0, 0, 0, 1, 2, 0, 0, 12, 13, 0, 0, 0, 0, 0, 69,
        59, 36, 37, 0, 12, 13, 0, 0, 12, 13, 0, 0, 0, 0, 0, 80,
        70, 3, 4, 0, 12, 13, 0, 0, 12, 13, 0, 0, 0, 56, 23, 23,
        81, 14, 15, 0, 12, 13, 0, 0, 12, 13, 0, 0, 0, 0, 27, 0,
        23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 46, 24
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
          x = 1280,
          y = 1024,
          width = 128,
          height = 128,
          properties = {}
        },
        {
          name = "",
          type = "grower",
          x = 1664,
          y = 256,
          width = 128,
          height = 128,
          properties = {}
        },
        {
          name = "",
          type = "door",
          x = 1664,
          y = 640,
          width = 256,
          height = 256,
          properties = {}
        }
      }
    }
  }
}
