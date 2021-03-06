--
-- A level for Enigma
--
-- Copyright (c) 2003 Siegfried Fennig
-- Licensed under the GPL version 2.

levelw = 58
levelh = 13

create_world(levelw, levelh)
--draw_border("st-rock5")
enigma.ConserveLevel = FALSE
oxyd_default_flavor = "b"
fill_floor("fl-rough")

function renderLine( line, pattern)
    for i=1, strlen(pattern) do
      local c = strsub( pattern, i, i)
      if c == "g" then
         set_stone("st-glass1",i-1,line)
      elseif c == "f" then
         fill_floor("fl-rough", i-1,line, 1,1)
      elseif c == "#" then
         fill_floor("fl-abyss", i-1,line, 1,1)
      elseif c == "w" then
         fill_floor("fl-water", i-1,line, 1,1)
      elseif c == "h" then
         set_stone("st-glass1_hole",i-1,line)
      elseif c == "z" then
         set_stone("st-wood",i-1,line)
      elseif c == "b" then
         set_stone("st-glass2_hole",i-1,line)
      elseif c == "r" then
         set_stone("st-rock5", i-1,line)
      elseif c == "y" then
         set_stone("st-bolder-n", i-1,line)
      elseif c == "i" then
         set_stone("st-stoneimpulse", i-1,line)
      elseif c == "l" then
         set_attrib(laser(i-1,line, FALSE, NORTH), "name", "laser")
      elseif c == "m" then
         mirror3(i-1,line,0,0, 1)
      elseif c == "n" then
         mirrorp(i-1,line,0,1, 4)
      elseif c == "p" then
         mirrorp(i-1,line,0,1, 3)
      elseif c == "q" then
         mirrorp(i-1,line,0,0, 4)
      elseif c == "(" then
         mirrorp(i-1,line,0,0, 2)
      elseif c == ")" then
         mirrorp(i-1,line,0,0, 3)
      elseif c == "!" then
         mirrorp(i-1,line,0,0, 1)
      elseif c == "s" then
         mirror3(i-1,line,0,0, 4)
      elseif c == "c" then
         set_stone("st-coinslot", i-1,line, {action="onoff", target="laser"})
      elseif c == "t" then
         set_item("it-trigger", i-1,line, {action="openclose", target="door"})
      elseif c == "d" then
         doorh( i-1,line, {name="door"})
      elseif c == "o" then
         oxyd( i-1, line)
      elseif c == "a" then
         set_actor("ac-blackball", i-.5,line+.5)
        end
    end
end
--                        1         2         3         4         5
--              0123456789012345678901234567890123456789012345678901234567
renderLine(00, "rrrrrrrrrrrrrrrrrrr####################rrrrrrrrrrrrrrrrrrr")
renderLine(01, "r  gng        gyg r####################r     g q         r")
renderLine(02, "r  ggg        gwg r####################r  q  g mm   gggggr")
renderLine(03, "r  ggg        gwg r#########o##########r     g  m   pgirrr")
renderLine(04, "r )gng q    ! gwg  bbbbbbbbbbbbbbbbbbbb   (  g      rii  r")
renderLine(05, "r  ggg     mm gwg  bbbbbbbbbbbbbbbbbbbb      g      ri   r")
renderLine(06, "o          mm gwg  bbbbbbbbbbbbbbbbbbbb            tzi   o")
renderLine(07, "r             gwg  bbbbbbbbbbbbbbbbbbbb     hih     ri   r")
renderLine(08, "r  a          gwg r#########o##########r    hir s   ri   r")
renderLine(09, "r             gwg r####################r    hir gggggirdrr")
renderLine(10, "r      m    m gwg r####################r  ( hiz     ggg gr")
renderLine(11, "r                 r####################r    hi g         r")
renderLine(12, "rrlcrrrrrrrrrrrrrrr####################rrrrrrrrrrrrrrrrrrr")
--              0123456789012345678901234567890123456789012345678901234567
--                        1         2         3         4         5

oxyd_shuffle()

set_item("it-coin1",19, 4)
set_item("it-coin1",34, 4)
set_item("it-coin1",25, 7)
set_item("it-coin1",36, 7)
