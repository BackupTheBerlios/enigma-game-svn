-- Copyright (c) 2003 Jacob Scott
-- License: GPL v2.0 or above
-- Enigma Level: Run!

levelw=25
levelh=15

create_world( levelw, levelh)

fill_floor("fl-leaves",0,0,levelw,levelh)

function renderLine( line, pattern)
    for i=1, strlen(pattern) do
        local c = strsub( pattern, i, i)
        if c =="#" then
            set_stone( "st-glass", i-1, line)
        elseif c == "o" then
            oxyd( i-1, line)
        elseif c=="z" then
            local     ball=			set_actor("ac-blackball", i-.5,line+.5)
        elseif c == "*" then
            set_stone( "st-brownie", i-1, line)
        elseif c == "g" then
            set_stone( "st-grate1", i-1, line)
        elseif c == "!" then
            abyss(i-1,line)
            --			fill_floor("fl-water", i-1,line, 1,1)
        elseif c == "~" then
            --			abyss(i-1,line)
            fill_floor("fl-water", i-1,line, 1,1)
        elseif c=="+" then
            set_stone( "st-wood", i-1, line)
        elseif c=="L" then
            set_stone("st-oneway-w", i-1,line)
        elseif c=="R" then
            set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funcc10"})
        elseif c=="J" then
            set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funcc11"})
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
            set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funcc8"})
        elseif c=="9" then
            set_item("it-trigger", i-1,line, {invisible=1,action="callback", target="funcc9"})
        end
    end	
end

-- Floor:  " "
-- Border: "#"
-- Oxyd:   "o"

renderLine(00,"####################")
renderLine(01,"#897897897897897897#")
renderLine(02,"#5 4 6 5 4 6 5 4 6 #")
renderLine(03,"#231231231231231231#")
renderLine(04,"# 9 8 7 9 8 7 9 8 7#")
renderLine(05,"#564564564564564564#")
renderLine(06,"#2 1 3 2 1 3 2 1 3 #")
renderLine(07,"#897897897897897897#")
renderLine(08,"# 6 5 4 6 5 4 6 5 4#")
renderLine(09,"#231231231231231231#")
renderLine(10,"#8 7 9 8 7 9 8 7####")
renderLine(11,"#56456456456456RJLz#")
renderLine(12,"####################")

function renderLine( line, pattern)
   for i=1, strlen(pattern) do
      local c = strsub( pattern, i, i)
      if c =="#" then
	 set_stone( "st-glass", i-1, line)
      elseif c == "o" then
	 oxyd( i-1, line)
      end
   end
end

renderLine(00,"####o###o##o###o####")
renderLine(01,"#                  #")
renderLine(02,"# # # # # # # # # ##")
renderLine(03,"o                  o")
renderLine(04,"## # # # # # # # # #")
renderLine(05,"o                  o")
renderLine(06,"# # # # # # # # # ##")
renderLine(07,"o                  o")
renderLine(08,"## # # # # # # # # #")
renderLine(09,"o                  o")
renderLine(10,"# # # # # # # # # ##")
renderLine(11,"#                  #")
renderLine(12,"####o###o##o###o####")

oxyd_shuffle()

fill_floor("fl-abyss",1,1,3,3)

direc=0

tt=0

ax=2
ay=2

bx=16
by=11

prev=0

f1=0
f2=0
f3=0
f4=0
f5=0
f6=0
f7=0
f8=0
f9=0
f10=0
f11=0

cur=4

function funcc1()
   if f1==0 then
      cur=1
      f1=1
      dcheck()
   else
      f1=0
   end
end

function funcc2()
   if f2==0 then
      cur=2
      f2=1
      dcheck()
   else
      f2=0
   end
end

function funcc3()
   if f3==0 then
      cur=3
      f3=1
      dcheck()
   else
      f3=0
   end
end

function funcc4()
   if f4==0 then
      cur=4
      f4=1
      dcheck()
   else
      f4=0
   end
end

function funcc5()
   if f5==0 then
      cur=5
      f5=1
      dcheck()
   else
      f5=0
   end
end

function funcc6()
   if f6==0 then
      cur=6
      f6=1
      dcheck()
   else
      f6=0
   end
end

function funcc7()
   if f7==0 then
      cur=7
      f7=1
      dcheck()
   else
      f7=0
   end
end

function funcc8()
   if f8==0 then
      cur=8
      f8=1
      dcheck()
   else
      f8=0
   end
end

function funcc9()
   if f9==0 then
      cur=9
      f9=1
      dcheck()
   else
      f9=0
   end
end

function funcc10()
   if f10==0 then
      bx=15
      by=11
      cur=4
      f10=1
      if prev==6 then
	 bx=14
	 by=11
	 dcheck()
      end
      if prev==7 then
	 bx=15
	 by=10
	 dcheck()
      end
   else
      f10=0
   end
end


function funcc11()
   if f11==0 then
      cur=5
      prev=4
   else
      f11=1
   end
end

