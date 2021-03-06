-- Impulsive -- the Enigma Level
-- (c) 2003 Petr Machata/ant_39
-- Licensed under GPL v2.0 or above
-- 2003-01-10

dofile(enigma.FindDataFile("levels/ant.lua"))

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

cells={}

cells[" "]=cell{{{randomfloor, cell{floor="fl-tigris"}, 3, cell{floor="fl-samba"}, 1, cell{floor="fl-stone"}, 20}}}
cells["o"]=cell{stone="st-swap"}
cells["w"]=cell{stone="st-wood"}
cells["i"]=cell{stone="st-stoneimpulse"}

cells["a"]=cell{stone={face="st-door", attr={name="doorA", type="v"}}}
cells["b"]=cell{stone={face="st-door", attr={name="doorB", type="v"}}}
cells["c"]=cell{stone={face="st-door", attr={name="doorC", type="v"}}}
cells["d"]=cell{stone={face="st-door", attr={name="doorD", type="h"}}}
cells["A"]=cell{item= {face="it-trigger", attr={action="openclose", target="doorA"}}}
cells["B"]=cell{item= {face="it-trigger", attr={action="openclose", target="doorB"}}}
cells["C"]=cell{item= {face="it-trigger", attr={action="openclose", target="doorC"}}}
cells["D"]=cell{item= {face="it-trigger", attr={action="openclose", target="doorD"}}}
cells["O"]=cell{actor={face="ac-blackball", attr={player=0}}}
cells["0"]=oxyd

level = {
   "iiiiiiiiiiiiiiiiiiii",
   "iiiO               i",
   "i    iiii iiiiiiii i",
   "idii iiCi ii Ai    i",
   "i ii iw iii  iiiii i",
   "i i  iiiii  ii a   i",
   "i i i  ii wii0 i i i",
   "i i   ii  iiiiii i i",
   "i ii ii  iii wii i i",
   "i 0i iB ii iDiii iii",
   "i ii iiii  iii0b c i",
   "i i          iii i0i",
   "iiiiiiiiiiiiiiiiiiii"
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
oxyd_default_flavor = "c"
set_default_parent(cells[" "])
create_world_by_map(level)
oxyd_shuffle()
