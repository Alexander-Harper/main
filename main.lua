-- Comentario

function love.load()
    print("love.load is running")
    love.window.setTitle("2D Platformer")
    love.window.setMode(800, 600)
    love.graphics.setBackgroundColor(0.2, 0.5, 0.6)

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
        {x = -500, y = 560, width = 21000, height = 40}
    }

    camera = {
        x = 0,
        y = 0
    }

    clouds = {
        {x = 100, y = 150, width = 80, height = 40},
        {x = 300, y = 140, width = 100, height = 50},
        {x = 500, y = 160, width = 90, height = 45},
        {x = 700, y = 135, width = 70, height = 35},
        {x = 900, y = 165, width = 85, height = 40}
    }

    cloud_tile_width = 1000
end

function love.update(dt)
    player.yVelocity = player.yVelocity - player.gravity * dt
    player.y = player.y + player.yVelocity * dt

    player.onGround = false
    for _, p in ipairs(platforms) do
        if player.y + player.height > p.y and
           player.x + player.width > p.x and
           player.x < p.x + p.width then
            player.y = p.y - player.height
            player.yVelocity = 0
            player.onGround = true
        end
    end

    if love.keyboard.isDown("right") then
        player.x = player.x + 5 + player.speed * dt
        print("Right pressed, new X: " .. math.floor(player.x))
    end
    if love.keyboard.isDown("left") then
        player.x = player.x - 5 - player.speed * dt
        print("Left pressed, new X: " .. math.floor(player.x))
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + 2 * player.speed * dt
        print("Down pressed, new Y: " .. math.floor(player.y))
    end

    if player.x < -400 then
        player.x = -400
        print("Clamped X to -400")
    end

    if camera then
        camera.x = player.x + player.width / 2 - 400
        camera.y = player.y + player.height / 2 - 300
    end
end

function love.keypressed(key)
    if key == "space" and player.onGround then
        player.yVelocity = player.jumpHeight
        player.onGround = false
        print("Jumped")
    end
end

function love.draw()
    love.graphics.push()
    if camera then
        love.graphics.translate(-camera.x * 0.5, -camera.y * 0.5)
        love.graphics.setColor(1, 1, 1, 0.8)
        local tile_width = cloud_tile_width
        local cam_bg_x = camera.x * 0.5
        local offset = cam_bg_x % tile_width
        if offset > 0 then offset = offset - tile_width end
        local first_tile = math.floor(cam_bg_x / tile_width) - 1
        print("Cloud debug: cam_bg_x=" .. math.floor(cam_bg_x) .. ", offset=" .. math.floor(offset) .. ", first_tile=" .. first_tile)
        for i = first_tile, first_tile + 2 do
            love.graphics.push()
            love.graphics.translate(i * tile_width, 0)
            for _, cloud in ipairs(clouds) do
                love.graphics.rectangle("fill", cloud.x, cloud.y, cloud.width, cloud.height)
            end
            love.graphics.pop()
        end
    end
    love.graphics.pop()

    love.graphics.push()
    if camera then
        love.graphics.translate(-camera.x, -camera.y)
    end

    love.graphics.setColor(0.3, 0.3, 0.3)
    for _, p in ipairs(platforms) do
        love.graphics.rectangle("fill", p.x, p.y, p.width, p.height)
    end

    love.graphics.setColor(0, 0.7, 1)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)

    love.graphics.pop()

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("X: " .. math.floor(player.x) .. " Y: " .. math.floor(player.y), 10, 10)
    love.graphics.print("On Ground: " .. tostring(player.onGround), 10, 30)
    love.graphics.print("Tip: Hold RIGHT - watch X increase & ground/clouds move LEFT", 10, 50)
end