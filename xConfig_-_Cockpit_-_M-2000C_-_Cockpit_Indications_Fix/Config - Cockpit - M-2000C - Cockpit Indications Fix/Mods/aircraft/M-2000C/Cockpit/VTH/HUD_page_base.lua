-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.5 (04/17/2020) for DCS World 2.5.6.47224 (04/16/2020)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."VTH/"
dofile(my_path.."HUD_definitions.lua")

-- VTH Alignment Elements
local DBG_RED = MakeMaterial(nil, {255,0,0,50})

local VTH_center            = CreateElement "ceSimple"
VTH_center.name             = "VTH_center"
VTH_center.init_pos         = vth_base_init_pos
AddHUDElement(VTH_center)

-- VTH Elements

-- Heading Tape
tape_begin                        = CreateElement "ceMeshPoly"
tape_begin.name                   = "tape_begin"
tape_begin.vertices               = {{42,16},{-42,16},{-42,-16},{42,-16},}        -- { {60, 28}, { -60, 28}, { -60,-28}, {60,-28}, }
tape_begin.indices                = {0,1,2 ; 0,2,3}
tape_begin.init_pos               = {0, 133, 0}                                   -- {0, 130, 0}
tape_begin.material               = DBG_RED
tape_begin.h_clip_relation        = h_clip_relations.INCREASE_IF_LEVEL
tape_begin.level                  = HUD_DEFAULT_LEVEL
tape_begin.isvisible              = false
tape_begin.collimated             = true
tape_begin.z_enabled              = false
Add(tape_begin)

tape_hdg                          = create_hdg_textr_box(0, 2, 2880, 64, 165, nil) -- ( 0, 0, 3721, 80, 165, nil)
tape_hdg.name                     = "tape_hdg"
tape_hdg.init_pos                 = {0, 133, 0}                                   -- {0, 130, 0}
tape_hdg.h_clip_relation          = h_clip_relations.COMPARE
tape_hdg.level                    = HUD_DEFAULT_LEVEL + 1
tape_hdg.controllers              = {{"vis_alleg"}, {"hud_hdg", -0.09}}         -- {{"vis_alleg"}, {"hud_hdg" ,-0.1175}}
tape_hdg.isvisible                = true
tape_hdg.collimated               = true
tape_hdg.use_mipfilter            = true
tape_hdg.additive_alpha           = true --additive blending
Add(tape_hdg)

tape_end                          = CreateElement "ceMeshPoly"
tape_end.name                     = "tape_end"
tape_end.vertices                 = tape_begin.vertices
tape_end.indices                  = tape_begin.indices
tape_end.init_pos                 = tape_begin.init_pos
tape_end.material                 = tape_begin.material
tape_end.h_clip_relation          = h_clip_relations.DECREASE_IF_LEVEL
tape_end.level                    = HUD_DEFAULT_LEVEL + 1
tape_end.isvisible                = false
tape_end.collimated               = true
tape_end.z_enabled                = false
Add(tape_end)

local  hdg_ind                    = create_vth_textured_box(210, 76, 219, 107)    -- (210, 75, 218, 107)
hdg_ind.name                      = "hdg_ind"
hdg_ind.init_pos                  = {0, 118, 0}                                   -- {0, 110, 0}
hdg_ind.controllers               = {{"vis_alleg"}}
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
pl_p90_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -90.0}}
AddHUDElement(pl_p90_line)

local  pl_p85_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p85_line.name                  = "pl_p85_line"
pl_p85_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p85_line.parent_element        = Pitch_Ladder_center.name
pl_p85_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -85.0}}
AddHUDElement(pl_p85_line)

local  pl_p80_line                = create_vth_textured_box( 19, 562, 443, 592)   -- ( 10, 570, 440, 595)
pl_p80_line.name                  = "pl_p80_line"
pl_p80_line.init_pos              = {0,0,0}
pl_p80_line.parent_element        = Pitch_Ladder_center.name
pl_p80_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -80.0}}
AddHUDElement(pl_p80_line)

local  pl_p75_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p75_line.name                  = "pl_p75_line"
pl_p75_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p75_line.parent_element        = Pitch_Ladder_center.name
pl_p75_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -75.0}}
AddHUDElement(pl_p75_line)

local  pl_p70_line                = create_vth_textured_box( 19, 532, 443, 562)   -- ( 10, 535, 440, 560)
pl_p70_line.name                  = "pl_p70_line"
pl_p70_line.init_pos              = {0,0,0}
pl_p70_line.parent_element        = Pitch_Ladder_center.name
pl_p70_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -70.0}}
AddHUDElement(pl_p70_line)

local  pl_p65_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p65_line.name                  = "pl_p65_line"
pl_p65_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p65_line.parent_element        = Pitch_Ladder_center.name
pl_p65_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -65.0}}
AddHUDElement(pl_p65_line)

local  pl_p60_line                = create_vth_textured_box( 19, 502, 443, 532)   -- ( 10, 505, 440, 530)
pl_p60_line.name                  = "pl_p60_line"
pl_p60_line.init_pos              = {0,0,0}
pl_p60_line.parent_element        = Pitch_Ladder_center.name
pl_p60_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -60.0}}
AddHUDElement(pl_p60_line)

local  pl_p55_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p55_line.name                  = "pl_p55_line"
pl_p55_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p55_line.parent_element        = Pitch_Ladder_center.name
pl_p55_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -55.0}}
AddHUDElement(pl_p55_line)

