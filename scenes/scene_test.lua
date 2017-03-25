--! file: scene_test.lua
require "actors.person"

SceneTest = Object:extend()

function SceneTest:new()
    self.people = self:regenPeople()
end

function SceneTest:regenPeople()
    local newpeople = {}
    for i=1,3 do
        for j=1,3 do
            local x = 300 + (i-1) * 300
            local y = 300 + (j-1) * 300
            local person = Person()
            person.x = x
            person.y = y
            table.insert(newpeople,person)
        end
    end
    return newpeople
end

function SceneTest:update(dt)
    for i=1,#self.people do
        local person = self.people[i]
        person:update(dt)
    end  
end

function SceneTest:checkKeyDown()

end 

function SceneTest:keypressed(key,scancode,isreapeat)
    if key == "space" then
        for i=1,#self.people do
            local person = self.people[i]

            local ani_idx   = math.random(1,table.getn(settings.test_animationStates))
            local ani_state = settings.test_animationStates[ani_idx]
            person:setAnimationState(ani_state)

            local dir_idx   = math.random(1,table.getn(settings.test_directions))
            local dir_state = settings.test_directions[dir_idx]
            person:setDirection(dir_state)
        end  
    end
end

function SceneTest:mousepressed(x, y, button, istouch)
    if button == 1 then
        self.people = self:regenPeople()
    end
end

function SceneTest:draw()
	love.graphics.setBackgroundColor( 255,255,255 )
    for i=1,#self.people do
        local person = self.people[i]
        person:draw()
    end
end