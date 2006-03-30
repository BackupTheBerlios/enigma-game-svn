--
-- A level for Enigma
--
-- Copyright (c) 2003 Siegfried Fennig
-- Licensed under the GPL version 2.

levelw = 20
levelh = 13

create_world(levelw, levelh)
oxyd_default_flavor = "b"
fill_floor("fl-wood")

fill_floor("fl-water", 1,1, 18,1)
fill_floor("fl-water", 1,11, 18,1)
fill_floor("fl-water", 1,2, 1,10)
fill_floor("fl-water", 18,2, 1,10)

oxyd( 6, 5)
oxyd( 13,7)
oxyd( 5, 7)
oxyd( 14,5)
oxyd_shuffle()

fakeoxyd(5,3)
fakeoxyd(8,3)
fakeoxyd(13,3)
fakeoxyd(16,3)

draw_stones("st-invisible", {9,2}, {1,0},2)
draw_stones("st-grate2", {9,3}, {1,0},2)
draw_stones("st-grate2", {9,9}, {1,0},2)

set_stone("st-switch", 3,3, {action="openclose", target="door1"})
set_stone("st-switch", 4,3, {action="openclose", target="door2"})
set_stone("st-switch", 14,3, {action="openclose", target="door3"})
set_stone("st-switch", 15,3, {action="openclose", target="door4"})
set_stone("st-switch", 6,4, {action="openclose", target="door5"})
set_stone("st-switch", 7,4, {action="openclose", target="door6"})
set_stone("st-switch", 8,4, {action="openclose", target="door7"})
set_stone("st-switch", 11,4, {action="openclose", target="door8"})
set_stone("st-switch", 12,4, {action="openclose", target="door9"})
set_stone("st-switch", 13,4, {action="openclose", target="door10"})
set_stone("st-switch", 3,5, {action="openclose", target="door11"})
set_stone("st-switch", 4,5, {action="openclose", target="door12"})
set_stone("st-switch", 13,5, {action="openclose", target="door13"})
set_stone("st-switch", 15,5, {action="openclose", target="door14"})
set_stone("st-switch", 16,5, {action="openclose", target="door15"})
set_stone("st-switch", 4,6, {action="openclose", target="door16"})
set_stone("st-switch", 6,6, {action="openclose", target="door17"})
set_stone("st-switch", 7,6, {action="openclose", target="door18"})
set_stone("st-switch", 8,6, {action="openclose", target="door19"})
set_stone("st-switch", 11,6, {action="openclose", target="door20"})
set_stone("st-switch", 13,6, {action="openclose", target="door21"})
set_stone("st-switch", 3,7, {action="openclose", target="door22"})
set_stone("st-switch", 4,7, {action="openclose", target="door23"})
set_stone("st-switch", 6,7, {action="openclose", target="door24"})
set_stone("st-switch", 8,7, {action="openclose", target="door25"})
set_stone("st-switch", 15,7, {action="openclose", target="door26"})
set_stone("st-switch", 4,8, {action="openclose", target="door27"})
set_stone("st-switch", 6,8, {action="openclose", target="door28"})
set_stone("st-switch", 8,8, {action="openclose", target="door29"})
set_stone("st-switch", 11,8, {action="openclose", target="door30"})
set_stone("st-switch", 13,8, {action="openclose", target="door31"})
set_stone("st-switch", 15,8, {action="openclose", target="door32"})
set_stone("st-switch", 3,9, {action="openclose", target="door33"})
set_stone("st-switch", 4,9, {action="openclose", target="door34"})
set_stone("st-switch", 5,9, {action="openclose", target="door35"})
set_stone("st-switch", 14,9, {action="openclose", target="door36"})
set_stone("st-switch", 15,9, {action="openclose", target="door37"})
set_stone("st-switch", 16,9, {action="openclose", target="door38"})

set_stone("st-door_c", 11,3, {name="door1"})
set_stone("st-door_c", 12,3, {name="door2"})
set_stone("st-door_c", 6,3, {name="door3"})
set_stone("st-door_c", 7,3, {name="door4"})
set_stone("st-door_c", 14,4, {name="door5"})
set_stone("st-door_c", 15,4, {name="door6"})
set_stone("st-door_c", 16,4, {name="door7"})
set_stone("st-door_c", 3,4, {name="door8"})
set_stone("st-door_c", 4,4, {name="door9"})
set_stone("st-door_c", 5,4, {name="door10"})
set_stone("st-door_c", 11,5, {name="door11"})
set_stone("st-door_c", 12,5, {name="door12"})
set_stone("st-door_c", 5,5, {name="door13"})
set_stone("st-door_c", 7,5, {name="door14"})
set_stone("st-door_c", 8,5, {name="door15"})
set_stone("st-door_c", 12,6, {name="door16"})
set_stone("st-door_c", 14,6, {name="door17"})
set_stone("st-door_c", 15,6, {name="door18"})
set_stone("st-door_c", 16,6, {name="door19"})
set_stone("st-door_c", 3,6, {name="door20"})
set_stone("st-door_c", 5,6, {name="door21"})
set_stone("st-door_c", 11,7, {name="door22"})
set_stone("st-door_c", 12,7, {name="door23"})
set_stone("st-door_c", 14,7, {name="door24"})
set_stone("st-door_c", 16,7, {name="door25"})
set_stone("st-door_c", 7,7, {name="door26"})
set_stone("st-door_c", 12,8, {name="door27"})
set_stone("st-door_c", 14,8, {name="door28"})
set_stone("st-door_c", 16,8, {name="door29"})
set_stone("st-door_c", 3,8, {name="door30"})
set_stone("st-door_c", 5,8, {name="door31"})
set_stone("st-door_c", 7,8, {name="door32"})
set_stone("st-door_c", 11,9, {name="door33"})
set_stone("st-door_c", 12,9, {name="door34"})
set_stone("st-door_c", 13,9, {name="door35"})
set_stone("st-door_c", 6,9, {name="door36"})
set_stone("st-door_c", 7,9, {name="door37"})
set_stone("st-door_c", 8,9, {name="door38"})

set_actor("ac-blackball", 10, 6.5)










