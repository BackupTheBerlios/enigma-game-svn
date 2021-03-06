-- Copyright (c) 2004 Jacob Scott
-- License: GPL v2.0 or above
-- Enigma Level: Solar System

rooms_wide=11
rooms_high=5

levelw=1+(19*rooms_wide)+2
levelh=1+(12*rooms_high)

create_world( levelw, levelh)

fill_floor("fl-hay", 0,0,levelw,levelh)

function renderLine( line, pattern)
	for i=1, strlen(pattern) do
		local c = strsub( pattern, i, i)
		if c =="#" then
			set_stone( "st-invisible", i-1, line)
			set_floor("fl-space",i-1,line)
		elseif c == "o" then
			oxyd( i-1, line)
		elseif c == "*" then
			set_stone( "st-brownie", i-1, line)
                elseif c == "!" then
			abyss(i-1,line)
		elseif c == "~" then
		   set_floor("fl-water",i-1,line)
		elseif c=="z" then
		   set_actor("ac-blackball", i-1,line+.5, {player=0})
			set_floor("fl-metal",i-1,line)
		elseif c=="y" then
		   set_actor("ac-whiteball", i-1,line+.5, {player=1})
		elseif c == "g" then
			draw_stones("st-grate1",{i-1,line}, {1,1}, 1)
		elseif c=="+" then
			set_stone( "st-wood", i-1, line)
			set_floor("fl-leaves",i-1,line)
		elseif c=="=" then
			set_floor("fl-space",i-1,line)
		elseif c=="i" then
			set_floor("fl-ice_001",i-1,line)
		elseif c==" " then
			set_floor("fl-space",i-1,line)
		elseif c=="%" then
			set_floor("fl-metal",i-1,line)
			set_stone( "st-rock4", i-1, line)
		elseif c=="O" then
		   set_item("it-extralife",i-1,line)
			set_floor("fl-metal",i-1,line)
		elseif c=="A" then
		   set_item("it-magnet",i-1,line,{on=1})
			set_floor("fl-rough-red",i-1,line)
		elseif c=="B" then
		   set_item("it-magnet",i-1,line,{on=1})
			set_floor("fl-swamp",i-1,line)
		elseif c=="C" then
		   set_item("it-magnet",i-1,line,{on=1})
			set_floor("fl-leaves",i-1,line)
		elseif c=="D" then
		   set_item("it-magnet",i-1,line,{on=1})
			set_floor("fl-bumps",i-1,line)
		elseif c=="E" then
		   set_item("it-magnet",i-1,line,{on=1})
			set_floor("fl-red",i-1,line)
		elseif c=="F" then
		   set_item("it-magnet",i-1,line,{on=1})
			set_floor("fl-sahara",i-1,line)
		elseif c=="G" then
		   set_item("it-magnet",i-1,line,{on=1})
			set_floor("fl-rock",i-1,line)
		elseif c=="H" then
		   set_item("it-magnet",i-1,line,{on=1})
			set_floor("fl-rough-blue",i-1,line)
		elseif c=="I" then
		   set_item("it-magnet",i-1,line,{on=1})
			set_floor("fl-black",i-1,line)
		elseif c=="J" then
		   set_item("it-magnet",i-1,line,{on=1})
			set_floor("fl-sahara",i-1,line)
			set_stone( "st-greenbrown", i-1, line)
		elseif c=="`" then
		   set_item("it-magnet",i-1,line,{on=1})
			set_floor("fl-water",i-1,line)
		elseif c=="K" then
			oxyd( i-1, line)
			set_floor("fl-rough-red",i-1,line)
		elseif c=="L" then
			oxyd( i-1, line)
			set_floor("fl-swamp",i-1,line)
		elseif c=="M" then
			oxyd( i-1, line)
			set_floor("fl-leaves",i-1,line)
		elseif c=="N" then
			oxyd( i-1, line)
			set_floor("fl-bumps",i-1,line)
		elseif c=="&" then
			oxyd( i-1, line)
			set_floor("fl-red",i-1,line)
		elseif c=="P" then
			oxyd( i-1, line)
			set_floor("fl-sahara",i-1,line)
		elseif c=="Q" then
			oxyd( i-1, line)
			set_floor("fl-rock",i-1,line)
		elseif c=="R" then
			oxyd( i-1, line)
			set_floor("fl-rough-blue",i-1,line)
		elseif c=="@" then
			oxyd( i-1, line)
			set_floor("fl-black",i-1,line)
		elseif c=="$" then
			oxyd( i-1, line)
			set_floor("fl-sahara",i-1,line)
		elseif c=="1" then
		   set_item("it-extralife",i-1,line)
			set_floor("fl-rough-red",i-1,line)
		elseif c=="2" then
		   set_item("it-extralife",i-1,line)
			set_floor("fl-swamp",i-1,line)
		elseif c=="3" then
		   set_item("it-extralife",i-1,line)
			set_floor("fl-leaves",i-1,line)
		elseif c=="4" then
		   set_item("it-extralife",i-1,line)
			set_floor("fl-bumps",i-1,line)
		elseif c=="5" then
		   set_item("it-extralife",i-1,line)
			set_floor("fl-red",i-1,line)
		elseif c=="6" then
		   set_item("it-extralife",i-1,line)
			set_floor("fl-sahara",i-1,line)
		elseif c=="7" then
		   set_item("it-extralife",i-1,line)
			set_floor("fl-rock",i-1,line)
		elseif c=="8" then
		   set_item("it-extralife",i-1,line)
			set_floor("fl-rough-blue",i-1,line)
		elseif c=="9" then
		   set_item("it-extralife",i-1,line)
			set_floor("fl-black",i-1,line)
		elseif c=="0" then
		   set_item("it-extralife",i-1,line)
			set_floor("fl-sahara",i-1,line)
			set_stone( "st-greenbrown", i-1, line)
		elseif c=="j" then
			set_floor("fl-leaves",i-1,line)
		elseif c=="k" then
			set_floor("fl-black",i-1,line)
		elseif c=="l" then
			set_floor("fl-bumps",i-1,line)
		elseif c=="m" then
			set_floor("fl-concrete",i-1,line)
		elseif c=="n" then
			set_floor("fl-gravel",i-1,line)
		elseif c=="p" then
			set_floor("fl-light",i-1,line)
		elseif c=="r" then
			set_floor("fl-red",i-1,line)
		elseif c=="s" then
			set_floor("fl-rock",i-1,line)
		elseif c=="t" then
			set_floor("fl-rough-blue",i-1,line)
		elseif c=="u" then
			set_floor("fl-rough-red",i-1,line)
		elseif c=="v" then
			set_floor("fl-marble",i-1,line)
		elseif c=="V" then
			set_floor("fl-sahara",i-1,line)
		elseif c=="w" then
			set_floor("fl-tigris",i-1,line)
		elseif c=="W" then
			set_floor("fl-swamp",i-1,line)
		elseif c=="y" then
			set_floor("fl-sand",i-1,line)
		elseif c=="x" then
			set_floor("fl-metal",i-1,line)
		elseif c=="S" then
		   set_item("it-burnable_ignited",i-1,line)
			set_floor("fl-sahara",i-1,line)
		elseif c=="T" then
		   set_item("it-burnable_ignited",i-1,line)
		   set_stone( "st-invisible", i-1, line)
			set_floor("fl-sahara",i-1,line)
		elseif c=="q" then
		   set_item("it-umbrella",i-1,line)
		   set_floor("fl-metal",i-1,line)
		elseif c=="h" then
		   set_item("it-ring",i-1,line)
		   set_floor("fl-metal",i-1,line)
		elseif c=="X" then
			set_floor("fl-black",i-1,line)
			set_stone( "st-death", i-1, line)
		elseif c=="f" then
			set_floor("fl-leaves",i-1,line)
			set_item("it-flagblack",i-1,line)
	     end
	end	
