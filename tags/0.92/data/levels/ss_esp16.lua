-- A level for Enigma
-- Copyright: 	(C) 2003 Sven Siggelkow
-- License: 	GPL v2.0 or above
-- ESPRIT #016

levelw = 20
levelh = 13
create_world(levelw, levelh)
oxyd_default_flavor = "b"       -- Default flavor for oxyd stones.

set_actor("ac-blackball", 2.5,1.5)
fill_floor("fl-water",0,0,levelw,levelh)
fill_floor("fl-sand",1,0,levelw-3,levelh)

function renderLine( line, pattern)
    for i=1, strlen(pattern) do
        local c = strsub( pattern, i, i)
        if c ==   "#" then
            set_stone("st-door_b", i-1,line)
        elseif c=="1" then
            set_item("it-sensor", i-1,line, {action="open", target="door_1"})
        elseif c=="2" then
            set_item("it-sensor", i-1,line, {action="open", target="door_2"})         
        elseif c=="3" then
            set_item("it-sensor", i-1,line, {action="open", target="door_3"})
        elseif c=="4" then
            set_item("it-sensor", i-1,line, {action="open", target="door_4"})    
        elseif c=="5" then
            set_item("it-sensor", i-1,line, {action="open", target="door_5"})
        elseif c=="6" then
            set_item("it-sensor", i-1,line, {action="open", target="door_6"})         
        elseif c=="7" then
            set_item("it-sensor", i-1,line, {action="open", target="door_7"})
        elseif c=="8" then
            set_item("it-sensor", i-1,line, {action="open", target="door_8"})    
        elseif c=="9" then
            set_item("it-sensor", i-1,line, {action="open", target="door_9"})
        elseif c=="a" then
            set_item("it-sensor", i-1,line, {action="open", target="door_10"})         
        elseif c=="b" then
            set_item("it-sensor", i-1,line, {action="open", target="door_11"})
        elseif c=="c" then
            set_item("it-sensor", i-1,line, {action="open", target="door_12"})    
        elseif c=="d" then
            set_item("it-sensor", i-1,line, {action="open", target="door_13"})
        elseif c=="e" then
            set_item("it-sensor", i-1,line, {action="open", target="door_14"})         
        elseif c=="f" then
            set_item("it-sensor", i-1,line, {action="open", target="door_15"})
        elseif c=="g" then
            set_item("it-sensor", i-1,line, {action="open", target="door_16"})    
        elseif c=="h" then
            set_item("it-sensor", i-1,line, {action="open", target="door_17"})    
        elseif c=="J" then
            set_stone("st-door_b", i-1,line, {name="door_1"})
        elseif c=="K" then
            set_stone("st-door_b", i-1,line, {name="door_2"})         
        elseif c=="L" then
            set_stone("st-door_b", i-1,line, {name="door_3"})
        elseif c=="M" then
            set_stone("st-door_b", i-1,line, {name="door_4"})    
        elseif c=="N" then
            set_stone("st-door_b", i-1,line, {name="door_5"})
        elseif c=="P" then
            set_stone("st-door_b", i-1,line, {name="door_6"})         
        elseif c=="Q" then
            set_stone("st-door_b", i-1,line, {name="door_7"})
        elseif c=="R" then
            set_stone("st-door_b", i-1,line, {name="door_8"})    
        elseif c=="I" then
            set_stone("st-door_b", i-1,line, {name="door_9"})
        elseif c=="A" then
            set_stone("st-door_b", i-1,line, {name="door_10"})         
        elseif c=="B" then
            set_stone("st-door_b", i-1,line, {name="door_11"})
        elseif c=="C" then
            set_stone("st-door_b", i-1,line, {name="door_12"})    
        elseif c=="D" then
            set_stone("st-door_b", i-1,line, {name="door_13"})
        elseif c=="E" then
            set_stone("st-door_b", i-1,line, {name="door_14"})         
        elseif c=="F" then
            set_stone("st-door_b", i-1,line, {name="door_15"})
        elseif c=="G" then
            set_stone("st-door_b", i-1,line, {name="door_16"})    
        elseif c=="H" then
            set_stone("st-door_b", i-1,line, {name="door_17"})          
        elseif c=="O" then
            oxyd(i-1,line)
        end
    end  
end
--               01234567890123456789
renderLine(00 , " #################  ")
renderLine(01 , " #   #   #   #   #  ")
renderLine(02 , " # O9I9OaAaObBbO #  ")
renderLine(03 , " # 1 # 2 # 3 # 4 #  ")
renderLine(04 , " ##J###K###L###M##  ")  
renderLine(05 , " # 1 # 2 # 3 # 4 #  ")
renderLine(06 , " # OcCcOdDdOeEeO #  ")
renderLine(07 , " # 5 # 6 # 7 # 8 #  ")
renderLine(08 , " ##N###P###Q###R##  ")
renderLine(09 , " # 5 # 6 # 7 # 8 #  ")
renderLine(10 , " # OfFfOgGgOhHhO #  ")
renderLine(11 , " #   #   #   #   #  ")
renderLine(12 , " #################  ")
--               01234567890123456789
oxyd_shuffle()
