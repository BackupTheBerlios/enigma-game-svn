-- Copyright (c) 2004 Jacob Scott
-- License: GPL v2.0 or above
-- Enigma Level: Excruciating

levelw=50
levelh=50

create_world( levelw, levelh)

enigma.ElectricForce=50

fill_floor("fl-hay", 0,0,levelw,levelh)

function renderLine( line, pattern)
	for i=1, strlen(pattern) do
		local c = strsub( pattern, i, i)
		if c =="#" then
			set_stone( "st-greenbrown", i-1, line)
		elseif c =="<" then
			set_stone( "st-greenbrown", i-1, line)
			set_floor("fl-water",i-1,line)
		elseif c =="@" then
			set_stone( "st-greenbrown", i-1, line)
			set_floor("fl-leaves",i-1,line)
		elseif c =="V" then
			set_stone( "st-glass", i-1, line)
			set_floor("fl-leaves",i-1,line)
		elseif c =="w" then
			set_stone( "st-glass", i-1, line)
		elseif c =="v" then
			set_stone( "st-death_invisible", i-1, line)
		elseif c == "o" then
			oxyd( i-1, line)
		elseif c == "*" then
			set_stone( "st-brownie", i-1, line)
		elseif c == "Y" then
			set_stone( "st-brownie", i-1, line)
		   set_floor("fl-water",i-1,line)
                elseif c == "!" then
			abyss(i-1,line)
		elseif c == "~" then
		   set_floor("fl-water",i-1,line)
		elseif c=="z" then
		   set_actor("ac-blackball", i-1,line+.5, {player=0})
		elseif c == "g" then
			draw_stones("st-grate1",{i-1,line}, {1,1}, 1)
		elseif c == "G" then
			draw_stones("st-grate1",{i-1,line}, {1,1}, 1)
			set_floor("fl-sand",i-1,line)
		elseif c == "P" then
			draw_stones("st-grate1",{i-1,line}, {1,1}, 1)
			set_floor("fl-leaves",i-1,line)
		elseif c=="+" then
			set_stone( "st-wood", i-1, line)
		elseif c=="%" then
			set_stone( "st-wood", i-1, line)
			set_floor("fl-sand",i-1,line)
		elseif c=="=" then
			set_floor("fl-space",i-1,line)
