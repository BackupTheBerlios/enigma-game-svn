-- A level for Enigma
-- Name: 	Ibiza!
-- Filename: 	ralf02.lua
-- Copyright: 	(c) Feb 2003 Ralf Westram
-- Contact: 	amgine@reallysoft.de
-- License: 	GPL v2.0 or above

randomseed(enigma.GetTicks())

floortile1 = "fl-space"
floortile2 = "fl-metal"
floortile3 = "fl-gradient"
floortile4 = "fl-inverse"


walltile   = "st-rock5"
walltile2  = "st-glass"

xw = 5
yw = 5

levelw = (xw*6)+3
levelh = (yw*6)+2
tiles = (xw*yw+1)/2

                       mask = "1001100101010"
if random(1,3)==1 then mask = "0101010100101" end
if random(1,3)==1 then mask = "0101010100110" end
if random(1,3)==1 then mask = "0100101010101" end

create_world(levelw,levelh)

fill_floor("fl-water")
draw_border(walltile)

display.SetFollowMode(display.FOLLOW_SMOOTH)

ftilew = 10
ftileh = 12
stilew = 5
stileh = 6
floorw = (ftilew+2)*2
floorh = 4*ftileh
stonew = (stilew+1)*2
stoneh = 4*stileh

function set_floor_repeated(ftile,x,y)
    local ly = y
    while (ly < levelh) do
        local lx = x
        while (lx < levelw) do
            if lx >= 0 and ly >= 0 then
                if ftile == "fl-gradient" then
                    set_floor(ftile,lx,ly,{type=random(1,8)})
                else
                    set_floor(ftile,lx,ly)
                end
            end
            lx = lx + floorw
        end
        ly = ly + floorh
    end
end
function set_stone_repeated(stile,x,y)
    local ly = y
    while (ly < (levelh-1)) do
        local lx = x
        while (lx < (levelw-1)) do
            if lx > 0 and ly > 0 then
                set_stone(stile,lx,ly)
            end
            lx = lx + stonew
        end
        ly = ly + stoneh
    end
end

function fill_floor_repeated(ftile,x1,y1,x2,y2)
    for x=x1, x2 do
        for y=y1, y2 do
            set_floor_repeated(ftile,x,y)
        end
    end
end
function fill_stone_repeated(stile,x1,y1,x2,y2)
    for x=x1, x2 do
        for y=y1, y2 do
            set_stone_repeated(stile,x,y)
        end
    end
end

function draw_floor_tile(ftile,x,y,xt,yt)
    set_floor_repeated(ftile,x+xt,           y+yt)
    set_floor_repeated(ftile,x+(ftilew-xt-1),y+yt)
    set_floor_repeated(ftile,x+(ftilew-xt-1),y+(ftileh-yt-1))
    set_floor_repeated(ftile,x+xt,           y+(ftileh-yt-1))
end
function draw_floor_tiles(ftile,x,y,xt1,yt1,xt2,yt2)
    for xt=xt1, xt2 do
        for yt=yt1, yt2 do
            draw_floor_tile(ftile,x,y,xt,yt)
        end
    end
end

function draw_stone_tile(stile,x,y,xt,yt)
    set_stone_repeated(stile,x+xt,           y+yt)
    set_stone_repeated(stile,x+(stilew-xt-1),y+yt)
    set_stone_repeated(stile,x+(stilew-xt-1),y+(stileh-yt-1))
    set_stone_repeated(stile,x+xt,           y+(stileh-yt-1))
end

count = 0

function draw_oxyd_tile(x,y,xt,yt)
    draw_stone_tile("st-fakeoxyd",x,y,xt,yt)
    count = count+1
    if (strsub(mask,count,count)=="1") then
        local d = random(1,4)
        if     (d == 1) then oxyd(x+xt,y+yt)
    	elseif (d == 2) then oxyd(x+(stilew-xt-1),y+yt)
	    elseif (d == 3) then oxyd(x+(stilew-xt-1),y+(stileh-yt-1))
    	elseif (d == 4) then oxyd(x+xt,           y+(stileh-yt-1))
        end
    end
end
function draw_oxyd_tile_repeated(x,y,xt,yt)
    local ly = y
    while (ly < (levelh-1)) do
        local lx = x
        while (lx < (levelw-1)) do
            if lx > 0 and ly > 0 then
                draw_oxyd_tile(lx,ly,xt,yt)
            end
            lx = lx + stonew
        end
        ly = ly + stoneh
    end
end

-- grobes Muster
function draw_floor_i(ftile,x,y)
    draw_floor_tiles(ftile,x,y,0,0,1,3)
    draw_floor_tiles(ftile,x,y,2,0,3,1)
    fill_floor_repeated(ftile,x+ftilew/2-1,y,x+ftilew/2,y+ftileh-1)
end

-- feines Muster
function draw_floor_i_fein(ftile,x,y)
    draw_floor_tile(ftile,x,y,0,0)
    draw_floor_tile(ftile,x,y,0,1)
    draw_floor_tile(ftile,x,y,1,0)
    fill_floor_repeated(ftile,x+ftilew/2,y,x+ftilew/2,y+ftileh-1)
end

function draw_stone_i(stile,x,y)
    draw_stone_tile(stile,x,y,0,0)
    draw_stone_tile(stile,x,y,0,1)
    draw_stone_tile(stile,x,y,1,0)
    draw_oxyd_tile_repeated(x,y,1,1)
    fill_stone_repeated(stile,x+2,y,x+2,y+5)
end

function draw_floor_column(ftile1,ftile2,ftile3,ftile4,x,y)
    draw_floor_i(ftile1,x, y)
    draw_floor_i(ftile2,x, y+ftileh)
    draw_floor_i(ftile3,x, y+ftileh*2)
    draw_floor_i(ftile4,x, y+ftileh*3)
end

-- starting positions of floor
x1 = -3
x2 = x1+(floorw/4)
y1 = -4
y2 = y1-(ftileh/2)

draw_floor_column(floortile1,floortile2,floortile3,floortile4,x1,y1)
draw_floor_column(floortile2,floortile3,floortile4,floortile1,x2,y2)
draw_floor_column(floortile1,floortile2,floortile3,floortile4,x1+floorw/2,y1)
draw_floor_column(floortile3,floortile4,floortile1,floortile2,x2+floorw/2,y2)

x3 = 2
y3 = 1

draw_stone_i(walltile2,x3,         y3)
draw_stone_i(walltile2,x3,         y3+stoneh/2)
draw_stone_i(walltile2,x3+stonew/2,y3+stoneh/4)
draw_stone_i(walltile2,x3+stonew/2,y3-stoneh/4)

oxyd_shuffle()
set_actor("ac-blackball", levelw/2+6, levelh/2+0.5)

