-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.5 (04/17/2020) for DCS World 2.5.6.47224 (04/16/2020)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."VTH/"
dofile(my_path.."HUD_definitions.lua")

-- VTH Elements
local DBG_RED = MakeMaterial(nil, {255,0,0,50})

-- Heading Tape
tape_begin                      = CreateElement "ceMeshPoly"
tape_begin.name	                = "tape_begin"
tape_begin.vertices             = {{42,16},{-42,16},{-42,-16},{42,-16},}          -- {{60, 28},{-60,28},{-60,-28},{60,-28},}
tape_begin.indices              = {0,1,2 ; 0,2,3}
tape_begin.init_pos             = {0,21,0}                                        -- {0, 20, 0}
tape_begin.material             = DBG_RED
tape_begin.h_clip_relation      = h_clip_relations.INCREASE_IF_LEVEL
tape_begin.level                = HUD_DEFAULT_LEVEL
tape_begin.isvisible            = false
tape_begin.collimated           = true
tape_begin.z_enabled            = false
Add(tape_begin)

tape_hdg                        = create_hdg_textr_box(0, 2, 2880, 64, 165, nil)  -- ( 0, 0, 3721, 80, 165, nil)
tape_hdg.name                   = "tape_hdg"
tape_hdg.init_pos               = {0,21,0}                                        -- {0,32,0}
tape_hdg.h_clip_relation        = h_clip_relations.COMPARE
tape_hdg.level                  = HUD_DEFAULT_LEVEL + 1
tape_hdg.controllers            = {{"hud_hdg" ,-0.09}}                            -- {{"hud_hdg" ,-0.11775}} 
tape_hdg.isvisible              = true
tape_hdg.collimated             = true
tape_hdg.use_mipfilter          = true
tape_hdg.additive_alpha         = true --additive blending
Add(tape_hdg)

tape_end                        = CreateElement "ceMeshPoly"
tape_end.name                   = "tape_end"
tape_end.vertices               = tape_begin.vertices
tape_end.indices                = tape_begin.indices
tape_end.init_pos               = tape_begin.init_pos
tape_end.material               = tape_begin.material
tape_end.h_clip_relation        = h_clip_relations.DECREASE_IF_LEVEL
tape_end.level                  = HUD_DEFAULT_LEVEL + 1
tape_end.isvisible              = false
tape_end.collimated             = true
tape_end.z_enabled              = false
Add(tape_end)

local  hdg_ind                  = create_vth_textured_box(210, 76, 219, 107)      -- (210, 75, 218, 107)
hdg_ind.name                    = "hdg_ind"
hdg_ind.init_pos                = {0,6,0}                                         -- {0,15,0}
AddHUDElement(hdg_ind)

-- HUD Center
local Pitch_Ladder_center         = CreateElement "ceSimple"
Pitch_Ladder_center.name          = "Pitch_Ladder_center"
Pitch_Ladder_center.init_pos      = vth_base_init_pos
Pitch_Ladder_center.controllers   = {{"bound_by_circle", TFOV_radius * GetScale()}}
AddHUDElement(Pitch_Ladder_center)

-- Pitch Ladder
local  pl_p90_line                = create_vth_textured_box( 19, 592, 443, 622)   -- ( 10, 600, 440, 625)
pl_p90_line.name                  = "pl_p90_line"
pl_p90_line.init_pos              = {0,0,0}
pl_p90_line.parent_element        = Pitch_Ladder_center.name
pl_p90_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -90.0}}
AddHUDElement(pl_p90_line)

local  pl_p85_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p85_line.name                  = "pl_p85_line"
pl_p85_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p85_line.parent_element        = Pitch_Ladder_center.name
pl_p85_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -85.0}}
AddHUDElement(pl_p85_line)

local  pl_p80_line                = create_vth_textured_box( 19, 562, 443, 592)   -- ( 10, 570, 440, 595)
pl_p80_line.name                  = "pl_p80_line"
pl_p80_line.init_pos              = {0,0,0}
pl_p80_line.parent_element        = Pitch_Ladder_center.name
pl_p80_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -80.0}}
AddHUDElement(pl_p80_line)

local  pl_p75_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p75_line.name                  = "pl_p75_line"
pl_p75_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p75_line.parent_element        = Pitch_Ladder_center.name
pl_p75_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -75.0}}
AddHUDElement(pl_p75_line)

