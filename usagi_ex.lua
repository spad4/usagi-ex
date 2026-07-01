
---@class UsagiEX.text
local text_ex = {
    _text = "",
    _x = 0,
    _y = 0,
    _color = gfx.COLOR_TRUE_WHITE,
    _scale = 1,
    _rotation = 0,
    _alpha = 1
}

--- Sets the text's transparency. 
--- @param alpha      integer alpha value; 0 = transparent, 1 = opaque
function text_ex:alpha(alpha)
    self._alpha = alpha
    return self
end

--- Overrides the text's color.
--- @param color      integer a gfx.COLOR_* constant; optional, defaults to gfx.COLOR_TRUE_WHITE (0)
function text_ex:color(color)
    self._color = color
    return self
end

--- Rotates the text.
--- @param rotation      number amount to rotate, in radians. use math.rad(deg) to convert from degrees
function text_ex:rotate(rotation)
    self._rotation = rotation
    return self
end

--- Scales the text. Use integers for best results.
--- @param scale      number the amount to scale by
function text_ex:scale(scale)
    self._scale = scale
    return self
end

--- Draws the text to the screen.
--- Ends the chain.
function text_ex:draw()
    gfx.text_ex(self._text, self._x, self._y, self._scale, self._rotation, self._color, self._alpha)
end

---@class UsagiEX.gfx_ex
gfx_ex = {}

--- Wrapper for gfx.text_ex.
--- To draw to the screen, call .draw() on the table returned by this function.
--- To customize, chain UsagiEX.text functions.
---@param text       string    string to render
---@param x          number    left edge in game-space pixels
---@param y          number    top edge in game-space pixels
---@param color?     integer   a gfx.COLOR_* constant; optional, defaults to gfx.COLOR_TRUE_WHITE (0)
---@return UsagiEX.text
function gfx_ex.text(text, x, y, color)
    local new_text = {
        _text = text,
        _x = x,
        _y = y,
        _color = color or text_ex._color
    }
    setmetatable(new_text, {__index=text_ex})

    return new_text
end