function dcheck()
tt=1
if cur==2 and prev==1 then
direc=2
elseif cur==3 and prev==2 then
direc=2
elseif cur==1 and prev==3 then
direc=2
elseif cur==5 and prev==4 then
direc=2
elseif cur==6 and prev==5 then
direc=2
elseif cur==4 and prev==6 then
direc=2
elseif cur==8 and prev==7 then
direc=2
elseif cur==9 and prev==8 then
direc=2
elseif cur==7 and prev==9 then
direc=2

elseif cur==1 and prev==2 then
direc=4
elseif cur==2 and prev==3 then
direc=4
elseif cur==3 and prev==1 then
direc=4
elseif cur==4 and prev==5 then
direc=4
elseif cur==5 and prev==6 then
direc=4
elseif cur==6 and prev==4 then
direc=4
elseif cur==7 and prev==8 then
direc=4
elseif cur==8 and prev==9 then
direc=4
elseif cur==9 and prev==7 then
direc=4

elseif cur==4 and prev==1 then
direc=1
elseif cur==5 and prev==2 then
direc=1
elseif cur==6 and prev==3 then
direc=1
elseif cur==7 and prev==4 then
direc=1
elseif cur==8 and prev==5 then
direc=1
elseif cur==9 and prev==6 then
direc=1
elseif cur==1 and prev==7 then
direc=1
elseif cur==2 and prev==8 then
direc=1
elseif cur==3 and prev==9 then
direc=1

elseif cur==1 and prev==4 then
direc=3
elseif cur==2 and prev==5 then
direc=3
elseif cur==3 and prev==6 then
direc=3
elseif cur==4 and prev==7 then
direc=3
elseif cur==5 and prev==8 then
direc=3
elseif cur==6 and prev==9 then
direc=3
elseif cur==7 and prev==1 then
direc=3
elseif cur==8 and prev==2 then
direc=3
elseif cur==9 and prev==3 then
direc=3
end

   if direc==1 then
      by=by-1
   elseif direc==2 then
      bx=bx+1
   elseif direc==3 then
      by=by+1
   elseif direc==4 then
      bx=bx-1
   end

prev=cur
end

function timer_callback()
   xdist=(((ax-bx)^2)^(1/2))
   ydist=(((ay-by)^2)^(1/2))
   if xdist>ydist and (ax-bx)<0 then
      direc2=2
   elseif xdist>ydist and (ax-bx)>0 then
      direc2=4
   elseif ydist>xdist and (ay-by)<0 then
      direc2=3
   elseif ydist>xdist and (ay-by)>0 then
      direc2=1
   elseif xdist==ydist then
      direc2=random(2)
      if (ax-bx)>0 then
	 if (ay-by)>0 then
	    if direc2==1 then
	       direc2=1
	    elseif direc2==2 then
	       direc2=4
	    end
	 elseif (ay-by)<0 then
	    if direc2==1 then
	       direc2=3
	    elseif direc2==2 then
	       direc2=4
	    end
	 end
      elseif (ax-bx)<0 then
	 if (ay-by)>0 then
	    if direc2==1 then
	       direc2=1
	    elseif direc2==2 then
	       direc2=2
	    end
	 elseif (ay-by)<0 then
	    if direc2==1 then
	       direc2=2
	    elseif direc2==2 then
	       direc2=3
	    end
	 end
      end	       
   end
   if direc2==1 then
      ay=ay-1
   elseif direc2==2 then
      ax=ax+1
   elseif direc2==3 then
      ay=ay+1
   elseif direc2==4 then
      ax=ax-1
   end
set_floor("fl-abyss", (ax-1), (ay-1))
set_floor("fl-abyss", (ax-1), (ay))
set_floor("fl-abyss", (ax-1), (ay+1))
set_floor("fl-abyss", (ax), (ay-1))
set_floor("fl-abyss", (ax), (ay))
set_floor("fl-abyss", (ax), (ay+1))
set_floor("fl-abyss", (ax+1), (ay-1))
set_floor("fl-abyss", (ax+1), (ay))
set_floor("fl-abyss", (ax+1), (ay+1))

if direc2==4 then
set_floor("fl-leaves", (ax+2), (ay+1))
set_floor("fl-leaves", (ax+2), (ay))
set_floor("fl-leaves", (ax+2), (ay-1))
end

if direc2==2 then
set_floor("fl-leaves", (ax-2), (ay+1))
set_floor("fl-leaves", (ax-2), (ay))
set_floor("fl-leaves", (ax-2), (ay-1))
end

if direc2==1 then
set_floor("fl-leaves", (ax-1), (ay+2))
set_floor("fl-leaves", (ax), (ay+2))
set_floor("fl-leaves", (ax+1), (ay+2))
end

if direc2==3 then
set_floor("fl-leaves", (ax-1), (ay-2))
set_floor("fl-leaves", (ax), (ay-2))
set_floor("fl-leaves", (ax+1), (ay-2))
end
end


set_stone("st-timer", 21,0, {loop=1, action="callback", target="timer_callback", interval=.35})