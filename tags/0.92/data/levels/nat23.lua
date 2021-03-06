-- How Many Spirals?
-- A level for Enigma
--
-- Copyright (c) 2005 Nat Pryce
-- Licensed under the GPL version 2.

Require("levels/natmaze.lua")
randomseed( enigma.GetTicks() )


send_message = SendMessage

function send_message_to_group( group, message, arg )
    for i = 1, getn(group) do
        send_message( group[i], message, arg )
    end
end

function group_message( group, message )
    return function(arg)
        send_message_to_group( %group, %message, arg )
    end
end

set_oxyd = oxyd

function oxyd( x, y, tiles )
    return set_oxyd( x, y )
end

function nothing(x, y, tiles)
    -- create nothing
end

function horizontal_bolder(x,y,tiles)
    if random() >= 0.5 then
        return set_stone( "st-bolder-w", x, y )
    else
    	return set_stone( "st-bolder-e", x, y )
    end
end

function vertical_bolder(x,y,tiles)
    if random() >= 0.5 then
        return set_stone( "st-bolder-n", x, y )
    else
    	return set_stone( "st-bolder-s", x, y )
    end
end

function checkerboard_floor( type1, type2, attribs1, attribs2 )
    return function( x, y, tiles )
        if mod(x,2) == mod(y,2) then
            return set_floor( %type1, x, y, %attribs1 or {} )
        else
            return set_floor( %type2, x, y, %attribs2 or {} )
        end
    end
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

function gradient( gradient_type )
    return function( x, y, tiles )
        return set_floor( "fl-gradient", x, y, {type=%gradient_type} )
    end
end

function inherit(tile_type)
    return function( x, y, tiles )
        return create_tile( tiles, x, y, %tile_type )
    end
end

function group( array, constructor )
    return function( x, y, tiles )
        object = %constructor( x, y, tiles )
    	tinsert( %array, object )
    	return object
    end
end

function difficulty( d, constructor )
    if options.Difficulty == d then
    	return constructor
    else
    	return nothing
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
	error("invalid tile identifier " .. tile )
    end
end

oxyd_default_flavor = "a"

dark_floor = floor("fl-leavesb")
light_floor = floor("fl-leaves")

doors_a = {}
doors_b = {}
doors_c = {}
doors_f = {}
lasers = {}

openclose_doors_a = group_message(doors_a, "openclose")
openclose_doors_b = group_message(doors_b, "openclose")
openclose_doors_c = group_message(doors_c, "openclose")
open_doors_f = group_message(doors_f, "open")
toggle_lasers = group_message(lasers, "onoff")


tiles = {}
tiles[" "] = {light_floor }
tiles["/"] = {floor("fl-leavesc1")}
tiles["("] = {floor("fl-leavesc2")}
tiles["`"] = {floor("fl-leavesc3")}
tiles[","] = {floor("fl-leavesc4")}
tiles["."] = {dark_floor}
tiles[";"] = {floor("fl-normal")}
tiles["+"] = {dark_floor, stone("st-grate1")}
tiles["#"] = {dark_floor, stone("st-rock2")}
tiles["-"] = {dark_floor, stone("st-rock2_hole")}
tiles["%"] = {light_floor, stone("st-rock3_hole")}
tiles["="] = {light_floor, stone("st-rock3")}
tiles["x"] = {light_floor, stone("st-rock3_break")}
tiles["*"] = {light_floor, oxyd}
tiles["e"] = {dark_floor, stone("st-laser", {on=TRUE,dir=EAST})}
tiles["w"] = {dark_floor, stone("st-laser", {on=TRUE,dir=WEST})}
tiles["n"] = {dark_floor, stone("st-laser", {on=TRUE,dir=NORTH})}
tiles["s"] = {dark_floor, stone("st-laser", {on=TRUE,dir=SOUTH})}
tiles["H"] = {light_floor, difficulty(HARD,horizontal_bolder)}
tiles["V"] = {light_floor, difficulty(HARD,vertical_bolder)}
tiles["h"] = {light_floor, horizontal_bolder}
tiles["v"] = {light_floor, vertical_bolder}
tiles["~"] = {floor("fl-water")}
tiles["}"] = {floor("fl-water"), stone("st-grate1")}
tiles["o"] = {light_floor, stone("st-wood")}
tiles["@"] = {light_floor, item("it-wormhole", {targetx=28.5,targety=18.5,range=1})}
tiles["u"] = {gradient(FLAT_FORCE_N)}
tiles["d"] = {gradient(FLAT_FORCE_S)}
tiles["l"] = {gradient(FLAT_FORCE_W)}
tiles["r"] = {gradient(FLAT_FORCE_E)}
tiles["U"] = {gradient(FLAT_FORCE_N), actor("ac-killerball", {controllers=0})}
tiles["D"] = {gradient(FLAT_FORCE_S), actor("ac-killerball", {controllers=0})}
tiles["L"] = {gradient(FLAT_FORCE_W), actor("ac-killerball", {controllers=0})}
tiles["R"] = {gradient(FLAT_FORCE_E), actor("ac-killerball", {controllers=0})}
tiles["J"] = {floor("fl-wood")}