local  pl_p50_line                = create_vth_textured_box( 19, 472, 443, 502)   -- ( 10, 470, 440, 495)
pl_p50_line.name                  = "pl_p50_line"
pl_p50_line.init_pos              = {0,0,0}
pl_p50_line.parent_element        = Pitch_Ladder_center.name
pl_p50_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -50.0}}
AddHUDElement(pl_p50_line)

local  pl_p45_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p45_line.name                  = "pl_p45_line"
pl_p45_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p45_line.parent_element        = Pitch_Ladder_center.name
pl_p45_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -45.0}}
AddHUDElement(pl_p45_line)

local  pl_p40_line                = create_vth_textured_box( 19, 442, 443, 472)   -- ( 10, 440, 440, 465)
pl_p40_line.name                  = "pl_p40_line"
pl_p40_line.init_pos              = {0,0,0}
pl_p40_line.parent_element        = Pitch_Ladder_center.name
pl_p40_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -40.0}}
AddHUDElement(pl_p40_line)

local  pl_p35_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p35_line.name                  = "pl_p35_line"
pl_p35_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p35_line.parent_element        = Pitch_Ladder_center.name
pl_p35_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -35.0}}
AddHUDElement(pl_p35_line)

local  pl_p30_line                = create_vth_textured_box( 19, 412, 443, 442)   -- ( 10, 410, 440, 435)
pl_p30_line.name                  = "pl_p30_line"
pl_p30_line.init_pos              = {0,0,0}
pl_p30_line.parent_element        = Pitch_Ladder_center.name
pl_p30_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -30.0}}
AddHUDElement(pl_p30_line)

local  pl_p25_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p25_line.name                  = "pl_p25_line"
pl_p25_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p25_line.parent_element        = Pitch_Ladder_center.name
pl_p25_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -25.0}}
AddHUDElement(pl_p25_line)

local  pl_p20_line                = create_vth_textured_box( 19, 382, 443, 412)   -- ( 10, 380, 440, 405)
pl_p20_line.name                  = "pl_p20_line"
pl_p20_line.init_pos              = {0,0,0}
pl_p20_line.parent_element        = Pitch_Ladder_center.name
pl_p20_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -20.0}}
AddHUDElement(pl_p20_line)

local  pl_p15_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p15_line.name                  = "pl_p15_line"
pl_p15_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p15_line.parent_element        = Pitch_Ladder_center.name
pl_p15_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -15.0}}
AddHUDElement(pl_p15_line)

local  pl_p10_line                = create_vth_textured_box( 19, 352, 443, 382)   -- ( 10, 350, 440, 375)
pl_p10_line.name                  = "pl_p10_line"
pl_p10_line.init_pos              = {0,0,0}
pl_p10_line.parent_element        = Pitch_Ladder_center.name
pl_p10_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -10.0}}
AddHUDElement(pl_p10_line)

local  pl_p05_line                = create_vth_textured_box( 13, 24, 354, 38)     -- ( 8, 25, 352, 38)
pl_p05_line.name                  = "pl_p05_line"
pl_p05_line.init_pos              = {0,0,0}                                       -- {0, -2, 0}
pl_p05_line.parent_element        = Pitch_Ladder_center.name
pl_p05_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", -5.0}}
AddHUDElement(pl_p05_line)

local  pl_hor_line                = create_vth_textured_box(0, 6, 1024, 12)       -- ( 0, 5, 2048, 12)
pl_hor_line.name                  = "pl_hor_line"
pl_hor_line.init_pos              = {0,0,0}
pl_hor_line.parent_element        = Pitch_Ladder_center.name
pl_hor_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev_horiz", 0.0}}
AddHUDElement(pl_hor_line)

local  pl_m05_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m05_line.name                  = "pl_m05_line"
pl_m05_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m05_line.parent_element        = Pitch_Ladder_center.name
pl_m05_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 5.0}}
AddHUDElement(pl_m05_line)

local  pl_m10_line                = create_vth_textured_box( 450, 352, 874, 382) -- ( 455, 345, 870, 375)
pl_m10_line.name                  = "pl_m10_line"
pl_m10_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m10_line.parent_element        = Pitch_Ladder_center.name
pl_m10_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 10.0}}
AddHUDElement(pl_m10_line)

local  pl_m15_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m15_line.name                  = "pl_m15_line"
pl_m15_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m15_line.parent_element        = Pitch_Ladder_center.name
pl_m15_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 15.0}}
AddHUDElement(pl_m15_line)

local  pl_m20_line                = create_vth_textured_box( 450, 382, 874, 412)  -- ( 455, 380, 870, 405)
pl_m20_line.name                  = "pl_m20_line"
pl_m20_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m20_line.parent_element        = Pitch_Ladder_center.name
pl_m20_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 20.0}}
AddHUDElement(pl_m20_line)

local  pl_m25_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m25_line.name                  = "pl_m25_line"
pl_m25_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m25_line.parent_element        = Pitch_Ladder_center.name
pl_m25_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 25.0}}
AddHUDElement(pl_m25_line)

local  pl_m30_line                = create_vth_textured_box( 450, 412, 874, 442)  -- ( 455, 410, 870, 435)
pl_m30_line.name                  = "pl_m30_line"
pl_m30_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m30_line.parent_element        = Pitch_Ladder_center.name
pl_m30_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 30.0}}
AddHUDElement(pl_m30_line)

