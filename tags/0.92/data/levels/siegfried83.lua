--
-- A level for Enigma
--
-- Copyright (c) 2003 Siegfried Fennig
-- Licensed under the GPL version 2.

levelw = 20
levelh = 13

create_world(levelw, levelh)
draw_border("st-rock4")
enigma.ConserveLevel = FALSE
--oxyd_default_flavor = "d"
fill_floor("fl-bluegreen")

function renderLine( line, pattern)
    for i=1, strlen(pattern) do
      local c = strsub( pattern, i, i)
      if c =="t" then
         set_stone("st-turnstile",i-1,line)
      elseif c == "n" then
         set_stone("st-turnstile-n",i-1,line)
      elseif c == "e" then
         set_stone("st-turnstile-e",i-1,line)
      elseif c == "s" then
         set_stone("st-turnstile-s",i-1,line)
      elseif c == "w" then
         set_stone("st-turnstile-w",i-1,line)
      elseif c == "r" then
         set_stone("st-rock4",i-1,line)
      elseif c == "X" then
         set_stone("st-swap",i-1,line)
      elseif c == "Y" then
         set_stone("st-wood",i-1,line)
      elseif c == "E" then
         set_stone("st-oneway-e",i-1,line)
      elseif c == "S" then
         set_stone("st-oneway-s",i-1,line)
      elseif c == "W" then
         set_stone("st-oneway-w",i-1,line)
      elseif c == "q" then
         set_item("it-trigger",i-1,line, {action="callback", target="callback1"})
      elseif c == "p" then
         set_item("it-trigger",i-1,line, {action="callback", target="callback2"})
      elseif c == "l" then
         set_attrib(laser(i-1,line, 0, NORTH), "name", "laser")
      elseif c == "m" then
         mirrorp(i-1,line,0,1,3)
      elseif c == "M" then
         mirrorp(i-1,line,0,1,1)
      elseif c == "f" then
         mirror3(i-1,line,0,0,1)
      elseif c == "H" then
         set_item("it-hollow",i-1,line)
      elseif c == "h" then
         set_item("it-tinyhollow",i-1,line)
      elseif c == "K" then
         set_item("it-hill",i-1,line)
      elseif c == "k" then
         set_item("it-tinyhill",i-1,line)
      elseif c == "Z" then
         set_item("it-spade",i-1,line)
      elseif c == "i" then
         yy1( "white",  i-1, line)
      elseif c == "j" then
         yy1( "black",  i-1, line)
      elseif c == "o" then
         set_stone("st-oxyd",i-1,line,{color="1", flavor="d"})
      elseif c == "#" then
         set_floor("fl-water",i-1,line)
      elseif c == "a" then
         set_actor("ac-blackball", i-.5,line+.5)
         set_item("it-yinyang", i-1, line+.5)
      elseif c == "b" then
         set_actor("ac-whiteball", i-.5,line+.5)
         set_item("it-yinyang", i-1, line+.5)
      elseif c == "d" then
         document(i-1,line,"Dig in...")
        end
    end
end

function yy1( color, x, y)
        stone = format( "st-%s1", color)
        set_stone( stone, x, y)
end

--              01234567890123456789
renderLine(00, "                    ")
renderLine(01, " rrrrrroMmfMorrrrrr ")
renderLine(02, " rrrrr########rrrrr ")
renderLine(03, " rrrrrrr jk rrrrrrr ")
renderLine(04, " rrrrrrr rl rrrrrrr ")
renderLine(05, " rrrrrrr rr rrrrrrr ")
renderLine(06, " rrrrr E  X Ejrrrrr ")
renderLine(07, " rr Zr rwtterSrrrrr ")
renderLine(08, " rriYr W s HYjrrrrr ")
renderLine(09, " rr hrrr rr jjrr n  ")
renderLine(10, " rr  hK  rr rrrrwte ")
renderLine(11, " rrr    irrda b qsp ")
renderLine(12, "                    ")
--              01234567890123456789

trigger1 = 0
trigger2 = 0

function triggeraction()
    lasera=enigma.GetNamedObject("laser")
    if trigger1 == 1 and trigger2 == 1 then
        SendMessage(lasera, "on")
    end
    if trigger1 == 0 and trigger2 == 1 then
        SendMessage(lasera, "off")
    end
    if trigger1 == 1 and trigger2 == 0 then
        SendMessage(lasera, "off")
    end
    if trigger1 == 0 and trigger2 == 0 then
        SendMessage(lasera, "off")
    end
end

function callback1 (ispressed)
     trigger1=ispressed
     triggeraction()
end

function callback2 (ispressed)
     trigger2=ispressed
     triggeraction()
end

