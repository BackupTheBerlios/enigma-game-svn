--
-- A level for Enigma
--
-- Copyright (c) 2003 Siegfried Fennig
-- Licensed under the GPL version 2.

levelw = 20
levelh = 13

create_world(levelw, levelh)
enigma.ConserveLevel = FALSE
oxyd_default_flavor = "d"
fill_floor("fl-samba")

function renderLine( line, pattern)
    for i=1, strlen(pattern) do
      local c = strsub( pattern, i, i)
      if c =="t" then
         set_stone("st-timeswitch",i-1,line)
      elseif c == "w" then
         set_stone("st-break_acwhite",i-1,line)
      elseif c == "1" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback1"})
      elseif c == "2" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback2"})
      elseif c == "3" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback3"})
      elseif c == "4" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback4"})
      elseif c == "5" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback5"})
      elseif c == "6" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback6"})
      elseif c == "7" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback7"})
      elseif c == "8" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback8"})
      elseif c == "9" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback9"})
      elseif c == "l" then
         set_attrib(laser(i-1,line, FALSE, NORTH), "name", "laser")
      elseif c == "A" then
         set_attrib(mirror3(i-1,line,0,0,2), "name", "mirror01")
      elseif c == "B" then
         set_attrib(mirrorp(i-1,line,0,1,3), "name", "mirror02")
      elseif c == "C" then
         set_attrib(mirror3(i-1,line,0,0,4), "name", "mirror03")
      elseif c == "D" then
         set_attrib(mirrorp(i-1,line,0,0,4), "name", "mirror04")
      elseif c == "E" then
         set_attrib(mirrorp(i-1,line,0,1,4), "name", "mirror05")
      elseif c == "F" then
         set_attrib(mirror3(i-1,line,0,1,1), "name", "mirror06")
      elseif c == "G" then
         set_attrib(mirrorp(i-1,line,0,0,1), "name", "mirror07")
      elseif c == "H" then
         set_attrib(mirrorp(i-1,line,0,1,2), "name", "mirror08")
      elseif c == "I" then
         set_attrib(mirror3(i-1,line,0,0,2), "name", "mirror09")
      elseif c == "K" then
         set_attrib(mirror3(i-1,line,0,0,2), "name", "mirror10")
      elseif c == "L" then
         set_attrib(mirror3(i-1,line,0,0,2), "name", "mirror11")
      elseif c == "M" then
         set_attrib(mirrorp(i-1,line,0,0,2), "name", "mirror12")
      elseif c == "N" then
         set_attrib(mirror3(i-1,line,0,0,1), "name", "mirror13")
      elseif c == "O" then
         set_attrib(mirrorp(i-1,line,0,1,4), "name", "mirror14")
      elseif c == "P" then
         set_attrib(mirror3(i-1,line,0,0,3), "name", "mirror15")
      elseif c == "Q" then
         set_attrib(mirrorp(i-1,line,0,0,2), "name", "mirror16")
      elseif c == "o" then
         oxyd( i-1, line)
      elseif c == "a" then
         set_actor("ac-blackball", i, line+.5)
        end
    end
end
--              01234567890123456789
renderLine(00, "tt8ttttttttttttttttt")
renderLine(01, "t  to o o o o owwwwt")
renderLine(02, "1  twwwwwwwwwwwwwwwt")
renderLine(03, "2  twwwwwwwwwwwwwwwt")
renderLine(04, "3  twwwwwwwwwwwwwwwt")
renderLine(05, "4  tABwwCwDwEwFwwwwt")
renderLine(06, "5  twwwwwwwwwwwwwwwt")
renderLine(07, "6a tGHIwKwLwMwNwwwwt")
renderLine(08, "t  twwwwwwwwwwwwwwwt")
renderLine(09, "7  twOwwPwQwwwwwwwwt")
renderLine(10, "t  twwwwwwwwwwwwwwwt")
renderLine(11, "t  twwwwwwwwwwwwwwwt")
renderLine(12, "tt9ttltttttttttttttt")
--              01234567890123456789

oxyd_shuffle()

switch1 = 0
switch2 = 0
switch3 = 0
switch4 = 0
switch5 = 0
switch6 = 0
switch7 = 0
switch8 = 0
switch9 = 0

