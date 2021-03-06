-- This is the library used by all Sokoban levels
-- Filename: 	ralf_sokoban.lua
-- Copyright: 	(C) Mar 2003 Ralf Westram
-- Contact: 	amgine@reallysoft.de
-- License: 	GPL v2.0 or above

dofile(enigma.FindDataFile("levels/ralf.lua"))

--debug_mode()
show_restricted = 0 -- set to 1 to use different floors for restricted areas (for debugging)
start_solved = 0 -- set to 1 to start solved (for debugging)
test=0
--if not difficult then
--   test=1 -- set this to 1 for st-brake testing
--end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- characters allowed in level:
--
-- '!'      space outside level
-- ' '      normalfloor
-- '_'      normalfloor (unreachable after pushing all boxes onto targets)
-- '='      normalfloor (very likely a bad position for any adjacent oxyd)
-- 'x'      normalfloor (completely unreachable)
-- '#'      walls
-- 'o'      boxes
-- 'O'      boxes (on '_')
-- '0'      boxes (on '=')
-- '.'      targets
-- '*'      box on target
-- '@'      player
-- '+'      player (on target)
-- 'a'      player (on '_')
-- 'A'      player (on '=')

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

space_faces  = { "fl-space", "fl-leaves", "fl-abyss", "fl-water",  "fl-sahara" }
space_faces2 = { "",         "",          "",         "",          "fl-rough-blue" }
spacewalk    = {  1,          1,           0,          0,           1,         }

-- do NOT change the number of elements!
floor_faces = { "fl-bluegray",  "fl-tigris",         "fl-rough",     "fl-samba", "fl-wood",  "fl-himalaya",  "fl-leaves" }
wall_faces  = { "st-bluegray",  "st-rock6",          "st-rock1",     "st-rock5", "st-glass", "st-rock4",     "st-rock3"  }
floor_faces2= { "fl-white",  "fl-acblack",        "fl-light",     "",         "",         "fl-rough-red", ""          }
wall_faces2 = { "st-metal",     "st-likeoxydc-open", "st-blue-sand", "",         "",         "st-glass",     ""          }

box_faces  = { "st-brownie",  "st-marble_move", "st-wood",         "st-shogun", "st-glass_move",      "st-block" }
box_faces2 = { "",            "st-rock3_move",  "st-wood-growing", "",          "st-greenbrown_move", ""         }

if ((getn(floor_faces) ~= getn(floor_faces2))
    or (getn(wall_faces) ~= getn(wall_faces2))
       or (getn(box_faces) ~= getn(box_faces2))
       or (getn(space_faces) ~= getn(space_faces2)))
then
   error("wrong size in one of the face arrays")
end

door_faces = { "st-door_a", "st-door_b", "st-door_c" }
door_faces2 = { "", "", "st-blocker" }
oxyd_flavors = { "a", "b", "c", "d" }

shogunLaser = 0 -- if set to 1 then lasers are used to activate oxyds (this only works with shogun stones)
swapStyle = 1 -- if set to 0 then  swap-stones are never used as boxes (otherwise swapStyle is selected randomly)
invisible = 0 -- if set to 1 then boxes are invisible
boxlikewall = 0 -- if set to 1 then boxes look like walls
useSwapStyle = 1 -- local value of 'swapStyle'
improve = 0 -- if set to 1 in level file -> always improve_solvability()
scrolling=0 -- if set to 1 in level file -> always use free-scrolling
reverse_scrolling=0 -- if set to 1 in level file -> if scrolling use reverse floor 

-- Symmetry information:
xsymm = 0
ysymm = 0
psymm = 0

triggers = 0
doors = 0
lasers = 0

space_count = 0 -- count occurances of space (outside level)

triggerstate = "" -- current state of the triggers
shuffle = {} -- contains random permutation (to select trigger targets)
shuffletrig = {} -- contains random permutation (to select triggers)

position = {} -- positions of doors
positions = 0

locked_door_triggered = 0 -- one of the doors is locked until ALL targets are covered
locked_door = 1

boxx = {}
boxy = {}

function init_globals()
   triggers = 0
   doors = 0
   lasers = 0
   space_count = 0
   triggerstate = ""
   shuffle = {}
   shuffletrig = {}
   position = {}
   positions = 0
   locked_target_triggered = 0
   locked_target = 1
   setboxes=0
   currtestbox=1
   game_lost=0
   laser_flickered=0
end

-----------------------------------------

function init_shuffle(targets)
   local set = {}
   for i=1,targets do set[i] = i end

   local left = targets
   for count=1,targets do
      local sel = random(1,left)
      shuffle[count] = set[sel]
      set[sel] = set[left]
      left = left-1
      -- debug("shuffle["..count.."]="..shuffle[count])
   end

   local settrig = {}
   for i=1,triggers do settrig[i] = i end

   left = triggers
   for count=1,triggers do
      local sel = random(1,left)
      shuffletrig[count] = settrig[sel]
      settrig[sel] = settrig[left]
      left = left-1
      -- debug("shuffletrig["..count.."]="..shuffletrig[count])
   end
end

function unflicker_laser()
   if (laser_flickered~=0) then
      SendMessage("laser"..laser_flickered, "on")
      laser_flickered=0
   end
end

flicker_next_tries = {}

function flicker_lasers()
   unflicker_laser()
   for retries=1,4 do
      local left = getn(flicker_next_tries) 
      if (left==0) then
         flicker_next_tries = {}
         for all=1,lasers do flicker_next_tries[all] = all end
         left = lasers
      end

      local r = random(1,left)
      local sel = flicker_next_tries[r]
      flicker_next_tries[r] = flicker_next_tries[left]
      tremove(flicker_next_tries)

      if (sel ~= locked_target or not strfind(triggerstate,"0")) then
         local laser = enigma.GetNamedObject("laser"..sel)
         local state = GetAttrib(laser,"on")

         if (state==1) then
            laser_flickered=sel
            SendMessage(laser, "off")
            return
         end
      end
   end