local  pl_m35_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m35_line.name                  = "pl_m35_line"
pl_m35_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m35_line.parent_element        = Pitch_Ladder_center.name
pl_m35_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 35.0}}
AddHUDElement(pl_m35_line)

local  pl_m40_line                = create_vth_textured_box( 450, 442, 874, 472)  -- ( 455, 440, 870, 465)
pl_m40_line.name                  = "pl_m40_line"
pl_m40_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m40_line.parent_element        = Pitch_Ladder_center.name
pl_m40_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 40.0}}
AddHUDElement(pl_m40_line)

local  pl_m45_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m45_line.name                  = "pl_m45_line"
pl_m45_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m45_line.parent_element        = Pitch_Ladder_center.name
pl_m45_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 45.0}}
AddHUDElement(pl_m45_line)

local  pl_m50_line                = create_vth_textured_box( 450, 472, 874, 502)  -- ( 455, 470, 870, 495)
pl_m50_line.name                  = "pl_m50_line"
pl_m50_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m50_line.parent_element        = Pitch_Ladder_center.name
pl_m50_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 50.0}}
AddHUDElement(pl_m50_line)

local  pl_m55_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m55_line.name                  = "pl_m55_line"
pl_m55_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m55_line.parent_element        = Pitch_Ladder_center.name
pl_m55_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 55.0}}
AddHUDElement(pl_m55_line)

local  pl_m60_line                = create_vth_textured_box( 450, 502, 874, 532)  -- ( 455, 500, 870, 525)
pl_m60_line.name                  = "pl_m60_line"
pl_m60_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m60_line.parent_element        = Pitch_Ladder_center.name
pl_m60_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 60.0}}
AddHUDElement(pl_m60_line)

local  pl_m65_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m65_line.name                  = "pl_m65_line"
pl_m65_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m65_line.parent_element        = Pitch_Ladder_center.name
pl_m65_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 65.0}}
AddHUDElement(pl_m65_line)

local  pl_m70_line                = create_vth_textured_box( 450, 532, 874, 562)  -- ( 455, 530, 870, 555)
pl_m70_line.name                  = "pl_m70_line"
pl_m70_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m70_line.parent_element        = Pitch_Ladder_center.name
pl_m70_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 70.0}}
AddHUDElement(pl_m70_line)

local  pl_m75_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m75_line.name                  = "pl_m75_line"
pl_m75_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m75_line.parent_element        = Pitch_Ladder_center.name
pl_m75_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 75.0}}
AddHUDElement(pl_m75_line)

local  pl_m80_line                = create_vth_textured_box( 450, 562, 874, 592)  -- ( 455, 560, 870, 585)
pl_m80_line.name                  = "pl_m80_line"
pl_m80_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m80_line.parent_element        = Pitch_Ladder_center.name
pl_m80_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 80.0}}
AddHUDElement(pl_m80_line)

local  pl_m85_line                = create_vth_textured_box( 13, 45, 354, 60)     -- ( 8, 44, 352, 62)
pl_m85_line.name                  = "pl_m85_line"
pl_m85_line.init_pos              = {0,0,0}                                       -- {0, -3, 0}
pl_m85_line.parent_element        = Pitch_Ladder_center.name
pl_m85_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 85.0}}
AddHUDElement(pl_m85_line)

local  pl_m90_line                = create_vth_textured_box( 450, 592, 874, 622)  -- ( 455, 595, 870, 621)
pl_m90_line.name                  = "pl_m90_line"
pl_m90_line.init_pos              = {0,0,0}                                       -- {0, -4, 0}
pl_m90_line.parent_element        = Pitch_Ladder_center.name
pl_m90_line.controllers           = {{"vis_alleg"}, {"hud_roll" ,1.0}, {"hud_elev", 90.0}}
AddHUDElement(pl_m90_line)


-- FPM
local  vth_fpm                    = create_vth_textured_box(358, 18, 468, 66)     -- ( 360, 20, 467, 65)
vth_fpm.name                      = "vth_fpm"
vth_fpm.init_pos                  = {0,1.5,0}
vth_fpm.parent_element            = VTH_center.name
vth_fpm.controllers               = {{"hud_fpm"}, {"hud_svz", 0.6}, {"hud_svy", 0.6}}
AddHUDElement(vth_fpm)

local Accel_Z                     = create_vth_textured_box(478, 21, 794, 51)     -- ( 480, 20,795, 50)
Accel_Z.name                      = "Accel_Z"
Accel_Z.init_pos                  = {0,0,0}
Accel_Z.parent_element            = vth_fpm.name
Accel_Z.controllers               = {{"vis_alleg"}, {"hud_acc_z", 2.0}}
AddHUDElement(Accel_Z)

-- NAV
local wp_SpeedGuide               = create_vth_textured_box(235, 70, 505, 129)    -- ( 236, 72, 511, 130)
wp_SpeedGuide.name                = "wp_SpeedGuide"
wp_SpeedGuide.init_pos            = {0.0, 0.0, 0.0}
wp_SpeedGuide.parent_element      = Accel_Z.name
wp_SpeedGuide.controllers         = {{"wp_SpeedGuide", 0.8}}
AddHUDElement(wp_SpeedGuide)