function switchaction()
    lasera=enigma.GetNamedObject("laser")
    if switch8 == 1 or switch9 == 1 then
       SendMessage(lasera, "on")
    end
    if switch8 == 0 and switch9 == 0 then
       SendMessage(lasera, "off")
    end
    mir1=enigma.GetNamedObject("mirror01")
    mir2=enigma.GetNamedObject("mirror02")
    if switch1 == 1 or switch4 == 1 then
       SendMessage(mir1, "mirror-east")
       SendMessage(mir2, "mirror-east")
    end
    if switch1 == 0 and switch4 == 0 then
       SendMessage(mir1, "mirror-west")
       SendMessage(mir2, "mirror-north")
    end
    mir3=enigma.GetNamedObject("mirror03")
    if switch2 == 1 or switch4 == 1 then
       SendMessage(mir3, "mirror-north")
    end
    if switch2 == 0 and switch4 == 0 then
       SendMessage(mir3, "mirror-east")
    end
    mir4=enigma.GetNamedObject("mirror04")
    if switch3 == 1 or switch4 == 1 then
       SendMessage(mir4, "mirror-south")
    end
    if switch3 == 0 and switch4 == 0 then
       SendMessage(mir4, "mirror-east")
    end
    mir5=enigma.GetNamedObject("mirror05")
    if switch4 == 1 or switch5 == 1 then
       SendMessage(mir5, "mirror-west")
    end
    if switch4 == 0 and switch5 == 0 then
       SendMessage(mir5, "mirror-east")
    end
    mir6=enigma.GetNamedObject("mirror06")
    if switch4 == 1 then
       SendMessage(mir6, "mirror-west")
    end
    if switch4 == 0 then
       SendMessage(mir6, "mirror-south")
    end
    mir7=enigma.GetNamedObject("mirror07")
    mir8=enigma.GetNamedObject("mirror08")
    if switch1 == 1 or switch6 == 1 then
       SendMessage(mir7, "mirror-west")
       SendMessage(mir8, "mirror-east")
    end
    if switch1 == 0 and switch6 == 0 then
       SendMessage(mir7, "mirror-south")
       SendMessage(mir8, "mirror-west")
    end
    mir9 =enigma.GetNamedObject("mirror09")
    mir13=enigma.GetNamedObject("mirror13")
    if switch6 == 1 then
       SendMessage(mir9,  "mirror-north")
       SendMessage(mir13, "mirror-west")
    end
    if switch6 == 0 then
       SendMessage(mir9,  "mirror-west")
       SendMessage(mir13, "mirror-south")
    end
    mir10=enigma.GetNamedObject("mirror10")
    if switch2 == 1 or switch6 == 1 then
       SendMessage(mir10, "mirror-south")
    end
    if switch2 == 0 and switch6 == 0 then
       SendMessage(mir10, "mirror-west")
    end
    mir11=enigma.GetNamedObject("mirror11")
    if switch3 == 1 or switch6 == 1 then
       SendMessage(mir11, "mirror-north")
    end
    if switch3 == 0 and switch6 == 0 then
       SendMessage(mir11, "mirror-west")
    end
    mir12=enigma.GetNamedObject("mirror12")
    if switch5 == 1 or switch6 == 1 then
       SendMessage(mir12, "mirror-east")
    end
    if switch5 == 0 and switch6 == 0 then
       SendMessage(mir12, "mirror-west")
    end
    mir14=enigma.GetNamedObject("mirror14")
    if switch1 == 1 or switch7 == 1 then
       SendMessage(mir14, "mirror-south")
    end
    if switch1 == 0 and switch7 == 0 then
       SendMessage(mir14, "mirror-east")
    end
    mir15=enigma.GetNamedObject("mirror15")
    if switch2 == 1 or switch7 == 1 then
       SendMessage(mir15, "mirror-west")
    end
    if switch2 == 0 and switch7 == 0 then
       SendMessage(mir15, "mirror-north")
    end
    mir16=enigma.GetNamedObject("mirror16")
    if switch3 == 1 or switch7 == 1 then
       SendMessage(mir16, "mirror-east")
    end
    if switch3 == 0 and switch7 == 0 then
       SendMessage(mir16, "mirror-west")
    end
end

function callback1 (ison)
     switch1=ison
     switchaction()
end

function callback2 (ison)
     switch2=ison
     switchaction()
end

function callback3 (ison)
     switch3=ison
     switchaction()
end

function callback4 (ison)
     switch4=ison
     switchaction()
end

function callback5 (ison)
     switch5=ison
     switchaction()
end

function callback6 (ison)
     switch6=ison
     switchaction()
end

function callback7 (ison)
     switch7=ison
     switchaction()
end

function callback8 (ison)
     switch8=ison
     switchaction()
end

function callback9 (ison)
     switch9=ison
     switchaction()
end
