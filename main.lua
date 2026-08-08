require("usagi_ex")

function _config()
    ---@type Usagi.Config
    return { name = "Game", game_id = "com.usagiengine.YOURGAMENAME", sprite_size = 8 }
end

function _init()
    input.set_mouse_visible(false)
end

function _update(dt)
end

local text = gfx_ex.text("Hello, Usagi!", 32, 64, gfx.COLOR_BLUE):scale(2)
text:hover():underline(gfx.COLOR_WHITE):color(gfx.COLOR_WHITE)

local safe_theta = 0
local unsafe_theta = 0
local target_theta = 0

function _draw(dt)
    gfx.clear(gfx.COLOR_BLACK)
    local mx, my = input.mouse()
    local sx, sy = usagi.measure_text("TEST ROTATE!")
    sx, sy = sx, sy

    -- TESTING

    -- local color = usagi.elapsed % 0.5 > 0.25 and gfx.COLOR_WHITE or gfx.COLOR_BLUE
    -- text:rotate(math.sin(usagi.elapsed*1.5)*0.025):draw()

    local tx, ty = 64 + sx, 64 + sy
    local dx, dy = mx - tx, my - ty
    target_theta = util_ex.full_angle_from_vec({x = dx, y = dy})
    safe_theta = util_ex.lerp_rotate(safe_theta, target_theta, 0.1)
    unsafe_theta = util.lerp(unsafe_theta, target_theta, 0.1)
    gfx_ex.text("SAFE!", 64, 64, gfx.COLOR_BLUE):scale(2):rotate(safe_theta):draw()
    gfx_ex.text("UNSAFE!", 128, 64, gfx.COLOR_RED):scale(2):rotate(unsafe_theta):draw()

    -- MOUSE
    gfx.spr(1, mx, my)
end