local wp_RouteGuide               = create_vth_textured_box(886, 82, 967, 151)    -- ( 886, 82, 967, 152)
wp_RouteGuide.name                = "wp_RouteGuide"
wp_RouteGuide.init_pos            = {0.0, 0.0, 0.0}
wp_RouteGuide.parent_element      = vth_fpm.name
wp_RouteGuide.controllers         = {{"wp_RouteGuide", 0.6}}
AddHUDElement(wp_RouteGuide)

local wp_trackerror_to            = create_vth_textured_box(881, 17, 917, 61, nil, 59) -- ( 883, 19, 916, 60, nil, 60)
wp_trackerror_to.name             = "wp_trackerror_to"
wp_trackerror_to.init_pos         = {0.0,0,0}
wp_trackerror_to.parent_element   = vth_fpm.name
wp_trackerror_to.controllers      = {{"hud_roll" ,1.0}, {"wp_trk_err_t", 0.6}}
AddHUDElement(wp_trackerror_to)

local wp_trackerror_frm           = create_vth_textured_box(922, 20, 958, 65, nil, 21)  -- ( 925, 23, 957, 64)
wp_trackerror_frm.name            = "wp_trackerror_frm"
wp_trackerror_frm.init_pos        = {0,0,0}                                      -- {0,-10.0,0}
wp_trackerror_frm.parent_element  = vth_fpm.name
wp_trackerror_frm.controllers     = {{"hud_roll" ,1.0}, {"wp_trk_err_f", 0.6}}
AddHUDElement(wp_trackerror_frm)

local BUT_reticule                =  create_vth_textured_box(525, 57, 582, 113)   -- (526, 58, 581, 112)
BUT_reticule.name                 = "BUT_reticule"
BUT_reticule.init_pos             = {0,0,0}
BUT_reticule.parent_element       = VTH_center.name
BUT_reticule.controllers          = {{"wp_but_reticle"}}
AddHUDElement(BUT_reticule)

local route_bearing               = create_vth_textured_box(805, 21, 833, 52)     -- ( 807, 22, 832,51)
route_bearing.name                = "route_bearing"
route_bearing.init_pos            = {0,118,0}                                     -- {0,110,0}
route_bearing.controllers         = {{"vis_alleg"}, {"route_bearing", 0.28}}      -- {{"vis_alleg"}, {"route_bearing", 0.555}}
AddHUDElement(route_bearing)

local AP_route_bearing            = create_vth_textured_box(845, 21, 873, 52)     -- ( 847, 22, 872,51)
AP_route_bearing.name             = "AP_route_bearing"
AP_route_bearing.init_pos         = {0,118,0}                                     -- {0,110,0}
AP_route_bearing.controllers      = {{"vis_alleg"}, {"AP_route_bearing", 0.28}}   -- {{"vis_alleg"}, {"AP_route_bearing", 0.555}}
AddHUDElement(AP_route_bearing) 

local AP_route_bearing_val          = CreateElement "ceStringPoly"
AP_route_bearing_val.name           = "AP_route_bearing_val"
AP_route_bearing_val.material       = indication_font
AP_route_bearing_val.init_pos       = {0, -11, 0}                                -- {0, -10, 0}
AP_route_bearing_val.alignment      = "CenterCenter"
AP_route_bearing_val.formats        = {"%03d"}
AP_route_bearing_val.stringdefs     = font_size_default                           -- {0.004,0.004}
AP_route_bearing_val.parent_element = AP_route_bearing.name
AP_route_bearing_val.controllers    = {{"vis_alleg"}, {"AP_route_bearing_val"}}
AddHUDElement(AP_route_bearing_val)

local AP_fpm                      = CreateElement "ceStringPoly"
AP_fpm.name                       = "AP_fpm"
AP_fpm.material                   = indication_font_light                         -- indication_font
AP_fpm.init_pos                   = {0,0,0}
AP_fpm.parent_element             = vth_fpm.name
AP_fpm.alignment                  = "CenterCenter"
AP_fpm.value                      = "*"
AP_fpm.stringdefs                 = font_size_large                               -- {0.007,0.007}
AP_fpm.controllers                = {{"vis_alleg"}, {"AP_fpm", 0.6}}
AddHUDElement(AP_fpm)

-- INS Radar Update
local UNI_rdr_update_ret          = create_vth_textured_box(456, 239, 501, 297)   -- ( 731, 63, 772, 116)
UNI_rdr_update_ret.name           = "UNI_rdr_update_ret"
UNI_rdr_update_ret.init_pos       = {0,94.0,0}                                       -- {0,0,0}
UNI_rdr_update_ret.parent_element = VTH_center.name
UNI_rdr_update_ret.controllers    = {{"hud_roll" , 1.0}, {"uni_rdr_obl_ret", 5.0}}
AddHUDElement(UNI_rdr_update_ret)

local UNI_rdr_update_val          = CreateElement "ceStringPoly"
UNI_rdr_update_val.name           = "UNI_rdr_update_val"
UNI_rdr_update_val.material       = indication_font
UNI_rdr_update_val.init_pos       = {120.0, 20.0, 0.0}                             -- {104.5, -8.0, 0.0}
UNI_rdr_update_val.alignment      = "RightTop"
UNI_rdr_update_val.formats        = {"%1.1f KM"}
UNI_rdr_update_val.stringdefs     = font_size_default                              -- {0.006,0.006}
UNI_rdr_update_val.controllers    = {{"uni_rdr_obl_val"}}
AddHUDElement(UNI_rdr_update_val)

