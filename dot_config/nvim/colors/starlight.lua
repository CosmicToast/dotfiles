-- [nfnl] Compiled from colors/starlight.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("mini.base16")
local mini_palette = _local_1_["mini_palette"]
local setup = _local_1_["setup"]
local starlight = {black = "#242424", brblack = "#616161", red = "#F62B5A", brred = "#FF4D51", green = "#47B413", brgreen = "#35D450", yellow = "#E3C401", bryellow = "#E9E836", blue = "#24ACD4", brblue = "#5DC5F8", magenta = "#F2AFFD", brmagenta = "#FEABF2", cyan = "#13C299", brcyan = "#24DFC4", white = "#E6E6E6", brwhite = "#FFFFFF"}
starlight.background = starlight.black
starlight.foreground = starlight.brwhite
local b16p = mini_palette(starlight.background, starlight.foreground, 87)
local palette = {base00 = b16p.base00, base01 = b16p.base01, base02 = b16p.base02, base03 = b16p.base03, base04 = b16p.base04, base05 = b16p.base05, base06 = b16p.base06, base07 = b16p.base07, base08 = starlight.yellow, base09 = starlight.brcyan, base0A = starlight.cyan, base0B = starlight.green, base0C = starlight.brred, base0D = starlight.blue, base0E = starlight.magenta, base0F = starlight.white}
setup({palette = palette})
vim.g.colors_name = "starlight"
return nil
