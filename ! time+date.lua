local font = draw.CreateFont( "Verdana", 16, 200 )
local fps = 75

local cheatname = "Cringe"
local cheatname2 = " Box"
local function RGBRainbow(frequency)

    local curtime = globals.CurTime() 
    local r,g,b
    r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)
    
    return r, g, b
end

-- Draw text: Lmaobox | FPS: x | Ping: x | Time: x
local function Lmaobox()

    local inGame = clientstate.GetClientSignonState()
    local me = entities.GetLocalPlayer()  

    if inGame == 6 then
        ping = entities.GetPlayerResources():GetPropDataTableInt("m_iPing")[me:GetIndex()] 
    else
        ping = "disconnected"
    end

    if globals.FrameCount() % 30 == 0 then
        fps = math.floor(1 / globals.FrameTime())
    end
    draw.SetFont( font )
	
    draw.Color( 0, 255, 0, 255 )
    draw.Color( 124,252,0, 255 ) --last is *aplha* green: 124,252,0
   
   draw.Text( 6, 5, "Time - " .. os.date("%H:%M %p") )
    draw.Text( 6, 30, "FPS - " .. fps )
    draw.Text( 6, 45, "Ping - " .. tostring(ping) )
    
end

callbacks.Register( "Draw", Lmaobox )