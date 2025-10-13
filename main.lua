function love.load()
    love.window.setTitle("2D Platformer")
    love.window.setMode(800, 600)
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)

    player = {
        x = 100,
        y = 500,
        width = 40,
        height = 60,
        speed = 200,
        yVelocity = 0,
        jumpHeight = -400,
        gravity = -800,
        onGround = false
    }

    platforms = {
        {x = 0, y = 560, width = 20000, height = 40} -- ground
    }
end

function love.update(dt)
    -- Apply gravity
    player.yVelocity = player.yVelocity - player.gravity * dt
    player.y = player.y + player.yVelocity * dt

    -- Simple collision check with platforms
    for _, p in ipairs(platforms) do
        if player.y + player.height > p.y and
           player.x + player.width > p.x and
           player.x < p.x + p.width then
            player.y = p.y - player.height
            player.yVelocity = 0
            player.onGround = true
        else
            player.onGround = false
        end
    end

    -- Movement
    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed * dt
    elseif love.keyboard.isDown("left") then
        player.x = player.x - player.speed * dt
    end
end

function love.keypressed(key)
    if key == "space" and player.onGround then
        player.yVelocity = player.jumpHeight
        player.onGround = false
    end
end

function love.draw()
    -- Draw player
    love.graphics.setColor(0, 0.7, 1)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)

    -- Draw platforms
    love.graphics.setColor(0.3, 0.3, 0.3)
    for _, p in ipairs(platforms) do
        love.graphics.rectangle("fill", p.x, p.y, p.width, p.height)
    end
end