end

renderLine(00,"###############################################################################################################################################################################################===================")
renderLine(01,"#                                                                                                                                                                                             #===================")
renderLine(02,"#                                                                                  X                  rr                                                                                      #===================")
renderLine(03,"#                                                                                                   rrrrrr                                                                                    #===================")
renderLine(04,"#                         %%%%%%                                                                  rrrrrrrrrr                                                                                  #===================")
renderLine(05,"#                     qxx %OqqO% xxq                                                             rrrrrrrrrrrr                                                                                 #===================")
renderLine(06,"#                     OxqxhxxzxhxqxO                                                            rrrrrrrrrrrrrr                                                                                #===================")
renderLine(07,"#                     qxx %OqqO% xxq                                                           rrrrrrrrrrrrrrrr                                                                               #===================")
renderLine(08,"#                         %%%%%%                                                               rrrrrrrrr&rrrrrr                                                                               #===================")
renderLine(09,"#                                                            jjj                              rrrrrrrrrrrrrrrrrr                                                                              #===================")
renderLine(10,"#                                                          jjjjjjj                            rrrrrrrrrrrrrrrrrr                                                                    kk@       #===================")
renderLine(11,"#                                                         ~jjjjjjjj                          rrrrrrrrrEErrrrrrrrr                                                                   kIk       #===================")
renderLine(12,"#                                                        ~~jjMj~~~~~                         rrrrrrrrEEEErrrrrrrr                                                                   kkk       #===================")
renderLine(13,"#                                                       jjjjjjj~~~~~j                        rrrrrrrrrEErrrrrrrrr                                                                             #===================")
renderLine(14,"#                                                       j+jjj~~~~~jjj                XX       rrrrrrrrrrrrrrrrrr                                                                              #===================")
renderLine(15,"#                                                      jj+jj~~~~~jjjjj               XX       rrrrrrrrrrrrrrrrrr                                                                              #===================")
renderLine(16,"T                                                      jjjj~~~`~~j++jj                         rrrrrrrrrrrrrrrr                                                                               #===================")
renderLine(17,"TS                                                     jjjj~~~~~~jjjjj                         rrrrrrrrrrrrrrrr                                                                               #===================")
renderLine(18,"TSS                                                     j~~~~~jjMjjjj                           rrrrrrrrrrrrrr                                                                                #===================")
renderLine(19,"TSS                                                     j~~~~jjjjj~~j                            rrrrrrrrrrrr                                                                                 #===================")
renderLine(20,"TSSS                                                     ~~~~jjjj~~~                              rrrrrrrrrr                                                                                  #===================")
renderLine(21,"TSSS                                                      ~jjjfjj~~                                 rrrrrr                                                                                    #===================")
renderLine(22,"TSSSS                                                      jjjjjj~                                    rr                                                                                      #===================")
renderLine(23,"TSSSS                                                        jjj                                                                           sss                                                #===================")
renderLine(24,"TSSSSS                                                                                                                                   sssssss                                              #===================")
renderLine(25,"TSSSSS        uuu                                                                                                                       sssssssss                                             #===================")
renderLine(26,"TSSSSSS      uuuuu                                                                                                                      sssssssss                                             #===================")
renderLine(27,"TSSSSSS     uuuuuuu                                                                                                                    sssssssssss                                            #===================")
renderLine(28,"JJJJSSSS    uuuAKuu                                                                                                                    ssssGGGssss                                            #===================")
renderLine(29,"JJJJSSSS    uuuuuuu                                                                               XX                                   sssssssssss                                            #===================")
renderLine(30,"JJJJSSSS     uuuuu                                                                                XX                                    sssssQsss                                             #===================")
renderLine(31,"JJJJSSSS      uuu                                                               llll                                                    sssssssss                                             #===================")
renderLine(32,"JJJJSSSS                           WW                                          llllll                                                    sssssss                                              #===================")
renderLine(33,"TSSSSSS                          WWWWWW                                       llllllll                                                     sss                                                #===================")
renderLine(34,"TSSSSSS                         WWWWWWWW                                     llllllllll                                                                                                       #===================")
renderLine(35,"TSSSSS                         WWWWWWWWWW                                   llllllllllll                                                                                                      #===================")
renderLine(36,"TSSSSS                        WWWWWWWWWWWW                                  llllllllllll                         XX                                                                           #===================")
renderLine(37,"TSSSS                         WWWWWWWWWWWW                                  lllllDDlllll                         XX                                                                           #===================")
renderLine(38,"TSSSS                        WWWWWWWWWWWWWW                                 llllllllllll                                                                                                      #===================")
renderLine(39,"TSSS                         WWWWWBBBBWWWWW                                 lllllllNllll                                                                                                      #===================")
renderLine(40,"TSSS                         WWWWWWWWWWWWWW                                  llllllllll                                                                                                       #===================")
renderLine(41,"TSS                           WWWWWWWWWWWW                                    llllllll                                                                               ttt                      #===================")
renderLine(42,"TSS                           WWWLWWWWWWWW                                     llllll                               iiiiiii                                         ttttt                     #===================")
renderLine(43,"TS                             WWWWWWWWWW                                       llll                              iii     iii                                      ttRtttt                    #===================")
renderLine(44,"T                               WWWWWWWW                                                                         ii   VVV   ii                                     tttHttt                    #===================")
renderLine(45,"#                                WWWWWW                                                                         ii  VVVVVVV  ii                                    ttttttt                    #===================")
renderLine(46,"#                                  WW                                                                           i  VVVVVVVVV  i                                     ttttt                     #===================")
renderLine(47,"#                                                                                                              ii VVVVVVVVVVV ii                                     ttt                      #===================")
renderLine(48,"#                                                                                                XX            i  VVVVVVVVVVV  i                                                              #===================")
renderLine(49,"#                                                                                                XX            i VVVVVVVVVVVVV i                                                              #===================")
renderLine(50,"#                                                                                                XX            i VVVVVFFFVVVVV i                                                              #===================")
renderLine(51,"#                                                                                                              i VVVVVVVVVVVVV i                                                              #===================")
renderLine(52,"#                                                                                                              i  VVVVVPVVVVV  i                                                              #===================")
renderLine(53,"#                                                                                                              ii VVVVVVVVVVV ii                                                              #===================")
renderLine(54,"#                                                                                                               i  VVVVVVVVV  i                                                               #===================")
renderLine(55,"#                                                                                                               ii  VVVVVVV  ii                                                               #===================")
renderLine(56,"#                                                                                     XX                         ii   VVV   ii                                                                #===================")
renderLine(57,"#                                                                                     XX                          iii     iii                                                                 #===================")
renderLine(58,"#                                                                                                                   iiiiiii                                                                   #===================")
renderLine(59,"#                                                                                                                                                                                             #===================")
renderLine(60,"###############################################################################################################################################################################################===================")