local  pl_p70_line                = create_vth_textured_box( 19, 532, 443, 562)   -- ( 10, 535, 440, 560)
pl_p70_line.name                  = "pl_p70_line"
pl_p70_line.init_pos              = {0,0,0}
pl_p70_line.parent_element        = Pitch_Ladder_center.name
pl_p70_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -70.0}}
AddHUDElement(pl_p70_line)

local  pl_p65_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p65_line.name                  = "pl_p65_line"
pl_p65_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p65_line.parent_element        = Pitch_Ladder_center.name
pl_p65_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -65.0}}
AddHUDElement(pl_p65_line)

local  pl_p60_line                = create_vth_textured_box( 19, 502, 443, 532)   -- ( 10, 505, 440, 530)
pl_p60_line.name                  = "pl_p60_line"
pl_p60_line.init_pos              = {0,0,0}
pl_p60_line.parent_element        = Pitch_Ladder_center.name
pl_p60_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -60.0}}
AddHUDElement(pl_p60_line)

local  pl_p55_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p55_line.name                  = "pl_p55_line"
pl_p55_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p55_line.parent_element        = Pitch_Ladder_center.name
pl_p55_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -55.0}}
AddHUDElement(pl_p55_line)

local  pl_p50_line                = create_vth_textured_box( 19, 472, 443, 502)   -- ( 10, 470, 440, 495)
pl_p50_line.name                  = "pl_p50_line"
pl_p50_line.init_pos              = {0,0,0}
pl_p50_line.parent_element        = Pitch_Ladder_center.name
pl_p50_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -50.0}}
AddHUDElement(pl_p50_line)

local  pl_p45_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p45_line.name                  = "pl_p45_line"
pl_p45_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p45_line.parent_element        = Pitch_Ladder_center.name
pl_p45_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -45.0}}
AddHUDElement(pl_p45_line)

local  pl_p40_line                = create_vth_textured_box( 19, 442, 443, 472)   -- ( 10, 440, 440, 465)
pl_p40_line.name                  = "pl_p40_line"
pl_p40_line.init_pos              = {0,0,0}
pl_p40_line.parent_element        = Pitch_Ladder_center.name
pl_p40_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -40.0}}
AddHUDElement(pl_p40_line)

local  pl_p35_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p35_line.name                  = "pl_p35_line"
pl_p35_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p35_line.parent_element        = Pitch_Ladder_center.name
pl_p35_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -35.0}}
AddHUDElement(pl_p35_line)

local  pl_p30_line                = create_vth_textured_box( 19, 412, 443, 442)   -- ( 10, 410, 440, 435)
pl_p30_line.name                  = "pl_p30_line"
pl_p30_line.init_pos              = {0,0,0}
pl_p30_line.parent_element        = Pitch_Ladder_center.name
pl_p30_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -30.0}}
AddHUDElement(pl_p30_line)

local  pl_p25_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p25_line.name                  = "pl_p25_line"
pl_p25_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p25_line.parent_element        = Pitch_Ladder_center.name
pl_p25_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -25.0}}
AddHUDElement(pl_p25_line)

local  pl_p20_line                = create_vth_textured_box( 19, 382, 443, 412)   -- ( 10, 380, 440, 405)
pl_p20_line.name                  = "pl_p20_line"
pl_p20_line.init_pos              = {0,0,0}
pl_p20_line.parent_element        = Pitch_Ladder_center.name
pl_p20_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -20.0}}
AddHUDElement(pl_p20_line)

local  pl_p15_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p15_line.name                  = "pl_p15_line"
pl_p15_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p15_line.parent_element        = Pitch_Ladder_center.name
pl_p15_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -15.0}}
AddHUDElement(pl_p15_line)

local  pl_p10_line                = create_vth_textured_box( 19, 352, 443, 382)   -- ( 10, 350, 440, 375)
pl_p10_line.name                  = "pl_p10_line"
pl_p10_line.init_pos              = {0,0,0}
pl_p10_line.parent_element        = Pitch_Ladder_center.name
pl_p10_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -10.0}}
AddHUDElement(pl_p10_line)

