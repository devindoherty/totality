Menu = {}

function Menu:new(x, y, items)
    local menu = {}
    setmetatable(menu, self)
    self.__index = self
    menu.x = X
    menu.y = y
    
    menu.items = items
    menu.selection = 0
    return menu
end

function Menu:update(action)
    if action == "menu_up" then
        if self.selection ~= 0 then
            self.selection = self.selection - 1
        end
    elseif action == "menu_down" then
        if self.selection ~= #self.items then
            self.selection = self.selection + 1
        end
    elseif action == "menu_enter" or "menu_click" then
        self.menu.items[self.selection].on_select()
    end
end

function Menu:render()


end


Item = {}

function Item:new(text, on_select)
    local item = {}
    setmetatable(item, self)
    self.__index = self
    item.x = X
    item.y = y
    
    item.text = text
    item.on_select = on_select
    return item
end

