-- A level for Enigma
-- Copyright: 	(C) 2003 Sven Siggelkow
-- License: 	GPL v2.0 or above
-- Oxyd.magnum # 100

-- FIXME: if openclose message for it-vortex is ok functions ss01-ss08 can be replaced action="openclose" in trigger attributes
             
enigma.SetCompatibility("oxyd.magnum")                                                               
dofile(enigma.FindDataFile("levels/ant.lua"))
cells={}
cells[" "]=cell{floor="fl-rock"}
cells["#"]=cell{stone="st-metal"}
cells["-"]=cell{floor="fl-rock",stone="st-oneway_white-e"}
cells["."]=cell{floor="fl-rock",item="it-seed"}
cells["/"]=cell{{{mirrorp, FALSE, FALSE, 4}}}
cells["<"]=cell{floor="fl-rock",stone="st-oneway_black-w"}
cells[">"]=cell{floor="fl-rock",stone="st-oneway_black-e"}
cells["'"]=cell{parent=cells[" "],item="it-dynamite"}
cells["A"]=cell{floor="fl-rock",stone="st-block"}
cells["B"]=cell{stone="st-bombs"}
cells["C"]=cell{floor="fl-rock",item="it-crack3"}
cells["D"]=cell{floor="fl-rock",stone="st-death_invisible"}
cells["E"]=cell{stone="st-thief"}
cells["G"]=cell{floor="fl-rock",stone="st-grate1"}
cells["I"] = cell{parent=cells[" "],stone={"st-stoneimpulse",{name="impulse1"}}}
cells["J"] = cell{parent=cells[" "],stone={"st-stoneimpulse",{name="impulse3"}}}
cells["H"] = cell{parent=cells[" "],stone={"st-stoneimpulse",{name="impulse2"}}}
cells["K"] = cell{parent=cells[" "],stone={"st-stoneimpulse",{name="impulse4"}}}
cells["L"] = cell{parent=cells[" "],stone={"st-laser", {on=FALSE, dir=WEST, name="laser1"}}}
cells["M"]=cell{{{mirror3, FALSE, FALSE, 4}}}
cells["O"]=cell{stone="st-oxyd"}
cells["P"]=cell{item={"it-trigger", {action="callback", target="ss11"}}}
cells["S"]=cell{floor="fl-space"}
cells["T"]=cell{stone={face="st-timer", attr={action="callback", target="doors", interval=2.0}}}
cells["W"]=cell{item={"it-vortex-open", {targetx=21.5, targety=52.5}}}
cells["X"]=cell{floor="fl-rock"}
cells["Y"]=cell{floor="fl-rock",stone="st-yinyang1"}
cells["^"]=cell{floor="fl-rock",stone="st-oneway_black-n"}
cells["a"]=cell{floor="fl-abyss"}
cells["b"]=cell{floor="fl-rock",item="it-blackbomb"}
cells["c"]=cell{floor="fl-rock",stone="st-brick"}
cells["d"]=cell{floor="fl-abyss",item="it-blackbomb"}
cells["f"]=cell{floor="fl-rock",item="it-flagblack"}
cells["g"]=cell{floor="fl-rock",stone="st-grate3"}
cells["h"]=cell{parent=cells[" "],stone={"st-door", {name="door7", type="v"}}}
cells["i"]=cell{item={"it-trigger", {action="callback", target="s1", invisible=1}}}
cells["j"]=cell{item={"it-trigger", {action="callback", target="s1", invisible=1}}}
cells["k"]=cell{floor="fl-rock", stone="st-knight"}
cells["l"] = cell{parent=cells[" "],stone={"st-laser", {on=FALSE, dir=EAST, name="laser2"}}}
cells["m"]=cell{floor="fl-metal"}
cells["n"]=cell{floor="fl-rock",stone="st-stoneimpulse"}
cells["o"]=cell{floor="fl-rock",stone="st-stoneimpulse-hollow"}
cells["p"]=cell{item={"it-trigger", {action="callback", target="ss10"}}}
cells["q"]=cell{item={"it-trigger", {action="onoff", target="laser2"}}}
cells["r"]=cell{parent=cells[" "],item="it-extralife",stone={"st-door", {name="door4", type="v"}}}
cells["s"]=cell{parent=cells[" "],item="it-hammer",stone={"st-door", {name="door6", type="v"}}}
cells["t"]=cell{item={"it-trigger", {action="onoff", target="laser1"}}}
cells["u"]=cell{parent=cells[" "],stone={"st-door", {name="door5", type="v"}}}
cells["v"]=cell{floor="fl-rock",stone="st-oneway_black-s"}
cells["w"]=cell{floor="fl-rock",stone="st-wood"}
cells["x"]=cell{parent=cells[" "],stone={"st-door", {name="door3", type="v"}}}
cells["y"]=cell{parent=cells[" "],item="it-extralife",stone={"st-door", {name="door2", type="v"}}}
cells["z"]=cell{parent=cells[" "],stone={"st-door", {name="door1", type="v"}}}
cells["|"]=cell{floor="fl-rock",stone="st-oneway_white-n"}
cells["+"] = cell{parent=cells[" "],stone="st-turnstile"}
cells["~"] = cell{parent=cells[" "],stone="st-turnstile-w"}
cells["*"] = cell{parent=cells[" "],stone="st-turnstile-e"}       
cells["?"] = cell{parent=cells[" "],stone="st-turnstile-s"}
cells["�"] = cell{parent=cells[" "],stone="st-turnstile-n"}   
level = { 
-- 0123456789012345678901234567890123456789012345678901234567 
  "##########################################################" , -- 00
  "#    G             # #                #  #SSSSSSSSSSSSSSS#" , -- 01
  "#  Gwccccg         # #     # # # # #  #  #SOSSSSSSSSSSSOS#" , -- 02
  "# Gwwccccg         # #                #  #SSSSSSSSSSSSSSS#" , -- 03
  "# wwtccccgggg      # #     ############  #SSSSSSmmmmSSSSS#" , -- 04
  "#GGccccccccMg    L # #     ############  #SSSSSSmmmmSSSSS#" , -- 05
  "#  ccccccccgg      # # T   z y x r u s#  #SSSSSSmmmmSSSSS#" , -- 06
  "#  ccccccccgg      # #     ############  #SSSSSSSSSSSSSSS#" , -- 07
  "#  ccccccccgg      # #     ############  #SSSSSSSSSSSSSSS#" , -- 08
  "#                  # #                #  #SSSSSSSSSSSSSSS#" , -- 09
  "#                  # #     # # # # #  #  #SOSSS#EkkE#SSOS#" , -- 10
  "#                  #                  #  #SSSSSK    HSSSS#" , -- 11
  "###########^###### ####################YY#######+*~+######" , -- 12
  "#         YYY    # #aaaaaaaaaaaaaaaaaa#  #     J?Pp?I    #" , -- 13
  "#                # #aaaaaaaaaaaaaaaaaa#  #     GGGGG     #" , -- 14
  "#                # >a    .  X  f     a#  #     ##A##     #" , -- 15
  "#                ###aCaaa aaaaaaa aa a#  #     #   #     #" , -- 16
  "#      w           #a aaa   w  '  aa a#  ######## ########" , -- 17
  "#                  #a aaa aaCaaaaCaa a#  ######## ########" , -- 18
  "#                  -a    wbbwbbbbbaa a#  qooooooooooooooo#" , -- 19
  "#                  #a aaa aa aaaadaa a#  ###############n#" , -- 20
  "#                  #a    b BwbbbbbB  a#  ############### #" , -- 21
  "#                  #aaaaaaaa baaaaaaaa#  #               #" , -- 22
  "#                  #aaaaaaaa baaaaaaaa#  #l             /#" , -- 23
  "###^############|###########BB#########  #################" , -- 24
  "#     ^>^^>v>v^^   #                  #  #  D    D   D   #" , -- 25
  "#     ^<>^>^v><v   #                  #  #             D #" , -- 26
  "#     <><>v^><>v   #                  #  # D  D    D     #" , -- 27
  "#     >v^^vv<^^v   #                  #  #      D      D #" , -- 28
  "#     v>^>v<vv>v #####                #  #   D   D  D    #" , -- 29
  "#     v>^>v<vv<v  ihj                ~+  # D             #" , -- 30
  "#     v>^>v<vv>v #####                ?  #    D D  D D D #" , -- 31
  "#     v^>>v<^v^^   #                  #  #   D           #" , -- 32
  "#     <v>>^^v>^v   #                  #  # #    D D      #" , -- 33
  "#     <>^v^<<v>v   #                  #  # #  D      D   #" , -- 34
  "#     >>>><<v<^^   #                  #  #.#     D      D#" , -- 35
  "############################  ############################" , -- 36
  "# #     #          #          #       #           # # #  #" , -- 37
  "# #     #          #          #       #           # # #  #" , -- 38
  "#       #          #          #       #           # # #  #" , -- 39
  "#       #          #          #       #      ####   # �  #" , -- 40
  "#       #          #          #       # ###  #  #~+*# + ##" , -- 41
  "#       #          #          #### ## #   #  #  #     ?  #" , -- 42
  "#       #          #             #    # ###  #  ######## #" , -- 43
  "#       #                        ###  #      #    #   #  #" , -- 44
  "#       #          #             #    #      #  # # # # ##" , -- 45
  "#    ####          #             #  ###      #  # # # #  #" , -- 46
  "#    #  #          #            �#    #      #  #   #    #" , -- 47
  "######### #####################~+#########################" , -- 48
  "#                  #                  #                  #" , -- 49
  "#                  #   #   ####   #   #      aaaaaaa     #" , -- 50
  "#                  #   #   ####   #   #      aaaaaaa     #" , -- 51
  "#                  #   #   ####   #   #      aaaaaaa     #" , -- 52
  "#                  ####################      aa   aa w w #" , -- 53
  "#aaaaaaaaaaaaaaaaaa####################      aa   aa wwww#" , -- 54
  "#                  ####################      aa   aa w w #" , -- 55
  "#                  #   #   ####   #   #      aaaaaaa     #" , -- 56
  "#                  #   #   ####   #   #      aaaaaaa     #" , -- 57
  "#                  #   #   ####   #   #      aaaaaaa     #" , -- 58
  "#                  #                  #                  #" , -- 59
  "######### ###############+*###############################" , -- 60
  "#                  ######? ############        ##      # #" , -- 61
  "#                  ####     ###########        ##      # #" , -- 62
  "#                  ####        ########        ##        #" , -- 63
  "#                  #   +*+*� +*########        ##        #" , -- 64
  "#                      ? ? +*? ####  ##        ##        #" , -- 65
  "#                  #    +*+* � ##nn ###        ##        #" , -- 66
  "#                  #    ? ? ~+ # w# ###        ##        #" , -- 67
  "#                  ##############   ### #      ##        #" , -- 68
  "#                  ############## ##### #      ##        #" , -- 69
  "#                  #################### #      ##        #" , -- 70
  "#                  #################### #      ##        #" , -- 71
  "##########################################################" , -- 72
-- 0123456789012345678901234567890123456789012345678901234567 

}   
    
    
set_default_parent(cells[" "])
    
