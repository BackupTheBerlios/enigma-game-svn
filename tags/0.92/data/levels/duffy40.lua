-- Copyright (c) 2003 Jacob Scott
-- License: GPL v2.0 or above
-- Enigma Level: Cover Your Ears

levelw=100
levelh=50

create_world( levelw, levelh)
enigma.TwoPlayerGame = TRUE

fill_floor("fl-bluegreen", 0,0,levelw,levelh)

function renderLine( line, pattern)
	for i=1, strlen(pattern) do
		local c = strsub( pattern, i, i)
		if c =="#" then
			set_stone( "st-greenbrown", i-1, line)
		elseif c == "o" then
			oxyd( i-1, line)
                elseif c == "!" then
			abyss(i-1,line)
--			fill_floor("fl-water", i-1,line, 1,1)
		elseif c=="z" then
                    set_actor("ac-blackball", i-.5,line+.5)
		elseif c=="y" then
                    set_actor("ac-whiteball", i-.5,line+.5, {player=0})
		elseif c=="H" then
		   hollow(i-1,line)
		elseif c == "d" then --1-d
			set_floor("fl-gradient",  i-1,  line, {type=1})
		elseif c == "u" then --2-u
			set_floor("fl-gradient",  i-1,  line, {type=2})
		elseif c == "r" then --3-r
			set_floor("fl-gradient",  i-1,  line, {type=3})
		elseif c == "l" then --4-l
		   set_floor("fl-gradient",  i-1,  line, {type=4})
		elseif c=="W" then
                    oneway(i-1,line, enigma.WEST)
                    set_floor("fl-gradient",  i-1,  line, {type=4})
		elseif c=="N" then
                    oneway(i-1,line, enigma.NORTH)
                    set_floor("fl-gradient",  i-1,  line, {type=2})
		elseif c=="E" then
                    oneway(i-1,line, enigma.EAST)
                    set_floor("fl-gradient",  i-1,  line, {type=3})
		elseif c=="S" then
                    oneway(i-1,line, enigma.SOUTH)
                    set_floor("fl-gradient",  i-1,  line, {type=1})
		end
	end	
     end

-- Floor:  " "
-- Border: "#"
-- Oxyd:   "o"

renderLine(00,"       #o#######################o##################       ")
renderLine(01,"       #rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrEdddd#       ")
renderLine(02,"       #rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrEdddd#       ")
renderLine(03,"       #rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrEdddd#       ")
renderLine(04,"       #rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrEdddd#       ")
renderLine(05,"       #NNNN##################################dddd#       ")
renderLine(06,"       #uuuu#                                #dddd#       ")
renderLine(07,"       #uuuu#                                #dddd#       ")
renderLine(08,"       #uuuu#                                #dddd#       ")
renderLine(09,"       #uuuu#                                #dddd#       ")
renderLine(10,"       #uuuu#                                #dddd#       ")
renderLine(11,"       #uuuu#                                #dddd#       ")
renderLine(12,"       #uuuu#      ######o######o######      #dddd#       ")
renderLine(13,"       #uuuu#      #                  #      #dddd#       ")
renderLine(14,"       #uuuu#      #                  #      #dddd#       ")
renderLine(15,"       #uuuu#      o                  o      #dddd#       ")
renderLine(16,"       #uuuu#      #                  #      #dddd#       ")
renderLine(17,"       #uuuu#      #                  #      #dddd#       ")
renderLine(18,"       ouuuu#      #        oo        #      #ddddo       ")
renderLine(19,"       #uuuu#      #                  #      #dddd#       ")
renderLine(20,"       #uuuu#      #                  #      #dddd#       ")
renderLine(21,"       #uuuu#      o                  o      #dddd#       ")
renderLine(22,"       #uuuu#      #                  #      #dddd#       ")
renderLine(23,"       #uuuu#      #                  #      #dddd#       ")
renderLine(24,"       #uuuu#      ######o######o######      #dddd#       ")
renderLine(25,"       #uuuu#                                #dddd#       ")
renderLine(26,"       #uuuu#                                #dddd#       ")
renderLine(27,"       #uuuu#                                #dddd#       ")
renderLine(28,"       #uuuu#                                #dddd#       ")
renderLine(29,"       #uuuu#                                #dddd#       ")
renderLine(30,"       #uuuu#                                #dddd#       ")
renderLine(31,"       #uuuu##################################SSSS#       ")
renderLine(32,"       #uuuuWlllllllllllllllllllllllllllllllllllll#       ")
renderLine(33,"       #uuuuWlllllllllllllllllllllllllllllllllllll#       ")
renderLine(34,"       #uuuuWlllllllllllllllllllllllllllllllllllll#       ")
renderLine(35,"       #uuuuWlllllllllllllllllllllllllllllllllllll#       ")
renderLine(36,"       ##################o#######################o#       ")

oxyd_shuffle()

local actor1=set_actor("ac-blackball", 34.5,15.5)

local actor2=set_actor("ac-whiteball",  49.5, 2.5)

-- set_item("it-yinyang",34,15)
-- set_item("it-yinyang",49,2)

AddRubberBand(actor1, actor2, 20, 0)