oxyd_shuffle()

-- 1,2,2,3,3,4,4,5,5,6,6,7,7,(7)

 function timer_handler()
 enigma.KillItem(1,17)
 enigma.KillItem(1,18)
 enigma.KillItem(2,18)
 enigma.KillItem(1,19)
 enigma.KillItem(2,19)
 enigma.KillItem(1,20)
 enigma.KillItem(2,20)
 enigma.KillItem(3,20)
 enigma.KillItem(1,21)
 enigma.KillItem(2,21)
 enigma.KillItem(3,21)
 enigma.KillItem(1,22)
 enigma.KillItem(2,22)
 enigma.KillItem(3,22)
 enigma.KillItem(4,22)
 enigma.KillItem(1,23)
 enigma.KillItem(2,23)
 enigma.KillItem(3,23)
 enigma.KillItem(4,23)
 enigma.KillItem(1,24)
 enigma.KillItem(2,24)
 enigma.KillItem(3,24)
 enigma.KillItem(4,24)
 enigma.KillItem(5,24)
 enigma.KillItem(1,25)
 enigma.KillItem(2,25)
 enigma.KillItem(3,25)
 enigma.KillItem(4,25)
 enigma.KillItem(5,25)
 enigma.KillItem(1,26)
 enigma.KillItem(2,26)
 enigma.KillItem(3,26)
 enigma.KillItem(4,26)
 enigma.KillItem(5,26)
 enigma.KillItem(6,26)
 enigma.KillItem(1,27)
 enigma.KillItem(2,27)
 enigma.KillItem(3,27)
 enigma.KillItem(4,27)
 enigma.KillItem(5,27)
 enigma.KillItem(6,27)
