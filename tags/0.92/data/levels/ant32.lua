-- Everhungry -- the Enigma Level
-- (c) 2003 Petr Machata/ant_39
-- Licensed under GPL v2.0 or above
-- 2003-02-12

Require("levels/ant.lua")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local shatter_map = {count=0, effct=1}
local intact_fields = {}

-- shatter given piece of floor
function bombit(x0, y0)
   bomb = set_item("it-blackbomb", x0, y0)
   SendMessage(bomb, "explode")
   %shatter_map[getkey(x0,y0)] = {x=x0, y=y0}
   %shatter_map.count = %shatter_map.count+1
   %shatter_map[%shatter_map.count] = %shatter_map[getkey(x0,y0)]
end

-- add given field to list of intact fields
function add_intact(x0, y0)
   %intact_fields[getkey(x0,y0)] = 1
end

-- move the eater
function tick()
   if ((%shatter_map.count or 0)==0) then bombit(10,7) return end
   if (%shatter_map.effct > %shatter_map.count) then return end

   local minx, maxx = 1, level_width-2
   local miny, maxy = 1, level_height-2 

   local count = 0,0
   local found = -1
   local x0,y0, x1,y1 = 0,0, 0,0

   repeat
      -- once the array is empty, there are no shatters left to satisfy conditions
      if (%shatter_map.effct > %shatter_map.count) then return end
      -- pick a field from shatter array and movement direction
      local m = %shatter_map.count
      local d = random(1,4)
      -- setup coordinates
      x0, y0 = %shatter_map[m].x, %shatter_map[m].y
      x1, y1 = x0, y0
      -- setup flags
      found = 1
      count= 0

      repeat
	 if     (d == 1) then x1=x0+0 y1=y0-1
	 elseif (d == 2) then x1=x0+1 y1=y0+0
	 elseif (d == 3) then x1=x0+0 y1=y0+1
	 elseif (d == 4) then x1=x0-1 y1=y0+0
	 end

	 d = d+1
	 if (d>4) then d=d-4 end

	 count=count+1
	 if (count>4) then found=0 break end

	 cond = (not(%shatter_map[getkey(x1,y1)] or %intact_fields[getkey(x1,y1)]))
      until cond

      --if not found, this square is inner void
      if (found == 0) then
	 -- swap
	 local rem = %shatter_map[%shatter_map.effct]
	 %shatter_map[%shatter_map.effct] = %shatter_map[m]
	 %shatter_map[m] = rem
	 -- move effective counter of shatter array
	 %shatter_map.effct = %shatter_map.effct+1
      end
   until (found==1)

   bombit(x1,y1)
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
floor = cell{floor="fl-tigris"}
stone = cell{stone="st-rock5"}
spring= cell{item= "it-spring1"}
actor = cell{actor={"ac-blackball", {player=0}}, parent=spring}
timer = cell{stone={"st-timer", {action="callback", target="tick", interval=0.2}}}
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

create_world(20, 13)
fill_world_func(floor)
draw_border_func({stone,add_intact})

timer(0,0)
set_funcs(oxyd, {{0,1},{0,6},{0,11},{19,1},{19,6},{19,11}})
set_funcs(add_intact, {{1,1},{1,6},{1,11},{18,1},{18,6},{18,11}})
oxyd_shuffle()

actor(1,1)
