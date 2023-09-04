local box1_color = {25, 25, 25, 255} -- the box above the coloured line
local coloured_line = {255, 4, 85, 255} -- the coloured line
local keyboard_logo_color = {255, 255, 255, 255} -- the keyboard logo colour 
local keybinds_color = {255, 255, 255, 255} -- the "keybinds" text colour that is next to the keyboard logo
local keybind_state_colours = {255, 255, 255, 255} -- the keybind state colour like for an example "doubletap: 100%"


-- no need to edit this stuff down here
-- if you can paste anything out of this spagetti code then feel free to do so
deafultFont = draw.CreateFont( "Consolas", 14, 800 )
KeyboardFont = draw.CreateFont( "untitled-font-1", 24, 400 )
SpectatorFont = draw.CreateFont( "untitled-font-1", 16, 400 )

keybinds_start_x = 420
keybinds_start_y = 800

spectators_start_x = 420
spectators_start_y = 400

infopanel_start_x = 1690
infopanel_start_y = 32

local function waujmujmw()
if engine.IsGameUIVisible() == false then

    local mX = input.GetMousePos()[1] -- mouse x position
    local mY = input.GetMousePos()[2] -- mouse y position
    local boxWidth, boxHeight = 200, 75 -- size of the box

    draw.SetFont( deafultFont ) -- set the font to get the text size



    --[[Here starts the keybinds box]]--
    local statuses = {}

--============================--
-- all of the statuses start from here

    if warp.GetChargedTicks() ~= 0 then -- doubletap

        local porcent = math.floor((warp.GetChargedTicks() / 23) * 100)

        local LocalWeapon = entities.GetLocalPlayer():GetPropEntity( "m_hActiveWeapon" )

        if (warp.CanDoubleTap(LocalWeapon)) and ((entities.GetLocalPlayer():GetPropInt( "m_fFlags" )) & FL_ONGROUND) == 1 then 
            canDt = " [Charged]"
        else
            canDt = " [Waiting]"
        end

        table.insert(statuses, "Doubletap:  ".. porcent .. "%".. canDt)

    end

    if (gui.GetValue( "Crit Hack" ) == "force key") or (gui.GetValue( "melee Crit Hack" ) == "force key") then -- crit hack
        if input.IsButtonDown( gui.GetValue( "Crit Hack key" ) ) then
            table.insert(statuses, "Crithack: Held")
        end
    end

    if gui.GetValue( "Aim key" ) ~= 0 then -- aimbot

        aimbot_key = gui.GetValue( "Aim key" )
        aimbot_mode = gui.GetValue( "Aim key mode" )

        if (gui.GetValue( "Aim bot" ) == 1) and (input.IsButtonDown( aimbot_key )) and (aimbot_mode == "hold-to-use") then 
            table.insert(statuses, "Aimbot:  Held" )
        end

        if (gui.GetValue( "Aim bot" ) == 1) and (aimbot_mode == "press-to-toggle") then
            table.insert(statuses, "Aimbot:  Toggeled" )
        end

    end

    if gui.GetValue( "Trigger shoot" ) == 1 then -- trigger shoot
        if input.IsButtonDown( gui.GetValue( "Trigger shoot key" ) ) then
            table.insert(statuses, "Trigger shoot:  Held" )
        end
    end

    if gui.GetValue( "Trigger key" ) ~= 0 then -- trigger key
        if input.IsButtonDown( gui.GetValue( "Trigger key" ) ) then
            table.insert(statuses, "Trigger key:  Held" )
        end
    end

    if gui.GetValue( "Fake Lag" ) ~= 0 then -- fakelag

        local fakelag_ticks = (gui.GetValue( "Fake lag value (ms)" ) + 15) /15
        fakelag_ticks = math.floor(fakelag_ticks)
        table.insert(statuses, "Fakelag:  ".. fakelag_ticks.. " tick's")

    end

    if gui.GetValue( "Anti Aim" ) ~= 0 then -- anti aim
        table.insert(statuses, "Spinnin^:  Yep")
    end

    if gui.GetValue( "Fake Latency" ) == 1 then -- fake latency
        table.insert(statuses, "Latency:  ".. (gui.GetValue( "Fake latency value (ms)" ) / 1000).. " second's")
    end

    if gui.GetValue( "Thirdperson" ) ~= 0 then -- thirdperson
        if gui.GetValue( "thirdperson key" ) ~= 0 then
            table.insert(statuses, "Thirdperson:  Toggled")
        else 
            table.insert(statuses, "Thirdperson:  On")
        end
    end

