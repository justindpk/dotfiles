-- Function to convert hex to RGB
local function hex_to_rgb(hex)
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

-- Function to convert RGB to hex
local function rgb_to_hex(r, g, b)
    return string.format("#%02x%02x%02x", r, g, b)
end

-- Function to adjust brightness
local function adjust_brightness(hex, percent)
    local r, g, b = hex_to_rgb(hex)
    r = math.min(r * percent / 100, 255)
    g = math.min(g * percent / 100, 255)
    b = math.min(b * percent / 100, 255)
    return rgb_to_hex(r, g, b)
end

local Colors = {
  color0 = "#0B1219",
  color1 = "#B1525F",
  color2 = "#5C4F5D",
  color3 = "#583648",
  color4 = "#1A5569",
  color5 = "#B37888",
  color6 = "#3C7489",
  color7 = "#a9bcc3",
  color8 = "#192a3c",
  color9 = "#f6596f",
  color10 = "#815b84",
  color11 = "#7b3c5e",
  color12 = "#197291",
  color13 = "#fc88a7",
  color14 = "#419cbe",
  color15 = "#e0f9ff",
  dark0_hard = adjust_brightness("#0B1219", 75),
  dark0 = "#0B1219",
  dark0_soft = adjust_brightness("#0B1219", 95),
  dark1 = adjust_brightness("#0B1219", 100),
  dark2 = adjust_brightness("#0B1219", 150),
  dark3 = adjust_brightness("#192a3c", 100),
  dark4 = adjust_brightness("#e0f9ff", 100),
  light0_hard = adjust_brightness("#e0f9ff", 120),
  light0 = adjust_brightness("#a9bcc3", 110),
  light0_soft = adjust_brightness("#a9bcc3", 115),
  light1 = adjust_brightness("#a9bcc3", 105),
  light2 = adjust_brightness("#e0f9ff", 125),
  light3 = adjust_brightness("#e0f9ff", 130),
  light4 = adjust_brightness("#a9bcc3", 120),
  bright_red = "#f6596f",
  bright_green = "#815b84",
  bright_yellow = "#7b3c5e",
  bright_blue = "#197291",
  bright_purple = "#fc88a7",
  bright_aqua = "#419cbe",
  bright_orange = adjust_brightness("#f6596f", 120),
  neutral_red = "#B1525F",
  neutral_green = "#5C4F5D",
  neutral_yellow = "#583648",
  neutral_blue = "#1A5569",
  neutral_purple = "#B37888",
  neutral_aqua = "#3C7489",
  neutral_orange = adjust_brightness("#B1525F", 120),
  faded_red = adjust_brightness("#B1525F", 70),
  faded_green = adjust_brightness("#5C4F5D", 70),
  faded_yellow = adjust_brightness("#583648", 70),
  faded_blue = adjust_brightness("#1A5569", 70),
  faded_purple = adjust_brightness("#B37888", 70),
  faded_aqua = adjust_brightness("#3C7489", 70),
  faded_orange = adjust_brightness("#B1525F", 70),
  dark_red_hard = adjust_brightness("#B1525F", 60),
  dark_red = adjust_brightness("#B1525F", 80),
  dark_red_soft = adjust_brightness("#B1525F", 90),
  light_red_hard = adjust_brightness("#f6596f", 120),
  light_red = adjust_brightness("#f6596f", 110),
  light_red_soft = adjust_brightness("#f6596f", 105),
  dark_green_hard = adjust_brightness("#5C4F5D", 60),
  dark_green = adjust_brightness("#5C4F5D", 80),
  dark_green_soft = adjust_brightness("#5C4F5D", 90),
  light_green_hard = adjust_brightness("#815b84", 120),
  light_green = adjust_brightness("#815b84", 110),
  light_green_soft = adjust_brightness("#815b84", 105),
  dark_aqua_hard = adjust_brightness("#3C7489", 60),
  dark_aqua = adjust_brightness("#3C7489", 80),
  dark_aqua_soft = adjust_brightness("#3C7489", 90),
  light_aqua_hard = adjust_brightness("#419cbe", 120),
  light_aqua = adjust_brightness("#419cbe", 110),
  light_aqua_soft = adjust_brightness("#419cbe", 105),
  gray = "#a9bcc3",
  alpha = 0.9,
}

return Colors