local UNI_rdr_update_nul          = CreateElement "ceStringPoly"
UNI_rdr_update_nul.name           = "UNI_rdr_update_nul"
UNI_rdr_update_nul.material       = indication_font
UNI_rdr_update_nul.init_pos       = {120.0, 20.0, 0.0}                            -- {104.5, -8.0, 0.0}
UNI_rdr_update_nul.alignment      = "RightTop"
UNI_rdr_update_nul.value          = "**** KM"
UNI_rdr_update_nul.stringdefs     = font_size_default                             -- {0.006,0.006}
UNI_rdr_update_nul.controllers    = {{"uni_rdr_obl_nul"}}
AddHUDElement(UNI_rdr_update_nul)

-- RADAR
local rdr_rng_bar                 = create_vth_textured_box(890, 305, 917, 619)   -- ( 890, 340, 932, 550)
rdr_rng_bar.name                  = "rdr_rng_bar"
rdr_rng_bar.init_pos              = {90, -38, 0}                                  -- {90, -65, 0}
rdr_rng_bar.controllers           = {{"vis_radar_tgt"}}
AddHUDElement(rdr_rng_bar)

local rdr_elevation_bar           = create_vth_textured_box(103, 1009, 753, 1015)  -- ( 104, 1010, 752, 1015)
rdr_elevation_bar.name            = "rdr_elevation_bar"
rdr_elevation_bar.init_pos        = {0, 0, 0}
rdr_elevation_bar.parent_element  = Pitch_Ladder_center.name
rdr_elevation_bar.controllers     = {{"hud_roll" ,1.0}, {"vis_radar_elevation_bar", 0.0}}
AddHUDElement(rdr_elevation_bar)

local rdr_aam_rmax                = create_vth_textured_box(920, 599, 950, 605)   -- ( 900, 557, 932, 564)
rdr_aam_rmax.name                 = "rdr_aam_rmax"
rdr_aam_rmax.init_pos             = {-6.5, 54.0, 0}                               -- {-5.0, 36.0, 0}
rdr_aam_rmax.controllers          = {{"aam_rmax"}}
rdr_aam_rmax.parent_element       = rdr_rng_bar.name
AddHUDElement(rdr_aam_rmax)

local rdr_aam_rnez                = create_vth_textured_box(920, 611, 950, 619)   -- ( 428, 46, 467, 49)
rdr_aam_rnez.name                 = "rdr_aam_rnez"
rdr_aam_rnez.init_pos             = {-6.5, 54.0, 0}                               -- {-6.0, 36.0, 0}
rdr_aam_rnez.controllers          = {{"aam_rnez"}}
rdr_aam_rnez.parent_element       = rdr_rng_bar.name
AddHUDElement(rdr_aam_rnez)

local rdr_aam_rmin                = create_vth_textured_box(920, 599, 950, 605)   -- ( 900, 557, 932, 564)
rdr_aam_rmin.name                 = "rdr_aam_rmin"
rdr_aam_rmin.init_pos             = {-6.5, 54.0, 0}                               -- {-5.0, 36.0, 0}
rdr_aam_rmin.controllers          = {{"aam_rmin"}}
rdr_aam_rmin.parent_element       = rdr_rng_bar.name
AddHUDElement(rdr_aam_rmin)

local rdr_tgtrng                  = create_vth_textured_box(933, 564, 950, 594)   -- ( 988, 74, 1019, 110)
rdr_tgtrng.name                   = "rdr_tgtrng"
rdr_tgtrng.init_pos               = {2.0, 54.0, 0}                                -- {3.0, 36.0, 0}
rdr_tgtrng.controllers            = {{"radar_tgt_rng", 1}}
rdr_tgtrng.parent_element         = rdr_rng_bar.name
AddHUDElement(rdr_tgtrng)

local txt_rdr_tgtrng              = CreateElement "ceStringPoly"
txt_rdr_tgtrng.name               = "txt_rdr_tgtrng"
txt_rdr_tgtrng.material           = indication_font
txt_rdr_tgtrng.init_pos           = {4.0, 0.0}                                    -- {4.0, 0, 0}
txt_rdr_tgtrng.alignment          = "LeftCenter"
txt_rdr_tgtrng.formats            = {"%1.f"}
txt_rdr_tgtrng.stringdefs         = font_size_default                             -- {0.006,0.006}
txt_rdr_tgtrng.controllers        = {{"txt_rdr_tgt_rng_10nm"}}
txt_rdr_tgtrng.parent_element     = rdr_tgtrng.name
AddHUDElement(txt_rdr_tgtrng)

local txt_rdr_tgtrng2             = CreateElement "ceStringPoly"
txt_rdr_tgtrng2.name              = "txt_rdr_tgtrng2"
txt_rdr_tgtrng2.material          = indication_font
txt_rdr_tgtrng2.init_pos          = {4.0, 0.0}                                    -- {4.0, 0, 0}
txt_rdr_tgtrng2.alignment         = "LeftCenter"
txt_rdr_tgtrng2.formats           = {"%1.1f"}
txt_rdr_tgtrng2.stringdefs        = font_size_default                             -- {0.006,0.006}
txt_rdr_tgtrng2.controllers       = {{"txt_rdr_tgt_rng_01nm",0}}
txt_rdr_tgtrng2.parent_element    = rdr_tgtrng.name
AddHUDElement(txt_rdr_tgtrng2)

