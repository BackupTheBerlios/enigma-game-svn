--
-- A level for Enigma
--
-- Copyright (c) 2003 Siegfried Fennig
-- Licensed under the GPL version 2.

levelw = 58
levelh = 49

create_world(levelw, levelh)
draw_border("st-glass1")
--enigma.ConserveLevel = FALSE
oxyd_default_flavor = "a"
fill_floor("fl-sahara")

function renderLine( line, pattern)
    for i=1, strlen(pattern) do
      local c = strsub( pattern, i, i)
      if c == "g" then
         set_stone("st-glass1",i-1,line)
      elseif c =="f" then
         fill_floor("fl-rough", i-1,line, 1,1)
      elseif c =="#" then
         fill_floor("fl-abyss", i-1,line, 1,1)
      elseif c =="x" then
         fill_floor("fl-space", i-1,line, 1,1)
      elseif c == "h" then
         set_stone("st-glass1_hole",i-1,line)
      elseif c == "r" then
         set_stone("st-rock5", i-1,line)
      elseif c == "y" then
         set_stone("st-death", i-1,line)
      elseif c == "d" then
         set_stone("st-death_invisible", i-1,line)
      elseif c == "q" then
         set_stone("st-window", i-1,line)
      elseif c == "i" then
         set_stone("st-actorimpulse", i-1,line)
      elseif c == "l" then
         set_attrib(laser(i-1,line, TRUE, EAST), "name", "laser")
      elseif c == "s" then
         set_item("it-spring1", i-1, line)
      elseif c == "o" then
         oxyd( i-1, line)
      elseif c == "a" then
         set_actor("ac-blackball", i-.5,line+.5)
        end
    end
end
--                        1         2         3         4         5
--              0123456789012345678901234567890123456789012345678901234567
renderLine(00, "                                                          ")
renderLine(01, "                  rgfffffg s          g                   ")
renderLine(02, "                  rgffoffg            g                   ")
renderLine(03, " l                rgfffffg          d h                   ")
renderLine(04, "                  rgfffffg            g                   ")
renderLine(05, "                  rgfffffg            g                   ")
renderLine(06, "                  rgfffff             g                   ")
renderLine(07, "                  rgfffffg            g                   ")
renderLine(08, "                  rgfffffg            g                   ")
renderLine(09, "                  rgfffffg            g                   ")
renderLine(10, "                  rgffoffg            g            d      ")
renderLine(11, " rrrrrrrrrrrrrrrrrrgfffffg            g                   ")
renderLine(12, " ggggggggggggggggggggggggggggggggggggggggggggggggggqgggggg")
renderLine(13, "                   g                  g                   ")
renderLine(14, "                   g                  h d                 ")
renderLine(15, "                   g                  g                   ")
renderLine(16, "                   g                  g                   ")
renderLine(17, "                   g                  g                   ")
renderLine(18, "                   g                  g                   ")
renderLine(19, "                   g                  g                   ")
renderLine(20, "                   g                  g                   ")
renderLine(21, "                   g                  g                   ")
renderLine(22, "   d               g                  g                   ")
renderLine(23, "                   h d                g                   ")
renderLine(24, " gghggggggggggggggggggggggggggggggggggggggghggggggggggggg ")
renderLine(25, "                   g                  g                   ")
renderLine(26, "                   g  # # #    # # #  g    d              ")
renderLine(27, "                   g  # # #    # # #  g                   ")
renderLine(28, "                   g  # # #    # # #  g                   ")
renderLine(29, "                   g  # #        # #  g                   ")
renderLine(30, "        a          g  # ####  #### #  g                   ")
renderLine(31, "                   g  #            #  g                   ")
renderLine(32, "                 d h  ##############  g                   ")
renderLine(33, "                   g                  g                   ")
renderLine(34, "                   g                  g                   ")
renderLine(35, "                   g                  g                   ")
renderLine(36, " gggggggggggggggggggggggggggggggggggggggggggggggggggghggg ")
renderLine(37, "                                                          ")
renderLine(38, "                                                     d    ")
renderLine(39, "                                                          ")
renderLine(40, "                                                          ")
renderLine(41, "   hhh   ggyggggggggggggggggyggggggggggggggggggygg        ")
renderLine(42, "   hyh   ###  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxig        ")
renderLine(43, "   hhh   ggyggggggggggggggggyggggggggggggggggggygg        ")
renderLine(44, "                                                          ")
renderLine(45, "                                                          ")
renderLine(46, "                                                          ")
renderLine(47, "                                                          ")
renderLine(48, "                                                          ")
--              0123456789012345678901234567890123456789012345678901234567
--                        1         2         3         4         5

set_stone("st-fourswitch",21,25, {action="callback", target="mf01"})
set_attrib (mirrorp ( 3, 3, 1,0,3), "name", "mirror01")
function mf01()
    mir=enigma.GetNamedObject("mirror01")
    SendMessage(mir, "turn")
end

set_stone("st-fourswitch",23,25, {action="callback", target="mf02"})
set_attrib (mirrorp ( 3, 5, 1,0,4), "name", "mirror02")
function mf02()
    mir=enigma.GetNamedObject("mirror02")
    SendMessage(mir, "turn")
end

set_stone("st-fourswitch",25,25, {action="callback", target="mf03"})
set_attrib (mirrorp ( 5, 5, 1,0,2), "name", "mirror03")
function mf03()
    mir=enigma.GetNamedObject("mirror03")
    SendMessage(mir, "turn")
end

set_stone("st-fourswitch",27,25, {action="callback", target="mf04"})
set_attrib (mirrorp ( 5, 3, 1,0,3), "name", "mirror04")
function mf04()
    mir=enigma.GetNamedObject("mirror04")
    SendMessage(mir, "turn")
end

set_stone("st-fourswitch",30,25, {action="callback", target="mf05"})
set_attrib (mirrorp ( 7, 3, 1,0,1), "name", "mirror05")
function mf05()
    mir=enigma.GetNamedObject("mirror05")
    SendMessage(mir, "turn")
end

set_stone("st-fourswitch",32,25, {action="callback", target="mf06"})
set_attrib (mirrorp ( 7, 5, 1,0,3), "name", "mirror06")
function mf06()
    mir=enigma.GetNamedObject("mirror06")
    SendMessage(mir, "turn")
end

set_stone("st-fourswitch",34,25, {action="callback", target="mf07"})
set_attrib (mirrorp ( 9, 5, 1,0,4), "name", "mirror07")
function mf07()
    mir=enigma.GetNamedObject("mirror07")
    SendMessage(mir, "turn")
end

set_stone("st-fourswitch",36,25, {action="callback", target="mf08"})
set_attrib (mirrorp ( 9, 3, 1,0,2), "name", "mirror08")
function mf08()
    mir=enigma.GetNamedObject("mirror08")
    SendMessage(mir, "turn")
end

set_stone("st-laserswitch",11, 3, {action="callback", target="sw1"})
set_stone("st-door",25, 6, {name="door1", type="v"})

function sw1()
    doora=enigma.GetNamedObject("door1")
    SendMessage(doora, "openclose")
end

document(22,42, "     5 = E     3 = S     ")
document(24,42, "     1 = W     8 = S     ")
document(26,42, "     4 = E     2 = S     ")
document(28,42, "     7 = N     6 = W     ")
document(12,30, "It's a long way...")
