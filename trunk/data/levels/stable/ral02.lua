--xml-- <?xml version="1.0" encoding="UTF-8" standalone="no" ?>
--xml-- <el:level xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://enigma/level level.xsd" xmlns:el="http://enigma/level">
--xml--   <el:protected >
--xml--     <el:info el:type="level">
--xml--       <el:identity el:titel="Toreador" el:id="ral02"/>
--xml--       <el:version el:release="0" el:revision="0" el:status="experimental"/>
--xml--       <el:author  el:name="Ronald Lamprecht" el:email="ral@users.berlios.de"/>
--xml--       <el:copyright>Copyright © 2006 Ronald Lamprecht</el:copyright>
--xml--       <el:license el:type="GPL2" el:open="true">GPL v2.0 or above</el:license>
--xml--       <el:compatibility el:enigma="0.93"/>
--xml--       <el:modes el:easy="false" el:single="true" el:network="false"/>
--xml--       <el:comments>
--xml--         <el:credit el:showinfo="true" el:showstart="false">Thanks to Nat Pryce for his libs and code examples</el:credit>
--xml--         <el:code>Lua 4.x based - replace %ident upvalues by ident for Lua 5.x in compatible mode</el:code>
--xml--       </el:comments>
--xml--       <el:score el:easy="-1" el:difficult="116"/>
--xml--     </el:info>
--xml--     <el:luamain><![CDATA[
enigma.ConserveLevel = FALSE

set_oxyd = oxyd
math_floor = floor

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
	error("invalid tile identifier " .. tile_type )
    end
end

oxyd_default_flavor = "a"

tiles = {}
tiles["-"] = {floor("fl-rock")}
tiles[" "] = {floor("fl-hay")}
tiles[","] = {floor("fl-wood")}
tiles["B"] = {inherit(" "), stone("st-black4")}
tiles["W"] = {inherit(" "), stone("st-white4")}
tiles["#"] = {inherit(" "), stone("st-marble")}
tiles["f"] = {inherit(" "), stone("st-fart")}
tiles["x"] = {inherit(" "), oxyd}

tiles["yb"] = {inherit("B"), item("it-yinyang")}
tiles["yw"] = {inherit("W"), item("it-yinyang")}

tiles["1"] = {inherit("yb"), actor("ac-blackball", {player=0})}
tiles["2"] = {inherit("yw"), actor("ac-whiteball", {player=1, controllers=2})}
tiles["8"] = {inherit(" "), actor("ac-top",{force=26, range=20, attacknearest=1, prefercurrent=0.8})}

create_world_from_map( tiles, {
"####################",
"#  WWW        BBB  #",
"#           8      #",
"# x              x #",
"#     x     x      #",
"#B                W#",
"#1       ff       2#",
"#B                W#",
"#     x     x      #",
"# x              x #",
"#       8          #",
"#  WWW        BBB  #",
"####################"
})

oxyd_shuffle()

--xml--     ]]></el:luamain>
--xml--     <el:i18n>
--xml--       <el:string el:key="titel">
--xml--         <el:english el:translate="true"/>
--xml--         <el:translation el:lang="de">Torero</el:translation>
--xml--       </el:string>
--xml--     </el:i18n>
--xml--   </el:protected>
--xml-- </el:level>
--xml-- 



