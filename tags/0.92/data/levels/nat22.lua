-- Hexagony
-- A level for Enigma
--
-- Copyright (c) 2003 Nat Pryce
-- Licensed under the GPL version 2.

Require("levels/natmaze.lua")
enigma.ConserveLevel = FALSE

ROTOR_FORCE = -40
BAND_LENGTH = 2
BAND_STRENGTH = 20
ROTOR_COUNT = 6

FLOORS_BY_DIFFICULTY = {"fl-samba","fl-metal"}
BORDERS_BY_DIFFICULTY = {"st-wood_001","st-fakeoxyd"}

FLOOR = FLOORS_BY_DIFFICULTY[options.Difficulty]
BORDER = BORDERS_BY_DIFFICULTY[options.Difficulty]

function black_marble( x, y )
    return set_actor( "ac-blackball", x, y )
end

function white_marble( x, y )
    return set_actor( "ac-whiteball", x, y )
end

function rotor( x, y )
    return set_actor( "ac-rotor", x, y, {force=ROTOR_FORCE,range=BAND_LENGTH, gohome=FALSE} )
end


function set_star( center_actor_constructor, x, y, radius, rubber_band_strength,
                   outer_actor_constructor, outer_actor_count )
    local center = center_actor_constructor(x,y)
    local delta = 360 / outer_actor_count
    local outer_band_length = 2*radius*sin(360/(2*outer_actor_count))

    local first_outer = nil
    local prev_outer = nil
    local angle = 0
    while angle < 360 do
        local outer = place_actor( outer_actor_constructor, x, y, radius, angle )
        AddRubberBand( center, outer, rubber_band_strength, radius )
        if prev_outer == nil then
            first_outer = outer
        else
            AddRubberBand( prev_outer, outer, 
                           rubber_band_strength, outer_band_length )
        end
        
        prev_outer = outer
        angle = angle + delta
    end
    AddRubberBand( prev_outer, first_outer, 
                   rubber_band_strength, outer_band_length )
end

function place_actor( actor_constructor, x, y, radius, angle )
    x = x + radius*cos(angle)
    y = y + radius*sin(angle)
    
    return actor_constructor( x, y )
end

function cellx_to_worldx( cellx )
    return 2*cellx + 2
end

function celly_to_worldy( celly )
    return 2*celly + 2
end

function render_cell( maze, cellx, celly )
    local x = cellx_to_worldx(cellx)
    local y = celly_to_worldy(celly)
        
    set_floor( FLOOR, x, y )
    if maze:can_go_east(cellx,celly) then
        set_floor( FLOOR, x+1, y )
    end
    if maze:can_go_south(cellx,celly) then
        set_floor( FLOOR, x, y+1 )
    end
end


create_world( 39, 13 )
fill_floor( "fl-water" )
draw_border( BORDER )
render_maze( new_kruskal_maze(18,5), render_cell )

set_star( black_marble, cellx_to_worldx(3)+0.5, celly_to_worldy(2)+0.5,           BAND_LENGTH, BAND_STRENGTH, rotor, ROTOR_COUNT )

oxyd( 0, 6 )
oxyd( 6, 0 )
oxyd( 6, 12 )
oxyd( level_width-1, 6 )
oxyd( level_width-7, 0 )
oxyd( level_width-7, 12 )
oxyd_shuffle()