-- enigma.KillItem(1,28)
-- enigma.KillItem(2,28)
-- enigma.KillItem(3,28)
 enigma.KillItem(4,28)
 enigma.KillItem(5,28)
 enigma.KillItem(6,28)
 enigma.KillItem(7,28)
-- enigma.KillItem(1,29)
-- enigma.KillItem(2,29)
-- enigma.KillItem(3,29)
 enigma.KillItem(4,29)
 enigma.KillItem(5,29)
 enigma.KillItem(6,29)
 enigma.KillItem(7,29)
-- enigma.KillItem(1,30)
-- enigma.KillItem(2,30)
-- enigma.KillItem(3,30)
 enigma.KillItem(4,30)
 enigma.KillItem(5,30)
 enigma.KillItem(6,30)
 enigma.KillItem(7,30)
-- enigma.KillItem(1,31)
-- enigma.KillItem(2,31)
-- enigma.KillItem(3,31)
 enigma.KillItem(4,31)
 enigma.KillItem(5,31)
 enigma.KillItem(6,31)
 enigma.KillItem(7,31)
-- enigma.KillItem(1,32)
-- enigma.KillItem(2,32)
-- enigma.KillItem(3,32)
 enigma.KillItem(4,32)
 enigma.KillItem(5,32)
 enigma.KillItem(6,32)
 enigma.KillItem(7,32)
 enigma.KillItem(1,33)
 enigma.KillItem(2,33)
 enigma.KillItem(3,33)
 enigma.KillItem(4,33)
 enigma.KillItem(5,33)
 enigma.KillItem(6,33)
 enigma.KillItem(1,34)
 enigma.KillItem(2,34)
 enigma.KillItem(3,34)
 enigma.KillItem(4,34)
 enigma.KillItem(5,34)
 enigma.KillItem(6,34)
 enigma.KillItem(1,35)
 enigma.KillItem(2,35)
 enigma.KillItem(3,35)
 enigma.KillItem(4,35)
 enigma.KillItem(5,35)
 enigma.KillItem(1,36)
 enigma.KillItem(2,36)
 enigma.KillItem(3,36)
 enigma.KillItem(4,36)
 enigma.KillItem(5,36)
 enigma.KillItem(1,37)
 enigma.KillItem(2,37)
 enigma.KillItem(3,37)
 enigma.KillItem(4,37)
 enigma.KillItem(1,38)
 enigma.KillItem(2,38)
 enigma.KillItem(3,38)
 enigma.KillItem(4,38)
 enigma.KillItem(1,39)
 enigma.KillItem(2,39)
 enigma.KillItem(3,39)
 enigma.KillItem(1,40)
 enigma.KillItem(2,40)
 enigma.KillItem(3,40)
 enigma.KillItem(1,41)
 enigma.KillItem(2,41)
 enigma.KillItem(1,42)
 enigma.KillItem(2,42)
 enigma.KillItem(1,43)
