--
-- A level for Enigma
--
-- Copyright (c) 2003 Siegfried Fennig
-- Licensed under the GPL version 2.

levelw = 39
levelh = 13

create_world(levelw, levelh)
draw_border("st-rock4")
fill_floor("fl-sand")

oxyd (26,4)
oxyd (37,11)

set_item("it-brush",3,7)

draw_stones("st-glass", {37,8}, {1,0},1)

draw_stones("st-stonebrush", {2,4}, {1,0},3)
draw_stones("st-stonebrush", {9,4}, {1,0},5)
draw_stones("st-stonebrush", {4,3}, {1,0},3)
draw_stones("st-stonebrush", {7,5}, {1,0},3)
draw_stones("st-stonebrush", {6,7}, {1,0},3)
draw_stones("st-stonebrush", {3,9}, {1,0},4)
draw_stones("st-stonebrush", {16,8}, {1,0},3)
draw_stones("st-stonebrush", {19,3}, {1,0},3)
draw_stones("st-stonebrush", {25,3}, {1,0},4)
draw_stones("st-stonebrush", {26,6}, {1,0},2)
draw_stones("st-stonebrush", {9,4}, {1,0},5)
draw_stones("st-stonebrush", {31,5}, {1,0},6)
draw_stones("st-stonebrush", {28,9}, {1,0},7)
draw_stones("st-stonebrush", {33,7}, {1,0},3)
draw_stones("st-stonebrush", {2,6}, {0,1},4)
draw_stones("st-stonebrush", {4,6}, {0,1},2)
draw_stones("st-stonebrush", {8,8}, {0,1},4)
draw_stones("st-stonebrush", {13,5}, {0,1},5)
draw_stones("st-stonebrush", {17,2}, {0,1},5)
draw_stones("st-stonebrush", {19,5}, {0,1},4)
draw_stones("st-stonebrush", {22,3}, {0,1},6)
draw_stones("st-stonebrush", {25,4}, {0,1},4)
draw_stones("st-stonebrush", {24,8}, {0,1},2)
draw_stones("st-stonebrush", {29,3}, {0,1},6)
draw_stones("st-stonebrush", {31,1}, {0,1},3)
draw_stones("st-stonebrush", {31,6}, {0,1},2)
draw_stones("st-stonebrush", {36,6}, {0,1},6)
draw_stones("st-stonebrush", {22,10}, {0,1},2)
draw_stones("st-stonebrush", {9,2}, {0,1},2)

mirrorp(3,7,TRUE,FALSE, 1)
mirrorp(5,7,TRUE,FALSE, 1)
mirrorp(17,7,TRUE,FALSE, 3)
mirrorp(36,2,TRUE,FALSE, 2)

set_stone( "st-timer", 2, 11, {action="callback", target="th"})

timer = 0

function th()
    if timer == 2 then
        SendMessage("laser1", "on")
    elseif timer == 4 then
        SendMessage("laser1", "off")
    end
    timer = timer + 1
    if timer == 6 then
        timer = 0
    end
end

set_attrib( laser( 1, 11, TRUE, NORTH), "name", "laser1")

set_actor("ac-blackball", 35.5,6.5)