--Radar Target Data
local txt_rdr_tgtcvel             = CreateElement "ceStringPoly"
txt_rdr_tgtcvel.name              = "txt_rdr_tgtcvel"
txt_rdr_tgtcvel.material          = indication_font
txt_rdr_tgtcvel.init_pos          = {79, 15, 0}                                   -- {78, -25, 0}
txt_rdr_tgtcvel.alignment         = "RightCenter"
txt_rdr_tgtcvel.formats           = {"%01.f"}
txt_rdr_tgtcvel.stringdefs        = font_size_default                             -- {0.006,0.006}
txt_rdr_tgtcvel.controllers       = {{"vis_radar_tgt"}, {"radar_tgt_cvel"}}
AddHUDElement(txt_rdr_tgtcvel)

local rdr_tgtcvel_box             = create_vth_textured_box(290, 232, 400, 283)   -- (290, 230, 400, 285)
rdr_tgtcvel_box.name              = "rdr_tgtcvel_box"
rdr_tgtcvel_box.init_pos          = {65, 15.5, 0}                                 -- {63, -25, 0}
rdr_tgtcvel_box.controllers       = {{"vis_radar_tgt"}}
AddHUDElement(rdr_tgtcvel_box)

local rdr_tgtbox                  = create_vth_textured_box(886, 76, 968, 158)    -- ( 887, 77, 967, 157)
rdr_tgtbox.name                   = "rdr_tgtbox"
rdr_tgtbox.init_pos               = {0, 0, 0}
rdr_tgtbox.parent_element         = VTH_center.name
rdr_tgtbox.controllers            = {{"vis_radar_tgt"}, {"radar_tgt_box", 0.87}}
AddHUDElement(rdr_tgtbox)

local rdr_tgtbox_oob              = create_vth_textured_box(886, 162, 968, 244)   -- ( 887, 163, 967, 243)
rdr_tgtbox_oob.name               = "rdr_tgtbox_oob"
rdr_tgtbox_oob.init_pos           = {0, 0, 0}
rdr_tgtbox_oob.parent_element     = VTH_center.name
rdr_tgtbox_oob.controllers        = {{"vis_radar_tgt"}, {"radar_tgt_box", 0.87}, {"bound_by_circle", RFOV_radius * GetScale()}} 
AddHUDElement(rdr_tgtbox_oob)

local rdr_tgt_iff_status          = CreateElement "ceStringPoly"
rdr_tgt_iff_status.name           = "rdr_tgt_iff_status"
rdr_tgt_iff_status.material       = indication_font
rdr_tgt_iff_status.init_pos       = {4.0, 0, 0}
rdr_tgt_iff_status.alignment      = "CenterCenter"
rdr_tgt_iff_status.formats        = {"%s"}
rdr_tgt_iff_status.stringdefs     = font_size_default                             -- {0.006,0.006}
rdr_tgt_iff_status.parent_element = rdr_tgtbox.name
rdr_tgt_iff_status.controllers    = {{"radar_tgt_iff_status"}}
AddHUDElement(rdr_tgt_iff_status)

local txt_tgt_b_angle             = CreateElement "ceStringPoly"
txt_tgt_b_angle.name              = "txt_tgt_b_angle"
txt_tgt_b_angle.material          = indication_font
txt_tgt_b_angle.init_pos          = {1.0, -36.0, 0.0}                             -- {0.0, -65.0, 0.0}
txt_tgt_b_angle.alignment         = "CenterCenter"
txt_tgt_b_angle.formats           = {"%1.f"}
txt_tgt_b_angle.stringdefs        = font_size_default                             -- {0.006,0.006}
txt_tgt_b_angle.controllers       = {{"radar_tgt_b_angle"}}
AddHUDElement(txt_tgt_b_angle)

local air_intercept_ring          = create_vth_textured_box(31, 660, 172, 800)    -- ( 15, 627, 189, 802)
air_intercept_ring.name           = "air_intercept_ring"
air_intercept_ring.init_pos       = {0, -5, 0}                                    -- {0, 0, 0}
air_intercept_ring.controllers    = {{"radar_tgt_od"}}
AddHUDElement(air_intercept_ring)

local AAM_Tracking_Guide          = create_vth_textured_box(813, 952, 838, 975)   -- ( 813, 952, 838, 976)
AAM_Tracking_Guide.name           = "AAM_Tracking_Guide"
AAM_Tracking_Guide.init_pos       = {0, 0, 0}
AAM_Tracking_Guide.parent_element = VTH_center.name
AAM_Tracking_Guide.controllers    = {{"radar_tgt_od_cue"}, {"bound_by_circle", TFOV_radius * GetScale()}}
AddHUDElement(AAM_Tracking_Guide)

-- MAGIC II
local Magic_Lock              = create_vth_textured_box(18, 942, 93, 1017)        -- (19, 943, 92, 1017)
Magic_Lock.name               = "Magic_Lock"
Magic_Lock.init_pos           = {0, 0, 0}
Magic_Lock.parent_element     = VTH_center.name
Magic_Lock.controllers        = {{"vis_magic_l", 0.6}}
AddHUDElement(Magic_Lock)

local	Magic_Lock_OOB					= create_vth_textured_box(282, 828, 359, 904)       -- (282, 828, 358, 902)
Magic_Lock_OOB.name				    = "Magic_Lock_OOB"
Magic_Lock_OOB.init_pos			  = {0, 0, 0}
Magic_Lock_OOB.parent_element	= VTH_center.name
Magic_Lock_OOB.controllers		= {{"vis_magic_l", 0.6}, {"bound_by_circle", RFOV_radius * GetScale()}}
AddHUDElement(Magic_Lock_OOB)