create_world_by_map(level,cells)

fill_floor("fl-swamp",39,37,18,11)
set_floor("fl-wood",40,42)
set_floor("fl-wood",41,42)

set_actor("ac-top", 10.5,17.5, {range=10, force=10})

set_item("it-blackbomb", 28,21)
set_item("it-key_a", 55,54)
set_item("it-puller-s", 20,64)
set_item("it-puller-w", 54,30)
set_item("it-puller-s", 36,47)
set_item("it-puller-s", 28,65)
set_item("it-ring", 37,47)
set_item("it-glasses", 30,66)
set_item("it-pipe-h", 44,64)
set_item("it-pipe-h", 44,66)
set_item("it-pipe-h", 44,67)
set_item("it-spring2", 30,67)
set_item("it-spring1", 18,47)
set_item("it-floppy", 52,66)
set_item("it-coin1", 7,47)
set_item("it-extralife", 6,47)
set_item("it-extralife",50,62)
set_item ("it-trigger",21,51, {action="callback", target="ss01"})
set_item ("it-trigger",25,51, {action="callback", target="ss02"})
set_item ("it-trigger",32,51, {action="callback", target="ss03"})
set_item ("it-trigger",36,51, {action="callback", target="ss04"})
set_item ("it-trigger",21,57, {action="callback", target="ss05"})
set_item ("it-trigger",25,57, {action="callback", target="ss06"})
set_item ("it-trigger",32,57, {action="callback", target="ss07"})
set_item ("it-trigger",36,57, {action="callback", target="ss08"})
set_item ("it-trigger",20,2,  {action="open", target="vortex09", invisible=1})
set_item ("it-trigger",42,34, {action="open", target="vortex10", invisible=1})
set_item ("it-trigger",40,42, {action="open", target="vortex12", invisible=1})
set_item ("it-trigger",35,65, {action="open", target="vortex13", invisible=1})
set_item ("it-trigger", 1,38, {action="open", target="vortex14", invisible=1})
set_item ("it-trigger",39,70, {action="open", target="vortex15", invisible=1})
set_item ("it-trigger",56,62, {action="open", target="vortex16", invisible=1})

