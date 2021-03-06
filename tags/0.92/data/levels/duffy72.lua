-- Copyright (c) 2003 Jacob Scott
-- License: GPL v2.0 or above
-- Enigma Level: Where Am I?

levelw=120
levelh=40

create_world( levelw, levelh)

fill_floor("fl-abyss", 0,0,levelw,levelh)

function renderLine( line, pattern)
	for i=1, strlen(pattern) do
		local c = strsub( pattern, i, i)
		if c =="#" then
			set_stone( "st-greenbrown", i-1, line)
		elseif c =="$" then
			set_stone( "st-actorimpulse", i-1, line)
			set_floor("fl-ice_001",i-1,line)
		elseif c =="f" then
			set_stone( "st-actorimpulse", i-1, line)
			set_floor("fl-normal",i-1,line)
		elseif c =="&" then
			set_stone( "st-greenbrown", i-1, line)
			set_floor("fl-hay",i-1,line)
		elseif c =="%" then
			set_stone( "st-invisible", i-1, line)
			abyss(i-1,line)
		elseif c =="q" then
			set_stone( "st-death", i-1, line)
			set_floor("fl-hay",i-1,line)
		elseif c =="X" then
			set_stone( "st-death", i-1, line)
		elseif c == "o" then
			oxyd( i-1, line)
		elseif c == "^" then
			oxyd( i-1, line)
		   set_floor("fl-ice_001",i-1,line)
		elseif c == "*" then
			set_stone( "st-brownie", i-1, line)
			set_floor("fl-hay",i-1,line)
                elseif c == "!" then
			abyss(i-1,line)
