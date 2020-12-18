-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.82 (10/05/2020) for DCS World 2.5.6.55743 (09/30/2020)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."PCA_PPA/"
dofile(my_path.."PPA_definitions.lua")

text_PPA_QTY					      = CreateElement "ceStringPoly"
text_PPA_QTY.name				    = "text_PPA_QTY"
text_PPA_QTY.material			  = PPA_gauge_font
text_PPA_QTY.init_pos			  = {0.0,0.9}                                   -- {0.0,0.7} 
text_PPA_QTY.alignment			= "CenterCenter"
text_PPA_QTY.formats			  = {"%02d"}
text_PPA_QTY.stringdefs			= {0.010,0.010}                               -- {0.012,0.012}
text_PPA_QTY.controllers 		= {{"PPA_VIS"}, {"PPA_QTY",0}}
Add_PPA_Element(text_PPA_QTY)

text_PPA_INT					      = CreateElement "ceStringPoly"
text_PPA_INT.name				    = "text_PPA_INT"
text_PPA_INT.material			  = PPA_gauge_font
text_PPA_INT.init_pos			  = {0.0,-0.8}                                  -- {0.0,-0.7}
text_PPA_INT.alignment			= "CenterCenter"
text_PPA_INT.formats			  = {"%02d"}
text_PPA_INT.stringdefs			= {0.010,0.010}                               -- {0.012,0.012}
text_PPA_INT.controllers 		= {{"PPA_VIS"}, {"PPA_INT",0}}
Add_PPA_Element(text_PPA_INT)
