--! file: colors.lua

eye_colors_lookup  = {"green","blue","brown"}
eye_colors         = {}
eye_colors.green   = {25,163,55}
eye_colors.blue    = {52,152,219}
eye_colors.brown   = {119,81,58}

face_colors_lookup = {"light","medium","dark"}
face_colors        = {}
face_colors.light  = {241,194,125}
face_colors.medium = {154,124,90}
face_colors.dark   = {119,81,58}

hair_colors_lookup = {"blonde","brown","black","red","grey"}
hair_colors        = {}
hair_colors.blonde = {232,205,158}
hair_colors.brown  = {111,69,49}
hair_colors.black  = {40,25,12}
hair_colors.red    = {153,60,28}
hair_colors.grey   = {153,154,163}

function random_eye_color()
    local idx   = math.random(1,table.getn(eye_colors_lookup))
    local color = eye_colors_lookup[idx]
    return eye_colors[color]
end

function random_face_color()
    local idx   = math.random(1,table.getn(face_colors_lookup))
    local color = face_colors_lookup[idx]
    return face_colors[color]
end

function random_hair_color()
    local idx   = math.random(1,table.getn(hair_colors_lookup))
    local color = hair_colors_lookup[idx]
    return hair_colors[color]
end