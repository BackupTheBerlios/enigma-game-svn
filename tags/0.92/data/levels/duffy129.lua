-- Copyright (c) 2004 Jacob Scott
-- License: GPL v2.0 or above
-- Enigma Level: Island Labyrinth

rooms_wide=8
rooms_high=6

levelw=1+(19*rooms_wide)
levelh=1+(12*rooms_high)

create_world( levelw, levelh)
enigma.SetCompatibility("oxyd1")

fill_floor("fl-leaves", 0,0,levelw,levelh)

function renderLine( line, pattern)
	for i=1, strlen(pattern) do
		local c = strsub( pattern, i, i)
		if c =="#" then
			set_stone( "st-rock1", i-1, line)
		elseif c =="$" then
			set_stone( "st-rock1", i-1, line)
			set_floor("fl-ice_001",i-1,line)
		elseif c =="^" then
			set_stone( "st-rock1", i-1, line)
			set_floor("fl-sand",i-1,line)
		elseif c =="X" then
			set_stone( "st-death", i-1, line)
		elseif c =="-" then
			set_stone( "st-death", i-1, line)
			set_floor("fl-space",i-1,line)
		elseif c == "o" then
			oxyd( i-1, line)
		elseif c == "I" then
			oxyd( i-1, line)
		   set_floor("fl-water",i-1,line)
		elseif c == ":" then
		   oxyd( i-1, line)
		   abyss(i-1,line)
		elseif c == ";" then
		   oxyd( i-1, line)
			set_floor("fl-ice_001",i-1,line)
		elseif c == "*" then
			set_stone( "st-brownie", i-1, line)
                elseif c == "!" then
			abyss(i-1,line)
		elseif c == "~" then
		   set_floor("fl-water",i-1,line)
		elseif c == "q" then
		   set_floor("fl-water",i-1,line)
		elseif c=="z" then
		   set_actor("ac-blackball", i-.5,line+.5, {player=0})
		elseif c=="y" then
		   set_actor("ac-whiteball", i-1,line+.5, {player=1})
		elseif c == "g" then
			draw_stones("st-grate1",{i-1,line}, {1,1}, 1)
		elseif c=="+" then
			set_stone( "st-wood", i-1, line)
		elseif c=="=" then
			set_floor("fl-space",i-1,line)
		elseif c=="Y" then
			set_floor("fl-ice_001",i-1,line)
		elseif c=="n" then
			set_floor("fl-sand",i-1,line)
		elseif c=="p" then
			set_floor("fl-normal",i-1,line)
		elseif c=="O" then
		   set_item("it-extralife",i-1,line)
		elseif c=="f" then
		   set_item("it-flagblack",i-1,line)
		elseif c == "d" then --1-d
			set_floor("fl-gradient",  i-1,  line, {type=1})
		elseif c == "u" then --2-u
			set_floor("fl-gradient",  i-1,  line, {type=2})
		elseif c == "r" then --3-r
			set_floor("fl-gradient",  i-1,  line, {type=3})
		elseif c == "l" then --4-l
			set_floor("fl-gradient",  i-1,  line, {type=4})
		elseif c == "1" then --ur
			set_floor("fl-gradient",  i-1,  line, {type=11})
		elseif c == "3" then --dl
			set_floor("fl-gradient",  i-1,  line, {type=9})
		elseif c == "7" then --dr
			set_floor("fl-gradient",  i-1,  line, {type=12})
		elseif c == "9" then --ul
			set_floor("fl-gradient",  i-1,  line, {type=10})
		elseif c == "Q" then
		   set_actor("ac-rotor", i-.5,line+.5, {player=1, mouseforce=0, range=5.5, force=30})
		   set_floor("fl-water",i-1,line)
		elseif c == "R" then
		   set_actor("ac-rotor", i-.5,line+.5, {player=1, mouseforce=0, range=3, force=10})
		elseif c == "v" then
		   set_actor("ac-rotor", i-.5,line+.5, {player=1, mouseforce=0, range=10, force=5})
			set_floor("fl-ice_001",i-1,line)
		elseif c == "?" then
		   set_actor("ac-top", i-.5,line+.5, {player=1, mouseforce=0, range=0, force=0})
			set_floor("fl-ice_001",i-1,line)
		elseif c == "W" then
		   set_actor("ac-top", i-.5,line+.5, {player=1, mouseforce=0, range=5, force=5})
			set_floor("fl-ice_001",i-1,line)
		elseif c == "b" then
			yy1( "black",  i-1, line)
		elseif c == "F" then
			yy1( "black",  i-1, line)
			set_floor("fl-ice_001",i-1,line)
		elseif c=="T" then
		   set_stone("st-turnstile",i-1,line)
		elseif c=="n" then
		   set_stone("st-turnstile-n",i-1,line)
		elseif c=="N" then
		   set_stone("st-turnstile-n",i-1,line)
		   set_floor("fl-water",i-1,line)
		elseif c=="e" then
		   set_stone("st-turnstile-e",i-1,line)
		elseif c=="S" then
		   set_stone("st-turnstile-s",i-1,line)
		elseif c=="w" then
		   set_stone("st-turnstile-w",i-1,line)
		elseif c=="i" then
  		   set_item("it-vortex-closed", i-1, line,{name="v1"})
		elseif c=="j" then
  		   set_item("it-vortex-closed", i-1, line,{name="v2"})
		elseif c=="C" then
		   set_item("it-vortex-open", i-1, line,{targetx="135.5",targety="9.5"})
		elseif c=="D" then
		   set_item("it-vortex-open", i-1, line,{targetx="77.5",targety="19.5"})
		elseif c=="&" then
		   set_item("it-vortex-open", i-1, line,{targetx="149.5",targety="27.5"})
		elseif c=="@" then
		   set_item("it-vortex-open", i-1, line,{targetx="136.5",targety="35.5"})
		elseif c=="s" then
		   set_stone("st-stoneimpulse",i-1,line)
		elseif c=="A" then
			doorh( i-1,line, {name="door1"})
		elseif c=="B" then
			doorh( i-1,line, {name="door2"})
		elseif c=="5" then
			doorh( i-1,line, {name="door3"})
		elseif c=="<" then
			doorv( i-1,line, {name="door4"})
		elseif c==">" then
			doorv( i-1,line, {name="door5"})
		elseif c=="P" then
			set_stone("st-switch", i-1,line, {action="callback",target="funcc1"})
		elseif c=="V" then
			set_stone("st-switch", i-1,line, {action="callback",target="funcc2"})
		elseif c=="U" then
			set_stone("st-switch", i-1,line, {action="openclose",target="door3"})
		elseif c=="8" then
			set_stone("st-bolder", i-1,line, {direction=NORTH})
		elseif c=="6" then
			set_stone("st-bolder", i-1,line, {direction=EAST})
		elseif c=="2" then
			set_stone("st-bolder", i-1,line, {direction=SOUTH})
		elseif c=="4" then
			set_stone("st-bolder", i-1,line, {direction=WEST})
		elseif c=="0" then
			set_stone("st-rotator-right", i-1,line)
		elseif c=="." then
			set_stone("st-rotator-left", i-1,line)
		elseif c=="K" then
			set_stone("st-key_a", i-1,line, {action="openclose", target="door4"})
		elseif c=="k" then
			set_item("it-key_a", i-1,line)
		elseif c=="M" then
			set_stone( "st-floppy", i-1,line,{action="openclose",target="door5"})
		elseif c=="m" then
			set_item("it-floppy", i-1,line)
			set_floor("fl-ice_001",i-1,line)
		elseif c=="J" then
		   set_item("it-springboard",i-1,line)
		elseif c=="t" then
		        set_stone("st-oneway_black", i-1,line, {orientation=enigma.SOUTH})
		elseif c=="a" then
		        set_stone("st-oneway_black", i-1,line, {orientation=enigma.NORTH})
		elseif c=="H" then
		   set_item("it-hollow",i-1,line)
		elseif c=="`" then
			mirrorp(i-1,line,TRUE,FALSE, 2)
		elseif c=="/" then
			mirrorp(i-1,line,TRUE,FALSE, 4)
		elseif c=="L" then
			set_attrib(laser(i-1,line, TRUE, EAST), "name", "laser")
		elseif c=="h" then
		   set_item("it-magicwand",i-1,line)
	     end
	end	
     end

