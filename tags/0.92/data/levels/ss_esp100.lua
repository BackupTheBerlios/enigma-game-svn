-- A level for Enigma
-- Copyright: 	(C) 2003 Sven Siggelkow
-- License: 	GPL v2.0 or above
-- Esprit # 100
                                                               
world.DefineSimpleStoneMovable("oneway_move", "st-metal", 0)

display.DefineAlias("oneway_move", "st-oneway_black-n")

dofile(enigma.FindDataFile("levels/ant.lua"))
cells={}

-- only for testing
--if difficult then 
--  cells[" "]=cell{floor="fl-space"}
--else
--  cells[" "]=cell{floor="fl-swamp"}
--end
cells[" "]=cell{floor="fl-space"}
cells["#"]=cell{stone="st-rock1"}
cells["."]=cell{item="it-extralife", floor="fl-metal"}
cells["1"]=cell{parent=cells[" "],stone={"st-key_a", {action="openclose", target="door1"}}}
cells["2"]=cell{parent=cells[" "],stone={"st-key_b", {action="callback", target="door23"}}}
cells["3"]=cell{parent=cells[" "],stone={"st-key_c", {action="callback", target="door45"}}}

cells["4"]=cell{floor="fl-metal",stone={"st-door_c", {name="door1"}}}
cells["5"]=cell{floor="fl-metal",stone={"st-door_c", {name="door2"}}}
cells["6"]=cell{floor="fl-metal",stone={"st-door_c", {name="door3"}}}
cells["7"]=cell{floor="fl-metal",stone={"st-door_c", {name="door4"}}}
cells["8"]=cell{floor="fl-metal",stone={"st-door_c", {name="door5"}}}
cells["9"]=cell{parent=cells[" "], item="it-coin2"}
cells["<"]=cell{floor="fl-metal",stone="st-oneway-w"}
cells[">"]=cell{floor="fl-metal",stone="st-oneway-e"}
cells["A"]=cell{floor="fl-metal",stone={"st-door_b", {name="door6"}}}
cells["B"]=cell{floor="fl-metal",stone="st-rock3_break"}
cells["C"]=cell{parent=cells[" "],stone={"st-coinslot", {action="openclose", target="door6"}}}
cells["D"]=cell{parent=cells[" "],stone="st-death"}
cells["E"]=cell{parent=cells[" "],stone="st-bombs"}
cells["H"]=cell{floor="fl-metal",stone="st-rock3_hole"}
cells["I"]=cell{floor="fl-space",stone="st-invisible"}
cells["J"]=cell{item="it-key_a", floor="fl-metal",stone="st-rock3_move"}
cells["K"]=cell{item="it-key_c", floor="fl-metal"}
cells["M"]=cell{floor="fl-metal",stone="st-rock3_move"}
cells["P"]=cell{floor="fl-metal",stone="st-rock3"}                                                

if not difficult then  
  cells["S"]=cell{item="it-umbrella", floor="fl-metal"}     
  cells["Z"]=cell{floor="fl-space"}
  cells["Y"]=cell{parent=cells[" "],stone="st-actorimpulse"}
else -- normal
  cells["S"]=cell{floor="fl-metal"}
  cells["Z"]=cell{parent=cells[" "],stone="st-actorimpulse"}
  cells["Y"]=cell{floor="fl-space"}
