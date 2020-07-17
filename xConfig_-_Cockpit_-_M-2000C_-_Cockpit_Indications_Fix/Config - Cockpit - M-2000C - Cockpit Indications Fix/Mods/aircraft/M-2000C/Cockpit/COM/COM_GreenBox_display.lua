-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.8 (06/17/2020) for DCS World 2.5.6.49798 (05/29/2020)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."COM/"
dofile(my_path.."COM_definitions.lua")


local	text_COM_VHF					    = CreateElement "ceStringPoly"
		text_COM_VHF.name				    = "text_COM_VHF"
		text_COM_VHF.material			  = COM_greenbox_font
		text_COM_VHF.init_pos			  = {1.0,0}                                 -- {0.8,0}
		text_COM_VHF.alignment			= "RightCenter"
		text_COM_VHF.formats			  = {"%03.2f"}
		text_COM_VHF.stringdefs			= {0.005,0.005}                           -- {0.006,0.006}
		text_COM_VHF.controllers 		= {{"COM_VIS"}, {"COM_VHF",0}}
Add_COM_Element(text_COM_VHF)

