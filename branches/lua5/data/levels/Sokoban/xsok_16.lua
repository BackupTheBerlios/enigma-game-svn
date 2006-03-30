-- A sokoban clone for Enigma
-- Name    : Sokoban 16
-- Filename: xsok_16.lua
--
-- Taken from Sokoban
-- Copyright: Thinking Rabbit
--
-- Converted to enigma format by Ralf Westram (amgine@reallysoft.de)


dofile(enigma.FindDataFile("levels/lib/ralf_sokoban.lua"))

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

level={
  "######!!!!!!!!!",
  "#    #####!!!!!",
  "#  o #   ######",
  "#   o@ o #    #",
  "##  o # #  o  #",
  "!### ## o  o###",
  "!!!#oo ##   #!!",
  "!!!#   ##o###!!",
  "!!##  o o...#!!",
  "!!#    # .*.#!!",
  "!!# o o# #..#!!",
  "!!####  ##..#!!",
  "!!!!!##.....#!!",
  "!!!!!!#######!!",
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

play_sokoban(level,769)