end


function trig_doorlaser(which,is_door,targets)
   unflicker_laser()
   which = shuffletrig[which]
   local state = strsub(triggerstate,which,which)
   if (state == "0") then state = "1" else state = "0" end

   local trig_target = -1
   if (targets == triggers) then -- 1 trigger <-> 1 door
      trig_target = which
   else
      local s0,s1 = 0,0
      if (state=="1") then s1 = 1 else s0 = 1 end

      local w2 = which-targets
      local wlow = which
      while (w2 > 0) do
         local state2 = strsub(triggerstate,w2,w2)
         if (state2=="1") then s1 = s1+1 else s0 = s0+1 end
         wlow = w2
         w2 = w2-targets
      end
      w2 = which+targets
      while (w2 <= triggers) do
         local state2 = strsub(triggerstate,w2,w2)
         if (state2=="1") then s1 = s1+1 else s0 = s0+1 end
         w2 = w2+targets
      end

      debug("s0="..s0.." s1="..s1.." wlow="..wlow)

      if ((s0==0) or (s0==1 and state=="0")) then
         trig_target = wlow
      end
   end

   triggerstate = strsub(triggerstate,1,which-1)..state..strsub(triggerstate,which+1)
   local all_covered = not strfind(triggerstate,"0")
   debug(triggerstate)
   debug("trig_target="..trig_target);

   if (trig_target ~= -1) then
      if (trig_target ~= locked_target) then
         if (is_door==1) then
            local msg="open"
            if (state=="0") then msg="close" end -- state is the NEW value
            SendMessage("door"..shuffle[trig_target], msg)
         else
            local msg="on"
            if (state=="0") then msg="off" end -- state is the NEW value
            SendMessage("laser"..shuffle[trig_target], msg)
         end
      end
   end

   if (all_covered) then
      if (locked_target_triggered==0) then
         if (is_door==1) then
            SendMessage("door"..shuffle[locked_target], "open")
         else
            SendMessage("laser"..shuffle[locked_target], "on")
         end
         locked_target_triggered = 1
      end
   else
      if (locked_target_triggered==1) then
         if (is_door==1) then
            SendMessage("door"..shuffle[locked_target], "close")
         else
            SendMessage("laser"..shuffle[locked_target], "off")
         end
         locked_target_triggered = 0
      end
   end
   debug("locked_target_triggered="..locked_target_triggered)
end

function trig_door(which)
   trig_doorlaser(which,1,doors)
end
function trig_laser(which)
   trig_doorlaser(which,0,lasers)
end

-- actors position
acx = 0
acy = 0

function set_the_actor(x,y)
   acx,acy = x+.5,y+.5
end

function set_soko_trigger(x,y)
   triggers = triggers + 1
   local funcn = "trig_"..triggers
   if (shogunLaser==1) then
      dostring(funcn.." = function() trig_laser("..triggers..") end")
   else
      dostring(funcn.." = function() trig_door("..triggers..") end")
   end
   set_item(triggerface,x,y,{action="callback", target=funcn})
end

function set_actor_on_trigger(x,y)
   set_the_actor(x,y)
   set_soko_trigger(x,y)
end

--spacemod = 2

function set_space_floor(x,y)
   set_floor(spaceface,x,y)
end

function set_glasswall(x,y)
   if (mod(x,2)==mod(y,2)) then
      set_floor(floorface,x,y)
   else
      set_space_floor(x,y)
   end
   set_stone("st-glass",x,y)
end

function set_spacecell(x,y)
   space_count = space_count+1
   set_space_floor(x,y)
end

function set_box(x,y)
   setboxes=setboxes+1
   local boxname = "box"..setboxes
   if (test==1) then
      set_stone("st-brake",x,y,{name=boxname});
   elseif (boxface=="st-glass1" or boxface=="sokoban_box") then
      print("boxface="..boxface);
      set_stone(boxface,x,y,{movable=1,name=boxname});
   else
      print("boxface="..boxface);
      set_stone(boxface,x,y,{name=boxname})
   end
end

