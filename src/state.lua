local State = {}
State.__index = State

function State:new(initial)
    local this = { current = initial or "menu" }
    setmetatable(this, self)
    return this
end

function State:set(state)
    self.current = state
end

function State:is(state)
    return self.current == state
end

return State