--			fill_floor("fl-water", i-1,line, 1,1)
		elseif c=="z" then
			set_actor("ac-blackball", i-.5,line+.5)
		   set_floor("fl-ice_001",i-1,line)
		elseif c=="t" then
		   set_actor("ac-top", i-.5,line+.5, {player=1, mouseforce=0, range=0, force=0})
			set_floor("fl-hay",i-1,line)
		elseif c=="s" then
		   set_actor("ac-rotor", i-.5,line+.5, {player=1, mouseforce=0, range=2, force=50})
			set_floor("fl-hay",i-1,line)
		elseif c=="U" then
		   set_actor("ac-rotor", i-.5,line+.5, {player=1, mouseforce=0, range=5, force=10})
			abyss(i-1,line)
		elseif c == "g" then
			draw_stones("st-grate1",{i-1,line}, {1,1}, 1)
			set_floor("fl-hay",i-1,line)
		elseif c=="+" then
			set_stone( "st-wood", i-1, line)
			set_floor("fl-hay",i-1,line)
		elseif c=="=" then
			set_floor("fl-space",i-1,line)
		elseif c=="x" then
			set_floor("fl-hay",i-1,line)
		elseif c=="O" then
		   set_item("it-extralife",i-1,line)
			set_floor("fl-hay",i-1,line)
		elseif c=="m" then
		   set_item("it-extralife",i-1,line)
			set_floor("fl-space",i-1,line)
		elseif c=="v" then
			set_floor("fl-normal",i-1,line)
		elseif c=="I" then
		   set_floor("fl-ice_001",i-1,line)
		elseif c=="i" then
		   set_item("it-extralife",i-1,line)
		   set_floor("fl-ice_001",i-1,line)
		elseif c == "d" then --1-d
			set_floor("fl-gradient",  i-1,  line, {type=1})
		elseif c == "u" then --2-u
			set_floor("fl-gradient",  i-1,  line, {type=2})
		elseif c == "r" then --3-r
			set_floor("fl-gradient",  i-1,  line, {type=3})
		elseif c == "l" then --4-l
			set_floor("fl-gradient",  i-1,  line, {type=4})
		elseif c == "1" then --ur
			set_floor("fl-gradient",  i-1,  line, {type=11})
		elseif c == "3" then --dl
			set_floor("fl-gradient",  i-1,  line, {type=9})
		elseif c == "7" then --dr
			set_floor("fl-gradient",  i-1,  line, {type=12})
		elseif c == "9" then --ul
			set_floor("fl-gradient",  i-1,  line, {type=10})
		elseif c=="H" then
		   set_stone("st-actorimpulse",i-1,line)
		elseif c=="h" then
		   set_stone("st-actorimpulse",i-1,line)
		   set_floor("fl-ice_001",i-1,line)
		elseif c=="T" then
		   set_item("it-vortex-open", i-1, line)
			set_floor("fl-normal",i-1,line)
		elseif c=="Q" then
		   set_item("it-vortex-open", i-1, line)
			set_floor("fl-hay",i-1,line)
		elseif c=="k" then
		   set_item("it-springboard",i-1,line)
		   set_floor("fl-ice_001",i-1,line)
		elseif c=="j" then
		   set_item("it-springboard",i-1,line)
		   set_floor("fl-hay",i-1,line)
		elseif c=="R" then
		   set_item("it-vortex-open", i-1, line, {targetx="42.5",targety="33.5"})
		   set_floor("fl-ice_001",i-1,line)
		elseif c=="A" then
		   set_item("it-vortex-open", i-1, line, {targetx="29.5",targety="30.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="B" then
		   set_item("it-vortex-open", i-1, line, {targetx="67.5",targety="30.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="C" then
		   set_item("it-vortex-open", i-1, line, {targetx="10.5",targety="6.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="D" then
		   set_item("it-vortex-open", i-1, line, {targetx="47.5",targety="18.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="K" then
		   set_item("it-vortex-open", i-1, line, {targetx="10.5",targety="30.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="`" then
		   set_item("it-vortex-open", i-1, line, {targetx="10.5",targety="18.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="L" then
		   set_item("it-vortex-open", i-1, line, {targetx="86.5",targety="18.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="M" then
		   set_item("it-vortex-open", i-1, line, {targetx="86.5",targety="30.5"})
			set_floor("fl-normal",i-1,line)
		elseif c=="N" then
		   set_item("it-vortex-open", i-1, line, {targetx="48.5",targety="18.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="S" then
		   set_item("it-vortex-open", i-1, line, {targetx="86.5",targety="6.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="J" then
		   set_item("it-vortex-open", i-1, line, {targetx="29.5",targety="18.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="V" then
		   set_item("it-vortex-open", i-1, line, {targetx="47.5",targety="18.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="P" then
		   set_item("it-vortex-open", i-1, line, {targetx="47.5",targety="18.5"})
			set_floor("fl-hay",i-1,line)
		elseif c==";" then
		   set_item("it-vortex-open", i-1, line, {targetx="67.5",targety="18.5"})
			set_floor("fl-hay",i-1,line)
		elseif c==":" then
		   set_item("it-vortex-open", i-1, line, {targetx="105.5",targety="6.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="," then
		   set_item("it-vortex-open", i-1, line, {targetx="67.5",targety="6.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="." then
		   set_item("it-vortex-open", i-1, line, {targetx="66.5",targety="6.5"})
			set_floor("fl-hay",i-1,line)
		elseif c=="<" then
		   set_item("it-vortex-open", i-1, line, {targetx="30.5",targety="10.5"})
			set_floor("fl-normal",i-1,line)
		elseif c==">" then
		   set_item("it-vortex-open", i-1, line, {targetx="30.5",targety="2.5"})
			set_floor("fl-normal",i-1,line)
	     end
	end	
     end


-- Floor:  " "
-- Border: "#"
-- Oxyd:   "o"

renderLine(00,"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
renderLine(01,"%                                                            ffffffffffff                                         %")
renderLine(02,"%                           xx;             H $$$$$$$$$$     f7uuuuuuuu9f                                         %")
renderLine(03,"%                       xxx j x        HIIIII $IIRIIIIR$     fl7uu  uu9rf                                         %")
renderLine(04,"%                       QxQ             I   I $IRIRhRII$   vvvll7uuuu9rrvvv                                       %")
renderLine(05,"%         Xxxx xxx xxxx xxx xxj         I   I $RRh$$RIR$   v flll7uu9rrrf v           X                  X        %")
renderLine(06,"%        XDxxQ QOQ QxxQ     Qxxo        I   I $III$RIII$  ov fl ll<>rr rf vo         XJX                X.o       %")
renderLine(07,"%         Xxxx xxx xxxx xxx xxj         I   I hRhI$RIhR$   v flll1dd3rrrf v           X                  X        %")
renderLine(08,"%                       QxQ             IIIhIIiIII$RIII$   vvvll1dddd3rrvvv                                       %")
renderLine(09,"%                       xxx j x         h I   hRRR$RRRI$     fl1dd  dd3rf                                         %")
renderLine(10,"%                           xx:        SI I   $$$$$$$$I$     f1dddddddd3f                                         %")
renderLine(11,"%                                       III           I      ffffffffffff                                         %")
renderLine(12,"%                                                     I                                        %%%%%%%%%%%%%%%%%%%%")
renderLine(13,"%       xxx                                           k                           o            %")
renderLine(14,"%       xsx                                                                       v 7TvvvT9    %")
renderLine(15,"%       xxx                                           k                           v T     T    %")
renderLine(16,"%       x x                                           I                           v v 7T9 v    %")
renderLine(17,"%       x x                  X                 XX     I            X              v v T T v    %")
renderLine(18,"%      oO L                 oVX               XAKzIIIIiH          o,X             v v M v v    %")
renderLine(19,"%       x x                  X                 XX     I            X              v T   T v    %")
renderLine(20,"%       x x                                           I                           v 1TvT3 v    %")
renderLine(21,"%       xxx                                           k                           T       T    %")
renderLine(22,"%       xsx                                                                       1TvvvvvT3    %")
renderLine(23,"%       xxx                                           k                                        %")
renderLine(24,"%                                                     I                                        %")
renderLine(25,"%                                                     I                                        %")
renderLine(26,"%                                        7u9   7u9   7u9                                       %")
renderLine(27,"%                                       olOr===lxr===lxr                                       %")
renderLine(28,"%                                        1d3   1d3   1d3                                       %")
renderLine(29,"%         X                  o            =     =     =            X                  X        %")
renderLine(30,"%        X`X                XBX           =    UmU    =           oCX                oNo       %")
renderLine(31,"%         o                  X            =     =     =            o                  X        %")
renderLine(32,"%                                        7u9   7u9   7u9                                       %")
renderLine(33,"%                                       olQr===lxr===lOr                                       %")
renderLine(34,"%                                        1d3   1d3   1d3                                       %")
renderLine(35,"%                                                                                              %")
renderLine(36,"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")

oxyd_shuffle()