--		elseif c == "d" then --1-d
--			set_floor("fl-gradient",  i-1,  line, {type=1})
--		elseif c == "u" then --2-u
--			set_floor("fl-gradient",  i-1,  line, {type=2})
--		elseif c == "r" then --3-r
--			set_floor("fl-gradient",  i-1,  line, {type=3})
--		elseif c == "l" then --4-l
--			set_floor("fl-gradient",  i-1,  line, {type=4})
--		elseif c == "1" then --ur
--			set_floor("fl-gradient",  i-1,  line, {type=11})
--		elseif c == "3" then --dl
--			set_floor("fl-gradient",  i-1,  line, {type=9})
--		elseif c == "7" then --dr
--			set_floor("fl-gradient",  i-1,  line, {type=12})
--		elseif c == "9" then --ul
--			set_floor("fl-gradient",  i-1,  line, {type=10})
		elseif c=="m" then
		   set_floor("fl-normal",i-1,line)
		elseif c=="M" then
		   fill_floor("fl-metal",i-2,line,20,12)
		elseif c=="I" then
		   fill_floor("fl-ice_001",i-1,line,19,11)
		elseif c=="l" then
		   fill_floor("fl-leaves",i-2,line-1,20,12)
		elseif c=="p" then
		   set_floor("fl-leaves",i-1,line)
		elseif c=="t" then
		   set_floor("fl-sand",i-1,line)
		elseif c=="i" then
		   set_floor("fl-ice_001",i-1,line)
		elseif c=="c" then
			set_item("it-coin1", i-1,line)
		elseif c=="C" then
			set_stone("st-coinslot", i-1,line, {action="onoff", target="laser2"})
		elseif c=="E" then
			set_attrib(laser(i-1,line, FALSE, WEST), "name", "laser2")
		elseif c=="H" then
			set_stone("st-coinslot", i-1,line, {action="openclose", target="door2"})
		   set_floor("fl-leaves",i-1,line)
		elseif c=="h" then
		   set_stone("st-stone_break",i-1,line)
		elseif c=="S" then
		   set_stone("st-switch",i-1,line,{action="openclose",target="door1"})
		elseif c=="A" then
		   doorh( i-1,line, {name="door1"})
		elseif c=="B" then
		   doorv( i-1,line, {name="door2"})
		elseif c==";" then
			mirrorp(i-1,line,FALSE,FALSE, 2)
		elseif c==":" then
			mirrorp(i-1,line,FALSE,TRUE, 2)
		elseif c=="/" then
			mirrorp(i-1,line,FALSE,FALSE, 4)
		elseif c=="?" then
			mirrorp(i-1,line,FALSE,TRUE, 4)
		elseif c=="F" then
		   set_stone("st-laserswitch",i-1,line,{action="openclose",target="door2"})
		elseif c=="O" then
		   set_item("it-extralife",i-1,line)
		elseif c=="U" then
		   puzzle(i-1,line,PUZ_0010)
		elseif c=="D" then
		   puzzle(i-1,line,PUZ_1000)
		elseif c=="R" then
		   set_actor("ac-rotor", i-.5,line+.5, {player=1, mouseforce=0, range=7, force=20})
		elseif c=="b" then
			yy1( "black",  i-1, line)
		elseif c=="W" then
			yy1( "white",  i-1, line)
		elseif c=="n" then
		   set_stone("st-knight",i-1,line)
		elseif c=="K" then
		   set_item("it-vortex-open", i-1, line,{targetx="14.5",targety="30.5"})
		elseif c=="L" then
		   set_item("it-vortex-open", i-1, line,{targetx="14.5",targety="30.5"})
		   set_stone( "st-brownie", i-1, line)
		elseif c=="J" then
		   set_item("it-vortex-open", i-1, line,{targetx="1.5",targety="23.5"})
		elseif c=="j" then
		   set_item("it-vortex-open", i-1, line,{targetx="1.5",targety="23.5"})
		elseif c=="`" then
		   set_item("it-vortex-open", i-1, line,{targetx="9.5",targety="16.5"})
		elseif c=="1" then
  			set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funcc1"})
		elseif c=="2" then
  			set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funcc2"})
		elseif c=="3" then
  			set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funcc3"})
		elseif c=="4" then
  			set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funcc4"})
		elseif c=="5" then
  			set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funcc5"})
		elseif c=="6" then
  			set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funcc6"})
		elseif c=="7" then
  			set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funcc7"})
		elseif c=="8" then
  			set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funccx"})
		elseif c=="." then
  			set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funccb1"})
		elseif c=="," then
  			set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funccb2"})
		elseif c=="r" then
		   set_item("it-wormhole", i-1, line, {strength=0,targetx="12",targety="6.5"})
		   yy1( "black",  i-1, line)
		elseif c=="&" then
		   set_stone("st-chargeplus",i-1,line)
		elseif c=="^" then
		   set_stone("st-chargeminus",i-1,line)
		elseif c=="d" then
			set_floor("fl-gradient",  i-1,  line, {type=3})
			set_actor("ac-whiteball", i-.5,line+.5, {player=1,mouseforce=0})
		elseif c=="T" then
		   set_item("it-crack3",i-1,line)
		elseif c=="N" then
		   set_stone("st-bolder", i-1,line, {direction=EAST})
		   set_floor("fl-water",i-1,line)
		elseif c=="a" then
			set_attrib(laser(i-1,line, FALSE, NORTH), "name", "laser3")
		elseif c=="f" then
			set_attrib(laser(i-1,line, FALSE, NORTH), "name", "laser4")
		elseif c==">" then
  			set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funccc1"})
		elseif c=="q" then
  			set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funccc2"})
		elseif c=="Q" then
		   mirror3(i-1,line,FALSE,FALSE,2)
	     end
	end	
     end

function yy1( color, x, y)
        stone = format( "st-%s4", color)
        set_stone( stone, x, y)
end

