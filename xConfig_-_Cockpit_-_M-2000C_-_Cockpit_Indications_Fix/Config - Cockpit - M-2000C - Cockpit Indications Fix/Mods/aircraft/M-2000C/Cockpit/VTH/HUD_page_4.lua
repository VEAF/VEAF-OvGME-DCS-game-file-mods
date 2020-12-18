-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.82 (10/05/2020) for DCS World 2.5.6.55743 (09/30/2020)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."VTH/"
dofile(my_path.."HUD_definitions.lua")

-- This page is, apparently, currently NOT used at all...

txt_asi					            = CreateElement "ceStringPoly"
txt_asi.name				        = "txt_asi"
txt_asi.material			      = indication_font
txt_asi.init_pos			      = {-112.0,44.0}
txt_asi.alignment			      = "LeftTop"
txt_asi.formats			        = {"%03.f"}
txt_asi.stringdefs		      = {0.009,0.009}
txt_asi.controllers 		    = {{"txt_asi",0}}
AddHUDElement(txt_asi)

txt_balt_T					        = CreateElement "ceStringPoly"
txt_balt_T.name				      = "txt_balt_T"
txt_balt_T.material			    = indication_font
txt_balt_T.init_pos			    = {82.0,50.0}
txt_balt_T.alignment		    = "RightTop"
txt_balt_T.formats			    = {"%01.f"}
txt_balt_T.stringdefs	      = {0.011,0.011}
txt_balt_T.controllers 		  = {{"txt_balt_T",0}}
AddHUDElement(txt_balt_T)

txt_balt_H					        = CreateElement "ceStringPoly"
txt_balt_H.name				      = "txt_balt_H"
txt_balt_H.material			    = indication_font
txt_balt_H.init_pos			    = {105.0,46.0}
txt_balt_H.alignment		    = "RightTop"
txt_balt_H.formats			    = {"%03.f"}
txt_balt_H.stringdefs	      = {0.008,0.008}
txt_balt_H.controllers 		  = {{"txt_balt_H",0}}
AddHUDElement(txt_balt_H)

txt_pitch					          = CreateElement "ceStringPoly"
txt_pitch.name				      = "txt_pitch"
txt_pitch.material			    = indication_font
txt_pitch.init_pos			    = {-112.0,0.0}
txt_pitch.alignment			    = "LeftCenter"
txt_pitch.formats			      = {"%+03.f"}
txt_asi.stringdefs		      = {0.009,0.009}
txt_pitch.controllers 		  = {{"txt_pitch",0}}
AddHUDElement(txt_pitch)
