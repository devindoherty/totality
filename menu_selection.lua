Menu = {}

function Menu:new(x, y, width, length, selections, params)
    local menu = {}
    setmetatable(menu, self)
    self.__index = self
    menu.x = x
    menu.y = y
    
    menu.selections = selections
    menu.selected = 1
    return menu
end

function Menu:update(action)
    if action == "menu_up" then
        if self.selected ~= 1 then
            self.selected = self.selected - 1
        end
    elseif action == "menu_down" then
        if self.selected ~= #self.selections then
            self.selected = self.selected + 1
        end
    elseif action == "menu_enter" then
        self.selections[self.selected].on_select()
    end
end

function Menu:render()
    local x = self.x
    local y = self.y

    for i = 1, #self.selections do
        if self.selected == i then
            love.graphics.print(">", x - 12, y)
            self.selections[i]:render(x, y)
        else
            self.selections[i]:render(x, y)
        end
        i = i + 1
        y = y + 12
    end
end


Selection = {}

function Selection:new(text, on_select)
    local selection = {}
    setmetatable(selection, self)
    self.__index = self
    
    selection.text = text
    selection.on_select = on_select
    return selection
end

function Selection:render(x, y)
    love.graphics.print(self.text, x, y)
end