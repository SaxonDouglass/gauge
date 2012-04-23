return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 16,
  height = 6,
  tilewidth = 128,
  tileheight = 128,
  properties = {
    ["parallax1"] = "Background_MagicForest_Layer1.png",
    ["parallax2"] = "Background_MagicForest_Layer2.png",
    ["parallax3"] = "Background_MagicForest_Layer3.png"
  },
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
          id = 4,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 5,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 6,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 7,
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
        },
        {
          id = 26,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 29,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 30,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 31,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 32,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 44,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 45,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 46,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 47,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 55,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 56,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 57,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 58,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 66,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 67,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 68,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 69,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 77,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 78,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 79,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 80,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 88,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 89,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 90,
          properties = {
            ["solid"] = "true"
          }
        },
        {
          id = 91,
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
      height = 6,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47,
        59, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58,
        70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 69,
        81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 80,
        92, 20, 29, 0, 21, 22, 0, 0, 0, 20, 0, 21, 22, 29, 0, 91,
        23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23
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
          x = 256,
          y = 512,
          width = 128,
          height = 128,
          properties = {}
        },
        {
          name = "",
          type = "grower",
          x = 1664,
          y = 512,
          width = 128,
          height = 128,
          properties = {}
        },
        {
          name = "",
          type = "door",
          x = 896,
          y = 384,
          width = 256,
          height = 256,
          properties = {}
        }
      }
    }
  }
}
