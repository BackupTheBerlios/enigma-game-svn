-- Lifes' Cross, a level for Enigma
-- Copyright (C) 2005 Raoul 
-- Licensed under GPL v2.0 or above

levelw = 20
levelh = 20
create_world(levelw, levelh)

-- FLOOR --
fill_floor("fl-water", 0,0,20,20)

set_floor("fl-ice",4, 7)
set_floor("fl-ice",4, 13)
set_floor("fl-ice",5, 7)
set_floor("fl-ice",5, 8)
set_floor("fl-ice",5, 12)
set_floor("fl-ice",5, 13)
set_floor("fl-ice",6, 8)
set_floor("fl-ice",6, 9)
set_floor("fl-ice",6, 10)
set_floor("fl-ice",6, 11)
set_floor("fl-ice",6, 12)
set_floor("fl-ice",7, 4)
set_floor("fl-ice",7, 5)
set_floor("fl-ice",7, 9)
set_floor("fl-ice",7, 10)
set_floor("fl-ice",7, 11)
set_floor("fl-ice",7, 15)
set_floor("fl-ice",7, 16)
set_floor("fl-ice",8, 5)
set_floor("fl-ice",8, 6)
set_floor("fl-ice",8, 10)
set_floor("fl-ice",8, 14)
set_floor("fl-ice",8, 15)
set_floor("fl-ice",9, 6)
set_floor("fl-ice",9, 7)
set_floor("fl-ice",9, 13)
set_floor("fl-ice",9, 14)
set_floor("fl-ice",10, 6)
set_floor("fl-ice",10, 7)
set_floor("fl-ice",10, 8)
set_floor("fl-ice",10, 12)
set_floor("fl-ice",10, 13)
set_floor("fl-ice",10, 14)
set_floor("fl-ice",11, 6)
set_floor("fl-ice",11, 7)
set_floor("fl-ice",11, 13)
set_floor("fl-ice",11, 14)
set_floor("fl-ice",12, 5)
set_floor("fl-ice",12, 6)
set_floor("fl-ice",12, 10)
set_floor("fl-ice",12, 14)
set_floor("fl-ice",12, 15)
set_floor("fl-ice",13, 4)
set_floor("fl-ice",13, 5)
set_floor("fl-ice",13, 9)
set_floor("fl-ice",13, 10)
set_floor("fl-ice",13, 11)
set_floor("fl-ice",13, 15)
set_floor("fl-ice",13, 16)
set_floor("fl-ice",14, 8)
set_floor("fl-ice",14, 9)
set_floor("fl-ice",14, 10)
set_floor("fl-ice",14, 11)
set_floor("fl-ice",14, 12)
set_floor("fl-ice",15, 7)
set_floor("fl-ice",15, 8)
set_floor("fl-ice",15, 12)
set_floor("fl-ice",15, 13)
set_floor("fl-ice",16, 7)
set_floor("fl-ice",16, 13)

set_floor("fl-gray",10, 10)
set_floor("fl-gray",6, 6)
set_floor("fl-gray",6, 14)
set_floor("fl-gray",7, 7)
set_floor("fl-gray",7, 13)
set_floor("fl-gray",8, 8)
set_floor("fl-gray",8, 12)
set_floor("fl-gray",9, 9)
set_floor("fl-gray",9, 11)
set_floor("fl-gray",11, 9)
set_floor("fl-gray",11, 11)
set_floor("fl-gray",12, 8)
set_floor("fl-gray",12, 12)
set_floor("fl-gray",13, 7)
set_floor("fl-gray",13, 13)
set_floor("fl-gray",14, 6)
set_floor("fl-gray",14, 14)

