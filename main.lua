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

    gfx.text_ex("Hello, Usagi!", 64, 32, 1, usagi.elapsed, gfx.COLOR_TRUE_WHITE, 1)
    gfx_ex.text("Hello, Usagi!", 64, 64, gfx.COLOR_BLUE):rotate(usagi.elapsed):alpha(0.5):scale(2):draw()
end
