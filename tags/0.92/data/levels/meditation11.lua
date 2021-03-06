levelw = 20
levelh = 13

create_world(levelw, levelh)
draw_border("st-brownie")

fill_floor("fl-normal")

draw_floor("fl-gradient", { 2, 2}, {1,0}, 16, {type=1})
draw_floor("fl-gradient", { 3, 3}, {1,0}, 14, {type=2})
draw_floor("fl-gradient", { 4, 4}, {1,0}, 12, {type=1})
draw_floor("fl-gradient", { 5, 5}, {1,0}, 10, {type=2})
draw_floor("fl-gradient", { 5, 7}, {1,0}, 10, {type=1})
draw_floor("fl-gradient", { 4, 8}, {1,0}, 12, {type=2})
draw_floor("fl-gradient", { 3, 9}, {1,0}, 14, {type=1})
draw_floor("fl-gradient", { 2,10}, {1,0}, 16, {type=2})

draw_floor("fl-gradient", { 1, 3}, {0,1}, 7, {type=3})
draw_floor("fl-gradient", { 2, 4}, {0,1}, 5, {type=4})
draw_floor("fl-gradient", { 3, 5}, {0,1}, 3, {type=3})
draw_floor("fl-gradient", { 4, 6}, {0,1}, 1, {type=4})
draw_floor("fl-gradient", {15, 6}, {0,1}, 1, {type=3})
draw_floor("fl-gradient", {16, 5}, {0,1}, 3, {type=4})
draw_floor("fl-gradient", {17, 4}, {0,1}, 5, {type=3})
draw_floor("fl-gradient", {18, 3}, {0,1}, 7, {type=4})



set_floor("fl-gradient",  1,  2, {type=5})
set_floor("fl-gradient",  2,  3, {type=12})
set_floor("fl-gradient",  3,  4, {type=5})
set_floor("fl-gradient",  4,  5, {type=12})
set_floor("fl-gradient",  4,  7, {type=11})
set_floor("fl-gradient",  3,  8, {type=7})
set_floor("fl-gradient",  2,  9, {type=11})
set_floor("fl-gradient",  1, 10, {type=7})

set_floor("fl-gradient", 18,  2, {type=6})
set_floor("fl-gradient", 17,  3, {type=10})
set_floor("fl-gradient", 16,  4, {type=6})
set_floor("fl-gradient", 15,  5, {type=10})
set_floor("fl-gradient", 15,  7, {type=9})
set_floor("fl-gradient", 16,  8, {type=8})
set_floor("fl-gradient", 17,  9, {type=9})
set_floor("fl-gradient", 18, 10, {type=8})

hollow( 6, 6)
hollow( 8, 6)
hollow(11, 6)
hollow(13, 6)

set_actor("ac-whiteball-small", 2, 3, {player=0, mouseforce=1})
set_actor("ac-whiteball-small",18, 3, {player=0, mouseforce=1})
set_actor("ac-whiteball-small", 2,10, {player=0, mouseforce=1})
set_actor("ac-whiteball-small",18,10, {player=0, mouseforce=1})