-- gradients --
set_floor("fl-gradient4",4 ,5)
set_floor("fl-gradient11",4 ,6)
set_floor("fl-gradient12",4 ,14)
set_floor("fl-gradient4",4 ,15)
set_floor("fl-gradient2",5 ,4)
set_floor("fl-gradient1",5 ,6)
set_floor("fl-gradient2",5 ,14)
set_floor("fl-gradient1",5 ,16)
set_floor("fl-gradient10",6 ,4)
set_floor("fl-gradient3",6 ,5)
set_floor("fl-gradient6",6 ,7)
set_floor("fl-gradient8",6 ,13)
set_floor("fl-gradient3",6 ,15)
set_floor("fl-gradient9",6 ,16)
set_floor("fl-gradient7",7 ,6)
set_floor("fl-gradient11",7 ,8)
set_floor("fl-gradient12",7 ,12)
set_floor("fl-gradient5",7 ,14)
set_floor("fl-gradient10",8 ,7)
set_floor("fl-gradient6",8 ,9)
set_floor("fl-gradient8",8 ,11)
set_floor("fl-gradient9",8 ,13)
set_floor("fl-gradient7",9 ,8)
set_floor("fl-gradient4",9 ,10)
set_floor("fl-gradient5",9 ,12)
set_floor("fl-gradient2",10 ,9)
set_floor("fl-gradient1",10 ,11)
set_floor("fl-gradient8",11 ,8)
set_floor("fl-gradient3",11 ,10)
set_floor("fl-gradient6",11 ,12)
set_floor("fl-gradient12",12 ,7)
set_floor("fl-gradient5",12 ,9)
set_floor("fl-gradient7",12 ,11)
set_floor("fl-gradient11",12 ,13)
set_floor("fl-gradient8",13 ,6)
set_floor("fl-gradient9",13 ,8)
set_floor("fl-gradient10",13 ,12)
set_floor("fl-gradient6",13 ,14)
set_floor("fl-gradient12",14 ,4)
set_floor("fl-gradient4",14 ,5)
set_floor("fl-gradient5",14 ,7)
set_floor("fl-gradient7",14 ,13)
set_floor("fl-gradient4",14 ,15)
set_floor("fl-gradient11",14 ,16)
set_floor("fl-gradient2",15 ,4)
set_floor("fl-gradient1",15 ,6)
set_floor("fl-gradient2",15 ,14)
set_floor("fl-gradient1",15 ,16)
set_floor("fl-gradient3",16 ,5)
set_floor("fl-gradient9",16 ,6)
set_floor("fl-gradient10",16 ,14)
set_floor("fl-gradient3",16 ,15)

-- STONES --
set_stone("st-actorimpulse", 5, 5)
set_stone("st-actorimpulse", 5, 15)
set_stone("st-actorimpulse", 15, 5)
set_stone("st-actorimpulse", 15, 15)

-- ITEMS --
set_item("it-extralife",6 ,6)
set_item("it-extralife",7 ,7)
set_item("it-extralife",8 ,8)
set_item("it-extralife",9 ,9)
set_item("it-extralife",11 ,9)
set_item("it-extralife",12 ,8)
set_item("it-extralife",13 ,7)
set_item("it-extralife",14 ,6)
set_item("it-extralife",6 ,14)
set_item("it-extralife",7 ,13)
set_item("it-extralife",8 ,12)
set_item("it-extralife",9 ,11)
set_item("it-extralife",11 ,11)
set_item("it-extralife",12 ,12)
set_item("it-extralife",13 ,13)
set_item("it-extralife",14 ,14)

if not difficult then
 set_stone("st-chameleon", 16,13)
 set_item("it-pin", 16,13)
 set_item("it-document",10,10,{text="Wer sucht, der findet..."})
end

-- PLAYER --
local ac1=set_actor("ac-blackball", 10.5,10.5, {player=0})

-- OXYD --
oxyd(4,4)
oxyd(4,16)
oxyd(16,4)
oxyd(16,16)
oxyd_default_flavor = "a"
oxyd_shuffle()

-- WEITERES --
enigma.ConserveLevel = TRUE
enigma.BumperForce = 200
display.SetFollowMode(display.FOLLOW_SMOOTH)


