renderLine(00,"#########################################")
renderLine(01,"#l                 #   ============   ###")
renderLine(02,"#        oo        #   ############   ###")
renderLine(03,"#      o####o      #   #~~~~<~~~~~~~~~###")
renderLine(04,"#    o###  ###o    #   #~~~~~~~~~~~~~~###")
renderLine(05,"#  o###      ###oWW##T##~~~~~~<~~~~~~~###")
renderLine(06,"#d&##    &^    ##Wrn   #~~      ~~~~~~###")
renderLine(07,"#  o###      ###oWW# c #~~ ++++ ~~~<~~###")
renderLine(08,"#    o###  ###o    #   #~~ +  + ~~~~~~###")
renderLine(09,"#      o####o      #123#~~ +  + ~~~~~~###")
renderLine(10,"#        oo        #4L5#~~ +++g+~~~~~~###")
renderLine(11,"#                  #67X#~~      ~~~~~~###")
renderLine(12,"############################bb###########")
renderLine(13,"#~    b            #I       RR        ###")
renderLine(14,"#~    N#####       #                  ###")
renderLine(15,"#~    N#   #       #                  ###")
renderLine(16,"#~    N#*J*#       #                  ###")
renderLine(17,"#~    N# * #       #                  ###")
renderLine(18,"#~    N# * #       i                  ###")
renderLine(19,"#~    N#* *#########                  ###")
renderLine(20,"#~    N# * #       #                  ###")
renderLine(21,"#~    N# * #  O`O  #                  ###")
renderLine(22,"#a#  #f#***#   O   #                  ###")
renderLine(23,"#j, .     g#       #                  ###")
renderLine(24,"#####A###################################")
renderLine(25,"#c  > >               vhvhvhvhvhv *   ###")
renderLine(26,"#c  >>>               vhvhvhvhvhv *g  ###")
renderLine(27,"#                     vhvhvhvhvhv *Y**###")
renderLine(28,"#                     vhvhvhvhvhv U  ####")
renderLine(29,"#                     vhvhvhvhvhv D * ###")
renderLine(30,"#         z   K       vhvhvhvhvhv * *S###")
renderLine(31,"#                     vhvhvhvhvhv U * ###")
renderLine(32,"#                     vhvhvhvhvhv D  ####")
renderLine(33,"#                     vhvhvhvhvhv *Y**###")
renderLine(34,"#c                    vhvhvhvhvhv *g  ###")
renderLine(35,"#c                    vhvhvhvhvhv *   ###")
renderLine(36,"#########qq##############################")
renderLine(37,"#M    ;     w/w/ ; wppppppppppppppppppVF#")
renderLine(38,"# ;         w:w    #pppppttGtttGttpppp@##")
renderLine(39,"#           www    #ppppptG%G%G%Gtpppp@##")
renderLine(40,"#     /        /   #pppppG%~~~~~%Gpppp@##")
renderLine(41,"#;          Q    / #HpppptG~~~~~Gtpppp@##")
renderLine(42,"#                  Bpppppt%~~~~~%tpppp@##")
renderLine(43,"#            /     #HpppptG~~~~~Gtpppp@##")
renderLine(44,"#/    ;    www     #pppppG%~~~~~%Gpppp@##")
renderLine(45,"#          w;w  /  #ppppptG%G%G%Gtpppp@##")
renderLine(46,"#          www    C#pppppttGtttGttpppp@##")
renderLine(47,"# ;               E#pppppppppppppppppp@##")
renderLine(48,"####################@@@@@@@@@@@@@@@@@@@##")

oxyd_shuffle()

ffc1=0

xa=((random(11))+24)
xb=((random(11))+24)
xc=((random(11))+24)
xd=((random(11))+24)
xe=((random(11))+24)
xf=((random(11))+24)

enigma.KillStone(22,xa)
enigma.KillStone(24,xb)
enigma.KillStone(26,xc)
enigma.KillStone(28,xd)
enigma.KillStone(30,xe)
enigma.KillStone(32,xf)

ff1=0
function funcc1()
if ff1==0 then
ff1=1
elseif ff1==1 then
ff1=0
end
funcc8()
end

ff2=0
function funcc2()
if ff2==0 then
ff2=1
elseif ff2==1 then
ff2=0
end
funcc8()
end

ff3=0
function funcc3()
if ff3==0 then
ff3=1
elseif ff3==1 then
ff3=0
end
funcc8()
end

ff4=0
function funcc4()
if ff4==0 then
ff4=1
elseif ff4==1 then
ff4=0
end
funcc8()
end

ff5=0
function funcc5()
if ff5==0 then
ff5=1
elseif ff5==1 then
ff5=0
end
funcc8()
end

ff6=0
function funcc6()
if ff6==0 then
ff6=1
elseif ff6==1 then
ff6=0
end
funcc8()
end

ff7=0
function funcc7()
if ff7==0 then
ff7=1
elseif ff7==1 then
ff7=0
end
funcc8()
end

ffx=0
function funccx()
if ffx==0 then
ffx=1
elseif ffx==1 then
ffx=0
end
funcc8()
end

ff8=0
function funcc8()
   if (ff1+ff2+ff3+ff4+ff5+ff6+ff7+ffx)==2 and ff8==0 then
      enigma.KillItem(14,30)
      set_item("it-vortex-open", 14, 30,{targetx="21.5",targety="10.5"})
      ff8=1
   end
end

ffb1=0
function funccb1()
if ffb1==0 then
ffb1=1
elseif ffb1==1 then
ffb1=0
end
funccb3()
end

ffb2=0
function funccb2()
if ffb2==0 then
ffb2=1
elseif ffb2==1 then
ffb2=0
end
funccb3()
end

ffb3=0
function funccb3()
if ffb1==1 and ffb2==1 and ffb3==0 then
ffb3=1
end
if ffb1==0 and ffb2==0 and ffb3==1 then
   enigma.KillItem(9,16)
   set_item("it-vortex-open", 9, 16,{targetx="15.5",targety="21.5"})
ffb3=2
end
end



function funccc1()
if ffc1==0 then
   SendMessage("laser3","on")
   SendMessage("laser4","on")
ffc1=1
end
end

function funccc2()
    if ffc1==1 then
        SendMessage("laser3","off")
        SendMessage("laser4","off")
    end
    ffc1=0
end

ft1=0
function timer_callback()
if ft1==0 then
   set_floor("fl-leaves",1,6)
   enigma.KillStone(2,6)
ft1=1
end
end

set_stone( "st-timer", 43, 0,
           {target="timer_callback", action="callback",
	      name="timer", interval=1} )