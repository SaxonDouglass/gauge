
local context = gauge.input.context.new({active = true})
context.map = function (raw_input, map_input)
  if raw_input.keyboard.space then
    map_input.actions["jump"] = true
    raw_input.keyboard.space = nil
  end
  return raw_input, map_input
end


local dude = gauge.entity.new{
  position = { x = 200, y = 200 },
  velocity = { x = 100, y = 0 },
  acceleration = { x = 0, y = 0},
}
dude.lifetime = 0

local update = dude.update
dude.update = function (dt)
  update(dt)
  dude.lifetime = dude.lifetime + dt
end


gauge.event.subscribe("input",
  function (input)
    if input.actions.jump then
      -- do something
      dude.position({x = 100, y = 100})
    end
  end
)

