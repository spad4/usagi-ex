require("usagi_ex")

function _config()
    ---@type Usagi.Config
    return { name = "Game", game_id = "com.usagiengine.YOURGAMENAME" }
end

function _init()
    -- Live reload preserves globals across saved edits but resets locals.
    -- Stash mutable game state in a capitalized global like `State` so it
    -- survives reloads; F5 calls _init again to reset.
    State = {}
end

function _update(dt)
end

function _draw(dt)
    gfx.clear(gfx.COLOR_BLACK)

    gfx_ex.text("Hello, Usagi!", 32, 64, gfx.COLOR_BLUE)
        :rotate(math.sin(usagi.elapsed*1.5)*0.025)
        :scale(1)
        :underline(gfx.COLOR_WHITE)
        :draw()
end