function init(num)
   init_globals()

   local first = 0
   if (num == -1) then
      first = 1
      num = 0
   end

   spaceface  = space_faces [mod(num, getn(space_faces))+1]
   spaceface2 = space_faces2[mod(num, getn(space_faces))+1]
   floorface  = floor_faces [mod(num, getn(floor_faces))+1]
   floorface2 = floor_faces2[mod(num, getn(floor_faces))+1]
   wallface   = wall_faces  [mod(num, getn(wall_faces))+1]
   wallface2  = wall_faces2 [mod(num, getn(wall_faces))+1]
   boxface    = box_faces   [mod(num, getn(box_faces))+1]
   boxface2   = box_faces2  [mod(num, getn(box_faces))+1]
   doorface   = door_faces  [mod(num, getn(door_faces))+1]
   doorface2  = door_faces2 [mod(num, getn(door_faces))+1]

   if ((spaceface2 ~= "") and (mod(floor(num/getn(space_faces)),2)==1)) then
      spaceface,spaceface2 = spaceface2,spaceface
   end
   if ((floorface2 ~= "") and (mod(floor(num/(getn(floor_faces)*2)),2)==1)) then
      floorface,floorface2 = floorface2,floorface
   end
   if ((wallface2 ~= "") and (mod(floor(num/getn(wall_faces)),2)==1)) then
      wallface,wallface2 = wallface2,wallface
   end
   if ((boxface2 ~= "") and (mod(floor(num/getn(box_faces)),2)==1)) then
      boxface,boxface2 = boxface2,boxface
   end
   if ((doorface2 ~= "") and (mod(floor(num/getn(door_faces)),2)==1)) then
      doorface,doorface2 = doorface2,doorface
   end

   -- select style
   useSwapStyle=0
   if (shogunLaser==1) then -- shogunLaser has been set from level file
      boxface = "st-shogun"
      --elseif (swapStyle==1) then -- if swapStyle is not forbidden
      --   local n=mod(num,17)
      --   if (n==10 or n==16) then -- 2 of 17 levels use swapStyle
      --      useSwapStyle=1
      --   end
   elseif (swapStyle==2) then -- swapStyle forced
      useSwapStyle=1
   end

   if (useSwapStyle==1) then
      if not difficult then
         useSwapStyle=0
      else
         boxface="st-swap"
      end
   end

   if (reverse_scrolling==1 and not difficult) then
      floorface = "fl-inverse"
   end

   if (not difficult) then
      invisible=0
      boxlikewall=0
   end

   if (invisible==1) then
      world.DefineSimpleStoneMovable("sokoban_box", "stone", 0)
      display.DefineAlias("sokoban_box", "st-invisible")
      boxface="sokoban_box"
   end
   if (boxlikewall==1) then
      world.DefineSimpleStoneMovable("sokoban_box", "stone", 0)
      display.DefineAlias("sokoban_box", wallface)
      boxface="sokoban_box"
   end

   oxyd_default_flavor = oxyd_flavors[mod(num, getn(oxyd_flavors))+1]

   if (spaceface == floorface) then
      if (spaceface == "fl-leaves") then
         spaceface = "fl-water"
      else
         print("warning: [ralf_sokoban.lua]: no replacement texture defined for "..spaceface)
      end
   end

   if (boxface == "st-shogun") then triggerface = "it-shogun-s"
   else                             triggerface = "it-trigger"
   end

   cells={}
   stonecells={}

   if (useSwapStyle==1) then
      local grate_faces = { "st-grate1", "st-grate2", }
      cells[" "] = cell{floor={face=floorface},stone={face=grate_faces[mod(floor(num/8), getn(grate_faces))+1]}}
      if (show_restricted==1) then
         cells["_"] = cell{floor={face="fl-sand"},stone={face=grate_faces[mod(floor(num/8), getn(grate_faces))+1]}}
         cells["x"] = cell{floor={face="fl-ice"},stone={face=grate_faces[mod(floor(num/8), getn(grate_faces))+1]}}
         cells["="] = cell{floor={face="fl-red"},stone={face=grate_faces[mod(floor(num/8), getn(grate_faces))+1]}}
      end
      cells["#"] = cell{floor="fl-water"}
   else
      cells[" "] = cell{floor={face=floorface}}
      if (show_restricted==1) then
         cells["_"] = cell{floor={face="fl-sand"}}
         cells["x"] = cell{floor={face="fl-ice"}}
         cells["="] = cell{floor={face="fl-red"}}
      end
      if (wallface=="st-glass") then
         cells["#"] = cell{parent=set_glasswall}
      else
         cells["#"] = cell{parent = cells[" "], stone = {face = wallface}}
      end
   end

   cells["!"] = cell{parent = {set_spacecell}}
   if (show_restricted==0) then
      cells["_"] = cells[" "]
      cells["x"] = cells[" "]
      cells["="] = cells[" "]
   end

   cells["o"] = cells[" "]
   cells["O"] = cells["_"]
   cells["0"] = cells["="]
   cells["."] = cell{parent = {cells[" "], set_soko_trigger}}
   cells["@"] = cell{parent = {cells[" "], set_the_actor}}
   cells["a"] = cell{parent = {cells["_"], set_the_actor}}
   cells["A"] = cell{parent = {cells["="], set_the_actor}}

   cells["*"] = cells["."]
   cells["+"] = cell{parent = {cells[" "], set_actor_on_trigger}}

   stonecells["!"] = cell{}
   stonecells[" "] = cell{}
   stonecells["_"] = cell{}
   stonecells["x"] = cell{}
   stonecells["="] = cell{}
   stonecells["#"] = cell{}
   if (show_restricted==1) then
      stonecells["o"] = cell{floor={face=floorface},parent={set_box}}
      stonecells["O"] = cell{floor={face="fl-sand"},parent={set_box}}
      stonecells["0"] = cell{floor={face="fl-red"},parent={set_box}}
   else
      stonecells["o"] = cell{floor={face=floorface},parent={set_box}}
      stonecells["O"] = stonecells["o"]
      stonecells["0"] = stonecells["o"]
   end

   if (start_solved==1) then
      stonecells["."] = cell{floor={face=floorface},parent={set_box}}
      stonecells["*"] = stonecells["."]
      stonecells["o"] = cell{floor={face=floorface}}
      if (show_restricted==1) then
         stonecells["O"] = cell{floor={face="fl-sand"}}
         stonecells["0"] = cell{floor={face="fl-red"}}
      else
         stonecells["O"] = stonecells["o"]
         stonecells["0"] = stonecells["o"]
      end
   else
      stonecells["."] = cell{}
      stonecells["*"] = stonecells["o"]
   end

   stonecells["@"] = cell{}
   stonecells["a"] = cell{}
   stonecells["A"] = cell{}
   stonecells["+"] = cell{}

end

-- wether there's space outside the level
spl = 0
spr = 0
spt = 0
spb = 0

