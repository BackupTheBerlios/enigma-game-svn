--
-- A level for Enigma
--
-- Copyright (c) 2003 Siegfried Fennig
-- Licensed under the GPL version 2.

levelw = 58
levelh = 13

create_world(levelw, levelh)
enigma.ConserveLevel = FALSE
oxyd_default_flavor = "d"
fill_floor("fl-rough")

function renderLine( line, pattern)
    for i=1, strlen(pattern) do
      local c = strsub( pattern, i, i)
      if c == "+" then
         set_stone("st-rock3_break",i-1,line)
      elseif c == "r" then
         set_stone("st-blue-sand",i-1,line)
      elseif c == "*" then
         set_stone("st-grate1",i-1,line)
      elseif c == "#" then
         fill_floor("fl-abyss", i-1,line, 1,1)
      elseif c == "A" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door13"})
      elseif c == "a" then
         doorv( i-1,line, {name="door13"})
      elseif c == "C" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door14"})
      elseif c == "c" then
         doorv( i-1,line, {name="door14"})
      elseif c == "D" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door15"})
      elseif c == "d" then
         doorv( i-1,line, {name="door15"})
      elseif c == "E" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door16"})
      elseif c == "e" then
         doorv( i-1,line, {name="door16"})
      elseif c == "I" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door17"})
      elseif c == "i" then
         doorv( i-1,line, {name="door17"})
      elseif c == "J" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door18"})
      elseif c == "j" then
         doorv( i-1,line, {name="door18"})
      elseif c == "K" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door19"})
      elseif c == "k" then
         doorh( i-1,line, {name="door19"})
      elseif c == "L" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door20"})
      elseif c == "l" then
         doorh( i-1,line, {name="door20"})
      elseif c == "M" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door21"})
      elseif c == "m" then
         doorh( i-1,line, {name="door21"})
      elseif c == "N" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door22"})
      elseif c == "n" then
         doorh( i-1,line, {name="door22"})
      elseif c == "P" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door23"})
      elseif c == "p" then
         doorh( i-1,line, {name="door23"})
      elseif c == "Q" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door24"})
      elseif c == "q" then
         doorh( i-1,line, {name="door24"})
      elseif c == "S" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door25"})
      elseif c == "s" then
         doorh( i-1,line, {name="door25"})
      elseif c == "T" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door26"})
      elseif c == "t" then
         doorh( i-1,line, {name="door26"})
      elseif c == "U" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door27"})
      elseif c == "u" then
         doorh( i-1,line, {name="door27"})
      elseif c == "V" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door28"})
      elseif c == "v" then
         doorh( i-1,line, {name="door28"})
      elseif c == "W" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door29"})
      elseif c == "w" then
         doorh( i-1,line, {name="door29"})
      elseif c == "X" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door30"})
      elseif c == "x" then
         doorh( i-1,line, {name="door30"})
      elseif c == "Y" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door31"})
      elseif c == "y" then
         doorv( i-1,line, {name="door31"})
      elseif c == "Z" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door32"})
      elseif c == "z" then
         doorv( i-1,line, {name="door32"})
      elseif c == "G" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door33"})
      elseif c == "g" then
         doorv( i-1,line, {name="door33"})
      elseif c == "F" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door34"})
      elseif c == "f" then
         doorv( i-1,line, {name="door34"})
      elseif c == "B" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door35"})
      elseif c == "b" then
         doorv( i-1,line, {name="door35"})
      elseif c == "O" then
         set_stone("st-coinslot", i-1,line, {action="openclose", target="door36"})
      elseif c == "o" then
         doorv( i-1,line, {name="door36"})
      elseif c == "(" then
         set_item("it-vortex-closed", i-1,line)
      elseif c == "4" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback1"})
      elseif c == "5" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback2"})
      elseif c == "6" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback3"})
      elseif c == "7" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback4"})
      elseif c == "8" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback5"})
      elseif c == "9" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback6"})
      elseif c == "3" then
         set_stone("st-timeswitch",i-1,line, {action="callback", target="callback7"})
      elseif c == ")" then
         set_item("it-vortex-closed", i-1,line, {targetx = 18.5, targety =  11.5, name="vortex1"})
      elseif c == "1" then
         set_item("it-coin1", i-1,line)
      elseif c == "2" then
         set_item("it-coin4", i-1,line)
      elseif c == "?" then
         set_item("it-hammer", i-1,line)
      elseif c == ":" then
         set_item("it-key_a",i-1,line)
      elseif c == ";" then
         set_stone("st-key_a",i-1,line, {action="openclose", target="door37"})
      elseif c == "," then
         doorh( i-1,line, {name="door37"})
      elseif c == "%" then
         set_stone("st-door",i-1,line, {name="door38",  type="v"})
      elseif c == "&" then
        set_stone("st-door",i-1,line, {name="door39",  type="v"})
      elseif c == "-" then
         oxyd( i-1, line)
      elseif c == "=" then
         document(i-1,line,"You really will need every penny!")
      elseif c == "!" then
         set_actor("ac-blackball", i-.5,line+.5)
        end
    end