tiles["A"] = {dark_floor, stone("st-coinslot",{action="callback",target="openclose_doors_a"})}
tiles["a"] = {dark_floor, group(doors_a, stone("st-door_b"))}
tiles["B"] = {light_floor, stone("st-switch",{action="callback",target="openclose_doors_b"})}
tiles["b"] = {light_floor, group(doors_b, stone("st-door_b"))}
tiles["C"] = {light_floor, stone("st-switch", {action="onoff", target="laser"})}
tiles["c"] = {dark_floor, stone("st-laser", {name="laser", on=FALSE,dir=EAST})}
tiles["F"] = {light_floor, item("it-trigger", {action="callback", target="open_doors_f"})}
tiles["f"] = {light_floor, group(doors_f, stone("st-door_b"))}

tiles["1"] = {inherit("%"), item("it-wormhole", {targetx=45.5, targety=31.5,range=1})}
tiles["2"] = {inherit("%"), item("it-coin1")}
tiles["3"] = {inherit("%"), item("it-wormhole", {targetx=29.5,targety=18.5,range=1})}
tiles["4"] = {inherit("x"), item("it-spring2")}
tiles["5"] = {floor("fl-gray"), item("it-seed")}
tiles["6"] = {inherit("x"), item("it-coin1")}
tiles["7"] = {inherit("%"), item("it-extinguisher")}


tiles["maze_wall"] = { stone("st-grate1") }


create_world_from_map( tiles, {
"##########################################################",
"#;;;;;;;;;;;;;;;;;;#..................-.....=~~~~~~~.....#",
"#;==============%=;#./              `.#.....a..~...~./ `.#",
"#;=%%%%%%%%%%%%=%=;#. xxxxxxxxxxxxxx .#.....=~.~.~.~. B .#",
"#;=%==========%=%=;#. x*xxx4xx6xxx*x .#.....=~.~.~.~.( ,.#",
"#;=%=%%%%%%%7=%=%=;#. xxxxxxxxxxxxxx .#.....=~.~.~.~.....#",
"#;=%=%========%=%=;#.(              ,.#.....=~.~.~.~.....#",
"#;=%=%=1%%%%%%%=%=;#..................#.....=~.~.~.~.....#",
"#;=%=%==========%=;#..................#.....=~.~.~.~.....#",
"#;=%=%%%%%%%%%%%%=;#..................#.....A~.~.~.~.....#",
"#;=%==============;#..................#.....=~...~.......#",
"#;;;;;;;;;;;;;;;;;;#..................#.....=~~~~~~~.....#",
"####-###############++++++++++++++++++####################",
"#*#~ +++++++++++++++e................s+..................#",
"# #~ +o           o+./      H       `.+..................#",
"# #~ +             +.       h        .+...../   `........#",
"# #~ +             +.       H        .+..... =f= ........#",
"# #~ +             +.       H        .+..... =*= ........#",
"#~~~~~             +.V v V V  V V v V.+..... C=c         #",
"# #~ +             +.        H       .+..... =*= ........#",
"# #~ +             +.        H       .+..... =f= ........#",
"# #~ +             +.        h       .+.....(   ,........#",
"# #~ +o           o+.(       H      ,.+..................#",
"#*#~ +++++++++++++++n................w+..................#",
"####################++++++++++++++++++####################",
"#~                 -..................#;;;;;;;;;;;;;;;;;;#",
"#~       }}}}}}}}}~#..................#;==============%=;#",
"#~       }DddlllL}~#..................#;=%%%%%%%%%%%%=%=;#",
"#}RrrrddD}dddllll}~#e................w#;=%==========%=%=;#",
"#}rrrrddd}dddllll}~#..................#;=%=%%%%%%%3=%=%=;#",
"#}rrrrddd}ddd5uuu}~#./              `.#;=%=%========%=%=;#",
"#}uuuFddd}rrrruuu}~#. ============== .#;=%=%=2%%%%%%%=%=;#",
"#}uuullll}rrrruuu}~#. b*==========*b .#;=%=%==========%=;#",
"#}uuullll}RrrruuU}~#. ============== .#;=%=%%%%%%%%%%%%=;#",
"#}UuulllL}       ~~#.(              ,.#;=%==============;#",
"#}}}}}}}}}       ~~-..................#;;;;;;;;;;;;;;;;;;#",
"##########################################################"
})

render_maze( new_kruskal_maze(7,5), 
    function(maze,cellx,celly)
	local x = 6 + cellx*2 
	local y = 14 + celly*2

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


startx = level_width/2
starty = level_height/2
set_actor( "ac-blackball", startx, starty, {player=0} )

oxyd_shuffle()
