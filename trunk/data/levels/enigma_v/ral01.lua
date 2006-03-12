--xml-- <?xml version="1.0" encoding="UTF-8" standalone="no" ?>
--xml-- <el:level xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://enigma/level level.xsd" xmlns:el="http://enigma/level">
--xml--   <el:protected >
--xml--     <el:info el:type="level">
--xml--       <el:identity el:titel="Firefox" el:subtitel="Fire or be fired" el:id="20060213ral03"/>
--xml--       <el:version el:score="1" el:release="1" el:revision="1" el:status="stable"/>
--xml--       <el:author  el:name="Ronald Lamprecht" el:email="ral@users.berlios.de"/>
--xml--       <el:copyright>Copyright © 2006 Ronald Lamprecht</el:copyright>
--xml--       <el:license el:type="GPL v2.0 or above" el:open="true"/>
--xml--       <el:compatibility el:enigma="0.92">
--xml--         <el:dependency el:library="natmaze" el:release="1" el:preload="false"/>
--xml--       </el:compatibility>
--xml--       <el:modes el:easy="true" el:single="true" el:network="false"/>
--xml--       <el:comments>
--xml--         <el:credit el:showinfo="true" el:showstart="false">Thanks to Nat Pryce for his libs and code examples</el:credit>
--xml--         <el:dedication el:showinfo="true" el:showstart="false">To Daniel Heck for his great work on the engine</el:dedication>
--xml--         <el:code>Lua 4.x based - replace %ident upvalues by ident for Lua 5.x in compatible mode</el:code>
--xml--       </el:comments>
--xml--       <el:score el:easy="474" el:difficult="585"/>
--xml--     </el:info>
--xml--     <el:luamain><![CDATA[
Require("levels/lib/natmaze.lua")

enigma.ConserveLevel = FALSE

set_oxyd = oxyd
math_floor = floor

function oxyd( x, y, tiles )
    return set_oxyd( x, y )
end

function nothing(x, y, tiles)
    -- create nothing
end

function floor( floor_type, attribs )
    return function( x, y, tiles )
        return set_floor( %floor_type, x, y, %attribs or {} )
    end
end

function stone( stone_type, attribs )
    return function( x, y, tiles )
        return set_stone( %stone_type, x, y, %attribs or {} )
    end
end

function item( item_type, attribs )
    return function( x, y, tiles )
        return set_item( %item_type, x, y, %attribs or {} )
    end
end

function actor( actor_type, attribs )
    return function( x, y, tiles )
        return set_actor( %actor_type, x+0.5, y+0.5, %attribs or {} )
    end
end

function inherit(tile_type)
    return function( x, y, tiles )
        return create_tile( tiles, x, y, %tile_type )
    end
end

function create_world_from_map( tiles, map )
    create_world( strlen(map[1]), getn(map) )
    
    for y = 1,getn(map) do
        local line = map[y]
        for x = 1,strlen(line) do
            local tile = strchar(strbyte(line,x))
            create_tile( tiles, x-1, y-1, tile )
        end
    end
end

function create_tile( tiles, x, y, tile_type )
    local constructors = tiles[tile_type]

    if constructors then
	for i = 1,getn(constructors) do
	    constructors[i](x,y,tiles)
	end
    else
	error("invalid tile identifier " .. tile_type )
    end
end

oxyd_default_flavor = "a"

tiles = {}
tiles["-"] = {floor("fl-rock")}
tiles["."] = {floor("fl-hay")}
tiles[","] = {floor("fl-wood")}
tiles["i"] = {floor("fl-ice_001")}
tiles[" "] = {inherit("."), item("it-burnable")}
tiles[";"] = {inherit(","), item("it-burnable")}
tiles["d"] = {inherit("."), item("it-dynamite")}
tiles["h"] = {inherit("."), item("it-weight")}
tiles["L"] = {inherit("."), item("it-extralife")}
tiles["a"] = {inherit("."), item("it-booze")}
tiles["e"] = {inherit("."), item("it-extinguisher_empty",{name="extinguisher1"})}
tiles["f"] = {inherit("."), item("it-extinguisher")}
tiles["T"] = {inherit("."), item("it-document",{text="Do you think a bushman would start to search an extinguisher in the cellar in case of a wall of fire is approaching? Be a Firefox - you have the first 5 items to deal with, no more no less!"})}
tiles["I0"] = {inherit("i"), item("it-crack0")}
tiles["="] = {inherit("I0"), stone("st-wood")}
tiles["I"] =  tiles["I0"]
tiles["I3"] = {inherit("i"), item("it-crack3")}
tiles["I1"] = {inherit("i"), item("it-crack1")}
tiles["G"] = {inherit("."), stone("st-grate1")}
tiles["#"] = {inherit("."), stone("st-marble")}
tiles["$"] = {inherit(" "), stone("st-marble")}
tiles["N1"] = {inherit("-"), item("it-trigger", {invisible=1})} -- anti cracking
tiles["N"] = {inherit("N1"), stone("st-oneway_black-n")}
tiles["S1"] = {inherit("-"), item("it-trigger", {invisible=1, action="callback", target="helpbrokenmaze"})}
tiles["S"] = {inherit("S1"), stone("st-oneway_black-s")}
tiles["t"] = {inherit("."), stone("st-laser-n",{on=1})}
tiles["n"] = {inherit("."), stone("st-laser-n",{name="laser1",on=0})}
tiles["s"] = {inherit("."), stone("st-laser-s",{on=1})}
tiles["w"] = {inherit("."), stone("st-wood")}
tiles["B"] = {inherit(" "), stone("st-bombs")}
tiles["b"] = {inherit("."), item("it-blackbomb")}
tiles["x"] = {inherit("."), oxyd}
tiles["~"] = {floor("fl-water")}

tiles["1"] = {inherit(" "), actor("ac-blackball", {player=0})}
tiles["2"] = {inherit("."), item("it-trigger", {invisible=1, action="on", target="laser1"})}
tiles["3"] = {inherit("."), stone("st-switch", {action="callback", target="refill"})}
tiles["maze_wall"] = { inherit(","), item("it-burnable") }

if difficult then
    tiles["5"] =  tiles["h"]
    tiles["6"] =  tiles["h"]
    tiles["7"] =  tiles["e"]
    tiles["8"] =  tiles["a"]
    tiles["9"] =  tiles["d"]
    tiles["%"] = {inherit("I3"), stone("st-wood")}
else
    tiles["5"] =  tiles["d"]
    tiles["6"] =  tiles["a"]
    tiles["7"] =  tiles["h"]
    tiles["8"] =  tiles["e"]
    tiles["9"] =  tiles["h"]
    tiles["%"] = {inherit("I1"), stone("st-wood")}
end


water = 3
function refill()
    if water > 0 then
        local obj = enigma.GetItem(18, 26)
        local didFill = 0
        if obj == nil then
            if water == 3 then
                set_item("it-document", 18, 26, {text="You can extinguish fire with water. This is a good place to refill your extinguisher. Be aware, water is rare!"})
            end
        else
            if GetKind(obj) == "it-extinguisher_empty" then
                set_item("it-extinguisher_medium", 18, 26, {})
                water = water -1
                didFill = 1
            else
                if GetKind(obj) == "it-extinguisher_medium" then
                    set_item("it-extinguisher", 18, 26, {})
                    water = water - 2
                    didFill = 1
                end
            end
        end
        if didFill == 1 then
            if water < 3 then
                set_floor("fl-sahara", 18, 28, {})
            end
            if water < 2 then
                set_floor("fl-sahara", 18, 27, {})
            end
            if water < 1 then
                set_floor("fl-sahara", 18, 25, {})
            end
        end
    end
end

create_world_from_map( tiles, {
"###########x###############x###########",
"#         ===      d      ===         #",
"#                                     #",
"#                                     #",
"#                                     #",
"#                                     #",
"#=                                   =#",
"x=                                   =x",
"#=                                   =#",
"#                                     #",
"#                                     #",
"#                                     #",
"#                                     #",
"#                                     #",
"#                                     #",
"#                                     #",
"#=                                   =#",
"x=                                   =x",
"#=                                   =#",
"#                                     #",
"#                                     #",
"#                                     #",
"#                                     #",
"# ===    -              ===           #",
"###S##s##N###############x#############",
"#  -  .  Iwa     3~#     #   #   #    #",
"#     .           -# ### # # # # # #22#",
"#     .           ~#Tfx#   #   #   # 1#",
"#     .           ~#################22#",
"#     .      ;;;G###           .   ;  #",
"#     .      ;x;%  #           .   ;7 #",
"#     .      ;;;% x#           .   ;  #",
"#;;;###IIIIII#######    b      . 56;8 #",
"#           d           .      .   ;  #",
"#                       .      .   ;9 #",
"#                       .      .   ;  #",
"########################n######t#######"
})

function helpbrokenmaze()
    set_item("it-document", 20, 27, {text="OOPS! The maze is broken! Prepare to repair the maze before you destroy it."})
end

max_depth = 0
brake_x = -1
brake_y = -1
brake_dir = WEST
-- Brake a maze in the middle of the longest path from an arbitrary given
-- root node.
-- Recursive preorder depth first search algorithm.
function brake_maze(maze, path, depth, x, y, dir)
    local endpoint = true
    if dir ~= NORTH and  maze:contains_cell(x, y-1) and
            maze:can_go_south(x, y-1)  then
        endpoint = false
        path[depth] = {cellx=x, celly=y-1, dir=SOUTH}
        brake_maze(maze, path, depth+1, x, y-1, SOUTH)
    end
    if dir ~= SOUTH and  maze:contains_cell(x, y+1) and
            maze:can_go_south(x, y)  then
        endpoint = false
        path[depth] = {cellx=x, celly=y, dir=SOUTH}
        brake_maze(maze, path, depth+1, x, y+1, NORTH)
    end
    if dir ~= WEST and  maze:contains_cell(x-1, y) and
            maze:can_go_east(x-1, y)  then
        endpoint = false
        path[depth] = {cellx=x-1, celly=y, dir=EAST}
        brake_maze(maze, path, depth+1, x-1, y, EAST)
    end
    if dir ~= EAST and  maze:contains_cell(x, y) and
            maze:can_go_east(x, y)  then
        endpoint = false
        path[depth] = {cellx=x, celly=y, dir=EAST}
        brake_maze(maze, path, depth+1, x+1, y, WEST)
    end
    
    if endpoint == true then
        if max_depth < depth then     
            max_depth = depth
            local infn =   path[math_floor(depth/2)]
            brake_x = infn.cellx                      
            brake_y = infn.celly
            brake_dir = infn.dir
        end
    end
end

function render_broken_maze()
    local perfect_maze = new_kruskal_maze(19,12)
    render_maze(perfect_maze, 
            function(maze,cellx,celly)
                local x = 1 + cellx*2 
                local y = 1 + celly*2
        
                if not maze:can_go_east(cellx,celly) and maze:contains_cell(cellx+1,celly) then
                    create_tile( tiles, x+1, y, "maze_wall" )
                end
                
                if not maze:can_go_south(cellx,celly) and maze:contains_cell(cellx,celly+1) then
                    create_tile( tiles, x, y+1, "maze_wall" )
                end
                
                if maze:contains_cell(cellx+1,celly+1) then
                    create_tile( tiles, x+1, y+1, "maze_wall" )
                end
            end )
    local path = {}
    brake_maze(perfect_maze, path, 0, 0, 0, WEST)
    if brake_dir == EAST then
        create_tile( tiles, 2+brake_x*2, 1+brake_y*2, "maze_wall" )
        if not difficult then
            set_item("it-pin", 2+brake_x*2, 1+brake_y*2, {})
        end
    elseif brake_dir == SOUTH then
        create_tile( tiles, 1+brake_x*2, 2+brake_y*2, "maze_wall" )
        if not difficult then
            set_item("it-pin", 1+brake_x*2, 2+brake_y*2, {})
        end
    end
end

render_broken_maze()
oxyd_shuffle()
--xml--     ]]></el:luamain>
--xml--     <el:i18n>
--xml--       <el:string el:key="titel">
--xml--         <el:english el:translate="false"/>
--xml--       </el:string>
--xml--       <el:string el:key="subtitel">
--xml--         <el:english el:translate="true" el:comment="Set fire or die"/>
--xml--         <el:translation el:lang="de">Brenne oder verbrenne</el:translation>
--xml--       </el:string>
--xml--       <el:string el:key="Do you think a bushman would start to search an extinguisher in the cellar in case of a wall of fire is approaching? Be a Firefox - you have the first 5 items to deal with, no more no less!">
--xml--         <el:english el:comment="Firefox in sense of clever in handling fire">Do you think a bushman would start to search an extinguisher in the cellar in case of a wall of fire is approaching? Be a Firefox - you have the first 5 items to deal with, no more no less!</el:english>
--xml--         <el:translation el:lang="de">Würde ein Buschmann anfangen einen Feuerlöscher im Keller zu suchen, wenn eine Feuerwalze naht? Sei ein Fuchs im Feuer - es gibt nur die ersten 5 Gegenstände die zur Lösung beitragen können!</el:translation>
--xml--       </el:string>
--xml--       <el:string el:key="You can extinguish fire with water. This is a good place to refill your extinguisher. Be aware, water is rare!">
--xml--         <el:english>You can extinguish fire with water. This is a good place to refill your extinguisher. Be aware, water is rare!</el:english>
--xml--         <el:translation el:lang="de">Man kann Feuer mit Wasser löschen! Hier ist ein guter Ort um Feuerlöscher wieder aufzufüllen. Wer Wasser verschwendet, jämmerlich verendet!</el:translation>
--xml--       </el:string>
--xml--       <el:string el:key="OOPS! The maze is broken! Prepare to repair the maze before you destroy it.">
--xml--         <el:english>OOPS! The maze is broken! Prepare to repair the maze before you destroy it.</el:english>
--xml--         <el:translation el:lang="de">Oh! Das Labyrinth ist unvollständig! Unternimm etwas um das Labyrinth zu reparieren bevor Du es zerstörst.</el:translation>
--xml--       </el:string>
--xml--     </el:i18n>
--xml--   </el:protected>
--xml-- </el:level>
--xml-- 