enigma.KillItem(0,16)
enigma.KillItem(0,17)
enigma.KillItem(0,18)
enigma.KillItem(0,19)
enigma.KillItem(0,20)
enigma.KillItem(0,21)
enigma.KillItem(0,22)
enigma.KillItem(0,23)
enigma.KillItem(0,24)
enigma.KillItem(0,25)
enigma.KillItem(0,26)
enigma.KillItem(0,27)
--enigma.KillItem(0,28)
--enigma.KillItem(0,29)
--enigma.KillItem(0,30)
--enigma.KillItem(0,31)
--enigma.KillItem(0,32)
enigma.KillItem(0,33)
enigma.KillItem(0,34)
enigma.KillItem(0,35)
enigma.KillItem(0,36)
enigma.KillItem(0,37)
enigma.KillItem(0,38)
enigma.KillItem(0,39)
enigma.KillItem(0,40)
enigma.KillItem(0,41)
enigma.KillItem(0,42)
enigma.KillItem(0,43)
enigma.KillItem(0,44)

 set_item("it-burnable_ignited",1,17)
 set_item("it-burnable_ignited",1,18)
 set_item("it-burnable_ignited",2,18)
 set_item("it-burnable_ignited",1,19)
 set_item("it-burnable_ignited",2,19)
 set_item("it-burnable_ignited",1,20)
 set_item("it-burnable_ignited",2,20)
 set_item("it-burnable_ignited",3,20)
 set_item("it-burnable_ignited",1,21)
 set_item("it-burnable_ignited",2,21)
 set_item("it-burnable_ignited",3,21)
 set_item("it-burnable_ignited",1,22)
 set_item("it-burnable_ignited",2,22)
 set_item("it-burnable_ignited",3,22)
 set_item("it-burnable_ignited",4,22)
 set_item("it-burnable_ignited",1,23)
 set_item("it-burnable_ignited",2,23)
 set_item("it-burnable_ignited",3,23)
 set_item("it-burnable_ignited",4,23)
 set_item("it-burnable_ignited",1,24)
 set_item("it-burnable_ignited",2,24)
 set_item("it-burnable_ignited",3,24)
 set_item("it-burnable_ignited",4,24)
 set_item("it-burnable_ignited",5,24)
 set_item("it-burnable_ignited",1,25)
 set_item("it-burnable_ignited",2,25)
 set_item("it-burnable_ignited",3,25)
 set_item("it-burnable_ignited",4,25)
 set_item("it-burnable_ignited",5,25)
 set_item("it-burnable_ignited",1,26)
 set_item("it-burnable_ignited",2,26)
 set_item("it-burnable_ignited",3,26)
 set_item("it-burnable_ignited",4,26)
 set_item("it-burnable_ignited",5,26)
 set_item("it-burnable_ignited",6,26)
 set_item("it-burnable_ignited",1,27)
 set_item("it-burnable_ignited",2,27)
 set_item("it-burnable_ignited",3,27)
 set_item("it-burnable_ignited",4,27)
 set_item("it-burnable_ignited",5,27)
 set_item("it-burnable_ignited",6,27)
