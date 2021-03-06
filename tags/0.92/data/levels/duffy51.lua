-- Copyright (c) 2003 Jacob Scott
-- License: GPL v2.0 or above
-- Enigma Level: Stranded

levelw=20
levelh=13

create_world( levelw, levelh)

fill_floor("fl-hay", 0,0,levelw,levelh)

function renderLine( line, pattern)
    for i=1, strlen(pattern) do
        local c = strsub( pattern, i, i)
        if c =="#" then
            set_stone( "st-greenbrown", i-1, line)
        elseif c =="X" then
            set_stone( "st-death", i-1, line)
        elseif c =="%" then
            set_stone( "st-actorimpulse", i-1, line)
        elseif c == "o" then
            oxyd( i-1, line)
        elseif c == "*" then
            set_stone( "st-brownie", i-1, line)
        elseif c == "!" then
            abyss(i-1,line)
            --			fill_floor("fl-water", i-1,line, 1,1)
        elseif c == "~" then
            --			abyss(i-1,line)
            fill_floor("fl-water", i-1,line, 1,1)
        elseif c=="z" then
            local ac0=set_actor("ac-blackball", i,line+.5, {name="ac0"})
        elseif c=="W" then
            local ac1=set_actor("ac-killerball", i,line+.5, {player=1, mouseforce=1,name="ac1"})
        elseif c=="i" then
            set_actor("ac-rotor", i-.5,line+.5, {player=1, mouseforce=0, range=28, force=50})
        elseif c == "g" then
            draw_stones("st-grate1",{i-1,line}, {1,1}, 1)
        elseif c=="+" then
            set_stone( "st-wood", i-1, line)
        elseif c=="=" then
            set_floor("fl-space",i-1,line)
        elseif c == "b" then
            yy1( "black",  i-1, line)
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
        elseif c =="A" then
            set_stone( "st-chargeplus", i-1, line)
        elseif c =="B" then
            set_stone( "st-chargeminus", i-1, line)
        elseif c =="C" then
            set_stone( "st-chargezero", i-1, line)
        elseif c =="U" then
            set_stone( "st-chargeplus", i-1, line)
            set_floor("fl-gradient",  i-1,  line, {type=3})
        elseif c =="V" then
            set_stone( "st-chargeplus", i-1, line)
            set_floor("fl-gradient",  i-1,  line, {type=4})
        elseif c =="T" then
            set_stone( "st-scissors", i-1, line)
        elseif c =="H" then
            set_stone("st-switch", i-1,line, {action="callback", target="funcc1"})
        elseif c =="I" then
            set_stone("st-switch", i-1,line, {action="callback", target="funcc2"})
        elseif c =="J" then
            set_stone("st-switch", i-1,line, {action="callback", target="funcc3"})
        elseif c =="K" then
            set_stone("st-switch", i-1,line, {action="callback", target="funcc4"})
        elseif c =="L" then
            set_stone("st-switch", i-1,line, {action="callback", target="funcc5"})
        elseif c =="M" then
            set_stone("st-switch", i-1,line, {action="callback", target="funcc6"})
        elseif c =="P" then
            set_stone("st-door_a",i-1,line,{name="door1"})
        elseif c =="Q" then
            set_stone("st-door_a",i-1,line,{name="door2"})
        elseif c =="R" then
            set_stone("st-door_a",i-1,line,{name="door3"})
        elseif c =="S" then
            set_stone("st-door_a",i-1,line,{name="door4"})

        end
    end	
end

function yy1( color, x, y)
    stone = format( "st-%s4", color)
    set_stone( stone, x, y)
end

renderLine(00,"#oB######TT######Bo#")
renderLine(01,"#~                ~#")
renderLine(02,"#        z         #")
renderLine(03,"#  ######PQ######  #")
renderLine(04,"#  #o%H~~~~~~I%o#  #")
renderLine(05,"#  #  b~+  +~b  #  #")
renderLine(06,"L  #  b~AW A~b  #  M")
renderLine(07,"#  #  b~+  +~b  #  #")
renderLine(08,"#  #o%J~~~~~~K%o#  #")
renderLine(09,"#  ######RS######  #")
renderLine(10,"#                  #")
renderLine(11,"#~                ~#")
renderLine(12,"#oB######TT######Bo#")

oxyd_shuffle()

ac0=enigma.GetNamedObject("ac0")
ac1=enigma.GetNamedObject("ac1")

enigma.AddRubberBand(ac0,ac1,1,7)

ff1=0
function funcc1()
   if ff1==0 then
      ff1=1
   elseif ff1==1 then
      ff1=0
   end
   funcc7()
end

ff2=0
function funcc2()
   if ff2==0 then
      ff2=1
   elseif ff2==1 then
      ff2=0
   end
   funcc7()
end

ff3=0
function funcc3()
   if ff3==0 then
      ff3=1
   elseif ff3==1 then
      ff3=0
   end
   funcc7()
end

ff4=0
function funcc4()
   if ff4==0 then
      ff4=1
   elseif ff4==1 then
      ff4=0
   end
   funcc7()
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

function funcc7()
    if ff1==1 and ff2==1 and ff3==1 and ff4==1 then
        SendMessage("door1","open")
        SendMessage("door2","open")
        SendMessage("door3","open")
        SendMessage("door4","open")
    end
    if ff1==0 or ff2==0 or ff3==0 or ff4==0 then
        SendMessage("door1","close")
        SendMessage("door2","close")
        SendMessage("door3","close")
        SendMessage("door4","close")
    end
end

function funcc8()
    if ff5==1 and ff6==0 then
        enigma.ElectricForce=100
    end
    if ff5==0 and ff6==1 then
        enigma.ElectricForce=100
    end
    if ff5==1 and ff6==1 then
        enigma.ElectricForce=200
    end
    if ff5==0 and ff6==0 then
        enigma.ElectricForce=0
    end
end