local  pl_p05_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p05_line.name                  = "pl_p05_line"
pl_p05_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p05_line.parent_element        = Pitch_Ladder_center.name
pl_p05_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", -5.0}}
AddHUDElement(pl_p05_line)

local  pl_hor_line                = create_vth_textured_box(0, 6, 1024, 12)       -- ( 0, 5, 2048, 12)
pl_hor_line.name                  = "pl_hor_line"
pl_hor_line.init_pos              = {0,0,0}
pl_hor_line.parent_element        = Pitch_Ladder_center.name
pl_hor_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev_horiz", 0.0}}
AddHUDElement(pl_hor_line)

local  pl_m05_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m05_line.name                  = "pl_m05_line"
pl_m05_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m05_line.parent_element        = Pitch_Ladder_center.name
pl_m05_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 5.0}}
AddHUDElement(pl_m05_line)

local  pl_m10_line                = create_vth_textured_box( 450, 352, 874, 382) -- ( 455, 345, 870, 375)
pl_m10_line.name                  = "pl_m10_line"
pl_m10_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m10_line.parent_element        = Pitch_Ladder_center.name
pl_m10_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 10.0}}
AddHUDElement(pl_m10_line)

local  pl_m15_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m15_line.name                  = "pl_m15_line"
pl_m15_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m15_line.parent_element        = Pitch_Ladder_center.name
pl_m15_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 15.0}}
AddHUDElement(pl_m15_line)

local  pl_m20_line                = create_vth_textured_box( 450, 382, 874, 412)  -- ( 455, 380, 870, 405)
pl_m20_line.name                  = "pl_m20_line"
pl_m20_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m20_line.parent_element        = Pitch_Ladder_center.name
pl_m20_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 20.0}}
AddHUDElement(pl_m20_line)

local  pl_m25_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m25_line.name                  = "pl_m25_line"
pl_m25_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m25_line.parent_element        = Pitch_Ladder_center.name
pl_m25_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 25.0}}
AddHUDElement(pl_m25_line)

local  pl_m30_line                = create_vth_textured_box( 450, 412, 874, 442)  -- ( 455, 410, 870, 435)
pl_m30_line.name                  = "pl_m30_line"
pl_m30_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m30_line.parent_element        = Pitch_Ladder_center.name
pl_m30_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 30.0}}
AddHUDElement(pl_m30_line)

local  pl_m35_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m35_line.name                  = "pl_m35_line"
pl_m35_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m35_line.parent_element        = Pitch_Ladder_center.name
pl_m35_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 35.0}}
AddHUDElement(pl_m35_line)

local  pl_m40_line                = create_vth_textured_box( 450, 442, 874, 472)  -- ( 455, 440, 870, 465)
pl_m40_line.name                  = "pl_m40_line"
pl_m40_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m40_line.parent_element        = Pitch_Ladder_center.name
pl_m40_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 40.0}}
AddHUDElement(pl_m40_line)

local  pl_m45_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m45_line.name                  = "pl_m45_line"
pl_m45_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m45_line.parent_element        = Pitch_Ladder_center.name
pl_m45_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 45.0}}
AddHUDElement(pl_m45_line)

local  pl_m50_line                = create_vth_textured_box( 450, 472, 874, 502)  -- ( 455, 470, 870, 495)
pl_m50_line.name                  = "pl_m50_line"
pl_m50_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m50_line.parent_element        = Pitch_Ladder_center.name
pl_m50_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 50.0}}
AddHUDElement(pl_m50_line)

local  pl_m55_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m55_line.name                  = "pl_m55_line"
pl_m55_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m55_line.parent_element        = Pitch_Ladder_center.name
pl_m55_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 55.0}}
AddHUDElement(pl_m55_line)

local  pl_m60_line                = create_vth_textured_box( 450, 502, 874, 532)  -- ( 455, 500, 870, 525)
pl_m60_line.name                  = "pl_m60_line"
pl_m60_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m60_line.parent_element        = Pitch_Ladder_center.name
pl_m60_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 60.0}}
AddHUDElement(pl_m60_line)

local  pl_m65_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m65_line.name                  = "pl_m65_line"
pl_m65_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m65_line.parent_element        = Pitch_Ladder_center.name
pl_m65_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 65.0}}
AddHUDElement(pl_m65_line)