-- set_item("it-burnable_ignited",1,28)
-- set_item("it-burnable_ignited",2,28)
-- set_item("it-burnable_ignited",3,28)
 set_item("it-burnable_ignited",4,28)
 set_item("it-burnable_ignited",5,28)
 set_item("it-burnable_ignited",6,28)
 set_item("it-burnable_ignited",7,28)
-- set_item("it-burnable_ignited",1,29)
-- set_item("it-burnable_ignited",2,29)
-- set_item("it-burnable_ignited",3,29)
 set_item("it-burnable_ignited",4,29)
 set_item("it-burnable_ignited",5,29)
 set_item("it-burnable_ignited",6,29)
 set_item("it-burnable_ignited",7,29)
-- set_item("it-burnable_ignited",1,30)
-- set_item("it-burnable_ignited",2,30)
-- set_item("it-burnable_ignited",3,30)
 set_item("it-burnable_ignited",4,30)
 set_item("it-burnable_ignited",5,30)
 set_item("it-burnable_ignited",6,30)
 set_item("it-burnable_ignited",7,30)
-- set_item("it-burnable_ignited",1,31)
-- set_item("it-burnable_ignited",2,31)
-- set_item("it-burnable_ignited",3,31)
 set_item("it-burnable_ignited",4,31)
 set_item("it-burnable_ignited",5,31)
 set_item("it-burnable_ignited",6,31)
 set_item("it-burnable_ignited",7,31)
