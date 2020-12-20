-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 2.2 (2020-12-19) for DCS World 2.5.6.59398 (2020-12-17)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."FUEL/"
dofile(my_path.."FUEL_definitions.lua")

txt_fuel_g					          = CreateElement "ceStringPoly"
txt_fuel_g.name				        = "txt_fuel_g"
txt_fuel_g.material			      = fuel_gauge_font
txt_fuel_g.init_pos			      = {1.0,-0.1}
txt_fuel_g.alignment		      = "RightCenter"
txt_fuel_g.formats			      = {"%03.f"}
txt_fuel_g.stringdefs		      = {0.009,0.009}                               -- {0.010,0.010}
txt_fuel_g.controllers 		    = {{"visFUEL_USE"}, {"txtFUEL_USE",0}}
Add_FUEL_Element(txt_fuel_g)
