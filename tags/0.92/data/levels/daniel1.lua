-- Copyright (C) 2003 Daniel Heck 
-- Licensed under GPL v2.0 or above

levelw = 20 levelh = 13

create_world(levelw, levelh)
enigma.ConserveLevel = FALSE
fill_floor("fl-abyss")

local x0=1
local y0=3
local floor ="fl-samba"

draw_floor(floor, {x0,y0-2}, {1,0}, 3)
draw_floor(floor, {x0,y0-1}, {1,0}, 4)
draw_floor(floor, {x0,y0},   {1,0}, 5)
draw_floor(floor, {x0,y0+1}, {1,0}, 6)
draw_floor(floor, {x0,y0+2}, {1,0}, 7)
draw_floor(floor, {x0,y0+3}, {1,0}, 8)
draw_floor(floor, {x0,y0+4}, {1,0}, 7)
draw_floor(floor, {x0,y0+5}, {1,0}, 6)
draw_floor(floor, {x0,y0+6}, {1,0}, 5)
draw_floor(floor, {x0,y0+7}, {1,0}, 4)
draw_floor(floor, {x0,y0+8}, {1,0}, 3)

local x1=18
draw_floor(floor, {x1,y0-2}, {-1,0}, 3)
draw_floor(floor, {x1,y0-1}, {-1,0}, 4)
draw_floor(floor, {x1,y0},   {-1,0}, 5)
draw_floor(floor, {x1,y0+1}, {-1,0}, 6)
draw_floor(floor, {x1,y0+2}, {-1,0}, 7)
draw_floor(floor, {x1,y0+3}, {-1,0}, 8)
draw_floor(floor, {x1,y0+4}, {-1,0}, 7)
draw_floor(floor, {x1,y0+5}, {-1,0}, 6)
draw_floor(floor, {x1,y0+6}, {-1,0}, 5)
draw_floor(floor, {x1,y0+7}, {-1,0}, 4)
draw_floor(floor, {x1,y0+8}, {-1,0}, 3)

--draw_floor("fl-wood", {x0, y0-1}, {0,1}, 8)

SetDefaultAttribs("it-wormhole", {strength=25})
Wormhole (x0+5, y0+3, x1+0.5, y0+3.5)
Wormhole (x1-5, y0+3, x0+0.5, y0+3.5)

set_item("it-hollow", x0+1, y0);
set_item("it-hollow", x0+1, y0+6);
set_item("it-hollow", x1-1, y0);
set_item("it-hollow", x1-1, y0+6);

set_actor("ac-whiteball-small", x0+0.5,y0+3.5, {player=0})
set_actor("ac-whiteball-small", x0+2.5,y0+3.5, {player=0})
set_actor("ac-whiteball-small", x1+0.5,y0+3.5, {player=0})
set_actor("ac-whiteball-small", x1-1.5,y0+3.5, {player=0})