local  pl_m70_line                = create_vth_textured_box( 450, 532, 874, 562)  -- ( 455, 530, 870, 555)
pl_m70_line.name                  = "pl_m70_line"
pl_m70_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m70_line.parent_element        = Pitch_Ladder_center.name
pl_m70_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 70.0}}
AddHUDElement(pl_m70_line)

local  pl_m75_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m75_line.name                  = "pl_m75_line"
pl_m75_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m75_line.parent_element        = Pitch_Ladder_center.name
pl_m75_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 75.0}}
AddHUDElement(pl_m75_line)

local  pl_m80_line                = create_vth_textured_box( 450, 562, 874, 592)  -- ( 455, 560, 870, 585)
pl_m80_line.name                  = "pl_m80_line"
pl_m80_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m80_line.parent_element        = Pitch_Ladder_center.name
pl_m80_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 80.0}}
AddHUDElement(pl_m80_line)

local  pl_m85_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m85_line.name                  = "pl_m85_line"
pl_m85_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m85_line.parent_element        = Pitch_Ladder_center.name
pl_m85_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 85.0}}
AddHUDElement(pl_m85_line)

local  pl_m90_line                = create_vth_textured_box( 450, 592, 874, 622)  -- ( 455, 595, 870, 621)
pl_m90_line.name                  = "pl_m90_line"
pl_m90_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m90_line.parent_element        = Pitch_Ladder_center.name
pl_m90_line.controllers           = {{"hud_roll" ,1.0}, {"hud_elev", 90.0}}
AddHUDElement(pl_m90_line)


-- NAV Mode Elements
local route_bearing               = create_vth_textured_box(805, 21, 833, 52)     -- ( 807, 22, 832,51)
route_bearing.name                = "route_bearing"
route_bearing.init_pos            = {0,6,0}                                       -- {0,15,0}
route_bearing.controllers         = {{"vis_alleg"}, {"route_bearing", 0.28}}      -- {{"vis_alleg"}, {"route_bearing", 0.555}}
AddHUDElement(route_bearing)

local AP_route_bearing            = create_vth_textured_box(845, 21, 873, 52)     -- ( 847, 22, 872,51)
AP_route_bearing.name             = "AP_route_bearing"
AP_route_bearing.init_pos         = {0,6,0}                                       -- {0,15,0}
AP_route_bearing.controllers      = {{"vis_alleg"}, {"AP_route_bearing", 0.28}}   -- {{"vis_alleg"}, {"AP_route_bearing", 0.555}}
AddHUDElement(AP_route_bearing)

local AP_route_bearing_val          = CreateElement "ceStringPoly"
AP_route_bearing_val.name           = "AP_route_bearing_val"
AP_route_bearing_val.material       = indication_font
AP_route_bearing_val.init_pos       = {0, -11, 0}                                  -- {0, -10, 0}
AP_route_bearing_val.alignment      = "CenterCenter"
AP_route_bearing_val.formats        = {"%03d"}
AP_route_bearing_val.stringdefs     = font_size_default                           -- {0.004,0.004}
AP_route_bearing_val.parent_element = AP_route_bearing.name
AP_route_bearing_val.controllers    = {{"vis_alleg"}, {"AP_route_bearing_val"}}
AddHUDElement(AP_route_bearing_val)

-- Optional Elements
-- Waterline
--[[
local Waterline                   = create_vth_textured_box(400, 800, 500, 850)   -- Blank Texture at this location
Waterline.name                    = "Waterline"
Waterline.init_pos                = {0,-23,0}
Waterline.controllers             = {{"vis_alleg"}}
AddHUDElement(Waterline)
--]]
-- Panne Messages
local vth_panne_2                 = create_vth_textured_box(0, 234, 149, 338)     -- ( 2, 235, 147, 336) -- => barres "rateau"
vth_panne_2.name                  = "vth_panne_2"
vth_panne_2.init_pos              = {0, -100, 0}
vth_panne_2.controllers           = {{"vis_vth_panne2"}}
AddHUDElement(vth_panne_2)


-- Alignment
--[[
local vth_align 		= create_vth_alignment_box( 12, 12, 1012, 1012)
vth_align.name 	      	= "vth_align"
vth_align.init_pos    	= {0,0,0}
vth_align.controllers 	= {{"vis_alleg"}}
AddHUDElement(vth_align)
--]]
