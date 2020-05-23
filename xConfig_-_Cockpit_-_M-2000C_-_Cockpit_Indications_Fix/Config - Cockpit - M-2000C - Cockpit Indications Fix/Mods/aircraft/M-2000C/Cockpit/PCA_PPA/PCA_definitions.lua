-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.6 (05/22/2020) for DCS World 2.5.6.49314 (05/20/2020)
-- -----------------------------------------------------------------------------
dofile(LockOn_Options.common_script_path.."elements_defs.lua")

PCA_DEFAULT_LEVEL     = 8

SetScale(FOV)

----------- Fonts --------------
pca_gauge_font			= "pca_gauge_font"
pca_font_size_default = {0.010,0.010}
--------------------------------

function Add_PCA_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = PCA_DEFAULT_LEVEL
	object.additive_alpha     = true
	object.collimated 		  = false
	Add(object)
end

