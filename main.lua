local shader=love.graphics.newShader('shader.glsl')
local w,h=love.graphics.getDimensions()

local pos,pspeed={0,1,0},0.1
local rot={0,0}

function love.mousemoved(x,y,dx,dy)
  if love.mouse.isDown(1) then
    rot={rot[1]+dx/25,rot[2]+dy/25}
  end
end

function love.update(dt)
  local spd=dt/(1/60)
  local so,fo,uo=0,0,0
  if love.keyboard.isDown'up' then
    fo=spd*pspeed
  end if love.keyboard.isDown'down' then
    fo=-spd*pspeed
  end if love.keyboard.isDown'left' then
    so=spd*pspeed
  end if love.keyboard.isDown'right' then
    so=-spd*pspeed
  end if love.keyboard.isDown'space' then
    uo=spd*pspeed
  end if love.keyboard.isDown'lshift' then
    uo=-spd*pspeed
  end
  pos={pos[1]+so,math.max(.1,pos[2]+uo),pos[3]+fo}
  shader:send("pos",pos)
  shader:send("rot",rot)
end

function love.draw()
  local g = love.graphics
  g.setColor(1,1,1)
  g.setShader(shader)  
    g.rectangle('fill',0,0,w,h)
  g.setShader()
  g.print(love.timer.getFPS()..' FPS')
end