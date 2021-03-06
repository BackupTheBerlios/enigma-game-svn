--
-- A level for Enigma
--
-- Copyright (c) 2003 Siegfried Fennig
-- Licensed under the GPL version 2.

levelw = 20
levelh = 13

create_world(levelw, levelh)
draw_border("st-rock6")
fill_floor("fl-sahara")

oxyd_default_flavor = "b"

oxyd (  1, 1)
oxyd (  4, 1)
oxyd (  7, 1)
oxyd ( 12, 1)
oxyd ( 15, 1)
oxyd ( 18, 1)
oxyd (  1,11)
oxyd (  4,11)
oxyd (  7,11)
oxyd ( 12,11)
oxyd ( 15,11)
oxyd ( 18,11)

oxyd_shuffle()

draw_stones( "st-rock6", { 5, 1}, {1,0},  2)
draw_stones( "st-rock6", { 4, 2}, {1,0},  3)
draw_stones( "st-rock6", { 3, 3}, {1,0},  4)
draw_stones( "st-rock6", { 3, 4}, {1,0},  2)
draw_stones( "st-rock6", { 3, 5}, {1,0},  2)
draw_stones( "st-rock6", { 3, 7}, {1,0},  2)
draw_stones( "st-rock6", { 3, 8}, {1,0},  2)
draw_stones( "st-rock6", { 3, 9}, {1,0},  4)
draw_stones( "st-rock6", { 4,10}, {1,0},  3)
draw_stones( "st-rock6", { 5,11}, {1,0},  2)
draw_stones( "st-rock6", { 8, 5}, {1,0},  4)
draw_stones( "st-rock6", { 6, 6}, {1,0},  8)
draw_stones( "st-rock6", { 8, 7}, {1,0},  4)
draw_stones( "st-rock6", {13, 1}, {1,0},  2)
draw_stones( "st-rock6", {13, 2}, {1,0},  3)
draw_stones( "st-rock6", {13, 3}, {1,0},  4)
draw_stones( "st-rock6", {15, 4}, {1,0},  2)
draw_stones( "st-rock6", {15, 5}, {1,0},  2)
draw_stones( "st-rock6", {15, 7}, {1,0},  2)
draw_stones( "st-rock6", {15, 8}, {1,0},  2)
draw_stones( "st-rock6", {13, 9}, {1,0},  4)
draw_stones( "st-rock6", {13,10}, {1,0},  3)
draw_stones( "st-rock6", {13,11}, {1,0},  2)
set_stones("st-grate1", {{6,4},{6,5},{13,4},{13,5}})
set_stones("st-grate1", {{3,6},{4,6},{15,6},{16,6}})
set_stones("st-grate1", {{6,7},{6,8},{13,7},{13,8}})
set_stones("st-rock6", {{1,2},{18,2},{1,10},{18,10}})
set_stones("st-wood", {{5,7},{14,5}})
set_stones("st-stoneimpulse", {{5,4},{14,4},{5,8},{14,8}})

function yy1( color, x, y)
        stone = format( "st-%s1", color)
        set_stone( stone, x, y)
        set_stone( stone, x, y+1)
end

yy1( "white",  3, 1)
yy1( "white", 16,10)
yy1( "black",  3,10)
yy1( "black", 16, 1)

set_item("it-yinyang",  9, 2)
set_item("it-yinyang", 10,10)

set_actor("ac-blackball",  9.5,  2.5)
set_actor("ac-whiteball", 10.5, 10.5)