spaceres = {}
spaceres[0] = '-' -- means: don't use because it's outside the level
spaceres[1] = '!'

-- look at a specifix position of the level
-- supports 1 position outside level into each direction
function peek(x,y)
   if (x<1)    then return spaceres[spl] end
   if (x>mapw) then return spaceres[spr] end
   if (y<1)    then return spaceres[spt] end
   if (y>maph) then return spaceres[spb] end

   return strsub(level[y],x,x)
end

function rpeek(rx,ry)
   return peek(rx-xlo+1,ry-ylo+1)
end

function adjacent(x1,y1,x2,y2) -- returns TRUE if the two positions are adjacent
   local dx,dy = abs(x1-x2),abs(y1-y2)
   return (dx==0 and dy==1) or (dx==1 and dy==0)
end

-- locations of state[] indices:
--
--         3
--       1 P 2
--         4

xoff = { -1,  1,  0,  0 }
yoff = {  0,  0, -1,  1 }

function is_in_restricted_area(p)
   local xd,yd = position[p][1],position[p][2]
   local xo,yo = position[p][3],position[p][4]
   local xf,yf = xd+(xd-xo),yd+(yd-yo)

   -- debug("xf="..xf.." yf="..yf)

   local c = rpeek(xf,yf)
   if (c==' ' or c=='o' or c=='@') then return 0 end -- not restricted
   if (c=='_' or c=='O' or c=='a') then return 1 end -- restricted -> dont put final oxyd here
   if (c=='=' or c=='0' or c=='A') then return 1 end -- forbidden!

   return 2 -- somethings wrong!
end

--function symmetric_position(x,y,w,h)
--   if (xsymm==1) then return w-(x-xlo)+xlo,y end
--   if (ysymm==1) then return x,h-(y-ylo)+ylo end
--   if (psymm==1) then return h-(y-ylo)+xlo,x-xlo+ylo end
--   return x,y
--end

function symmetric_position(x,y,w,h)
   if (xsymm==1) then return w-x+1,y end
   if (ysymm==1) then return x,h-y+1 end
   if (psymm==1) then return h-y+1,x end
   return x,y
end

removed_indices={}
removed = 0

function rs_remove_oxyd(p,w,h)
   removed_indices={}
   removed = 0
   local x1,y1 = position[p][1],position[p][2]
   if (xsymm+ysymm+psymm) then
      local symmcount = 1
      if (psymm==1) then symmcount=3 end
      for c=1,symmcount do
         local x2,y2 = symmetric_position(x1,y1,w,h)
         for q=1,positions do
            if ((q~=p) and (x2==position[q][1]) and (y2==position[q][2])) then
               tremove(position,q)
               removed = removed+1
               removed_indices[removed] = q
               positions = positions-1
               if (q<p) then p = p-1 end
               break
            end
         end
         x1,y1 = x2,y2
      end
   end

   tremove(position,p)
   removed = removed+1
   removed_indices[removed] = p
   positions = positions-1
end

maxoxyds = 999