end
cells["T"]=cell{item="it-umbrella", floor="fl-metal"}
cells["W"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=48, targety=30.5, strength=0}}}
cells["^"]=cell{floor="fl-metal",stone="st-oneway-n"}
cells["a"]=cell{floor="fl-abyss"}
cells["b"]=cell{parent=cells[" "],stone="st-actorimpulse"}
cells["c"]=cell{item="it-crack1", floor="fl-metal"}
cells["d"]=cell{item="it-dynamite", floor="fl-metal"}   
cells["e"]=cell{floor="fl-leaves"}
cells["f"]=cell{item="it-flagblack", floor="fl-metal"}
cells["g"]=cell{item="it-weight", floor="fl-metal"}
cells["h"]=cell{item="it-hammer", floor="fl-metal",stone="st-rock3_move"}
cells["k"]=cell{item="it-key_b", floor="fl-metal"}
cells["m"]=cell{floor="fl-metal"}
cells["p"]=cell{floor="fl-metal",stone="st-plain"}
cells["v"]=cell{floor="fl-metal",stone="st-oneway-s"}   
cells["�"]=cell{floor="fl-metal",stone="oneway_move"}
cells["'"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=41.5, targety=8.5, strength=0}}}
cells["("]=cell{floor="fl-metal", item={"it-wormhole",{targetx=40.5, targety=3.5, strength=0}}}
cells[")"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=45.5, targety=4.5, strength=0}}}
cells["`"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=39.5, targety=11.5, strength=0}}}
cells["�"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=42.5, targety=8.5, strength=0}}}
cells["*"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=52.5, targety=5.5, strength=0}}}
cells["+"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=53.5, targety=9.5, strength=0}}}
cells["-"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=52.5, targety=5.5, strength=0}}}
cells["_"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=39.5, targety=11.5, strength=0}}}
cells["["]=cell{floor="fl-metal", item={"it-wormhole",{targetx=44.5, targety=10.5, strength=0}}}
cells["]"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=47.5, targety=17.5, strength=0}}}
cells["?"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=44.5, targety=10.5, strength=0}}}
cells[":"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=40.5, targety=3.5, strength=0}}}
cells["�"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=41.5, targety=8.5, strength=0}}}
cells["!"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=45.5, targety=4.5, strength=0}}}
cells["/"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=49.5, targety=3.5, strength=0}}}
cells["="]=cell{floor="fl-metal", item={"it-wormhole",{targetx=47.5, targety=8.5, strength=0}}}
cells["�"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=50.5, targety=10.5, strength=0}}}
cells["$"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=47.5, targety=8.5, strength=0}}}
cells["{"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=49.5, targety=3.5, strength=0}}}
cells["}"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=55.5, targety=3.5, strength=0}}}
cells["%"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=55.5, targety=11.5, strength=0}}}
cells["&"]=cell{floor="fl-metal", item={"it-wormhole",{targetx=49.5, targety=3.5, strength=0}}}


--cells["x"]=cell{floor="fl-metal", actor={"ac-blackball", {player=0}}}  -- see bottom

