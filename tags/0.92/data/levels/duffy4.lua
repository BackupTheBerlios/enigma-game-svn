-- Copyright (c) 2003 Jacob Scott
-- License: GPL v2.0 or above
-- Enigma Level: The Document

levelw=80
levelh=20

create_world( levelw, levelh)

fill_floor("fl-leaves", 0,0,levelw,levelh)

function renderLine( line, pattern)
	for i=1, strlen(pattern) do
		local c = strsub( pattern, i, i)
		if c =="#" then
			set_stone( "st-glass", i-1, line)
		elseif c == "o" then
			oxyd( i-1, line)
                elseif c == "!" then
			abyss(i-1,line)
--			fill_floor("fl-water", i-1,line, 1,1)
		elseif c=="z" then
			set_actor("ac-blackball", i-.5,line+.5)
		elseif c=="+" then
			set_stone( "st-wood", i-1, line)
		elseif c=="`" then
			mirrorp(i-1,line,FALSE,TRUE, 2)
		elseif c=="/" then
			mirrorp(i-1,line,FALSE,TRUE, 4)
		elseif c=="5" then	
			set_item("it-coin1", i-1,line)
		elseif c=="4" then	
			set_item("it-coin4", i-1,line,{value=3})
		elseif c=="P" then
			set_item("it-brush",i-1,line)
		elseif c=="a" then
			set_stone("st-switch", i-1,line, {action="callback",target="fa"})
		elseif c=="b" then
			set_stone("st-switch", i-1,line, {action="callback",target="fb"})
		elseif c=="c" then
			set_stone("st-switch", i-1,line, {action="callback",target="fc"})
		elseif c=="d" then
			set_stone("st-switch", i-1,line, {action="callback",target="fd"})
		elseif c=="e" then
			set_stone("st-switch", i-1,line, {action="callback",target="fe"})

		elseif c=="f" then
			set_stone("st-switch", i-1,line, {action="callback",target="ff"})
		elseif c=="g" then
			set_stone("st-switch", i-1,line, {action="callback",target="fg"})
		elseif c=="h" then
			set_stone("st-switch", i-1,line, {action="callback",target="fh"})
		elseif c=="i" then
			set_stone("st-switch", i-1,line, {action="callback",target="fi"})
		elseif c=="j" then
			set_stone("st-switch", i-1,line, {action="callback",target="fj"})
		elseif c=="k" then
			set_stone("st-switch", i-1,line, {action="callback",target="fk"})
		elseif c=="l" then
			set_stone("st-switch", i-1,line, {action="callback",target="fl"})
		elseif c=="m" then
			set_stone("st-switch", i-1,line, {action="callback",target="fm"})
		elseif c=="n" then
			set_stone("st-switch", i-1,line, {action="callback",target="fn"})
		elseif c=="O" then
			set_stone("st-switch", i-1,line, {action="callback",target="fo"})
		elseif c=="p" then
			set_stone("st-switch", i-1,line, {action="callback",target="fp"})
		elseif c=="q" then
			set_stone("st-switch", i-1,line, {action="callback",target="fq"})
		elseif c=="r" then
			set_stone("st-switch", i-1,line, {action="callback",target="fr"})
		elseif c=="s" then
			set_stone("st-switch", i-1,line, {action="callback",target="fs"})
		elseif c=="t" then
			set_stone("st-switch", i-1,line, {action="callback",target="ft"})
		elseif c=="u" then
			set_stone("st-switch", i-1,line, {action="callback",target="fu"})
		elseif c=="v" then
			set_stone("st-switch", i-1,line, {action="callback",target="fv"})
		elseif c=="w" then
			set_stone("st-switch", i-1,line, {action="callback",target="fw"})
		elseif c=="x" then
			set_stone("st-switch", i-1,line, {action="callback",target="fx"})
		elseif c=="y" then
			set_stone("st-switch", i-1,line, {action="callback",target="fy"})
		elseif c=="Z" then
			set_stone("st-switch", i-1,line, {action="callback",target="fz"})
		elseif c=="A" then
			doorh( i-1,line, {name="door1"})
		elseif c=="B" then
			doorh( i-1,line, {name="door2"})
		elseif c=="C" then
			doorh( i-1,line, {name="door3"})
		elseif c == "L" then
			abyss(i-1,line)
 			draw_stones("st-glass", {i-1,line},{1,1}, 1)
			set_item("it-magicwand",i-1,line)
		elseif c == "G" then
			fill_floor("fl-leaves", i-1,line,1,1)
			draw_stones("st-glass", {i-1,line},{1,0}, 1)
			set_item("it-magicwand",i-1,line)
		elseif c == "Y" then
			fill_floor("fl-sand", i-1,line,1,1)
			draw_stones("st-glass", {i-1,line},{1,0}, 1)
			set_item("it-magicwand",i-1,line)
		elseif c == "K" then
			fill_floor("fl-bluegreen", i-1,line,1,1)
			draw_stones("st-glass", {i-1,line},{1,0}, 1)
			set_item("it-magicwand",i-1,line)
		elseif c == "W" then
			fill_floor("fl-inverse", i-1,line, 1,1)
			draw_stones("st-glass", {i-1,line},{1,0}, 1)
			set_item("it-magicwand",i-1,line)
		elseif c=="I" then
			fill_floor("fl-ice_001", i-1,line, 1,1)
			draw_stones("st-glass", {i-1,line},{1,0}, 1)
			set_item("it-magicwand",i-1,line)
		elseif c=="T" then
			fill_floor("fl-marble", i-1,line, 1,1)
			draw_stones("st-glass", {i-1,line},{1,0}, 1)
			set_item("it-magicwand",i-1,line)
		elseif c=="R" then
			fill_floor("fl-wood", i-1,line, 1,1)
			draw_stones("st-glass", {i-1,line},{1,0}, 1)
			set_item("it-magicwand",i-1,line)
		elseif c=="S" then
			fill_floor("fl-space", i-1,line, 1,1)
		end
	end	
