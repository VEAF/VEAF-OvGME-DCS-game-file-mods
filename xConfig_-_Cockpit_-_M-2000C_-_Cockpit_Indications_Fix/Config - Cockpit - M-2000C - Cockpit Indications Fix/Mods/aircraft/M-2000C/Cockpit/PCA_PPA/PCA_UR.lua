-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.8 (06/17/2020) for DCS World 2.5.6.49798 (05/29/2020)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."PCA_PPA/"
dofile(my_path.."PCA_definitions.lua")

text_PCA_UR1                = CreateElement "ceStringPoly"
text_PCA_UR1.name           = "text_PCA_UR1"
text_PCA_UR1.material       = pca_gauge_font
text_PCA_UR1.init_pos       = {-0.99,-0.02}                                       -- {-0.95,-0.02}
text_PCA_UR1.alignment      = "LeftCenter"
text_PCA_UR1.formats        = {"%s"}
text_PCA_UR1.stringdefs	    = pca_font_size_default
text_PCA_UR1.controllers    = {{"PCA_VIS"}, {"PCA_UR1",0}}
Add_PCA_Element(text_PCA_UR1)

text_PCA_UR2                = CreateElement "ceStringPoly"
text_PCA_UR2.name           = "text_PCA_UR2"
text_PCA_UR2.material       = pca_gauge_font
text_PCA_UR2.init_pos       = {-0.57,-0.02}                                       -- {-0.55,-0.02}
text_PCA_UR2.alignment      = "LeftCenter"
text_PCA_UR2.formats        = {"%s"}
text_PCA_UR2.stringdefs     = pca_font_size_default
text_PCA_UR2.controllers    = {{"PCA_VIS"}, {"PCA_UR2",0}}
Add_PCA_Element(text_PCA_UR2)

text_PCA_UR3                = CreateElement "ceStringPoly"
text_PCA_UR3.name           = "text_PCA_UR3"
text_PCA_UR3.material       = pca_gauge_font
text_PCA_UR3.init_pos       = {-0.15,-0.02}
text_PCA_UR3.alignment      = "LeftCenter"
text_PCA_UR3.formats        = {"%s"}
text_PCA_UR3.stringdefs     = pca_font_size_default
text_PCA_UR3.controllers    = {{"PCA_VIS"}, {"PCA_UR3",0}}
Add_PCA_Element(text_PCA_UR3)

text_PCA_UR4                = CreateElement "ceStringPoly"
text_PCA_UR4.name           = "text_PCA_UR4"
text_PCA_UR4.material       = pca_gauge_font
text_PCA_UR4.init_pos       = {0.26,-0.02}                                        -- {0.25-0.02}
text_PCA_UR4.alignment      = "LeftCenter"
text_PCA_UR4.formats        = {"%s"}
text_PCA_UR4.stringdefs     = pca_font_size_default
text_PCA_UR4.controllers    = {{"PCA_VIS"}, {"PCA_UR4",0}}
Add_PCA_Element(text_PCA_UR4)

text_PCA_UR5                = CreateElement "ceStringPoly"
text_PCA_UR5.name           = "text_PCA_UR5"
text_PCA_UR5.material       = pca_gauge_font
text_PCA_UR5.init_pos       = {0.67,-0.02}                                        -- {0.65,-0.02} 
text_PCA_UR5.alignment      = "LeftCenter"
text_PCA_UR5.formats        = {"%s"}
text_PCA_UR5.stringdefs     = pca_font_size_default
text_PCA_UR5.controllers    = {{"PCA_VIS"}, {"PCA_UR5",0}}
Add_PCA_Element(text_PCA_UR5)