level = { 
-- 0123456789012345678901234567890123456789012345678901234567 
  "##########################################################" , -- 00
  "#m    m#mmmmmmm.mmm#aaaaaaaaaaaaaaaamaP                  #" , -- 01
  "#   #  #PPP  PPPPmm#aaaaaaaaaaaaaaaamaPIIII    IIIII IIII#" , -- 02
  "#   #  #  P  P  Pmm>mm>HHaJmmmmmmHmamaP�m!IIIIII�K$I I%m&#" , -- 03
  "#   #  #  P  P  PPP#aaaaHamaaaaaaamamaPIIIII/T=IIIIIIIIII#" , -- 04
  "#   #  #9          #aaaaHamaaaaaaamamaP    IIIIII I{S}I  #" , -- 05
  "#   #  #           #aaaavamaaaaammmaMaP       III IIIII  #" , -- 06
  "#   #  #           #aaaaHammmmMam0aamaPIIIII  I?I IIIII  #" , -- 07
  "#   #  #           #aaaaHamaaamamaaamaPI(m)IIIImIIIII-I  #" , -- 08
  "#   #  #  b 9    b #mmMaH0maammammMmmaPIIIII�II:II*IImI  #" , -- 09
  "#   #  #           #gamammm.amaamaaamaP    ImIIIIImII_III#" , -- 10
  "#   #  #           #mammmaamamammaaamaP'   I`I   I+III[m]#" , -- 11
  "#   #  #  9      9 #PPPPPPPmPPPPPPPPBBBBPPPPPPPPPPPPPPPPB#" , -- 12
  "#   #  #           #mmaammmmamammmmm^aP0                0#" , -- 13
  "#   #  #  9      9 #amaamaaaa^amaaaamaP pp1p#######p4ppp #" , -- 14
  "#   #  #    9 b    #amaamaaaamamaaaamaP p   #     #    p #" , -- 15
  "#   #  #    9      #amaa�ammmmamaaaamaP 5   # ### #    p #" , -- 16
  "#   #  #  b        #mmHmmamaaaamaaamgaP p   # #c# #    p #" , -- 17
  "#   #  #        b  #maaamammmmmmmmamaaP 2   # # # #ppppp #" , -- 18
  "#   #  #  9    9   #maaamaaaaaaaamamaaP p   #   # #    7 #" , -- 19
  "#   #  #  YZ       #maaamaaaaaaaamamaaP p  D##### #    p #" , -- 20
  "#   #  #  9       9#mmmmmmmmmHmmmmmmaaP p   W     #    3 #" , -- 21
  "#   #  #9    9 b   #maaaaaaaaaaAaaaaaaP pp6D#######pp8pp #" , -- 22
  "#   #  #           #CaaaaammmmmmdddddaP0                0#" , -- 23
  "#   #  #           #ammmmamaaaamaaaada####################" , -- 24
  "#   #  #           #amaa0amaaa0maaaada# M M M M M M M M M#" , -- 25
  "#   #  # b         #aMaammmmmmmmammmda#M M M M M M M M M #" , -- 26
  "#   #  #           #amaamamaamaSmma0da# M M M MEMEMEM M M#" , -- 27
  "#   #  #  m   mmm m#ammHmammmmaaamaada#M M M M M M M M M #" , -- 28
  "#   #  #  mm m  mkm#amaammmaaHammHmmmm# M M M M M M M M M#" , -- 29
  "#   #  #mm mm mm mm#amaamaaaamamaaamam<                  #" , -- 30
  "#   #  #m m mm  mm #amaamaaaamamaaamaa# M M M M M M M M M#" , -- 31
  "#   #  # m m mmm mm#amaamaaaamamaaamaa#M M M M M M M M M #" , -- 32
  "#   #  #  mm m mm m#aMaamaaa0mamaaaaaa# M M M M M M M M M#" , -- 33
  "# f #  #    m    m #ammmmmmmmmmmammhmm#M M M M M M M M M #" , -- 34
  "#mxm#         m  m #aaaaaaaaaaaaaaaaaa# M M M M M M0M M0M#" , -- 35
  "##########################################################" , -- 36
-- 0123456789012345678901234567890123456789012345678901234567 

}   
    
    
set_default_parent(cells[" "])
    
create_world_by_map(level,cells)

oxyd(49,25)
oxyd(45,35)

oxyd(46,26)
oxyd(43,35)

function door23()
SendMessage("door2", "openclose")  
SendMessage("door3", "openclose")
end

function door45()
SendMessage("door4", "openclose")  
SendMessage("door5", "openclose")
end

fill_floor("fl-leaves",38,24,20,13)
fill_floor("fl-metal",38,12,20,13)


------------------ Starting Points ------------------------------------

-- starting point
set_actor("ac-blackball", 2.5,35.5) set_floor("fl-metal",2,35)

-- room4
--set_actor("ac-blackball", 23.5,11.5, {player=0}) set_item("it-key_b",23,11) draw_items("it-coin2",{26,4},{0,1},7)

-- last but two puzzle (wormhole room)
--set_actor("ac-blackball", 39.5,11.5, {player=0})

-- last but one puzzle (Keyhole room)                               
--set_actor("ac-blackball", 47.5,17.5, {player=0})

-- last puzzle (meadow pushing)                               
--set_actor("ac-blackball", 48,30.5, {player=0})