end
--                        1         2         3         4         5
--              0123456789012345678901234567890123456789012345678901234567
renderLine(00, "rrrrrrrrrrrrrrrrrrrr##################rrrrrrrrrrrrrrrrrrrr")
renderLine(01, "r+++             r r##################r  rr  D  e  I  j  r")
renderLine(02, "r+-+    2        r r##################r  rr  d  E  i  J  r")
renderLine(03, "r+++  1          r r##################r  rr  r  r  rLlrMmr")
renderLine(04, "r         1      r r##################r  Ar  r  rKkr? r  r")
renderLine(05, "r              45r 8rrrrrrrrrrrrrrrrrrr  a   rPp3) r  r  r")
renderLine(06, "r !  1         %   & **            **** =rrNnY  z  GQqrsSr")
renderLine(07, "r              67r 9rrrrrrrrrrrrrrrrrrr  c   y  Z  g  r  r")
renderLine(08, "r     1   1 1    r,r##################r  CrtTrUurvVr  r  r")
renderLine(09, "r+++             ; r##################r  rr  r  r  rwWrXxr")
renderLine(10, "r+-+   1 1   1   r r##################r  rr  F  b    o   r")
renderLine(11, "r+++             r(r##################r  rr  f  B    O  :r")
renderLine(12, "rrrrrrrrrrrrrrrrrrrr##################rrrrrrrrrrrrrrrrrrrr")
--              0123456789012345678901234567890123456789012345678901234567
--                        1         2         3         4         5

oxyd_shuffle()

set_stone( "st-timer", 27, 8, {action="callback", target="t_h1"})
set_stone( "st-timer", 28, 8, {action="callback", target="t_h2"})
set_stone( "st-timer", 29, 8, {action="callback", target="t_h3"})

timer = 0

function t_h1()
    doora=enigma.GetNamedObject("door1")
    doorb=enigma.GetNamedObject("door2")
    doorc=enigma.GetNamedObject("door3")
    doord=enigma.GetNamedObject("door4")

    if timer == 0 then
        SendMessage(doora, "open")
     end
    if timer == 1 then
        SendMessage(doorb, "open")
    end
    if timer == 2 then
        SendMessage(doorc, "open")
    end
    if timer == 3 then
        SendMessage(doord, "open")
        SendMessage(doora, "close")
    end
    if timer == 4 then
        SendMessage(doorb, "close")
    end
    if timer == 5 then
        SendMessage(doorc, "close")
    end
    if timer == 6 then
        SendMessage(doord, "close")
    end
end

function t_h2()
    doora=enigma.GetNamedObject("door5")
    doorb=enigma.GetNamedObject("door6")
    doorc=enigma.GetNamedObject("door7")
    doord=enigma.GetNamedObject("door8")

    if timer == 4 then
        SendMessage(doora, "open")
    end
    if timer == 5 then
        SendMessage(doorb, "open")
    end
    if timer == 6 then
        SendMessage(doorc, "open")
    end
    if timer == 7 then
        SendMessage(doord, "open")
        SendMessage(doora, "close")
    end
    if timer == 8 then
        SendMessage(doorb, "close")
    end
    if timer == 9 then
        SendMessage(doorc, "close")
    end
    if timer == 10 then
        SendMessage(doord, "close")
    end
end

function t_h3()
    doora=enigma.GetNamedObject("door9")
    doorb=enigma.GetNamedObject("door10")
    doorc=enigma.GetNamedObject("door11")
    doord=enigma.GetNamedObject("door12")

    if timer == 8 then
        SendMessage(doora, "open")
    end
    if timer == 9 then
        SendMessage(doorb, "open")
    end
    if timer == 10 then
        SendMessage(doorc, "open")
    end
    if timer == 11 then
        SendMessage(doord, "open")
        SendMessage(doora, "close")
    end
    if timer == 0 then
        SendMessage(doorb, "close")
    end
    if timer == 1 then
        SendMessage(doorc, "close")
    end
    if timer == 2 then
        SendMessage(doord, "close")
    end

    timer = timer + 1
    if timer == 12 then
        timer = 0
    end
end

set_stone("st-door_a", 23, 6, {name="door1",  type="v"})
set_stone("st-door_a", 24, 6, {name="door2",  type="v"})
set_stone("st-door_a", 25, 6, {name="door3",  type="v"})
set_stone("st-door_a", 26, 6, {name="door4",  type="v"})
set_stone("st-door_a", 27, 6, {name="door5",  type="v"})
set_stone("st-door_a", 28, 6, {name="door6",  type="v"})
set_stone("st-door_a", 29, 6, {name="door7",  type="v"})
set_stone("st-door_a", 30, 6, {name="door8",  type="v"})
set_stone("st-door_a", 31, 6, {name="door9",  type="v"})
set_stone("st-door_a", 32, 6, {name="door10", type="v"})
set_stone("st-door_a", 33, 6, {name="door11", type="v"})
set_stone("st-door_a", 34, 6, {name="door12", type="v"})

switch1 = 0
switch2 = 0
switch3 = 0
switch4 = 0
switch5 = 0
switch6 = 0
switch7 = 0

function switchaction()
    doorx=enigma.GetNamedObject("door38")
    if switch1 == 1 or switch2 == 1 or
       switch3 == 1 or switch4 == 1 then
       SendMessage(doorx, "open")
    end
    if switch1 == 0 and switch2 == 0 and
       switch3 == 0 and switch4 == 0  then
       SendMessage(doorx, "close")
    end
    doory=enigma.GetNamedObject("door39")
    if switch5 == 1 or switch6 == 1 then
       SendMessage(doory, "open")
    end
    if switch5 == 0 and switch6 == 0 then
       SendMessage(doory, "close")
    end
    vortexa=enigma.GetNamedObject("vortex1")
    if switch7 == 1 then
       SendMessage(vortexa, "open")
    end
    if switch7 == 0 then
       SendMessage(vortexa, "close")
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
