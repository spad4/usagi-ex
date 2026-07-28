require("usagi_ex")

function _config()
    ---@type Usagi.Config
    return { name = "Game", game_id = "com.usagiengine.YOURGAMENAME", sprite_size = 8}
end

function _init()
    input.set_mouse_visible(false)
end

function _update(dt)
end

local text = gfx_ex.text("Hello, Usagi!", 32, 64, gfx.COLOR_BLUE):scale(2)
text:hover():underline(gfx.COLOR_WHITE)

function _draw(dt)
    gfx.clear(gfx.COLOR_BLACK)
    local color = usagi.elapsed % 0.5 > 0.25 and gfx.COLOR_WHITE or gfx.COLOR_BLUE
    text:hover():color(color)
    text:rotate(math.sin(usagi.elapsed*1.5)*0.025):draw()
    local mx, my = input.mouse()
    gfx.spr(1, mx, my)
end
