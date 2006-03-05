-- How solid?, a level for Enigma
-- Copyright (C) 2005 Andreas Lochmann
-- Licensed under GPL v2.0 or above 
-- Created with the help of BBE 1.05

Require("levels/lib/ant.lua")
function file_oxyd(x,y,f)
    oxyd_default_flavor=f
    oxyd(x,y)
end
levelh=13
levelw=20
enigma.FlatForce=30
enigma.SlopeForce=30
enigma.ElectricForce=30
cells={}
items={}
actors={}
stones={}
actors[" "]=cell{}
stones[" "]=cell{}
cells[" "]=cell{}
items[" "]=cell{}
cells["!"]=cell{floor="fl-abyss"}
stones["!"]=cell{stone="st-timer"}
stones["#"]=cell{stone="st-brick"}
stones["$"]=cell{stone="st-fourswitch"}
cells["#"]=cell{floor="fl-brick"}
function ac_blackball(x,y)
n=""
p=0
f=0
 if (x==2) and (y==2) then
  n="ac2x2"
  p=0
  mf=1,66666666666667
 end
set_actor("ac-blackball",x+0.5,y+0.5,{player=p,name=n,mouseforce=mf})
end
actors["!"]=cell{parent={{ac_blackball}}}
items["!"]=cell{item="it-document"}
stones["%"]=cell{stone="st-switch"}
stones["&"]=cell{parent={{file_oxyd,"a"}}}
level={"!!!!!!!!!!!!!!!!!!!!",
       "!!!!!!!!!!!!!!!!!!!!",
       "!!######!#!!!#####!!",
       "!!#!#!##!###!#!###!!",
       "!!!!#!##!!!###!###!!",
       "!!###!####!#!!!!#!!!",
       "!!#!!!!!!#!#!#####!!",
       "!!######!#!#!#!!!!!!",
       "!!######!#!#!#!!!!!!",
       "!!!!!!##!#!#!#!!###!",
       "!!######!###!######!",
       "!!!!!!!!!!!!!!!!###!",
       "!!!!!!!!!!!!!!!!!!!!"}
   acmap={"                    ",
          "                    ",
          "  !                 ",
          "                    ",
          "                    ",
          "                    ",
          "                    ",
          "                    ",
          "                    ",
          "                    ",
          "                    ",
          "                    ",
          "                    "}
  itmap={"                    ",
         "                    ",
         "                    ",
         "  !                 ",
         "                    ",
         "                    ",
         "                    ",
         "                    ",
         "                    ",
         "                    ",
         "                    ",
         "                    ",
         "                    "}
 stmap={"####################",
        "####################",
        "##      # ###     ##",
        "## # #  #   # #   %#",
        "##%# #  ###   #   ##",
        "##   #    # ########",
        "## ###### # #     ##",
        "##      # # # ######",
        "##      # # # ######",
        "######  # # # ##  &#",
        "##      #   # ##   #",
        "##########%#####  &#",
        "####################"}

sw1 = 0.0
sw2 = 0.0
sw3 = 0.0
uhrlaeuft = 0.0
richtung = 1.0
posx = 1.0
posy = 10.0
zerstoert = 0.0
if difficult then
  TIMERINT = 1.0
else
  TIMERINT = 1.2
end

function testallswitches()
  if (sw1 + sw2 + sw3 == 3.0) then
    uhrlaeuft = 1.0
  end
end
function switch1()
  sw1 = 1.0 - sw1
  testallswitches()
end
function switch2()
  sw2 = 1.0 - sw2
  testallswitches()
end
function switch3()
  sw3 = 1.0 - sw3
  testallswitches()
end
function timercallback()
  if (uhrlaeuft == 1.0) and (zerstoert == 0.0) then
    kill_stone(posx, posy)
    if difficult then
      if richtung == 1.0 then  posy = posy + 1  end
      if richtung == 2.0 then  posx = posx + 1  end
      if richtung == 3.0 then  posy = posy - 1  end
      if richtung == 4.0 then  posx = posx - 1  end
    else
      if richtung == 1.0 then  posy = posy - 1  end
      if richtung == 2.0 then  posx = posx + 1  end
      if richtung == 3.0 then  posy = posy + 1  end
      if richtung == 4.0 then  posx = posx - 1  end
    end
    if posx > 19 then posx = 19  end
    if posx < 0 then posx = 0  end
    if posy > 12 then posy = 12  end
    if posy < 0 then posy = 0  end
    if not ((posx == 1.0) and (posy == 1.0)) then
      set_stone("st-fourswitch",posx,posy, {action="callback", target="hitclock"})
      mir = enigma.GetStone(posx,posy)
      richtung2=richtung
      richtung=1
      --if richtung2 > 1 then
        for j=1,richtung2+3 do
          SendMessage(mir, "trigger")
          --SendMessage(mir, "turn", nil)
        end
      --end
    else -- hit the timer!
      zerstoert = 1.0
      set_item("it-document", 2,3)
      SetAttrib(enigma.GetItem(2,3),"text","That wasn't fast enough; try F3.                                                                              (Or search for non-solid stones, if you want.)                                                                                                        (But you won't find any.)                                                                                                                  (Really!)")
    end
  end
end
function hitclock()
  richtung = richtung + 1.0
  if richtung == 5.0 then
    richtung = 1.0
  end
end

create_world_by_map(level)
draw_map(0,0,stmap,stones)
draw_map(0,0,itmap,items)
draw_map(0,0,acmap,actors)
--SetAttrib(enigma.GetStone(0,0),"interval",1.0)
--SetAttrib(enigma.GetStone(0,0),"on",TRUE)
--SetAttrib(enigma.GetStone(0,0),"loop",TRUE)
set_stone("st-switch", 2, 4, {action="callback", target="switch1"})
set_stone("st-switch",18, 3, {action="callback", target="switch2"})
set_stone("st-switch",10,11, {action="callback", target="switch3"})
set_stone("st-timer", 1, 1, {action="callback", target="timercallback", interval=TIMERINT} )
set_stone("st-fourswitch",posx,posy, {action="callback", target="hitclock"})
--stones["("]=cell{stone="st-mirror-3^"}

enigma.ConserveLevel = FALSE

SetAttrib(enigma.GetItem(2,3),"text","You can believe me: All stones you see in this level are solid!                                                                                      You can really believe me!                                                                               Really!")
oxyd_shuffle()




