-- all of the statuses end here
--============================--
    local startY = 20
    local textHeight = 0 -- calculate the total height of the text
    for i, status in ipairs(statuses) do
        draw.Color( table.unpack(keybind_state_colours) )
        local width, height = draw.GetTextSize(status)
        draw.Text(math.floor(keybinds_start_x + 2), math.floor(keybinds_start_y + startY), status)
        startY = startY + 15
        textHeight = textHeight + (height + 1)
    end

    boxHeight = 20 + textHeight -- update the box height

    if input.IsButtonDown(MOUSE_LEFT) and -- is the cursor inside the box?
       mX >= keybinds_start_x and mX <= keybinds_start_x + boxWidth and
       mY >= keybinds_start_y and mY <= keybinds_start_y + boxHeight then
        keybinds_start_x = mX - boxWidth/2
        keybinds_start_y = mY - boxHeight/2
    end

    --draw.Color(50, 50, 50, 150) -- drawing the main box  -- currently disabled because it is drawing on top of the text
    --draw.FilledRect(math.floor(keybinds_start_x), math.floor(keybinds_start_y), math.floor(keybinds_start_x + boxWidth), math.floor(keybinds_start_y + boxHeight))

    draw.Color( table.unpack(box1_color) ) -- drawing the darker box above the main box
    draw.FilledRect(math.floor(keybinds_start_x), math.floor(keybinds_start_y), math.floor(keybinds_start_x + boxWidth), math.floor(keybinds_start_y + 20))  

    draw.Color( table.unpack(coloured_line) ) -- drawing the coloured line
    draw.FilledRect(math.floor(keybinds_start_x), math.floor(keybinds_start_y) + 18, math.floor(keybinds_start_x + boxWidth), math.floor(keybinds_start_y + 20))

    draw.SetFont( KeyboardFont ) -- drawing the keyboard logo
    draw.Color( table.unpack(keyboard_logo_color) )
    draw.Text(math.floor(keybinds_start_x) + 2, math.floor(keybinds_start_y) - 2,  "a" )
    
    draw.SetFont( deafultFont ) -- drawing the keybinds text
    draw.Color(table.unpack(keybinds_color))
    draw.Text(math.floor(keybinds_start_x) + 30, math.floor(keybinds_start_y) + 2, " Keybind's")
--[[Here ends the keybinds box]]--


--[[Here starts the spectators box]]--

local players = entities.FindByClass("CTFPlayer")

startpos = 5
for i, p in pairs(players) do
if (p:IsAlive() == false) and (p:IsDormant() == false) then

    if p:GetPropEntity("m_hObserverTarget"):GetName() == steam.GetPlayerName( steam.GetSteamID() ) then
        startpos = startpos + 15

        if p:GetPropInt("m_iObserverMode") == 1 then 
            specMode = " Deathcam"
        elseif p:GetPropInt("m_iObserverMode") == 2 then 
            specMode = " Freezecam"
        elseif p:GetPropInt("m_iObserverMode") == 4 then 
            specMode = " Firstperson"
        elseif p:GetPropInt("m_iObserverMode") == 5 then 
            specMode = " Thirdperson"
        end

    draw.Text(math.floor(spectators_start_x), math.floor(spectators_start_y + startpos), p:GetName().. " -".. specMode)
    end

end
end

if input.IsButtonDown(MOUSE_LEFT) and -- is the cursor inside the box?
       mX >= spectators_start_x and mX <= spectators_start_x + boxWidth and
       mY >= spectators_start_y and mY <= spectators_start_y + boxHeight then
        spectators_start_x = mX - boxWidth/2
        spectators_start_y = mY - boxHeight/2
    end

    draw.Color( table.unpack(box1_color) ) -- drawing the darker box above the main box 
    draw.FilledRect(math.floor(spectators_start_x), math.floor(spectators_start_y), math.floor(spectators_start_x + boxWidth), math.floor(spectators_start_y + 20))  

    draw.Color( table.unpack(coloured_line) ) -- drawing the coloured line
    draw.FilledRect(math.floor(spectators_start_x), math.floor(spectators_start_y) + 18, math.floor(spectators_start_x + boxWidth), math.floor(spectators_start_y + 20))

    draw.SetFont( SpectatorFont ) -- drawing the keyboard logo
    draw.Color( table.unpack(keyboard_logo_color) )
    draw.Text(math.floor(spectators_start_x) + 2, math.floor(spectators_start_y) + 1,  "b" )
    
    draw.SetFont( deafultFont ) -- drawing the keybinds text
    draw.Color(table.unpack(keybinds_color))
    draw.Text(math.floor(spectators_start_x) + 25, math.floor(spectators_start_y) + 2, " Spectator's")

--[[Here ends the spectators box]]--

end
end

callbacks.Register("Draw", "waujmujmw", waujmujmw)