function install_oxyds(w,h) -- uses Nat's method (see nat7.lua)
   for x=1,w do
      for y=1,h do
         if (peek(x,y)=='#') then
            local state = {}
            state[1] = peek(x-1,y)
            state[2] = peek(x+1,y)
            state[3] = peek(x,y-1)
            state[4] = peek(x,y+1)

            local reachable = 0
            local spacehere = 0
            local forbidden = 0
            for n=1,4 do
               if (state[n]=='!') then
                  if (spacehere == 0) then
                     spacehere = n
                  else
                     -- positions with more than 1 adjacent space should never be used as doors
                     -- (because you may escape there)
                     if (shogunLaser==0) then
                        spacehere = -1
                     else -- does not matter in shogunLaser-mode
                        -- ensure symmetry
                        if (xsymm==1 and (x==(w-x+1))) then
                           spacehere = n -- use oxyd in y direction
                        end
                     end
                  end
               end

               if (state[n]==' ' or state[n]=='o' or state[n]=='@' or state[n]=='_' or state[n]=='O' or state[n]=='a') then
                  if (reachable == 0) then
                     reachable = n
                  else
                     -- positions with more than 1 adjacent floor should never be used as doors
                     -- (because they change the level logic)
                     reachable = -1
                  end
               end

               if (state[n]=='=' or state=='0' or state=='A') then
                  forbidden = 1
               end
            end

            if (((reachable>0) or (shogunLaser==1)) and (spacehere>0) and (forbidden==0)) then
               positions = positions+1
               position[positions] = {x,y,x+xoff[spacehere], y+yoff[spacehere]}
            end
         end
      end
   end

   -- delete adjacent oxyds and adjacent doors
   -- [first those with two neighbours or more neighbours, then those with one neighbour]
   for delif=2,1,-1 do
      local deleted = 1
      while (deleted==1) do
         deleted = 0
         for p=1,positions do
            local xd1,yd1 = position[p][1],position[p][2]
            local xo1,yo1 = position[p][3],position[p][4]
            local oneighbours = 0
            local dneighbours = 0
            for q=1,positions do
               if (p~=q) then
                  local xd2,yd2 = position[q][1],position[q][2]
                  local xo2,yo2 = position[q][3],position[q][4]

                  if (xo1==xo2 and yo1==yo2) then -- oxyds use same position
                     oneighbours = delif
                     break
                  elseif (adjacent(xo1,yo1,xo2,yo2)) then
                     oneighbours = oneighbours+1
                     if (oneighbours==delif) then break end
                  end

                  if (adjacent(xd1,yd1,xd2,yd2)) then
                     dneighbours = dneighbours+1
                     if (dneighbours==delif) then break end
                  end
               end
            end
            if ((oneighbours>=delif) or (dneighbours>=delif)) then
               rs_remove_oxyd(p,w,h)
               deleted = 1
               break
            end
         end
      end
   end

   -- delete superfluous oxyds
   local want_remove = 0

   if (maxoxyds>triggers) then maxoxyds = triggers end
   if (maxoxyds>16) then maxoxyds = 16 end

   if (positions>maxoxyds) then
      want_remove = positions-maxoxyds
      debug("maxoxyds="..maxoxyds.." want_remove="..want_remove);
   end

   if (mod(positions-want_remove,2)==1) then want_remove = want_remove+1 end

   debug("positions="..positions.." want_remove="..want_remove);

   if ((psymm+xsymm+ysymm)>0) then
      local isSymmetric = {}
      local sym_count = 0
      local sym_count_single = 0
      local per_remove = 0

      for p=1,positions do isSymmetric[p] = 0 end
      if (psymm==1) then -- central symmetry
         per_remove=4
         for p=1,positions do
            if (isSymmetric[p]==0) then
               local x1,y1 = position[p][1],position[p][2]
               local allFound = 1
               local index={}
               for r=1,3 do
                  local x2,y2 = symmetric_position(x1,y1,w,h)
                  local found = 0
                  for q=1,positions do
                     if (p~=q and position[q][1]==x2 and position[q][2]==y2) then
                        local inUse=0
                        for r2=1,r-1 do
                           if (index[r2]==q) then inUse=1 break end
                        end
                        if (inUse==0) then
                           found=1
                           index[r]=q
                           break
                        end
                     end
                  end
                  if (found==0) then allFound = 0 break end
                  x1,y1 = x2,y2
               end
               if (allFound==1) then
                  isSymmetric[p]=1
                  for r=1,3 do isSymmetric[index[r]]=1 end
                  sym_count = sym_count+4
                  local array=""
                  for p=1,positions do array=array..isSymmetric[p] end
                  debug("isSymmetric="..array);
               end
            end
         end
      else
         per_remove=2
         for p=1,positions do
            if (isSymmetric[p]==0) then
               local x1,y1 = position[p][1],position[p][2]
               local x2,y2 = symmetric_position(x1,y1,w,h)

               if (x1==x2 and y1==y2) then
                  isSymmetric[p] = 2
                  sym_count_single = sym_count_single+1
               else
                  for q=1,positions do
                     if (p~=q and position[q][1]==x2 and position[q][2]==y2) then
                        isSymmetric[p] = 1
                        isSymmetric[q] = 1
                        sym_count = sym_count+2
                        break
                     end
                  end
               end
            end
         end
      end

      local assym_count = positions-(sym_count+sym_count_single)

      -- debug("positions="..positions.." sym_count="..sym_count.." sym_count_single="..sym_count_single.." assym_count="..assym_count);

      -- first remove assymetric positions
      if (assym_count>0 and want_remove>0) then
         for p=positions,1,-1 do
            if (isSymmetric[p]==0) then
               tremove(position,p);
               tremove(isSymmetric,p);
               want_remove = want_remove-1
               positions = positions-1
               assym_count = assym_count-1

               if (want_remove==0) then break end
            end
         end
      end

      -- then remove some symmetric positions
      while (want_remove>=per_remove) do
         if (sym_count<per_remove) then error("internal counter error") end
         local todel = 0
         for p=1,positions do -- try randomly
            local q = random(1,positions)
            if (isSymmetric[q]==1) then todel = q break end
         end
         if (todel==0) then -- if failed try by sequence
            for p=1,positions do
               if (isSymmetric[p]==1) then todel=p break end
            end
         end
         if (todel>0) then -- correct isSymmetric
            rs_remove_oxyd(todel,w,h)
            if (removed ~= per_remove) then error("internal error: removed ~= per_remove") end
            sym_count=sym_count-per_remove
            want_remove = want_remove-per_remove
            for r=1,removed do
               tremove(isSymmetric,removed_indices[r]);
            end
         end
      end

      -- now remove single symmetric positions
      while (want_remove>0 and sym_count_single>0) do
         for p=positions,1,-1 do
            if (isSymmetric[p]==2) then
               tremove(position,p);
               tremove(isSymmetric,p);
               want_remove = want_remove-1
               positions = positions-1
               sym_count_single = sym_count_single-1

               if (want_remove==0) then break end
            end
         end
      end
   end

   -- remove random stones for assymetric levels (or if symmetric remove failed)

   while (want_remove>0) do
      local p = random(1,positions)
      tremove(position,p);
      want_remove = want_remove-1
      positions=positions-1
   end

   if (mod(positions,2)==1) then -- final check for even oxyd count
      tremove(position,random(1,positions))
      positions = positions-1
   end

   -- end of oxyd removal

   debug("left oxyds: "..positions);

   if (positions == 0) then
      error("No oxyds were installed.")
   end

   -- transform to "real" coordinates
   for p=1,positions do
      position[p][1] = position[p][1]+xlo-1
      position[p][2] = position[p][2]+ylo-1
      position[p][3] = position[p][3]+xlo-1
      position[p][4] = position[p][4]+ylo-1
   end

   -- now really set oxyds
   for p=1,positions do
      local xd,yd = position[p][1],position[p][2]
      local xo,yo = position[p][3],position[p][4]

      enigma.KillStone(xd,yd)
      enigma.KillStone(xo,yo)

      if (shogunLaser==1) then
         lasers = lasers+1
         local d
         if (xd==xo) then
            if (yd>yo) then d = NORTH else d = SOUTH end
         else
            if (xd>xo) then d = WEST else d = EAST end
         end
         set_stone("st-laser",xd,yd,{name="laser"..lasers, dir=d,on=0})
      else
         doors = doors+1
         local d = "v"
         if (xd==xo) then d = "h" end
         set_floor(floorface,xd,yd)
         set_stone(doorface,xd,yd, {name="door"..doors, type=d})
      end
      oxyd(xo,yo)
      debug("- setting oxyd to "..xo.."/"..yo)
   end

   debug("Oxyds set: "..doors.." Triggers: "..triggers)

   return 0
