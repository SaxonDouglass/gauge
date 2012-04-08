
local context = gauge.input.context.new({active = true})
context.map = function (raw_input, map_input)
  if raw_input.keyboard.space then
    map_input.actions["jump"] = true
    raw_input.keyboard.space = nil
  end
  return raw_input, map_input
end

gauge.event.subscribe("input",
  function (input)
    if input.actions.jump then
      -- do something
    end
  end
)
