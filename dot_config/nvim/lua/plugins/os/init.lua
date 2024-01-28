local os = jit.os:lower()
return require('plugins.os.' .. os)