end

-- Floor:  " "
-- Border: "#"
-- Oxyd:   "o"

renderLine(00,"#######################################")
renderLine(01,"#                   #o               o#")
renderLine(02,"#    edcba          #########C#########")
renderLine(03,"#                   #########B#########")
renderLine(04,"#    jihgf          #########A#########")
renderLine(05,"#                                     #")
renderLine(06,"#    Onmlk  z                     D   #")
renderLine(07,"#                            ILT      #")
renderLine(08,"#    tsrqp                   SSK      #")
renderLine(09,"#                            GRY      #")
renderLine(10,"#    yxwvu                            #")
renderLine(11,"#                                    Z#")
renderLine(12,"#######################################")

oxyd_shuffle()

--document(34,6,"What do you want the first gate to do?")
--document(29,4,"Opposite")
--document(29,3,"If ten equals three, five equals four, two equals three, four equals four, and thirteen equals eight, what does nine equal?")
--document(29,2,"Congratulations!")

num1=0
through=0
function fa()
    if through==0 then
	num1=num1+1
	through=1
    getletter()
    elseif through==1 then
	num1=num1-1
	through=0
    getletter()
    end
end

throughb=0
function fb()
    if throughb==0 then
	num1=num1+2
	throughb=1
    getletter()
    elseif throughb==1 then
	num1=num1-2
	throughb=0
    getletter()
    end
end

throughc=0
function fc()
    if throughc==0 then
	num1=num1+4
	throughc=1
    getletter()
    elseif throughc==1 then
	num1=num1-4
	throughc=0
    getletter()
    end
end

throughd=0
function fd()
    if throughd==0 then
	num1=num1+8
	throughd=1
    getletter()
    elseif throughd==1 then
	num1=num1-8
	throughd=0
    getletter()
    end
end

throughe=0
function fe()
    if throughe==0 then
	num1=num1+16
	throughe=1
    getletter()
    elseif throughe==1 then
	num1=num1-16
	throughe=0
    getletter()
    end
end

num2=0
throughf=0
function ff()
    if throughf==0 then
	num2=num2+1
	throughf=1
    getletter()
    elseif throughf==1 then
	num2=num2-1
	throughf=0
    getletter()
    end
end

throughg=0
function fg()
    if throughg==0 then
	num2=num2+2
	throughg=1
    getletter()
    elseif throughg==1 then
	num2=num2-2
	throughg=0
    getletter()
    end
end

throughh=0
function fh()
    if throughh==0 then
	num2=num2+4
	throughh=1
    getletter()
    elseif throughh==1 then
	num2=num2-4
	throughh=0
    getletter()
    end
end

throughi=0
function fi()
    if throughi==0 then
	num2=num2+8
	throughi=1
    getletter()
    elseif throughi==1 then
	num2=num2-8
	throughi=0
    getletter()
    end
end

throughj=0
function fj()
    if throughj==0 then
	num2=num2+16
	throughj=1
    getletter()
    elseif throughj==1 then
	num2=num2-16
	throughj=0
    getletter()
    end
end

num3=0
throughk=0
function fk()
    if throughk==0 then
	num3=num3+1
	throughk=1
    getletter()
    elseif throughk==1 then
	num3=num3-1
	throughk=0
    getletter()
    end
