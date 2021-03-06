--
-- A level for Enigma
--
-- Copyright (c) 2003 Martin Hawlisch
-- Licensed under the GPL version 2.

levelw = 20
levelh = 13

create_world( levelw, levelh)

fill_floor("fl-hay", 0,0,levelw,levelh)
stone = "st-marble"

draw_border( stone)
draw_stones( stone, {3,2}, {0,1}, 4)
draw_stones( stone, {3,7}, {0,1}, 4)
draw_stones( stone, {5,1}, {0,1}, 3)
draw_stones( stone, {5,9}, {0,1}, 3)
draw_stones( stone, {5,5}, {1,0}, 3)
draw_stones( stone, {5,7}, {1,0}, 4)
draw_stones( stone, {7,1}, {0,1}, 4)
draw_stones( stone, {8,8}, {0,1}, 2)
draw_stones( stone, {8,1}, {1,0}, 11)
draw_stones( stone, {6,11}, {1,0}, 13)
set_stone( stone, 11, 2)
set_stone( stone, 11, 5)
set_stone( stone, 14, 6)
puzzle( 4, 4,PUZ_0010)
puzzle( 4, 5,PUZ_1010)
puzzle( 4, 6,PUZ_0000)
puzzle( 4, 7,PUZ_1010)
puzzle( 4, 8,PUZ_1000)

puzzle( 7,10,PUZ_0100)
puzzle( 8,10,PUZ_0000)
puzzle( 9,10,PUZ_0101)
puzzle(10,10,PUZ_0001)

puzzle(11,10,PUZ_1000)
puzzle(11, 9,PUZ_1010)
puzzle(11, 8,PUZ_0011)
puzzle(10, 8,PUZ_1100)
puzzle(10, 7,PUZ_1010)
puzzle(10, 6,PUZ_1010)
puzzle(10, 5,PUZ_0000)
puzzle(10, 4,PUZ_0110)
puzzle(11, 4,PUZ_0101)
puzzle(12, 4,PUZ_0101)
puzzle(13, 4,PUZ_0000)
puzzle(14, 4,PUZ_0101)
puzzle(15, 4,PUZ_0101)
puzzle(16, 4,PUZ_0011)
puzzle(16, 5,PUZ_0000)
puzzle(16, 6,PUZ_1010)
puzzle(16, 7,PUZ_0000)
puzzle(16, 8,PUZ_1001)
puzzle(15, 8,PUZ_0101)
puzzle(14, 8,PUZ_0101)
puzzle(13, 8,PUZ_1100)
puzzle(13, 7,PUZ_1010)
puzzle(13, 6,PUZ_1010)
puzzle(13, 5,PUZ_1010)
puzzle(13, 3,PUZ_0010)

puzzle(12, 6,PUZ_0010)
puzzle(12, 7,PUZ_0000)
puzzle(12, 8,PUZ_0000)
puzzle(12, 9,PUZ_1100)
puzzle(13, 9,PUZ_0101)
puzzle(14, 9,PUZ_0101)
puzzle(15, 9,PUZ_0000)
puzzle(16, 9,PUZ_0101)
puzzle(17, 9,PUZ_0101)
puzzle(18, 9,PUZ_1001)
puzzle(18, 8,PUZ_1010)
puzzle(18, 7,PUZ_1010)
puzzle(18, 6,PUZ_1010)
puzzle(18, 5,PUZ_0000)
puzzle(18, 4,PUZ_1010)
puzzle(18, 3,PUZ_1010)
puzzle(18, 2,PUZ_0011)
puzzle(17, 2,PUZ_0101)
puzzle(16, 2,PUZ_0101)
puzzle(15, 2,PUZ_0100)

oxyd(  6, 0)
oxyd( 12, 5)
oxyd( 19, 5)
oxyd( 11, 6)
oxyd(  7,11)
oxyd( 14,11)

oxyd_shuffle()


set_actor("ac-blackball", 9, 6.5)
