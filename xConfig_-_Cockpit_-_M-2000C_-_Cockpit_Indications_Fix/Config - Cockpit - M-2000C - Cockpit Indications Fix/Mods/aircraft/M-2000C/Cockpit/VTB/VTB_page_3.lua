-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 2.4 (2021-02-04) for DCS World 2.5.6.60966 (2021-02-03)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."VTB/"
dofile(my_path.."VTB_definitions.lua")
dofile(my_path.."VTB_page_0.lua")

local txt_TAS_static          = CreateElement "ceStringPoly"
txt_TAS_static.name           = "txt_TAS_static"
txt_TAS_static.material       = vtb_indication_font
txt_TAS_static.init_pos       = {0.64, 0.7, 0.0}                                  -- {0.7, 0.7, 0.0}
txt_TAS_static.alignment      = "CenterCenter"
txt_TAS_static.stringdefs     = vtb_font_size_default
txt_TAS_static.value          = "TAS"
txt_TAS_static.controllers    = {{"vis_TAS_rng"}}
Add_VTB_Element(txt_TAS_static)

local txt_RS_static           = CreateElement "ceStringPoly"
txt_RS_static.name            = "txt_RS_static"
txt_RS_static.material        = vtb_indication_font
txt_RS_static.init_pos        = {0.64, 0.6, 0.0}                                 -- {0.7, 0.6, 0.0}
txt_RS_static.alignment       = "CenterCenter"
txt_RS_static.stringdefs      = vtb_font_size_default
txt_RS_static.value           = "RS"
txt_RS_static.controllers     = {{"vis_RS_rng"}}
Add_VTB_Element(txt_RS_static)

local vtb_rdr_inop            = create_vtb_textured_box(189, 47, 350, 89)       -- (184, 40, 357, 97)
vtb_rdr_inop.name             = "vtb_rdr_inop"
vtb_rdr_inop.init_pos         = {0.0, 0.0, 0.0}
vtb_rdr_inop.controllers      = {{"vis_radar"}}
vtb_rdr_inop.additive_alpha   = true
Add_VTB_Element(vtb_rdr_inop)


--[[
local vtb_debug_1		= CreateElement "ceStringPoly"
vtb_debug_1.name		= "vtb_debug_1"
vtb_debug_1.material	= vtb_indication_font
vtb_debug_1.init_pos	= {0.0, 0.4, 0.0}
vtb_debug_1.alignment	= "CenterCenter"
vtb_debug_1.formats		= {"AC Pitch %1.1f"}
vtb_debug_1.stringdefs	= vtb_font_size_default
vtb_debug_1.controllers = {{"txt_pitch"}}
Add_VTB_Element(vtb_debug_1)

local vtb_debug_2		= CreateElement "ceStringPoly"
vtb_debug_2.name		= "vtb_debug_2"
vtb_debug_2.material	= vtb_indication_font
vtb_debug_2.init_pos	= {0.0, 0.2, 0.0}
vtb_debug_2.alignment	= "CenterCenter"
vtb_debug_2.formats		= {"Ant EL %1.1f"}
vtb_debug_2.stringdefs	= vtb_font_size_default
vtb_debug_2.controllers = {{"txt_radar_antel"}}
Add_VTB_Element(vtb_debug_2)

local vtb_debug_3		= CreateElement "ceStringPoly"
vtb_debug_3.name		= "vtb_r_txt_trk_pitch"
vtb_debug_3.material	= vtb_indication_font
vtb_debug_3.init_pos	= {0.0, 0.0, 0.0}
vtb_debug_3.alignment	= "CenterCenter"
vtb_debug_3.formats		= {"AC Pitch + Ant EL %1.1f"}
vtb_debug_3.stringdefs	= vtb_font_size_default
vtb_debug_3.controllers = {{"txt_abh"}}
Add_VTB_Element(vtb_debug_3)

--]]

