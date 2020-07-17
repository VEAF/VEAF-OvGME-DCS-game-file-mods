-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.8 (06/17/2020) for DCS World 2.5.6.49798 (05/29/2020)
-- -----------------------------------------------------------------------------
dofile(LockOn_Options.common_script_path.."elements_defs.lua")

FUEL_DEFAULT_LEVEL     = 8

SetScale(FOV)

----------- Fonts --------------
fuel_gauge_font       = "fuel_gauge_font"
fg_font_size_default  = {0.007,0.007}

function Add_FUEL_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = FUEL_DEFAULT_LEVEL
	object.additive_alpha     = true
	object.collimated 		  = false
	Add(object)
end