local Magic_Slave             = create_vth_textured_box(43, 833, 147, 929)        -- (36, 822, 156, 928)
Magic_Slave.name              = "Magic_Slave"
Magic_Slave.init_pos          = {0, 0, 0}
Magic_Slave.parent_element    = VTH_center.name
Magic_Slave.controllers       = {{"vis_magic_r", 0.6}}
AddHUDElement(Magic_Slave)

local	Magic_Slave_OOB					= create_vth_textured_box(171, 833, 275, 929)       -- (162, 822, 252, 928)
Magic_Slave_OOB.name			    = "Magic_Slave_OOB"
Magic_Slave_OOB.init_pos		  = {0, 0, 0}
Magic_Slave_OOB.parent_element	= VTH_center.name
Magic_Slave_OOB.controllers		= {{"vis_magic_r", 0.6}, {"bound_by_circle", RFOV_radius * GetScale()}}
AddHUDElement(Magic_Slave_OOB)

-- MAV
local	Magic_MAV					      = create_vth_textured_box(418, 944, 460, 982)       -- (627, 70, 670, 105)
Magic_MAV.name				        = "Magic_MAV"
Magic_MAV.init_pos			      = {0, 0, 0}
Magic_MAV.parent_element	    = VTH_center.name
Magic_MAV.controllers		      = {{"vis_magic_mav", 0.6}}
AddHUDElement(Magic_MAV)

local	AA_MAV_Icon_VScan				= create_vth_textured_box(410, 225, 426, 261)       -- ( 410, 236, 425, 258)
AA_MAV_Icon_VScan.name			  = "AA_MAV_Icon_VScan"
AA_MAV_Icon_VScan.init_pos		= {-83, 15.5, 0}                                    -- {-85, -4, 0}
AA_MAV_Icon_VScan.controllers	= {{"aa_cam_icon_vscan"}}
AddHUDElement(AA_MAV_Icon_VScan)

local	AA_MAV_Icon_HScan				= create_vth_textured_box(403, 262, 439, 276)       -- ( 405, 261, 430, 276)
AA_MAV_Icon_HScan.name			  = "AA_MAV_Icon_HScan"
AA_MAV_Icon_HScan.init_pos		= {-83, 15.5, 0}                                    -- {-85, -4, 0}
AA_MAV_Icon_HScan.controllers	= {{"aa_cam_icon_hscan"}}
AddHUDElement(AA_MAV_Icon_HScan)

local	AA_MAV_VNSUL				    = create_vth_textured_box(362, 637, 445, 720)     -- ( 360, 634, 442, 716)
AA_MAV_VNSUL.name			        = "AA_MAV_VNSUL"
AA_MAV_VNSUL.init_pos		      = {0.0, 0.0, 0}
AA_MAV_VNSUL.controllers	    = {{"aam_MAG_MAV", -2.5, 2.5, 0.6}}
AA_MAV_VNSUL.parent_element	  = VTH_center.name
AddHUDElement(AA_MAV_VNSUL)

local	AA_MAV_VNSUR				    = create_vth_textured_box(445, 637, 531, 720)     -- ( 449, 634, 531, 716)
AA_MAV_VNSUR.name			        = "AA_MAV_VNSUR"
AA_MAV_VNSUR.init_pos		      = {0.0, 0.0, 0}
AA_MAV_VNSUR.controllers	    = {{"aam_MAG_MAV", 2.5, 2.5, 0.6}}
AA_MAV_VNSUR.parent_element	  = VTH_center.name
AddHUDElement(AA_MAV_VNSUR)

local	AA_MAV_VNSDL				    = create_vth_textured_box(362, 720, 445, 803)     --( 360, 725, 442, 807)
AA_MAV_VNSDL.name			        = "AA_MAV_VNSDL"
AA_MAV_VNSDL.init_pos		      = vth_base_init_pos
AA_MAV_VNSDL.controllers	    = {{"aam_MAG_MAV", -2.5, -2.0, 0.6}}
AddHUDElement(AA_MAV_VNSDL)

local	AA_MAV_VNSDR				    = create_vth_textured_box(445, 720, 531, 803)     -- ( 449, 725, 531, 807)
AA_MAV_VNSDR.name			        = "AA_MAV_VNSDR"
AA_MAV_VNSDR.init_pos		      = vth_base_init_pos
AA_MAV_VNSDR.controllers	    = {{"aam_MAG_MAV", 2.5, -2.0, 0.6}}
AddHUDElement(AA_MAV_VNSDR)

-- Auxiliary Gunsight
local Hausse_manuelle             = create_vth_textured_box(100, 936, 342, 990)   -- ( 100, 936, 343, 990)
Hausse_manuelle.name              = "Hausse_manuelle"
Hausse_manuelle.init_pos          = {0, 0, 0}
Hausse_manuelle.parent_element    = VTH_center.name
Hausse_manuelle.controllers       = {{"vth_aux_gunsight", 0.6}}
AddHUDElement(Hausse_manuelle)