set_item("it-vortex-closed",21,56, {name="vortex01", targetx = 56.5, targety =  61.5})
set_item("it-vortex-closed",25,56, {name="vortex02", targetx = 39.5, targety =  71.5})
set_item("it-vortex-closed",32,56, {name="vortex03", targetx = 36.5, targety =  65.5})
set_item("it-vortex-closed",36,56, {name="vortex04", targetx = 41.5, targety =  54.5})
set_item("it-vortex-closed",21,52, {name="vortex05", targetx = 20.5, targety =  1.5})
set_item("it-vortex-closed",25,52, {name="vortex06", targetx =  1.5, targety =  37.5})
set_item("it-vortex-closed",32,52, {name="vortex07", targetx = 42.5, targety =  35.5})
set_item("it-vortex-closed",36,52, {name="vortex08", targetx = 41.5, targety =  42.5})
set_item("it-vortex-closed",20,1,  {name="vortex09", targetx = 21.5, targety =  52.5})
set_item("it-vortex-closed",42,35, {name="vortex10", targetx = 32.5, targety =  52.5})
set_item("it-vortex-closed",41,54, {name="vortex11", targetx = 36.5, targety =  56.5})
set_item("it-vortex-closed",41,42, {name="vortex12", targetx = 36.5, targety =  52.5})
set_item("it-vortex-closed",36,65, {name="vortex13", targetx = 32.5, targety =  56.5})
set_item("it-vortex-closed", 1,37, {name="vortex14", targetx = 25.5, targety =  52.5})
set_item("it-vortex-closed",39,71, {name="vortex15", targetx = 25.5, targety =  56.5})
set_item("it-vortex-closed",56,61, {name="vortex16", targetx = 21.5, targety =  56.5})