function yy1( color, x, y)
        stone = format( "st-%s4", color)
        set_stone( stone, x, y)
end

renderLine(00,"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq###########################################################################")
renderLine(01,"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq#     #   # #                                                             #")
renderLine(02,"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq# ### # # # # ########################################################### #")
renderLine(03,"qqqqq###################################################qqqqqqqqqqqqqqqqqqqqqq# #o# # #   # #                          i~~~j                          # #")
renderLine(04,"qqqqq#           #                                  nn~#qq#######qqqqqqqqqqqqq# # # # ##### # ##################A#################B################## # #")
renderLine(05,"qqqqq# ########### ########### ########### #############qq#   * ############### # # #  #    # #                #         *         #                # # #")
renderLine(06,"qqqqq# #                     #           #            o#qq# ** *  ~           # # # # ## XXX# #XXX ######## #############V############# ########### # # #")
renderLine(07,"qqqqq# # ###############################################qq#   * ############# # # #      X3ddddd1X        #                    J~J      #         # # # #")
renderLine(08,"qqqqq# # #qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq# **  #           # # # ########r33d11l######5######################P#~#### ### ####### # # # #")
renderLine(09,"qqqqq# # #qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq#   * # ######### # # #         rrr lll                          b R #      #D# #     # # # # #")
renderLine(10,"qqqqq# # #qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq##### # #~~~nn    # # ##########r99u77l############## ##################### # # # ### # # # # #")
renderLine(11,"qqqqq# # #qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq# # #~~~^^##### #          X9uuuuu7Xqqqqqqqqqqqq# #     #     s*        # # # # # # # # # #")
renderLine(12,"qqqqq# # #qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq# # #~~~nn    # ########## XXX# #XXXqqqqqqqqqqqq# # ### # ##### #######s# # # # # # # # # #")
renderLine(13,"qqqqq# # #qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq# # ######### # #        #    # #qqqqqqqqqqqqqqq# # #   #   #   #         # # # # # # # # #")
renderLine(14,"qqqqq# # #qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq# #         # # # ###### #### # #qqqqqqqqqqqqqqq# # # ##### # # #nnn# ##### # # # # #o# # #")
renderLine(15,"qqqqq# # #qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq# # ####### # # # #    #    # # #qqqqqqqqqqqqqqq# # #       # # #nnn# #     #   # # ### # #")
renderLine(16,"qqqqq# # #qqqqqqqqqqq##########################################+# #       # # # # ## # ## # # #qqqqqqqqqqqqqqq# # ######### # #~~~# # ### ### # #     # #")
renderLine(17,"qqqqq# # #qqqqqqqqqqq#  >                                       # # ####### # # # #  # #  # # #qqqqqqqqqqqqqqq# #         # # #~~~# # #  g  # # ####### #")
renderLine(18,"qqqqq# # #qqqqqqqqq### #M############# ######### ############## # # #   # # # # # # ## # ## # ################# ######### # # #~~~# # ##+*+## #         #")
renderLine(19,"qqqqq# # ###########   # #           # #qqqqqqq# #qqqqqqqqqqqq# # #   #   # #C# # #    #  # #               *           # # # #~~~# # #     # ###########")
renderLine(20,"qqqqq# #             ### # ######### # #qqqqqqq# #qqqqqqqqqqqq# # ######### ### ######### # # ######################### # # # #~~~# # # g g # #qqqqqqqqqq")
renderLine(21,"qqqqq# ###############   #   #     # # #qq###### ############q# #               #         # # #qqqqqqqqqqqqqqqqqqqqqqq# # # # #~~~# ##### ### #qqqqqqqqqq")
renderLine(22,"qqqqq#               # ##### # ##### # ####                 #q# ############### ########### # #qqqqqqqqqqqqqqqqqqqqqqq# # # # ##### #   # #   #qqqqqqqqqq")
renderLine(23,"qqqqq# ############# # #   # # #     #    ################# #q#                             # #qqqqqqqqqqqqqqqqqqqqqqq# # ###   # # ### # # # #qqqqqqqqqq")
renderLine(24,"qqqqq# #       #   # # # # # # # ######## #           #   # #q# ######## #################### #qqqqqqqqqqqqqqqqqqqqqqq# # #   #   #   # # # # #qqqqqqqqqq")
renderLine(25,"qqqqq# # ### # # # # #   #   # #        # # #########   #   #q# #      # # #qqqqqqqqqqqqqqqq# #qqqqqqqqqqqqqq########## # # ######### # # # # #qqqqqqqqqq")
renderLine(26,"qqqqq# # # # #   # # ######### ######## # # #qqqqqqq#########q# # #### # # #qqqqqqqqqqqqqqqq# #qqqqqqqqqqqqqq#  ~~~#  # #   #   #   # # # s # #qqqqqqoqqq")
renderLine(27,"qqqqq# # # # ##### #                  # # # #q#####qqqqqqqqqqq# # # O# # # #qqqqqqqqqqqqqqq## ##qqqqqqqqqqqqq# #~~~g+ # # #   #   #   # N s # #qqqqq#@#qq")
renderLine(28,"qqqqq# # # # #   # ############## ##### # # #q#   ############# # #  # # # #qqqqqqqqqqqqqqq#   #qqqqqqqqqqqqq# #~~~+  # ############### T s # #qqqqqq#qqq")
renderLine(29,"qqqqq# # # #   # #                #   # # # #q# z               # # ## # # #qqqqqqqqqqqqqqq#* *#qqqqqqqqqqqqq#U#~~~++                   S s # #qqqqqqqqqq")
renderLine(30,"qqqqq# # # ##### ################## # # # # #q#   ############# # #  # # # #qqqqqqqqqqqqqqq# * #qqqqqqqqqqqqq# #~~~+  ###################a# # #qqqqqqqqqq")
renderLine(31,"qqqqq# #       #                    #   # # #q#####qqqqqqqqqqq# # ## # # # #qqqqqqqqqqqqqqq#* *#qqqqqqqqqqqqq# #~~~g+ #                 # # # #qqqqqqqqqq")
renderLine(32,"qqqqq# ################################## # #qqqqqqqqqqqqqqqqq# # #  # # # #qqqqqqqqqqqqqqq#   #qqqqqqqqqqqqq#  ~~~#  # ###############     # #qqqqqqqqqq")
renderLine(33,"qqqqq#                                    #O################### # # ## # # #qqqqqqqqqqqqqqq#* *#qqqqqqqqqqqqq########## #qqqqqqqqqqqq######## #####qqqqqq")
renderLine(34,"qqqqq############ ##################### #####O                # # #    # # #qqqqqqqqqqqqqqq# * #qqqqqqqqqqqqqqqqqqqqqq# #qqqqqqqqq####            #qqqqqq")
renderLine(35,"qqqqqqqqqqqqqqqq# #                   # #   ################# # # ###### # #qqqqqqqqqqqqqqq#* *#qqqqqqqqqqqqqq###qqqqq# #qqqqqqqqq#    #&######## #qqqqqq")
renderLine(36,"qqqqqqqqqqqqqqqq# # #.############### # # # #                 # #        # #qqqqqqqqqqqqqqq# * #qqqqqqqqqqqqqq# #qqqqq# #qqqq###### ######qqqqqq# #qqqqqq")
renderLine(37,"qqqqqqqqqqqqqqqq# # #8   6     6   2. # # # # ################# ########## #qq##############* *##########qqqqq# #qqqqq# #qqqq#           #qqqqqq# #qqqqqq")
renderLine(38,"qqqqqqqqqqqqqqqq# # .    4     4    # # # # # #                            #qq#                   *     #qqqqq# #qqqqq# #qqqq#           #qqqqqq# #qqqqqq")
renderLine(39,"qqqqqqqqqqqqqqqq# # # ###########  .# # # # # # ############################qq# ####################### #qqqqq# #qqqqq# ###qq# +++ggg+++ #qqqqqq# #qqqqqq")
renderLine(40,"qqqqqqqqqqqqqqqq# # # #         #   # # # #   #                 #qqqqqqqqqqqqq# #qqqqqqqqqqqqqqqqqqqqq# #q##### #qqqqq#   #qq#~~~~~~~~~~~#qqqqqq# #qqqqqq")
renderLine(41,"qqqqqqqqqqqqqqqq# # # # ####### #   # # # ##################### #qqqqqqqqqqqqq# #qqqqqqqqqqqqqqqqqqqqq# #q#     #qqqqq# # #qq#~~~~~~~~~~~#qqqqqq# #qqqqqq")
renderLine(42,"qqqqqqqqqqqqqqqq# # # # #   #h# #   # # # #                 # # #qqqqqqqqqqqqq# #qqqqqqqqqqqqqqqqqqqqq# #q# #####qqqqq# # #qq#~~~~~I~~~~~#qqqqqq# #qqqqqq")
renderLine(43,"qqqqqqqqqqqqqqqq# # # # # # #O# #   < # #   #t#############   # #qqqqqqqqqqqqq# #qqqqqqqqqqqqqqqqqqqqq# #q# #qqqqqq#### # #qq#~~~~~~~~~~~#qqqqqq# #qqqqqq")
renderLine(44,"qqqqqqqqqqqqqqqq# # # # # # # # # ##K## #####             ### # #qqqqqqqqqqqqq# #qqqqqqqqqqqqqqqqqqqqq# #q# ########    # #qq#~~~~~~~~~~~#qqqqqq# #qqqqqq")
renderLine(45,"qqqqqqqqqqqqqqqq# # # #   # # # # #         # ########### #   # #qqqqqqqqqqqqq# #qqqqqqqqqqqqqqqqqqqqq# #q#          #### #qq# +++ggg+++ #qqqqqq# #qqqqqq")
renderLine(46,"qqqqqqqqqqqqqqqq# # # # ### # # # # ### ### # #         # # ### #qqqqqqqqqqqqq# #qqqqqqqqqqqqqqqqqqqqq# ############## o# #qq#           #qqqqqq# #qqqqqq")
renderLine(47,"qqqqqqqqqqqqqqqq# # # #   # # # # # #~# #~# # # ####### # #   # #qqqqqqqqqqqqq# #qqqqqqqqqqqqqqqqqqqqq#                 # #qq#           #qqqqqq# #qqqqqq")
renderLine(48,"qqqqqqqqqqqqqqqq# # # ##### # # # #b###b###b# # #   #   # ### # #qqqqqqqqqqqqq# #qqqqqqqqqqqqqqqqqqqqq# ############## o# ######### ######qqqqqq# #qqqqqq")
renderLine(49,"qqqqqqqqqqqqqqqq^n^n^nnnnnnn^n^n# #         # # # # # # # #   # ############### #####qqqqqqqqqqqqqqqqq# #qqqqqqqqqqqq#### #qqqqqqq# #qqqqqqqqqqq# #qqqqqq")
renderLine(50,"qqqqqqqqqqqqqqqq^n~n~~~~~~~~~n~n# #         # # # # # # # # ###                     #qqqqqqqqqqqqqqqqq# #qqqqqqqqqqqqqqq# #q#####q# ############# #qqqqqq")
renderLine(51,"qqqqqqqqqqqqqqqq^n~nnnnnnnnnnn~n# #  nnnnn  # # # # # # # #   # ################### #q-------------qqq# #qqqqqqqqqqqqqqq# #q#   #q#               #qqqqqq")
renderLine(52,"qqqqqqqqqqqqqqqq^n~~~~~~~~~~~~~n# #  n~~~n  # # # # # ### ### # #L                # #q-===========-qqq# #qq############## #q### #q#################qqqqqq")
renderLine(53,"qqqqqqqqqqqqqqqq^nnnnnnnnnnnnnnn# #  n~Q~n  # # # # #  J~ ~HH # #          nnnnn  # #q-=pp========-qqq# #qq#              #qqq# #qqqqqqqqqqqqqqqqqqqqqqqq")
renderLine(54,"qqqqqqqqqqqqqqqq^n~~~~~~~~~~~~~~# #  n~~~n  # # # # ##### ### # # nnn     nn~~~n  # #q-=pp===pp===-qqq# #qq# ##############qqq# #qqqqqqqqqqqqqqqqqqqqqqqq")
renderLine(55,"qqqqqqqqqqqqqqqq^n~nnnnnnnnnnnnn# #  nnnnn  # # # #       #   # # n~nn /`/n~~~~nn # #q-======pp===-qqq# #qq# #qqqqqqqqqqqqqqqq# #qqqqqqqqqqqqqqqqqqqqqqqq")
renderLine(56,"qqqqqqqqqqqqqqqq^n~n~~~~~~~~~~~n# #         # # # # ####### ### # n~~n ` `n~~~~~n # ###======pp===##### #qq# ###qqqq########### #qqqqqqqqqqqqqqqqqqqqqqqq")
renderLine(57,"qqqqqqqqqqqqqqqq^n~n~I~~nnnnnn~n# #    o    # # # # #         # # n~~n    nnn~~~n #    ==p==-=====      #qq#   #qqqq#           #qqqIqqqqqqqqqqqqqqqqqqqq")
renderLine(58,"qqqqqqqqqqqqqqqq^n~n~~~~~~~~~n~n# ########### # # # # ######### # nnnn      nnnnn #####=========p=############ #qqqq# ###########qq7u9qqqqqqqqqqqqqqqqqqq")
renderLine(59,"qqqqqqqqqqqqqqqq^n~nnnnnnnnnnn~n# # #   #   # # # # # #         #                     X===========X          # ###### #qqqqqqqqqqqqlnrqqqqqqqqqqqqqqqqqqq")
renderLine(60,"qqqqqqqqqqqqqqqq^n~~~~~~~~~~~n~n# #   #   #   #   # # ####################### ####### X====pp=====X ######## #        #qqqqqqqqqqqq1d3qqqqqqqqqqqqqqqqqqq")
renderLine(61,"qqqqqqqqqqqqqqqq^nnnnnnnnnnnnn~n# ################# # #                   #= = = = #  X=========p=X   #    # ##########qqqqqqqqqqqqqnqqqqqqqqqqqqqqqqqqqq")
renderLine(62,"qqqqqqqqqqqqqqqq# ############# #                   # # ################# # = = = =# #X===========X## # ## # #qqqqqqqqqqqqq7u9q7u9q7u9qqqqqqqqqqqqqqqqqqq")
renderLine(63,"qqqqqqqqqqqqqqqq# #             ##################### # #O              # #= = = = #  XXXXXXXXXXXXX #   #k # #qqqqqqqqqqqqqlnrnlnrnlnrqqqqqqqqqqqqqqqqqqq")
renderLine(64,"qqqqqqqqqqqqqqqq# # #############YYYYYYYYYYYYYYYYYYY# # ############### # ** ######## #   #   #   # ######## #qqqqqqqqqqqqq1d3q1d3q1d3qqqqqqqqqqqqqqqqqqq")
renderLine(65,"qqqqqqqqqqqqqqqq# # # *  *  * #YYYYYYYYYYYYYYYYYYYYY# #                 # #             #   #   #            #qqqqqqqqqqqqqqnqqqqqqqqqqqqqqqqqqqqqqqqqqqq")
renderLine(66,"qqqqqqqqqqqqqqqq# # # ** * ** #YYYYYYYYYYYYYYYYYYYYY# ################### ########### ################################q7u9q7u9qqqqqqqqqqqqqqqqqqqqqqqqqqq")
renderLine(67,"qqqqqqqqqqqqqqqq# # # *  *  * #   YYYYYYYYYYYYYYYYYY#                                                                 nlnrnlnrqqqqqqqqqqqqqqqqqqqqqqqqqqq")
renderLine(68,"qqqqqqqqqqqqqqqq# #   *** *** b # YYYYYYYYYYYYYYYYYY################################# ########################b#######q1d3q1d3qqqqqqqqqqqqqqqqqqqqqqqqqqq")
renderLine(69,"qqqqqqqqqqqqqqqq# # # *  *  * #   YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYFYYYYYYYY~~~YYYYYYYYFY?YYYYYYYYYYYYYYYYYYY$qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq")
renderLine(70,"qqqqqqqqqqqqqqqq# # # ** * ** #YYYYYYYYYYYYYYYYYYYYYvYYYYYYYYYYYYYYYYYYYYYYFYYYYYYmY~I~Y;YYYYYYFY?YYYYYYYYYYYYYYYYYYW$qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq")
renderLine(71,"qqqqqqqqqqqqqqqq# # # *  *  * #YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYFYYYYYYYY~~~YYYYYYYYFY?YYYYYYYYYYYYYYYYYYY$qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq")
renderLine(72,"qqqqqqqqqqqqqqqq###############$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq")

oxyd_shuffle()

door1=enigma.GetNamedObject("door1")
door2=enigma.GetNamedObject("door2")

v1=enigma.GetNamedObject("v1")
v2=enigma.GetNamedObject("v2")


ff1=0
function funcc1()
if ff1==0 then
   enigma.SendMessage(door1,"open",nil)
   enigma.SendMessage(door2,"open",nil)
ff1=1
elseif ff1==1 then
   enigma.SendMessage(door1,"close",nil)
   enigma.SendMessage(door2,"close",nil)
ff1=0
end
end

ff2=0
function funcc2()
if ff2==0 then
   enigma.SendMessage(v1,"open",nil)
   enigma.SendMessage(v2,"open",nil)
ff2=1
elseif ff2==1 then
   enigma.SendMessage(v1,"close",nil)
   enigma.SendMessage(v2,"close",nil)
ff2=0
end
end

display.SetFollowMode(display.FOLLOW_SCROLLING)
