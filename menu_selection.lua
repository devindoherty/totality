Menu = {}

function Menu:new(x, y, width, length, selections, params)
    local menu = {}
    setmetatable(menu, self)
    self.__index = self
    menu.x = x
    menu.y = y
    menu.width = width
    menu.length = length
    menu.background = params.background or false
    
    menu.spacing = params.spacing or 0
    menu.font = love.graphics.newFont(params.font)

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
    local old_font = love.graphics.getFont()

    love.graphics.setFont(self.font)


    if self.background then
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("fill", self.x - 12, self.y-6, self.width, self.length)
        love.graphics.setColor(1, 1, 0)
        love.graphics.rectangle("line", self.x - 12, self.y-6, self.width, self.length)
        love.graphics.setColor(1, 1, 1)
    end

    for i = 1, #self.selections do
        if self.selected == i then
            love.graphics.print(">", x - 12, y)
            self.selections[i]:render(x, y)
        else
            self.selections[i]:render(x, y)
        end
        i = i + 1
        y = y + 12 + self.spacing
    end
    love.graphics.setFont(old_font)
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