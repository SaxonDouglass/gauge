
local context = gauge.input.context.new({active = true})
context.map = function (raw_in, map_in)
  if raw_in.key.down[" "] then
    map_in.actions["jump"] = true
  end
  return map_in
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

