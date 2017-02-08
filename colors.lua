--! file: colors.lua

eye_colors_lookup  = {"green","blue","brown"}
eye_colors         = {}
eye_colors.green   = {25,163,55}
eye_colors.blue    = {52,152,219}
eye_colors.brown   = {119,81,58}

skin_colors_lookup   = {"light","light2","light3","light4","medium","medium2","medium3","dark"}
skin_colors          = {}
skin_colors.light    = {241,194,125}
skin_colors.light2   = {248,223,178}
skin_colors.light3   = {235,199,161}
skin_colors.light4   = {208,155,105}
skin_colors.medium   = {154,124,90}
skin_colors.medium2  = {184,134,93}
skin_colors.medium3  = {163,111,68}
skin_colors.dark     = {119,81,58}

ticket_color         = {255,231,157}

suitcase_colors_lookup = {"black","brown","red","blue","green"}
suitcase_colors        = {}
suitcase_colors.black  = {50,53,60}
suitcase_colors.brown  = {124,80,43}
suitcase_colors.red    = {169,63,45}
suitcase_colors.blue   = {66,78,122}
suitcase_colors.green  = {87,133,96} 

hair_colors_lookup = {"blonde",
                      "brown",
                      "black",
                      "red",
                      "grey",
                      "off_black",
                      "darkest_brown",
                      "med_dark_brown",
                      "chestnut_brown",
                      "light_chestnut_brown",
                      "dark_golden_brown",
                      "light_golden_brown",
                      "dark_honey_blonde",
                      "bleached_blonde",
                      "light_ash_blonde",
                      "light_ash_brown",
                      "lightest_blonde",
                      "pale_golden_blonde",
                      "strawberry_blonde",
                      "light_auburn",
                      "dark_auburn",
                      "darkest_grey",
                      "medium_grey",
                      "light_grey",
                      "white_blonde",
                      "platinum_blonde",
                      "russet_red",
                      "terra_cotta",
                      "violet",
                      "shocking_red",
                      "blue_bun"
                      }
hair_colors                         = {}
hair_colors.blonde                  = {232,205,158}
hair_colors.brown                   = {111,69,49}
hair_colors.black                   = {40,25,12}
hair_colors.red                     = {153,60,28}
hair_colors["grey"]                 = {153,154,163}
hair_colors["off_black"]            = {44,34,43}
hair_colors["darkest_brown"]        = {59,48,42}
hair_colors["med_dark_brown"]       = {78,67,63}
hair_colors["chestnut_brown"]       = {80,68,68}
hair_colors["light_chestnut_brown"] = {106,78,66}
hair_colors["dark_golden_brown"]    = {85,72,56}
hair_colors["light_golden_brown"]   = {165,133,108}
hair_colors["dark_honey_blonde"]    = {184,151,120}
hair_colors["bleached_blonde"]      = {220,208,186}
hair_colors["light_ash_blonde"]     = {222,188,153}
hair_colors["light_ash_brown"]      = {151,121,97}
hair_colors["lightest_blonde"]      = {230,206,168}
hair_colors["pale_golden_blonde"]   = {229,200,168}
hair_colors["strawberry_blonde"]    = {165,107,70}
hair_colors["light_auburn"]         = {145,85,59}
hair_colors["dark_auburn"]          = {83,61,50}
hair_colors["darkest_grey"]         = {113,99,90}
hair_colors["medium_grey"]          = {183,166,158}
hair_colors["light_grey"]           = {214,196,194}
hair_colors["white_blonde"]         = {255,245,225}
hair_colors["platinum_blonde"]      = {203,191,177}
hair_colors["russet_red"]           = {141,74,66}
hair_colors["terra_cotta"]          = {182,82,58}
hair_colors["violet"]               = {149,128,211}
hair_colors["shocking_red"]         = {223,21,5}
hair_colors["blue_bun"]             = {92,173,178}

function random_eye_color()
    local idx   = math.random(1,table.getn(eye_colors_lookup))
    local color = eye_colors_lookup[idx]
    return eye_colors[color]
end

function random_skin_color()
    local idx   = math.random(1,table.getn(skin_colors_lookup))
    local color = skin_colors_lookup[idx]
    return skin_colors[color]
end

function random_hair_color()
    local idx   = math.random(1,table.getn(hair_colors_lookup))
    local color = hair_colors_lookup[idx]
    return hair_colors[color]
end

function random_suitcase_color()
    local idx   = math.random(1,table.getn(suitcase_colors_lookup))
    local color = suitcase_colors_lookup[idx]
    return suitcase_colors[color]
end

function random_reasonable_color()
    local r = math.random(0,200)
    local g = math.random(0,180)
    local b = math.random(0,150)
    return {r,g,b}
end

function darker_shade(color,amt)
  local r = math.max(0,color[1]-amt)
  local g = math.max(0,color[2]-amt)
  local b = math.max(0,color[2]-amt)
  return {r,g,b}
end

function lighter_shade(color,amt)
  local r = math.min(240,color[1]+amt)
  local g = math.min(240,color[2]+amt)
  local b = math.min(240,color[2]+amt)
  return {r,g,b}
end

-- Convenience function for setting colors with a table
function setColor(color)
  love.graphics.setColor(color[1],color[2],color[3])
end