local Hausse_manuelle_txt         = CreateElement "ceStringPoly"
Hausse_manuelle_txt.name          = "Hausse_manuelle_txt"
Hausse_manuelle_txt.material      = indication_font
Hausse_manuelle_txt.init_pos      = {45, 11, 0}                                   -- {25, 10, 0}
Hausse_manuelle_txt.alignment     = "RightCenter"                                 -- "LeftCenter"
Hausse_manuelle_txt.formats       = {"%1.f"}
Hausse_manuelle_txt.stringdefs    = font_size_default                             -- {0.006,0.006}
Hausse_manuelle_txt.controllers   = {{"vth_aux_gunsight_decl"}}
Hausse_manuelle_txt.parent_element = Hausse_manuelle.name
AddHUDElement(Hausse_manuelle_txt)

-- HUD Warnings
local vth_panne_TNV               = create_vth_textured_box(0, 234, 149, 338)     -- ( 2, 235, 147, 336) -- => barres "rateau"
vth_panne_TNV.name                = "vth_panne_TNV"
vth_panne_TNV.init_pos            = {0, -90, 0}                                   -- {0, -100, 0}
vth_panne_TNV.controllers         = {{"vis_vth_panne2"}}
AddHUDElement(vth_panne_TNV)

local vth_low_alt_warn            = create_vth_textured_box(6, 112, 89, 228)      -- ( 15, 114, 92, 227) -- => fleche haut
vth_low_alt_warn.name             = "vth_low_alt_warn"
vth_low_alt_warn.init_pos         = {0, 0, 0}                                     -- {0, 0, 0}
vth_low_alt_warn.controllers      = {{"vth_low_alt_warn"}}
AddHUDElement(vth_low_alt_warn)

local vth_hor_sec_warn            = CreateElement "ceStringPoly"
vth_hor_sec_warn.name             = "vth_hor_sec_warn"
vth_hor_sec_warn.material         = indication_font_light                         -- indication_font
vth_hor_sec_warn.init_pos         = {0, -50, 0}                                   -- {0, -90, 0}
vth_hor_sec_warn.alignment        = "CenterCenter"
vth_hor_sec_warn.formats          = {"%s\n%s"}
vth_hor_sec_warn.stringdefs       = font_size_large                               -- {0.007,0.007}
vth_hor_sec_warn.controllers      = {{"vth_hor_sec_warn"}}
AddHUDElement(vth_hor_sec_warn)

local vth_ag_radar_off            = CreateElement "ceStringPoly"
vth_ag_radar_off.name             = "vth_ag_radar_off"
vth_ag_radar_off.material         = indication_font_light                         -- indication_font
vth_ag_radar_off.init_pos         = {0, -50, 0}                                   -- {0, -60, 0}
vth_ag_radar_off.alignment        = "CenterCenter"
vth_ag_radar_off.formats          = {"%s\n%s"}
vth_ag_radar_off.stringdefs       = font_size_large                               -- {0.007,0.007}
vth_ag_radar_off.controllers      = {{"txt_ag_radar_off"}}
AddHUDElement(vth_ag_radar_off)

local vth_aa_radar_mode           = CreateElement "ceStringPoly"
vth_aa_radar_mode.name            = "vth_aa_radar_mode"
vth_aa_radar_mode.material        = indication_font_light                         -- indication_font
vth_aa_radar_mode.init_pos        = {0, -60, 0}                                   -- {0, -20, 0}
vth_aa_radar_mode.alignment       = "CenterCenter"
vth_aa_radar_mode.formats         = {"%s"}
vth_aa_radar_mode.stringdefs      = font_size_large                               -- {0.007,0.007}
vth_aa_radar_mode.controllers     = {{"msg_radar_mode"}}
AddHUDElement(vth_aa_radar_mode)

local vth_aa_radar_msg_bar        = create_vth_textured_box(807, 844, 925, 880)   -- ( 808, 843, 925, 880) -- => barre pour "barrer" RADAR
vth_aa_radar_msg_bar.name         = "vth_aa_radar_msg_bar"
vth_aa_radar_msg_bar.init_pos     = {0, -60, 0}                                   -- {0, -20, 0}
vth_aa_radar_msg_bar.controllers  = {{"msg_warn_bar"}}
AddHUDElement(vth_aa_radar_msg_bar)
--
-- The 'txt_RS_static' object is modified for M-2000C Cockpit Indications 
-- Fix by Sedenion.
-- 
-- According to a real photography of Mirage 2000 HUD, the RS warning appear as 
-- a striked RS text positionned at top-left corner of the HUD, right bellow the 
-- IAS and Mach indications.
--
-- To achieve correct design, the dynamic RS text were remplaced with a  
-- texture sprite, created for this occasion in the HUD indication texture map.
--
--[[
local txt_RS_static               = CreateElement "ceStringPoly"
txt_RS_static.name                = "txt_RS_static"
txt_RS_static.material            = indication_font
txt_RS_static.init_pos            = {101.0, 5.0, 0.0}                             -- {106.0, -20, 0}
txt_RS_static.alignment           = "RightTop"
txt_RS_static.stringdefs          = font_size_default                             -- {0.006,0.006}
txt_RS_static.value               = "RS"
txt_RS_static.controllers         = {{"msg_radalt_off"}}
AddHUDElement(txt_RS_static)
--]]
local txt_RS_static               = create_vth_textured_box(245, 315, 280, 338)   -- Striked RS sprite
txt_RS_static.name                = "txt_RS_static"
txt_RS_static.init_pos            = {-104.0, 105.0, 0.0}                          -- {106.0, -20, 0}
txt_RS_static.controllers         = {{"msg_radalt_off"}}
AddHUDElement(txt_RS_static)
