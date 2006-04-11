-- You need them, a level for Enigma
-- Copyright (C) 2006 Raoul
-- Licensed under GPL v2.0 or above 
-- Dont think to much

-- GENERAL --
levelw = 58
levelh = 37
create_world(levelw, levelh)
enigma.ConserveLevel = 1
oxyd_default_flavor = "a"

-- DESIGN --
boden="fl-black"
wand="st-glass"

fill_floor(boden, 0,0, levelw,levelh)

function renderLine( line, pattern)
	for i=1, strlen(pattern) do
		local c = strsub( pattern, i, i)
		if c =="#" then
			set_stone(wand, i-1, line)
  		elseif c=="x" then
			oxyd(i-1, line)
  		elseif c=="o" then
			set_stone("st-stoneimpulse",i-1, line)
  		elseif c=="u" then
			set_stone("st-stoneimpulse-hollow",i-1, line)
  		elseif c=="6" then
set_stone("st-puzzle-ns",i-1,line)

  		elseif c=="8" then
set_stone("st-puzzle-ew",i-1,line)


  		elseif c=="1" then
set_stone("st-puzzle-sw",i-1,line)

  		elseif c=="2" then
set_stone("st-puzzle-nw",i-1,line)

  		elseif c=="3" then
set_stone("st-puzzle-ne",i-1,line)

  		elseif c=="4" then
set_stone("st-puzzle-es",i-1,line)

  		elseif c=="l" then
set_stone("st-puzzle-nsw",i-1,line)

  		elseif c=="r" then
set_stone("st-puzzle-nes",i-1,line)


		end
	end	
end

renderLine(00 , "##########################################################")
renderLine(01 , "#                  #                  #                  #")
renderLine(02 , "#                                                        #")
renderLine(03 , "#                                                        #")
renderLine(04 , "#                                  ooooooooooo           #")
renderLine(05 , "#                                  o         o           #")
renderLine(06 , "#                                  o         o           #")
renderLine(07 , "#                                  o     ooooo           #")
renderLine(08 , "#                                  o     o               #")
renderLine(09 , "#                                  o     o               #")
renderLine(10 , "#                                  o     o               #")
renderLine(11 , "#                 ooooo ooooooooo  o ooo oooo            #")
renderLine(12 , "##               oo###o#3#######o##o#o#o    o           ##")
renderLine(13 , "#              ooo #                  1oooooo            #")
renderLine(14 , "#              o   #                  #                  #")
renderLine(15 , "#           oooo   #   81        481  #                  #")
renderLine(16 , "#           o     oo  6xr 81  488lx6  2ouu               #")
renderLine(17 , "#           o     o#  382  6      82  #  u               #")
renderLine(18 , "#           o     o#       r88l       #  u               #")
renderLine(19 , "#           o     o8  481  6  6  48   #  u               #")
renderLine(20 , "#        oooo      #  6xr88   388lx6  2o u               #")
renderLine(21 , "#        o    ooooo6  38         382  #o u               #")
renderLine(22 , "#        oooooo#####                  oo u               #")
renderLine(23 , "#              ouuuu                  #  o               #")
renderLine(24 , "##             ouoo#u#o#######4##o#####  o              ##")
renderLine(25 , "#              ouooou#ooo ooooo  ooooooooo               #")
renderLine(26 , "#              ouuuuuo  o o                              #")
renderLine(27 , "#              ooooooo  o o                              #")
renderLine(28 , "#                       o o                              #")
renderLine(29 , "#                     ooo o                              #")
renderLine(30 , "#                     o   o                              #")
renderLine(31 , "#                     ooooo                              #")
renderLine(32 , "#                                                        #")
renderLine(33 , "#                                                        #")
renderLine(34 , "#                                                        #")
renderLine(35 , "#                  #                  #                  #")
renderLine(36,  "##########################################################")

oxyd_shuffle()

-- Special
set_actor("ac-blackball", 22.5,22.5, {player=0})                    

-- Cheatprotection
set_item("it-trigger",22,15,{action="callback", target="prot1", invisible=TRUE})
set_item("it-trigger",33,17,{action="callback", target="prot2", invisible=TRUE})
set_item("it-trigger",24,21,{action="callback", target="prot3", invisible=TRUE})
set_item("it-trigger",35,19,{action="callback", target="prot4", invisible=TRUE})
set_item("it-trigger",25,16,{action="callback", target="prot5", invisible=TRUE})
set_item("it-trigger",27,20,{action="callback", target="prot6", invisible=TRUE})
set_item("it-trigger",30,17,{action="callback", target="prot7", invisible=TRUE})

p1=0
p2=0
p3=0
p4=0
p5=0
p6=0
p7=0

function prot1()
 p1=1-p1
 check()
end

function prot2()
 p2=1-p2
 check()
end

function prot3()
 p3=1-p3
 check()
end

function prot4()
 p4=1-p4
 check()
end

function prot5()
 p5=1-p5
 check()
end

function prot6()
 p6=1-p6
 check()
end

function prot7()
 p7=1-p7
 check()
end

function check()
 if p1+p2+p3+p4+p5+p6+p7==7 then
  set_item("it-magicwand",16,26)
 else 
  enigma.KillItem(16,26)
 end
end
