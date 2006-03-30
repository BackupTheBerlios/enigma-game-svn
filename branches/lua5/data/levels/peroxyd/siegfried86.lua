--
-- A level for Enigma
--
-- Copyright (c) 2003 Siegfried Fennig
-- Licensed under the GPL version 2.

levelw = 20
levelh = 13

create_world(levelw, levelh)
enigma.ConserveLevel = FALSE
oxyd_default_flavor = "c"
fill_floor("fl-abyss")
fill_floor("fl-gray", 1, 2, 18, 9)

function renderLine( line, pattern)
    for i=1, strlen(pattern) do
      local c = strsub( pattern, i, i)
      if c =="N" then
         set_stone("st-oneway_black-n",i-1,line)
      elseif c == "n" then
         set_stone("st-oneway_white-n",i-1,line)
      elseif c == "E" then
         set_stone("st-oneway_black-e",i-1,line)
      elseif c == "e" then
         set_stone("st-oneway_white-e",i-1,line)
      elseif c == "S" then
         set_stone("st-oneway_black-s",i-1,line)
      elseif c == "s" then
         set_stone("st-oneway_white-s",i-1,line)
      elseif c == "W" then
         set_stone("st-oneway_black-w",i-1,line)
      elseif c == "w" then
         set_stone("st-oneway_white-w",i-1,line)
      elseif c == "h" then
         set_stone("st-wood",i-1,line)
      elseif c == "r" then
         set_stone("st-greenbrown",i-1,line)
      elseif c == "o" then
         oxyd( i-1, line)
      elseif c == "a" then
         set_actor("ac-blackball", i-.5,line+.5)
         set_item("it-yinyang", i-1, line+.5)
      elseif c == "b" then
         set_actor("ac-whiteball", i-.5,line+.5)
         set_item("it-yinyang", i-1, line+.5)
        end
    end
end
--              01234567890123456789
renderLine(00, "                    ")
renderLine(01, "    o   o   o   o   ")
renderLine(02, " rrrnrrrNrrrnrrrNrr ")
renderLine(03, "oW r   e  S       eo")
renderLine(04, " r  h h W n rr r hr ")
renderLine(05, "ow r r rrNnr  w h Eo")
renderLine(06, " r h r  Wbae hr r r ")
renderLine(07, "oW rr r rsSrr  N  eo")
renderLine(08, " r  h  E h  r r h r ")
renderLine(09, "ow   rn   r   r   Eo")
renderLine(10, " rrrSrrrsrrrSrrrsrr ")
renderLine(11, "    o   o   o   o   ")
renderLine(12, "                    ")
--              01234567890123456789

oxyd_shuffle()