end

throughl=0
function fl()
    if throughl==0 then
	num3=num3+2
	throughl=1
    getletter()
    elseif throughl==1 then
	num3=num3-2
	throughl=0
    getletter()
    end
end

throughm=0
function fm()
    if throughm==0 then
	num3=num3+4
	throughm=1
    getletter()
    elseif throughm==1 then
	num3=num3-4
	throughm=0
    getletter()
    end
end

throughn=0
function fn()
    if throughn==0 then
	num3=num3+8
	throughn=1
    getletter()
    elseif throughn==1 then
	num3=num3-8
	throughn=0
    getletter()
    end
end

througho=0
function fo()
    if througho==0 then
	num3=num3+16
	througho=1
    getletter()
    elseif througho==1 then
	num3=num3-16
	througho=0
    getletter()
    end
end

num4=0
throughp=0
function fp()
    if throughp==0 then
	num4=num4+1
	throughp=1
    getletter()
    elseif throughp==1 then
	num4=num4-1
	throughp=0
    getletter()
    end
end

throughq=0
function fq()
    if throughq==0 then
	num4=num4+2
	throughq=1
    getletter()
    elseif throughq==1 then
	num4=num4-2
	throughq=0
    getletter()
    end
end

throughr=0
function fr()
    if throughr==0 then
	num4=num4+4
	throughr=1
    getletter()
    elseif throughr==1 then
	num4=num4-4
	throughr=0
    getletter()
    end
end

throughs=0
function fs()
    if throughs==0 then
	num4=num4+8
	throughs=1
    getletter()
    elseif throughs==1 then
	num4=num4-8
	throughs=0
    getletter()
    end
end

throught=0
function ft()
    if throught==0 then
	num4=num4+16
	throught=1
    getletter()
    elseif throught==1 then
	num4=num4-16
	throught=0
    getletter()
    end
end

num5=0
throughu=0
function fu()
    if throughu==0 then
	num5=num5+1
	throughu=1
    getletter()
    elseif throughu==1 then
	num5=num5-1
	throughu=0
    getletter()
    end
end

throughv=0
function fv()
    if throughv==0 then
	num5=num5+2
	throughv=1
    getletter()
    elseif throughv==1 then
	num5=num5-2
	throughv=0
    getletter()
    end
end

throughw=0
function fw()
    if throughw==0 then
	num5=num5+4
	throughw=1
    getletter()
    elseif throughw==1 then
	num5=num5-4
	throughw=0
    getletter()
    end
end

throughx=0
function fx()
    if throughx==0 then
	num5=num5+8
	throughx=1
    getletter()
    elseif throughx==1 then
	num5=num5-8
	throughx=0
    getletter()
    end
end

throughy=0
function fy()
    if throughy==0 then
	num5=num5+16
	throughy=1
    getletter()
    elseif throughy==1 then
	num5=num5-16
	throughy=0
    getletter()
    end
end

firstdooropen=0
seconddooropen=0
thirddooropen=0
fdo=0
sdo=0
tdo=0

function fz()
    document(34,6,"What do you want the first gate to do?")
    document(29,4,"Opposite")
    document(29,3,"If ten equals three, five equals four, two equals three, four equals four, and thirteen equals eight, what does nine equal?")
    document(29,2,"Congratulations!")
    if fdo==0 and sdo==0 and tdo==0 then	
        if num1==15 and num2==16 and num3==5 and num4==14 and num5==29 and fdo==0 then
            SendMessage("door1", "open")
            firstdooropen=1
            fdo=1
        end
    end
    if fdo==1 and sdo==0 and tdo==0 then
        if num1==3 and num2==12 and num3==15 and num4==19 and num5==5 and sdo==0 and fdo==1 then
            SendMessage("door2", "open")
            seconddooropen=1
            firstdooropen=0
            sdo=1
        end
    end
    if fdo==1 and sdo==1 and tdo==0 then
        if num1==6 and num2==15 and num3==21 and num4==18 and num5==28 and tdo==0 and fdo==1 and sdo==1 then
            SendMessage("door3", "open")
            seconddooropen=0
            thirddooropen=1
            tdo=1
        end
    end
end

function getletter()
    if num1>0 and num2>0 and num3>0 and num4>0 and num5>0 then
        local letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ .!?,"
        let1 = strsub(letters, num1, num1)
        let2 = strsub(letters, num2, num2)
        let3 = strsub(letters, num3, num3)
        let4 = strsub(letters, num4, num4)
        let5 = strsub(letters, num5, num5)
	document(30,8,let1..let2..let3..let4..let5)
    end
end
