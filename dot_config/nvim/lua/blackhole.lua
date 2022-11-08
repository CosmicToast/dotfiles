-- black hole object
-- you can access and call and set things however you want
-- it will never do anything

local f = function (self) return self end
return setmetatable({}, {__call = f, __index = f, __newindex = f})