set_stone("st-door-v",33,45, {name="door8"})
set_stone("st-coinslot",33,44, {action="openclose", target="door8"})

set_stone("st-door-v",19,44, {name="door9"})
set_stone("st-key_a", 20,47, {action="openclose", target="door9"})
set_stone("st-door-v",5,47, {name="door10"})                      
set_stone("st-floppy", 6,46, {action="openclose", target="door10"})
set_stone ("st-mail-e",17,40)
set_stone("st-switch", 39,54, {action="callback",target="s2"})

if (not difficult) then 
        set_stone("st-grate1",34,69)
        set_stone("st-grate1",35,69)
end

oxyd(3,28)
oxyd(32,67)

oxyd(48,54)
oxyd(46,41)

function doors()
    SendMessage("door1", "openclose")
    SendMessage("door2", "openclose")  
    SendMessage("door3", "openclose")
    SendMessage("door4", "openclose")
    SendMessage("door5", "openclose")
    SendMessage("door6", "openclose")
end

local flags={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

function s1()
    local x1,y1 = enigma.GetPos(enigma.GetNamedObject("black"))
    local x2,y2 = enigma.GetPos(enigma.GetNamedObject("white"))
    if ((x1==18) or (x1==19) or (x1==20) or (x2==18) or (x2==19) or (x2==20)) then
        SendMessage("door7", "open")
    else 
        SendMessage("door7", "close")
    end
end

function s2()
   %flags[12] = 1-%flags[12]
   if (%flags[12] == 1) then 
      SendMessage("vortex11", "open")
   else 
      SendMessage("vortex11", "close")
   end
end

function ss01()
   %flags[1] = 1-%flags[1]
   if (%flags[1] == 1) then 
      SendMessage("vortex01", "open")
   else 
      SendMessage("vortex01", "close")
   end
end

function ss02()
   %flags[2] = 1-%flags[2]
   if (%flags[2] == 1) then 
      SendMessage("vortex02", "open")
   else 
      SendMessage("vortex02", "close")
   end
end

function ss03()
   %flags[3] = 1-%flags[3]
   if (%flags[3] == 1) then 
      SendMessage("vortex03", "open")
   else 
      SendMessage("vortex03", "close")
   end
end

function ss04()
   %flags[4] = 1-%flags[4]
   if (%flags[4] == 1) then 
      SendMessage("vortex04", "open")
   else 
      SendMessage("vortex04", "close")
   end
end

function ss05()
   %flags[5] = 1-%flags[5]
   if (%flags[5] == 1) then 
      SendMessage("vortex05", "open")
   else 
      SendMessage("vortex05", "close")
   end
end

function ss06()
   %flags[6] = 1-%flags[6]
   if (%flags[6] == 1) then 
      SendMessage("vortex06", "open")
   else 
      SendMessage("vortex06", "close")
   end
end

function ss07()
   %flags[7] = 1-%flags[7]
   if (%flags[7] == 1) then 
      SendMessage("vortex07", "open")
   else 
      SendMessage("vortex07", "close")
   end
end

function ss08()
   %flags[8] = 1-%flags[8]
   if (%flags[8] == 1) then 
      SendMessage("vortex08", "open")
   else 
      SendMessage("vortex08", "close")
   end
end

function ss09()
   %flags[9] = 1-%flags[9]
   if (%flags[9] == 1) then 
      SendMessage("vortex09", "open")
   else 
      SendMessage("vortex09", "close")
   end
end

function ss10()
   %flags[10] = 1-%flags[10]
   if (%flags[10] == 1) then 
      SendMessage("impulse1", "trigger")
   else 
      local x1,y1 = enigma.GetPos(enigma.GetNamedObject("black"))
      local x2,y2 = enigma.GetPos(enigma.GetNamedObject("white"))
      if not (((x1==50) and (y1==11)) or ((x2==50) and (y2==11))) then 
          SendMessage("impulse2", "trigger") 
      end
   end
end

function ss11()
   %flags[11] = 1-%flags[11]
   if (%flags[11] == 1) then 
      SendMessage("impulse3", "trigger")
   else 
      local x1,y1 = enigma.GetPos(enigma.GetNamedObject("black"))
      local x2,y2 = enigma.GetPos(enigma.GetNamedObject("white"))
      if not (((x1==49) and (y1==11)) or ((x2==49) and (y2==11))) then
          SendMessage("impulse4", "trigger") 
      end
   end
end

set_actor("ac-blackball", 29.5,15.5, {name="black"}) set_item("it-yinyang", 29,15)
set_actor("ac-whiteball", 9.5,65.5, {name="white"}) set_item("it-yinyang", 9,65)