end

function correct_locked_target_position()
   if (shogunLaser==1) then
      locked_target=random(1,lasers)
      return 1
   end

   local multiTriggeredDoors = triggers-doors
   if (multiTriggeredDoors>0 and multiTriggeredDoors<doors) then
      locked_target = multiTriggeredDoors+1 -- dont use multitrigger door (makes levels nearly unsolvable)
   end

   debug("correct_locked_target_position: locked_target="..locked_target.." doors="..doors.." multiTriggeredDoors="..multiTriggeredDoors);

   while (locked_target <= doors) do
      local ld = shuffle[locked_target]
      local restricted = is_in_restricted_area(ld)

      local xd,yd = position[ld][1],position[ld][2]
      debug("[locked door] ld="..ld.." xd="..xd.." yd="..yd.." restricted="..restricted)

      if (restricted == 0) then return 1 end
      locked_target = locked_target+1
   end
   debug("Could not correct position of locked target. Not playable!");
   return 0
end

function correct_multi_trigger_doors()
   if (doors == triggers) then return 1 end -- each trigger has exactly one door => no problem

   local multiTriggeredDoors = triggers-doors
   if (multiTriggeredDoors > doors) then multiTriggeredDoors = doors end
   for mtd=1,multiTriggeredDoors do
      local ld = shuffle[mtd]
      local restricted = is_in_restricted_area(ld)

      local xd,yd = position[ld][1],position[ld][2]
      debug("[multit door] ld="..ld.." xd="..xd.." yd="..yd.." restricted="..restricted)

      if (restricted ~= 0) then return 0 end
   end
   return 1
end

function correct_target_positions()
   local ok = correct_locked_target_position()
   if (ok==1 and shogunLaser==0) then
      ok = correct_multi_trigger_doors()
   end

   return ok
end

function improve_solvability()
   -- returns 1 if level got better solvable
   if (shogunLaser==1) then
      return 1 -- already 'best' solvable
   end

   local was_improved = 0

   local is_avail = {}
   local oxyd_color = {}
   local restricted = {}
   local oxyd = {}

   local color_oxyd1 = {}
   local color_oxyd2 = {}

   local colors = doors/2
   debug("Different oxyd colors: "..colors)
   for c=0,colors-1 do
      color_oxyd1[c] = nil
      color_oxyd2[c] = nil
   end

   for unshuffled=1,doors do
      local curr_door = shuffle[unshuffled]
      local xo2,yo2 = position[curr_door][3],position[curr_door][4]

      debug("oxyd #"..curr_door.." at "..xo2.."/"..yo2)

      oxyd[curr_door] = enigma.GetStone(xo2,yo2)
      local color = get_attrib(oxyd[curr_door],"color")+0 -- make color numeric
      is_avail[curr_door] = 1
      oxyd_color[curr_door] = color
      restricted[curr_door] = is_in_restricted_area(curr_door)

      if (color_oxyd1[color]==nil) then
         color_oxyd1[color] = curr_door
      else
         if (color_oxyd2[color]==nil) then
            color_oxyd2[color] = curr_door
         else
            error("Oxyd color '"..color.."' used 3 times ("..color_oxyd1[color]..", "..color_oxyd2[color].." and "..curr_door..").");
         end
      end
   end

   local partner_oxyd = {}
   for c=0,colors-1 do
      local o1 = color_oxyd1[c]
      local o2 = color_oxyd2[c]

      if (o2==nil) then
         if (o1==nil) then error("Expected to have oxyds of color "..c) end
         error("Only one oxyd of color "..c.." (Oxyd #"..o1..")")
      end

      debug("partner oxyds: "..o1.." and "..o2)

      partner_oxyd[o1] = o2
      partner_oxyd[o2] = o1
   end

   local oxyds_to_improve = {} -- holds all oxyds which shall be improved
   local improve_count = 0

   -- add oxyds to improve:

   -- check whether partner oxyds of locked oxyd is in restricted area
   local locked_oxyds_partner = partner_oxyd[shuffle[locked_target]]
   if (restricted[locked_oxyds_partner]==1) then
      improve_count = improve_count+1
      oxyds_to_improve[improve_count] = locked_oxyds_partner
   end
   local multiTriggeredDoors = triggers-doors
   if (multiTriggeredDoors>0) then
      -- check whether partner oxyds of multi-trigger oxyds are in restricted area
      for m=1,multiTriggeredDoors do
         local curr_door = shuffle[m]
         local multi_triggereds_partner = partner_oxyd[curr_door]

         if (restricted[multi_triggereds_partner]==1) then
            improve_count = improve_count+1
            oxyds_to_improve[improve_count] = multi_triggereds_partner
         end
      end
   end

   if (improve_count>0) then
      -- make 'oxyds to improve' and their partners unavailable

      for i=1,improve_count do
         is_avail[oxyds_to_improve[i]] = 0
         is_avail[partner_oxyd[oxyds_to_improve[i]]] = 0
      end

      -- actually improve

      for i=1,improve_count do
         local curr_oxyd = oxyds_to_improve[i]
         debug("improving oxyd #"..curr_oxyd)

         local othr_oxyd = nil
         local o=1
         while (othr_oxyd==nil and o<=doors) do
            if (is_avail[o]==1) then othr_oxyd=o end
            o=o+1
         end

         debug("Exchanging oxyd #"..curr_oxyd.." (color="..oxyd_color[curr_oxyd]..") with oxyd #"..othr_oxyd.." (color="..oxyd_color[othr_oxyd]..")")

         -- exchange colors
         local c1 = oxyd_color[curr_oxyd]
         local c2 = oxyd_color[othr_oxyd]
         --set_attrib(oxyd[curr_oxyd], "color", c2) -- this does not work c2->double->string-> e.g. '3.000' instead of '3'
         --set_attrib(oxyd[othr_oxyd], "color", c1)
         set_attrib(oxyd[curr_oxyd], "color", format("%i",c2))
         set_attrib(oxyd[othr_oxyd], "color", format("%i",c1))

         debug("checking set colors: color1="..get_attrib(oxyd[curr_oxyd],"color").." color2="..get_attrib(oxyd[othr_oxyd],"color"));

         oxyd_color[curr_oxyd] = c2
         oxyd_color[othr_oxyd] = c1

         -- exchange availability
         is_avail[othr_oxyd] = 0
         is_avail[curr_oxyd] = 1

         -- exchange partners
         local p1 = partner_oxyd[curr_oxyd]
         local p2 = partner_oxyd[othr_oxyd]
         partner_oxyd[p1] = othr_oxyd
         partner_oxyd[p2] = curr_oxyd
         partner_oxyd[curr_oxyd] = p2
         partner_oxyd[othr_oxyd] = p1
      end
      was_improved = 1
   else
      debug("Nothing to improve.")
   end

   return was_improved
