-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 2.4 (2021-02-04) for DCS World 2.5.6.60966 (2021-02-03)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."PCA_PPA/"
dofile(my_path.."PCA_definitions.lua")

text_PCA_BR1                = CreateElement "ceStringPoly"
text_PCA_BR1.name           = "text_PCA_BR1"
text_PCA_BR1.material       = pca_gauge_font
text_PCA_BR1.init_pos       = {-0.99,-0.01}                                       -- {-0.95,-0.02}
text_PCA_BR1.alignment      = "LeftCenter"
text_PCA_BR1.formats        = {"%s"}
text_PCA_BR1.stringdefs     = pca_font_size_default
text_PCA_BR1.controllers    = {{"PCA_VIS"}, {"PCA_BR1",0}}
Add_PCA_Element(text_PCA_BR1)

text_PCA_BR2                = CreateElement "ceStringPoly"
text_PCA_BR2.name           = "text_PCA_BR2"
text_PCA_BR2.material       = pca_gauge_font
text_PCA_BR2.init_pos       = {-0.57,-0.01}                                       -- {-0.55,-0.02}
text_PCA_BR2.alignment      = "LeftCenter"
text_PCA_BR2.formats        = {"%s"}
text_PCA_BR2.stringdefs     = pca_font_size_default
text_PCA_BR2.controllers    = {{"PCA_VIS"}, {"PCA_BR2",0}}
Add_PCA_Element(text_PCA_BR2)

text_PCA_BR3                = CreateElement "ceStringPoly"
text_PCA_BR3.name           = "text_PCA_BR3"
text_PCA_BR3.material       = pca_gauge_font
text_PCA_BR3.init_pos       = {-0.15,-0.01}                                       -- {-0.15,-0.02}
text_PCA_BR3.alignment      = "LeftCenter"
text_PCA_BR3.formats        = {"%s"}
text_PCA_BR3.stringdefs     = pca_font_size_default
text_PCA_BR3.controllers    = {{"PCA_VIS"}, {"PCA_BR3",0}}
Add_PCA_Element(text_PCA_BR3)

text_PCA_BR4                = CreateElement "ceStringPoly"
text_PCA_BR4.name           = "text_PCA_BR4"
text_PCA_BR4.material       = pca_gauge_font
text_PCA_BR4.init_pos       = {0.26,-0.01}                                        -- {0.25,-0.02}
text_PCA_BR4.alignment      = "LeftCenter"
text_PCA_BR4.formats        = {"%s"}
text_PCA_BR4.stringdefs     = pca_font_size_default
text_PCA_BR4.controllers    = {{"PCA_VIS"}, {"PCA_BR4",0}}
Add_PCA_Element(text_PCA_BR4)

text_PCA_BR5                = CreateElement "ceStringPoly"
text_PCA_BR5.name           = "text_PCA_BR5"
text_PCA_BR5.material       = pca_gauge_font
text_PCA_BR5.init_pos       = {0.67,-0.01}                                        -- {0.65,-0.02}
text_PCA_BR5.alignment      = "LeftCenter"
text_PCA_BR5.formats        = {"%s"}
text_PCA_BR5.stringdefs     = pca_font_size_default
text_PCA_BR5.controllers    = {{"PCA_VIS"}, {"PCA_BR5",0}}
Add_PCA_Element(text_PCA_BR5)

