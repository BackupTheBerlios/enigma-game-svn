-- A level for Enigma
-- Copyright: 	(C) 2003 Sven Siggelkow
-- License: 	GPL v2.0 or above
-- ESPRIT #058

levelw = 39
levelh = 25
create_world(levelw, levelh)
oxyd_default_flavor = "a"
display.SetFollowMode(display.FOLLOW_SCROLLING)
set_actor("ac-blackball", 19.5,13.5)
fill_floor("fl-normal",0,0,levelw,levelh)

function renderLine( line, pattern)
    for i=1, strlen(pattern) do
      local c = strsub( pattern, i, i)
      if c ==   "#" then
         set_stone("st-stone1", i-1,line)
      elseif c == " " then
         set_floor("fl-ice_001",i-1,line)
         set_item("it-crack0",i-1,line)                                       
      elseif c == "." then
         set_floor("fl-ice_001",i-1,line)
      elseif c == "w" then
         set_floor("fl-floor_001",i-1,line)
      elseif c=="1" then
	 set_floor("fl-gradient",  i-1,  line, {type=3})         
      elseif c=="2" then
	 set_floor("fl-gradient",  i-1,  line, {type=4})   
      elseif c=="3" then
	 set_floor("fl-gradient",  i-1,  line, {type=1})   
      elseif c=="4" then
	 set_floor("fl-gradient",  i-1,  line, {type=2})         
      elseif c=="a" then
         set_floor("fl-gradient",  i-1,  line, {type=12})   
      elseif c=="b" then
         set_floor("fl-gradient",  i-1,  line, {type=10})         
      elseif c=="c" then
         set_floor("fl-gradient",  i-1,  line, {type=11})   
      elseif c=="d" then
         set_floor("fl-gradient",  i-1,  line, {type=9})  
      elseif c=="+" then
         set_floor("fl-normal", i-1,line)
      elseif c =="M" then
         set_item("it-wormhole",i-1,line, {targetx="10.5",targety="14.5",strength=0})
      elseif c =="P" then
         set_item("it-wormhole",i-1,line, {targetx="20.5",targety="3.5",strength=0})
      elseif c =="Q" then
         set_item("it-wormhole",i-1,line, {targetx="8.5",targety="9.5",strength=0})
      elseif c =="R" then
         set_item("it-wormhole",i-1,line, {targetx="12.5",targety="6.5",strength=0})
      elseif c =="S" then
         set_item("it-wormhole",i-1,line, {targetx="8.5",targety="9.5",strength=0})
      elseif c =="T" then
         set_item("it-wormhole",i-1,line, {targetx="15.5",targety="22.5",strength=0})
      elseif c =="U" then
         set_item("it-wormhole",i-1,line, {targetx="6.5",targety="18.5",strength=0})
      elseif c =="V" then
         set_item("it-wormhole",i-1,line, {targetx="15.5",targety="22.5",strength=0})
      elseif c =="W" then
         set_item("it-wormhole",i-1,line, {targetx="29.5",targety="11.5",strength=0})
      elseif c =="X" then
         set_item("it-wormhole",i-1,line, {targetx="34.5",targety="16.5",strength=0})
      elseif c =="Y" then
         set_item("it-wormhole",i-1,line, {targetx="22.5",targety="11.5",strength=0})
      elseif c =="Z" then
         set_item("it-wormhole",i-1,line, {targetx="28.5",targety="11.5",strength=0})
      elseif c=="h" then                    
         hammer(i-1,line)
         set_floor("fl-floor_001",i-1,line)
      elseif c == ">" then
         set_stone("st-oneway-e",i-1,line)
      elseif c == "<" then
         set_stone("st-oneway-w",i-1,line)
      elseif c == "g" then
         set_stone("st-grate1",i-1,line)
      elseif c == "H" then               
         set_item("it-hollow",i-1,line)
      elseif c == "p" then               
         set_item("it-coffee",i-1,line)
      elseif c == "x" then               
         set_floor("fl-floor_001",i-1,line)
         set_item("it-hill",i-1,line)
      elseif c == "F" then
         set_stone("st-fakeoxyd",i-1,line)         
      elseif c == "O" then
	 oxyd(i-1,line)         
        end
    end  
end
--               012345678901234567890123456789012345678
renderLine(00 , "#######################################")
renderLine(01 , "#                   .............     #")
renderLine(02 , "# .....     +++     +++++++++++++     #")
renderLine(03 , "#.a444b#    + +     + #######   ++    #")
renderLine(04 , "#.2www1#    + + +<+ M #a444b#    ++++ #")
renderLine(05 , "#.2wOw1#    + + + +   #2www1#       H #")  
renderLine(06 , "#.2www1#    + + + H+++g2wOw1#       + #")
renderLine(07 , "#.c333d++>+ Q +++ +   #2www1#  .....+ #")
renderLine(08 , "#.####+#  +  .    H   #c333d#  .a444b #")
renderLine(09 , "#..+S#+#R +++a444b++  ###+###  .2www1 #")
renderLine(10 , "#..+ #+#  ...2www1 +    #+#    .2wOw1 #")
renderLine(11 , "#..+ #+#    .2wOw1+++++Z#+#Y++X 2whw1 #")
renderLine(12 , "#..+ #+#    .2www1      #+#    .c333d #")
renderLine(13 , "#..+ #+++++  c333d+++++p++.     +.... #") 
renderLine(14 , "#..+ #+#+ +P +.............     +     #")
renderLine(15 , "#..+ #+#+   .+.          a4b    + W.  #")
renderLine(16 , "#..+ #+#++++++.   ...    2F1    + +.  #")
renderLine(17 , "#..+ .+.. . .   .a444b.  c3d    + +.  #")
renderLine(18 , "#..+ .+. . . .  .2www1.         + +.  #")  
renderLine(19 , "#..+ .T..a444b. .2wOw1.   ##### + +.  #")
renderLine(20 , "#..+.   .2www1. .2www1++++gggg<++++++.#")
renderLine(21 , "#..++....2wOw1. .c333d... #####     +.#")
renderLine(22 , "#...+++++2xww1.U ......  V+++++++++++.#")
renderLine(23 , "#.  .....c333d.          ............ #")
renderLine(24 , "#######################################")
--               012345678901234567890123456789012345678
                               
oxyd_shuffle()