end


function choose_symmetry()
   if (xsymm==1 and ysymm==1) then ysymm=0 end -- prefer x-symmetry

   while ((xsymm+ysymm+psymm) > 1) do
      local r = random(1,3)
      if (r==1) then xsymm = 0
      elseif (r==2) then ysymm = 0
      else psymm = 0
      end
   end

   debug("----------------------------------------");
   if (xsymm==1) then debug("Symmetry: X") end
   if (ysymm==1) then debug("Symmetry: Y") end
   if (psymm==1) then debug("Symmetry: central") end
end

-- lost the game?

function stone_at(x,y)
   -- result==0 -> no stone (or ignored)
   -- result==1 -> yes
   -- result==2 -> yes (but movable)

   local stone = enigma.GetStone(x,y)
   if (not stone) then
      --print("no stone at "..x.."/"..y);
      if (useSwapStyle==1) then return 1 end

      if (doorface=="st-blocker") then
         local item = enigma.GetItem(x,y)
         if (item and GetKind(item)=="it-blocker") then return 1 end
      end
      return 0
   end

   local kind = enigma.GetKind(stone)
   --print("found stone '"..kind.."' at "..x.."/"..y.." boxface="..boxface.." wallface="..wallface)

   if (kind == "st-death") then return 1 end
   if (kind == boxface) then return 2 end
   if (kind == doorface) then return 1 end
   if (kind == "borderstone") then return 1 end

   if (useSwapStyle==1) then
      if (strsub(kind,1,8) == "st-grate") then return 0 end
   else
      if (kind == wallface) then return 1 end
      if (strsub(kind,1,7)=="st-wood" and boxface=="st-wood") then return 2 end
   end
   print("stone '"..kind.."' was ignored!");
   return 0
end

function moveable(st1,st2)
   -- result==0 -> yes
   -- result==1 -> no
   -- result==2 -> maybe

   if (st1==0) then
      if (st2==0) then return 0
      else return st2 end
   else
      if (st2==0) then
         return st1
      else
         if (st1==1 or st2==1) then return 1
         else return 2 end
      end
   end
end

function lost_game(x,y)
   local w = stone_at(x-1,y)
   local e = stone_at(x+1,y)
   local h = moveable(e,w)
   if (h==0) then return 0 end

   local n = stone_at(x,y-1)
   local s = stone_at(x,y+1)
   local v = moveable(n,s)
   if (v==0) then return 0 end

   if (h==1 and v==1) then return 1 end

   -- none is 0 and not both are 1
   -- do slower but safe check

   --debug("at "..x.."/"..y.." w="..w.." e="..e.." n="..n.." s="..s.." h="..h.." v="..v)

   if (h==1) then -- horizontal move is imposible
      -- check horizontal move for neighbor box
      if (s==2) then -- theres a box south
         local se,sw = stone_at(x+1,y+1),stone_at(x-1,y+1)
         if (moveable(se,sw)==1) then return 1 end -- which cannot be moved east-west
      end
      if (n==2) then -- theres a box north
         local ne,nw = stone_at(x+1,y-1),stone_at(x-1,y-1)
         if (moveable(ne,nw)==1) then return 1 end -- which cannot be moved east-west
      end
   end
   if (v==1) then -- vertical move is imposible
      -- check vertical move for neighbor box
      if (w==2) then -- theres a box west
         local nw,sw = stone_at(x-1,y-1),stone_at(x-1,y+1)
         if (moveable(nw,sw)==1) then return 1 end -- which cannot be moved north-south
      end
      if (e==2) then -- theres a box east
         local ne,se = stone_at(x+1,y-1),stone_at(x+1,y+1)
         if (moveable(ne,se)==1) then return 1 end -- which cannot be moved north-south
      end
   end

   -- finally check for a box of 4 stones
   if (w~=0) then
      if (n~=0) then
         if (stone_at(x-1,y-1)~=0) then return 1 end
      end
      if (s~=0) then
         if (stone_at(x-1,y+1)~=0) then return 1 end
      end
   end
   if (e~=0) then
      if (n~=0) then
         if (stone_at(x+1,y-1)~=0) then return 1 end
      end
      if (s~=0) then
         if (stone_at(x+1,y+1)~=0) then return 1 end
      end
   end

   return 0
