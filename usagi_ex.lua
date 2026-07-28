-- get mouse position once per frame
local Mouse = {x = 0, y = 0}
local last_mouse_update = 0
local function update_mouse()
    if last_mouse_update ~= usagi.elapsed then
        Mouse.x, Mouse.y = input.mouse()
        last_mouse_update = usagi.elapsed
    end
end

--[[ EXPANDED MATH FUNCTIONS ]]
---@class UsagiEX.util_ex
util_ex = {}

--- Rotates the given `{x, y}` vector around `0,0` by `angle` radians, clockwise.
---@param vec Usagi.Vec2  `{x, y}` vector to rotate
---@param angle number    amount to rotate by, in radians
---@return Usagi.Vec2
function util_ex.vec_rotate(vec, angle)
    local to_return = {
        x = vec.x * math.cos(angle) - vec.y * math.sin(angle),
        y = vec.x * math.sin(angle) + vec.y * math.cos(angle)
    }
    return to_return
end

--[[ EXPANDED GFX FUNCTIONS ]]
---@class UsagiEX.gfx_ex
gfx_ex = {}

---@class UsagiEX.text
local text_ex = {
    _text = "",
    _x = 0,
    _y = 0,
    _size_x = 0,
    _size_y = 0,
    _half_x = 0,
    _half_y = 0,
    _color = gfx.COLOR_TRUE_WHITE,
    _scale = 1,
    _rotation = 0,
    _alpha = 1,
    _underlined = false,
    _underline_color = 0,
    _hover = nil
}

--- Wrapper for gfx.text_ex.
--- To draw to the screen, call .draw() on the table returned by this function.
--- To customize, chain UsagiEX.text functions.
---@param text       string    string to render
---@param x          number    left edge in game-space pixels
---@param y          number    top edge in game-space pixels
---@param color?     integer   a gfx.COLOR_* constant; optional, defaults to gfx.COLOR_TRUE_WHITE (0)
---@return UsagiEX.text
function gfx_ex.text(text, x, y, color)
    local sx, sy = usagi.measure_text(text)
    local new_text = {
        _text = text,
        _x = x,
        _y = y,
        _size_x = sx,
        _size_y = sy,
        _half_x = sx / 2,
        _half_y = sx / 2,
        _color = color or text_ex._color
    }
    setmetatable(new_text, { __index = text_ex })

    return new_text
end

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
--- @param rotation      number amount to rotate, in radians; use math.rad(deg) to convert from degrees
function text_ex:rotate(rotation)
    self._rotation = rotation * math.pi
    return self
end

--- Scales the text. Use integers for best results.
--- @param scale      number the amount to scale by
function text_ex:scale(scale)
    self._scale = scale
    return self
end

--- Adds an underline to the text.
---@param color?      number the gfx color constant to use; matches the text's color by default (pass nothing or -1)
function text_ex:underline(color)
    self._underlined = true
    self._underline_color = color or -1
    return self
end

--- Chain functions applied after this call only take affect if the mouse is hovering over the text
---@return UsagiEX.text
function text_ex:hover()
    if self._hover then
        return self._hover
    end
    local to_return = {}
    setmetatable(to_return, {__index = self})
    self._hover = to_return
    return to_return
end

--- Draws the text to the screen.
--- Ends the chain.
function text_ex:draw()

    update_mouse()

    local this = self
    if self._hover then
        local my_rect = {x = self._x, y = self._y, w = self._size_x * self._scale, h = self._size_y * self._scale}
        if util.point_in_rect(Mouse, my_rect) then
            this = self._hover
        end
    end

    gfx.text_ex(this._text, this._x, this._y, this._scale, this._rotation, this._color, this._alpha)

    if this._underlined then
        local scaled_x, scaled_ = this._size_x * this._scale, this._size_y * this._scale
        local scaled_half_x = scaled_x / 2
        local mx, my = this._x + scaled_x / 2, this._y + scaled_ / 2
        local underline_color = this._underline_color == -1 and this._color or this._underline_color
        local y_offset = scaled_ / 2 + math.floor(this._scale * 1.5) - this._scale * 2

        local line_start = {x = -scaled_half_x, y = y_offset}
        local line_end = {x = scaled_half_x, y = y_offset}

        if this._rotation ~= 0 then
            line_start = util_ex.vec_rotate(line_start, this._rotation)
            line_end = util_ex.vec_rotate(line_end, this._rotation)
        end

        gfx.line_ex(mx + line_start.x, my + line_start.y, mx + line_end.x, my + line_end.y, this._scale,
            underline_color, this._alpha)

    end
end
