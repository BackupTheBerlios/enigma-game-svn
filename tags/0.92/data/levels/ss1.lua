-- A level for Enigma
-- Name:	Easy?
-- Copyright: 	(C) 2003 Sven Siggelkow
-- License: 	GPL v2.0 or above

levelw = 20
levelh = 13

create_world(levelw, levelh)
oxyd_default_flavor = "c"       -- Default flavor for oxyd stones.

draw_border("st-rock1")
fill_floor("fl-rough")

draw_stones ("st-rock1", {5,2},{1,0},11)
draw_stones ("st-rock1", {5,6},{1,0},5)
draw_stones ("st-rock1", {11,6},{1,0},5)
draw_stones ("st-rock1", {5,2},{0,1},5)
draw_stones ("st-rock1", {15,2},{0,1},5)
draw_stones ("st-rock1", {8,7},{0,1},5)
draw_stones ("st-rock1", {12,7},{0,1},5)
set_stone ("st-rock1",10,3)

draw_floor ("fl-water",{9,11},{1,0},3)

set_stone ("st-shogun",7,4)
draw_stones ("st-shogun", {9,4},{1,0},5)

shogundot1( 9, 7, {action="callback" , target="trig1"})
shogundot1( 9, 8, {action="callback" , target="trig2"})
shogundot1( 9, 9, {action="callback" , target="trig3"})
shogundot1( 9,10, {action="callback" , target="trig4"})
shogundot1(10, 9, {action="callback" , target="trig5"})
shogundot1(11, 9, {action="callback" , target="trig6"})

oxyd(1,11)
oxyd(18,11)

set_actor("ac-blackball", 10.5,5.5)

-- Ansrechbar als %door
local door = set_stone("st-door-v", 15, 4)

-- Ansprechbar als %switches
local switches={0,0,0,0,0,0}
doorsopen=0

function trig1 () trigger(1) end 
function trig2 () trigger(2) end 
function trig3 () trigger(3) end
function trig4 () trigger(4) end
function trig5 () trigger(5) end
function trig6 () trigger(6) end

function trigger(num)
   %switches[num] = 1-%switches[num]
   all=1
   for x=1,6 do
      if (%switches[x]==0) then
         all = 0
      end
   end
   if (doorsopen==0 and all==1) then
      SendMessage(%door, "open", TRUE)
      doorsopen = 1
   elseif (doorsopen==1 and all==0) then
      SendMessage(%door, "close", FALSE)
      doorsopen = 0
   end
end