end

one_died = 0 -- set to 1 as soon as one box is lost

function recheck_all_boxes()
   for b=1,setboxes do
      local box=enigma.GetNamedObject("box"..b)
      boxx[b]=-1
      boxy[b]=-1
      if (box) then
         local x,y = enigma.GetPos(box)

         if (x~=-1 and y~=-1) then
            local item = enigma.GetItem(x,y)
            if (item) then
               if (one_died==0 and enigma.GetKind(item)==triggerface) then
                  -- print("no recheck for box at "..x.."/"..y)
                  boxx[b]=x
                  boxy[b]=y
               end
            end
         end
      end
   end
end

skip_timer=0
do_recheck=1

function timer_cb()
   if (shogunLaser==1) then
      flicker_lasers()
   end

   if (skip_timer>0) then
      skip_timer=skip_timer-1
   else
      local max_repeat=3 -- to avoid deadlock
      local rep=1
      local recheck=0

      while (rep==1 and max_repeat>0) do
         rep = 0
         max_repeat=max_repeat-1

         for b=1,setboxes do
            local box=enigma.GetNamedObject("box"..b)
            if (box) then
               local x,y = enigma.GetPos(box)
               if (x~=boxx[b] or y~=boxy[b]) then -- box position has changed
                  --print("Checking pos "..x.."/"..y.." (boxx="..boxx[b]..",boxy="..boxy[b]..")");
                  local die = 0;
                  local item = enigma.GetItem(x,y)

                  if ((not item) or one_died==1) then die = 1
                  elseif (enigma.GetKind(item)~=triggerface) then die = 1
                  end

                  if (die==1) then
                     if (lost_game(x,y)==1) then
                        game_lost = 1
                        enigma.EmitSound(box,"stonetransform");
                        enigma.KillStone(x,y);
                        set_stone("st-death",x,y);
                        --print("kill stone at "..x.."/"..y);
                        rep=1
                        recheck=1
                        one_died=1
                     end
                  else -- box on trigger
                     if (lost_game(x,y)) then
                        recheck=1
                     end
                  end
                  boxx[b] = x;
                  boxy[b] = y;
               end
               -- else print("box expected")
            end
         end

         if (recheck==1) then recheck_all_boxes() end
      end
   end
end

function play_sokoban(level,num)
   local w,h = get_map_size(level)
   local tries = 80
   local ok = 0

   randomseed(enigma.GetTicks())
   choose_symmetry()

   if (w>20 or h>13) then
      scrolling=1
   end
   --scrolling=1 -- test

   if (scrolling==1) then
      for i=h,1,-1 do
         level[i+1]="!"..level[i].."!"
      end
      w,h = w+2,h+2
      level[1] = strrep("!",w)
      level[h] = strrep("!",w)

      preferred_width,preferred_height = w+40,h+26
   end

   while ((tries > 0) and (maxoxyds > 0) and (ok == 0)) do
      init(num-1)
      randomseed(enigma.GetTicks())
      rs_create_world(level,cells,set_spacecell,set_spacecell)

      enigma.ConserveLevel = FALSE
      enigma.ShowMoves = TRUE

      if (scrolling==1) then
         spl,spr,spt,spb = 1,1,1,1 -- everywhere is space
      else
         if (xlo > 0) then
            spl = 1 -- there's space at the left side
            space_count = space_count + maph
         end
         if (ylo > 0) then
            spt = 1 -- there's space at the top side
            space_count = space_count + mapw
         end
         if ((xlo+mapw) < 20) then
            spr = 1 -- there's space at the right side
            space_count = space_count + maph
         end
         if ((ylo+maph) < 13) then
            spb = 1 -- there's space at the bottom side
            space_count = space_count + mapw
         end
      end

      debug("Space aside: spl="..spl.." spr="..spr.." spt="..spt.." spb="..spb);

      -- install oxyds
      install_oxyds(w,h)
      local targets=doors
      if (shogunLaser==1) then targets=lasers end
      init_shuffle(targets) -- mix trigger-door associations
      ok = correct_target_positions()
      -- ok = 1
      if (ok == 0) then
         debug("---------------------------------------- re-initializing..");
      end
      tries = tries - 1
      -- if (maxoxyds > 2) then maxoxyds = maxoxyds - 1 end
   end

   if (ok==0) then
      error("Sorry - couldn't correct door positions. Avoiding deadlock (try again)");
   end

   triggerstate = strrep("0",triggers)

   if scrolling==1 then
      display.SetFollowMode(display.FOLLOW_SMOOTH)
   else
      display.SetFollowMode(display.FOLLOW_SCROLLING)
   end

   draw_map(xlo,ylo,level,stonecells)
   set_actor("ac-blackball",acx,acy)

   oxyd_shuffle()
   if (improve==1 or (doors>8) or (doors>4 and not difficult)) then
      improve_solvability()
   end

   -- change some names for game_lost
   if (boxface=="st-wood-growing") then boxface="st-wood" end
   if (shogunLaser==1) then doorface="st-laser" end

   -- activate callback:
   if (test==0) then
      skip_timer=3
      for b=1,setboxes do
         boxx[b]=-1
         boxy[b]=-1
      end
      set_stone("st-timer", 0,0, {action="callback", target="timer_cb", interval=0.3, invisible=1})
   end

end

