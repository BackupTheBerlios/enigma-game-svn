--
-- A level for Enigma
--
-- Copyright (c) 2003 Siegfried Fennig
-- Licensed under the GPL version 2.

levelw = 20
levelh = 49

create_world(levelw, levelh)
enigma.ConserveLevel = FALSE
oxyd_default_flavor = "d"
fill_floor("fl-normal")

function renderLine( line, pattern)
    for i=1, strlen(pattern) do
      local c = strsub( pattern, i, i)
      if c == "r" then
         set_stone("st-rock1",i-1,line)
      elseif c == "R" then
         set_stone("st-rock1_hole",i-1,line)
      elseif c == "1" then
         set_floor("fl-gradient",  i-1,  line, {type=21})
      elseif c == "3" then
         set_floor("fl-gradient",  i-1,  line, {type=23})
      elseif c == "4" then
         set_floor("fl-gradient",  i-1,  line, {type=24})
      elseif c == "D" then
         set_stone("st-death",i-1,line)
      elseif c == "T" then
         set_stone("st-timeswitch",i-1,line)
      elseif c == "e" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback1"})
      elseif c == "f" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback2"})
      elseif c == "g" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback3"})
      elseif c == "h" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback4"})
      elseif c == "i" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback5"})
      elseif c == "j" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback6"})
      elseif c == "k" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback7"})
      elseif c == "l" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback8"})
      elseif c == "m" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback9"})
      elseif c == "E" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback10"})
      elseif c == "F" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback11"})
      elseif c == "G" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback12"})
      elseif c == "H" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback13"})
      elseif c == "L" then
         set_attrib(laser(i-1,line, FALSE, EAST), "name", "laser")
      elseif c == "x" then
         set_attrib(laser(i-1,line, FALSE, SOUTH), "name", "laser1")
      elseif c == "#" then
         set_floor("fl-abyss",i-1,line)
      elseif c == "o" then
         oxyd( i-1, line)
      elseif c == "a" then
         set_actor("ac-blackball", i-.5,line+.5)
        end
    end
end
--              01234567890123456789
renderLine(00, "rrrrrrrrrrxrrrrrrrrr")
renderLine(01, "r    T T           r")
renderLine(02, "r    T T           r")
renderLine(03, "r            o     r")
renderLine(04, "r                  r")
renderLine(05, "r  o             TTr")
renderLine(06, "r                  r")
renderLine(07, "r     a          TTr")
renderLine(08, "r            efgh  r")
renderLine(09, "L              oi  r")
renderLine(10, "r        E G lmkj  r")
renderLine(11, "r        F H       r")
renderLine(12, "rrrrrrrrrrRrrrrrrrrr")
renderLine(13, "########r111r#######")
renderLine(14, "########r111r#######")
renderLine(15, "########r111r#######")
renderLine(16, "########r111r#######")
renderLine(17, "########r111r#######")
renderLine(18, "########r111r#######")
renderLine(19, "########r111r#######")
renderLine(20, "rrrrrrrrr111r#######")
renderLine(21, "r44444444411r#######")
renderLine(22, "r14444444441r#######")
renderLine(23, "r11444444444r#######")
renderLine(24, "r111rrrrrrrrr#######")
renderLine(25, "r111r###############")
renderLine(26, "r111r###############")
renderLine(27, "r111r###############")
renderLine(28, "r111r###############")
renderLine(29, "r111r###############")
renderLine(30, "r111r###############")
renderLine(31, "r111r###############")
renderLine(32, "r111rrrrrrrrrrrrrrrr")
renderLine(33, "r113333333333333331r")
renderLine(34, "r133333333333333311r")
renderLine(35, "r333333333333333311r")
renderLine(36, "rrrrrrrrrrrrrrrrr11r")
renderLine(37, "r               r11r")
renderLine(38, "r               r11r")
renderLine(39, "r               r11r")
renderLine(40, "r   o           r11r")
renderLine(41, "r               r11r")
renderLine(42, "r               r11r")
renderLine(43, "r               r11r")
renderLine(44, "r               r11r")
renderLine(45, "r                11r")
renderLine(46, "r                11r")
renderLine(47, "r                11r")
renderLine(48, "rrrrrrrrrrrrrrrrrDDr")
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
switch10 = 0
switch11 = 0
switch12 = 0
switch13 = 0

function switchaction()
    lasera=enigma.GetNamedObject("laser")
    if switch1 == 1 or switch2 == 1 or switch3 == 1 or
       switch4 == 1 or switch5 == 1 or switch6 == 1 or
       switch7 == 1 or switch8 == 1 or switch9 == 1 then
       SendMessage(lasera, "on")
    end
    if switch1 == 0 and switch2 == 0 and switch3 == 0 and
       switch4 == 0 and switch5 == 0 and switch6 == 0 and
       switch7 == 0 and switch8 == 0 and switch9 == 0 then
       SendMessage(lasera, "off")
    end
    laserb=enigma.GetNamedObject("laser1")
    if switch10 == 1 or switch11 == 1 or
       switch12 == 1 or switch13 == 1 then
       SendMessage(laserb, "on")
    end
    if switch10 == 0 and switch11 == 0 and
       switch12 == 0 and switch13 == 0  then
       SendMessage(laserb, "off")
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

function callback10 (ison)
     switch10=ison
     switchaction()
end

function callback11 (ison)
     switch11=ison
     switchaction()
end

function callback12 (ison)
     switch12=ison
     switchaction()
end

function callback13 (ison)
     switch13=ison
     switchaction()
end
