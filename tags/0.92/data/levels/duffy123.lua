-- Copyright (c) 2004 Jacob Scott
-- License: GPL v2.0 or above
-- Enigma Level: Electric Meditation

rooms_wide=1
rooms_high=1

levelw=1+(19*rooms_wide)+1
levelh=1+(12*rooms_high)

create_world( levelw, levelh)

difficult=(options.Difficulty==2)

if difficult==false then
enigma.ElectricForce=35
else
enigma.ElectricForce=50
end

fill_floor("fl-normal", 0,0,levelw,levelh)

function renderLine( line, pattern)
	for i=1, strlen(pattern) do
		local c = strsub( pattern, i, i)
		if c =="#" then
			set_stone( "st-greenbrown", i-1, line)
		elseif c =="P" then
			set_stone( "st-chargeplus", i-1, line)
		elseif c =="M" then
			set_stone( "st-chargeminus", i-1, line)
		elseif c =="N" then
			set_stone( "st-chargezero", i-1, line)
		elseif c =="T" then
		   set_stone( "st-timer", i-1, line,{interval=1,action="callback",target="funcc1"})
		elseif c == "o" then
			oxyd( i-1, line)
		elseif c == "*" then
			set_stone( "st-brownie", i-1, line)
		elseif c == "%" then
			set_stone( "st-brownie", i-1, line)
		   set_floor("fl-water",i-1,line)
                elseif c == "!" then
			abyss(i-1,line)
		elseif c == "~" then
		   set_floor("fl-water",i-1,line)
		elseif c=="z" then
		   set_actor("ac-blackball", i-.5,line+.5, {player=0})
		elseif c=="y" then
		   set_actor("ac-whiteball", i-1,line+.5, {player=1})
		elseif c=="w" then
		   set_actor("ac-whiteball-small", i-.5,line+.5, {controllers=1,mouseforce=1,player=0})
		elseif c=="W" then
		   set_actor("ac-whiteball-small", i-.5,line+.5, {controllers=0,mouseforce=0,player=1})
		   set_item("it-hill",i-1,line)
		elseif c == "g" then
			draw_stones("st-grate1",{i-1,line}, {1,1}, 1)
		elseif c=="+" then
			set_stone( "st-wood", i-1, line)
		elseif c=="=" then
			set_floor("fl-space",i-1,line)
		     elseif c=="H" then
		   set_item("it-hollow",i-1,line)
		elseif c=="1" then
		   set_item("it-wormhole",i-1,line,{strength=0,targetx=i-1.5,targety=line+2.5})
		elseif c == "d" then --1-d
			set_floor("fl-gradient",  i-1,  line, {type=1})
		   set_actor("ac-whiteball-small", i-.5,line+.5, {controllers=1,player=1})
		elseif c == "u" then --2-u
			set_floor("fl-gradient",  i-1,  line, {type=2})
		   set_actor("ac-whiteball-small", i-.5,line+.5, {controllers=1,player=1})
		elseif c == "r" then --3-r
			set_floor("fl-gradient",  i-1,  line, {type=3})
		   set_actor("ac-whiteball-small", i-.5,line+.5, {controllers=1,player=1})
		elseif c == "l" then --4-l
			set_floor("fl-gradient",  i-1,  line, {type=4})

	   set_actor("ac-whiteball-small", i-.5,line+.5, {controllers=1,player=1})
		     elseif c=="h" then
			set_item("it-hollow",i-1,line,{name="h1"})
	   set_actor("ac-whiteball-small", i-.5,line+.5, {controllers=1,player=0})
	   set_floor("fl-space",i-1,line)
	     end
	end
end

renderLine(00,"!!!!!!!M!!!!!M!!!!!!T")
renderLine(01,"!!!!!!MuM!!!MuM!!!!! ")
renderLine(02,"!!!!!P   P!P   P!!!! ")
renderLine(03,"!!!!P  H  P  H  P!!! ")
renderLine(04,"!!!P P   P=P   P P!! ")
renderLine(05,"!!M   M M===M M   M! ")
renderLine(06,"!Ml H  M==h==M  H rM ")
renderLine(07,"!!M   M M===M M   M! ")
renderLine(08,"!!!P P   P=P   P P!! ")
renderLine(09,"!!!!P  H  P  H  P!!! ")
renderLine(10,"!!!!!P   P!P   P!!!! ")
renderLine(11,"!!!!!!MdM!!!MdM!!!!! ")
renderLine(12,"!!!!!!!M!!!!!M!!!!!! ")

enigma.SendMessage(enigma.GetNamedObject("h1"),"trigger",nil)

ff1=0
function funcc1()
if ff1==0 then
   set_floor("fl-normal",7,1)
   set_floor("fl-normal",13,1)
   set_floor("fl-normal",2,6)
   set_floor("fl-normal",18,6)
   set_floor("fl-normal",7,11)
   set_floor("fl-normal",13,11)
set_floor("fl-normal",10,4)
set_floor("fl-normal",9,5)
set_floor("fl-normal",10,5)
set_floor("fl-normal",11,5)
set_floor("fl-normal",8,6)
set_floor("fl-normal",9,6)
set_floor("fl-normal",10,6)
set_floor("fl-normal",11,6)
set_floor("fl-normal",12,6)
set_floor("fl-normal",9,7)
set_floor("fl-normal",10,7)
set_floor("fl-normal",11,7)
set_floor("fl-normal",10,8)
   enigma.SendMessage(enigma.GetNamedObject("h1"),"trigger",nil)
ff1=1
end
end
