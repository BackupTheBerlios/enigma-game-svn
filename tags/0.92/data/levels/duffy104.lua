-- Copyright (c) 2004 Jacob Scott
-- License: GPL v2.0 or above
-- Enigma Level: Termites

rooms_wide=1
rooms_high=1

levelw=1+(19*rooms_wide)
levelh=1+(12*rooms_high)

create_world( levelw, levelh)
enigma.SetCompatibility("oxyd1")
enigma.ConserveLevel=FALSE

fill_floor("fl-hay", 0,0,levelw,levelh)

function renderLine( line, pattern)
	for i=1, strlen(pattern) do
		local c = strsub( pattern, i, i)
		if c =="#" then
			set_stone( "st-glass1", i-1, line)
		elseif c =="S" then
		   set_stone( "st-spitter", i-1, line)
		elseif c =="T" then
			set_stone( "st-thief", i-1, line)
		elseif c =="B" then
			set_stone( "st-glass1", i-1, line)
		   set_item("it-blackbomb",i-1,line)
		elseif c =="W" then
			set_stone( "st-glass1", i-1, line)
		   set_item("it-whitebomb",i-1,line)
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
		elseif c=="y" then
		   set_actor("ac-whiteball", i-1,line+.5, {player=1})
		elseif c == "g" then
			draw_stones("st-grate1",{i-1,line}, {1,1}, 1)
		elseif c=="+" then
			set_stone( "st-wood", i-1, line)
		elseif c=="=" then
			set_floor("fl-space",i-1,line)
		elseif c=="b" then
		   set_item("it-blackbomb",i-1,line)
		elseif c=="w" then
		   set_item("it-whitebomb",i-1,line)
		elseif c=="O" then
		   set_item("it-extralife",i-1,line)
		elseif c=="1" then
		   set_item("it-blackbomb",i-1,line,{name="b1"})
		elseif c=="f" then
		   set_item("it-floppy",i-1,line)
		elseif c=="A" then
		   set_stone("st-floppy",i-1,line,{action="openclose",target="door1"})
		elseif c=="a" then
			doorh( i-1,line, {name="door1"})
		elseif c=="%" then
		   set_stone("st-floppy",i-1,line,{action="openclose",target="door2"})
		elseif c=="$" then
			doorh( i-1,line, {name="door2"})
		elseif c=="C" then
		   set_stone("st-floppy",i-1,line,{action="openclose",target="door3"})
		elseif c=="c" then
			doorh( i-1,line, {name="door3"})
		elseif c=="D" then
		   set_stone("st-floppy",i-1,line,{action="openclose",target="door4"})
		elseif c=="d" then
		   doorh( i-1,line, {name="door4"})
		elseif c=="L" then
 			set_stone("st-oneway_black", i-1,line, {orientation=enigma.WEST})
	     end
	end	
end

renderLine(00,"####################")
renderLine(01,"#o#       z      #o#")
renderLine(02,"#aA bbbbbbbbbbbb %$#")
renderLine(03,"# 1bb          bbb #")
renderLine(04,"# #   bbbbbbbb   b #")
renderLine(05,"# bbbbb #####bbb b #")
renderLine(06,"# b   + Bb f# +b b #")
renderLine(07,"# b bbbbB+###bbb b #")
renderLine(08,"# b   + bbbbbb+  b #")
renderLine(09,"# bbb     +    bbb #")
renderLine(10,"#dD bbbbbbbbbbbb Cc#")
renderLine(11,"#o#              #o#")
renderLine(12,"####################")

oxyd_shuffle()

b1=enigma.GetNamedObject("b1")

enigma.SendMessage(b1,"ignite",nil)
