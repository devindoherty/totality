Menu = {}

function Menu:new(x, y, selections)
    local menu = {}
    setmetatable(menu, self)
    self.__index = self
    menu.x = X
    menu.y = y
    
    menu.selections = selections
    menu.selected = 0
    return menu
end

function Menu:update(action)
    if action == "menu_up" then
        if self.selected ~= 0 then
            self.selected = self.selected - 1
        end
    elseif action == "menu_down" then
        if self.selected ~= #self.items then
            self.selected = self.selected + 1
        end
    elseif action == "menu_enter" or "menu_click" then
        self.menu.selections[self.selected].on_select()
    end
end

function Menu:render()


end


Selection = {}

function Selection:new(text, on_select)
    local selection = {}
    setmetatable(selection, self)
    self.__index = self
    selection.x = X
    selection.y = y
    
    selection.text = text
    selection.on_select = on_select
    return selection
end