-- set_item("it-burnable_ignited",1,32)
-- set_item("it-burnable_ignited",2,32)
-- set_item("it-burnable_ignited",3,32)
 set_item("it-burnable_ignited",4,32)
 set_item("it-burnable_ignited",5,32)
 set_item("it-burnable_ignited",6,32)
 set_item("it-burnable_ignited",7,32)
 set_item("it-burnable_ignited",1,33)
 set_item("it-burnable_ignited",2,33)
 set_item("it-burnable_ignited",3,33)
 set_item("it-burnable_ignited",4,33)
 set_item("it-burnable_ignited",5,33)
 set_item("it-burnable_ignited",6,33)
 set_item("it-burnable_ignited",1,34)
 set_item("it-burnable_ignited",2,34)
 set_item("it-burnable_ignited",3,34)
 set_item("it-burnable_ignited",4,34)
 set_item("it-burnable_ignited",5,34)
 set_item("it-burnable_ignited",6,34)
 set_item("it-burnable_ignited",1,35)
 set_item("it-burnable_ignited",2,35)
 set_item("it-burnable_ignited",3,35)
 set_item("it-burnable_ignited",4,35)
 set_item("it-burnable_ignited",5,35)
 set_item("it-burnable_ignited",1,36)
 set_item("it-burnable_ignited",2,36)
 set_item("it-burnable_ignited",3,36)
 set_item("it-burnable_ignited",4,36)
 set_item("it-burnable_ignited",5,36)
 set_item("it-burnable_ignited",1,37)
 set_item("it-burnable_ignited",2,37)
 set_item("it-burnable_ignited",3,37)
 set_item("it-burnable_ignited",4,37)
 set_item("it-burnable_ignited",1,38)
 set_item("it-burnable_ignited",2,38)
 set_item("it-burnable_ignited",3,38)
 set_item("it-burnable_ignited",4,38)
 set_item("it-burnable_ignited",1,39)
 set_item("it-burnable_ignited",2,39)
 set_item("it-burnable_ignited",3,39)
 set_item("it-burnable_ignited",1,40)
 set_item("it-burnable_ignited",2,40)
 set_item("it-burnable_ignited",3,40)
 set_item("it-burnable_ignited",1,41)
 set_item("it-burnable_ignited",2,41)
 set_item("it-burnable_ignited",1,42)
 set_item("it-burnable_ignited",2,42)
 set_item("it-burnable_ignited",1,43)
 set_item("it-burnable_ignited",0,16)
 set_item("it-burnable_ignited",0,17)
 set_item("it-burnable_ignited",0,18)
 set_item("it-burnable_ignited",0,19)
 set_item("it-burnable_ignited",0,20)
set_item("it-burnable_ignited",0,21)
set_item("it-burnable_ignited",0,22)
set_item("it-burnable_ignited",0,23)
set_item("it-burnable_ignited",0,24)
set_item("it-burnable_ignited",0,25)
set_item("it-burnable_ignited",0,26)
set_item("it-burnable_ignited",0,27)
--set_item("it-burnable_ignited",0,28)
--set_item("it-burnable_ignited",0,29)
--set_item("it-burnable_ignited",0,30)
--set_item("it-burnable_ignited",0,31)
--set_item("it-burnable_ignited",0,32)
set_item("it-burnable_ignited",0,33)
set_item("it-burnable_ignited",0,34)
set_item("it-burnable_ignited",0,35)
set_item("it-burnable_ignited",0,36)
set_item("it-burnable_ignited",0,37)
set_item("it-burnable_ignited",0,38)
set_item("it-burnable_ignited",0,39)
set_item("it-burnable_ignited",0,40)
set_item("it-burnable_ignited",0,41)
set_item("it-burnable_ignited",0,42)
set_item("it-burnable_ignited",0,43)
set_item("it-burnable_ignited",0,44)

end

set_stone( "st-timer", 210, 0, {interval=1.5,action="callback", target="timer_handler"})

display.SetFollowMode(display.FOLLOW_SCROLLING)