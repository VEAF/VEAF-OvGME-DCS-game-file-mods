-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.5 (04/17/2020) for DCS World 2.5.6.47224 (04/16/2020)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."VTH/"
dofile(my_path.."HUD_definitions.lua")
dofile(my_path.."HUD_base_appr.lua")

-- HUD Center
local VTH_center		= CreateElement "ceSimple"
VTH_center.name			= "VTH_center"
VTH_center.init_pos		= vth_base_init_pos
AddHUDElement(VTH_center)

-- AIRCRAFT DATA
-- LEFT SIDE DATA
local txt_asi                 = CreateElement "ceStringPoly"
txt_asi.name                  = "txt_asi"
txt_asi.material              = indication_font_light                             -- indication_font
txt_asi.init_pos              = {-66, 22}                                         -- {-112.0,34.0}
txt_asi.alignment             = "RightTop"                                        -- "LeftTop"
txt_asi.formats               = {"%03.f"}
txt_asi.stringdefs            = font_size_large                                   -- {0.008,0.008}
txt_asi.controllers           = {{"txt_asi"}}
AddHUDElement(txt_asi)

local txt_mach                = CreateElement "ceStringPoly"
txt_mach.name                 = "txt_mach"
txt_mach.material             = indication_font
txt_mach.init_pos             = {-65, 8.0}                                        -- {-80.0,21.0}
txt_mach.alignment            = "RightTop"
txt_mach.formats              = {"%01.2f"}
txt_mach.stringdefs           = font_size_default                                 -- {0.006,0.006}
txt_mach.controllers          = {{"txt_mach"}}
AddHUDElement(txt_mach)

local aoa_symbol              = create_vth_textured_box(932, 291, 961, 315)       -- ( 967, 293, 997, 320)
aoa_symbol.name               = "aoa_symbol"
aoa_symbol.alignment          = "LeftTop"                                         -- ADDED
aoa_symbol.init_pos           = {-118.0, -26.0}                                   -- {-112.0 ,6.0, 0.0}
aoa_symbol.controllers        = {{"AOA_in_HUD"}}
AddHUDElement(aoa_symbol)

local txt_AOA                 = CreateElement "ceStringPoly"
txt_AOA.name                  = "txt_AOA"
txt_AOA.material              = indication_font
txt_AOA.init_pos              = {-88.0, -21.0}                                    -- {-105.0,6.0, 0.0}
txt_AOA.alignment             = "RightTop"
txt_AOA.formats               = {"%01.1f"}
txt_AOA.stringdefs            = font_size_default                                 -- {0.006,0.006}
txt_AOA.controllers           = {{"AOA_in_HUD"}, {"txt_AOA"}}
AddHUDElement(txt_AOA)


-- RIGHT SIDE DATA
local txt_balt_T              = CreateElement "ceStringPoly"
txt_balt_T.name               = "txt_balt"
txt_balt_T.material           = indication_font_light                             -- indication_font
txt_balt_T.init_pos           = {88.0, 22}                                        -- {96.0,34.0}
txt_balt_T.alignment          = "RightTop"
txt_balt_T.formats            = {"%01.f"}
txt_balt_T.stringdefs         = font_size_large                                   -- {0.008,0.008}
txt_balt_T.controllers        = {{"txt_balt_T"}}
AddHUDElement(txt_balt_T)

local txt_balt_H              = CreateElement "ceStringPoly"
txt_balt_H.name               = "txt_balt_H"
txt_balt_H.material           = indication_font
txt_balt_H.init_pos           = {101.0, 18.5}                                     -- {110.0,32.0}
txt_balt_H.alignment          = "RightTop"
txt_balt_H.formats            = {"%02.f"}
txt_balt_H.stringdefs         = font_size_default                                 -- {0.006,0.006}
txt_balt_H.controllers        = {{"txt_balt_H",0}}
AddHUDElement(txt_balt_H)

local txt_radalt_H            = CreateElement "ceStringPoly"
txt_radalt_H.name             = "txt_radalt_H"
txt_radalt_H.material         = indication_font
txt_radalt_H.init_pos         = {101.0, 8.0}                                      -- {110.0, 20.0}
txt_radalt_H.alignment        = "RightTop"
txt_radalt_H.formats          = {"%01.f"}
txt_radalt_H.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_radalt_H.controllers      = {{"app_wu_radalt"}, {"txt_radalt",0}}
AddHUDElement(txt_radalt_H)

local txt_radalt_N            = CreateElement "ceStringPoly"
txt_radalt_N.name             = "txt_radalt_N"
txt_radalt_N.material         = indication_font
txt_radalt_N.init_pos         = {101.0, 8.0}                                      -- {110.0, 20.0, 0.0}
txt_radalt_N.alignment        = "RightTop"
txt_radalt_N.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_radalt_N.value            = "*****"
txt_radalt_N.controllers      = {{"app_wu_radalt_n"}}
AddHUDElement(txt_radalt_N)

local txt_radalt_L            = CreateElement "ceStringPoly"
txt_radalt_L.name             = "txt_radalt_L"
txt_radalt_L.material         = indication_font
txt_radalt_L.init_pos         = {107.5, 8.0}                                      -- {112.0, 20.0, 0.0}
txt_radalt_L.alignment        = "LeftTop" 
txt_radalt_L.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_radalt_L.value            = "H"
txt_radalt_L.controllers      = {{"app_wu_radalt_l"}}
AddHUDElement(txt_radalt_L)

local txt_hautgr_H            = CreateElement "ceStringPoly"
txt_hautgr_H.name             = "txt_hautgr_H"
txt_hautgr_H.material         = indication_font
txt_hautgr_H.init_pos         = {101.0, -2.0}                                     -- {110.0, 7.0, 0.0}
txt_hautgr_H.alignment        = "RightTop"
txt_hautgr_H.formats          = {"%01.f"}
txt_hautgr_H.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_hautgr_H.controllers      = {{"vis_hautg"},{"txt_hautg",0}}
AddHUDElement(txt_hautgr_H)

-- This one was missing in the original file :
local txt_hautgr_L            = CreateElement "ceStringPoly"
txt_hautgr_L.name             = "txt_hautgr_L"
txt_hautgr_L.material         = indication_font
txt_hautgr_L.init_pos         = {107.5, -2.0}                                     -- N/A
txt_hautgr_L.alignment        = "LeftTop"
txt_hautgr_L.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_hautgr_L.value            = "HG"
txt_hautgr_L.controllers      = {{"vis_hautg"}}
AddHUDElement(txt_hautgr_L)

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

local AP_fpm                      = CreateElement "ceStringPoly"
AP_fpm.name                       = "AP_fpm"
AP_fpm.material                   = indication_font
AP_fpm.init_pos                   = {0,0,0}
AP_fpm.parent_element             = vth_fpm.name
AP_fpm.alignment                  = "CenterCenter"
AP_fpm.value                      = "*"
AP_fpm.stringdefs                 = {0.006,0.006}                                 -- {0.007,0.007}
AP_fpm.controllers                = {{"vis_alleg"}, {"AP_fpm", 0.6}}
AddHUDElement(AP_fpm)

-- ACCEL X
local JxAccel_box             = create_vth_textured_box(290, 232, 400, 283)       -- (290, 230, 400, 285)
JxAccel_box.name              = "JxAccel_box"
JxAccel_box.init_pos          = {0.0, 50.0, 0.0}
JxAccel_box.controllers       = {{"vis_wdown"}}
AddHUDElement(JxAccel_box)

local JxAccel_txt             = CreateElement "ceStringPoly"
JxAccel_txt.name              = "JxAccel_txt"
JxAccel_txt.material          = indication_font
JxAccel_txt.init_pos          = {0.0, 49.8, 0.0}                                  -- {0.0, 50.0, 0.0}
JxAccel_txt.alignment         = "CenterCenter"
JxAccel_txt.formats           = {"%01.2f"}
JxAccel_txt.stringdefs        = font_size_default                                 -- {0.006,0.006}
JxAccel_txt.controllers       = {{"vis_wdown"}, {"txt_xaccel",0}}
AddHUDElement(JxAccel_txt)

-- AOA
local vth_aoa               = create_vth_textured_box(240, 142, 500, 200)         -- ( 240, 142, 501, 202)
vth_aoa.name                = "vth_aoa"
vth_aoa.init_pos            = {0,0,0}
vth_aoa.parent_element      = vth_fpm.name
vth_aoa.controllers         = {{"appr_aoa", 0.65}}
AddHUDElement(vth_aoa)

-- RADALT
local fpm_radalt_H          = CreateElement "ceStringPoly"
fpm_radalt_H.name           = "fpm_radalt_H"
fpm_radalt_H.material       = indication_font
fpm_radalt_H.init_pos       = {0.0, -20.0}
fpm_radalt_H.alignment      = "CenterCenter"
fpm_radalt_H.formats        = {"%01.f"}
fpm_radalt_H.stringdefs     = font_size_default                                     -- {0.006,0.006}
fpm_radalt_H.parent_element = vth_fpm.name
fpm_radalt_H.controllers    = {{"app_wd_radalt"}, {"txt_radalt",0}}
AddHUDElement(fpm_radalt_H)

local fpm_radalt_N          = CreateElement "ceStringPoly"
fpm_radalt_N.name           = "fpm_radalt_N"
fpm_radalt_N.material       = indication_font
fpm_radalt_N.init_pos       = {0.0, -20.0}
fpm_radalt_N.alignment      = "CenterCenter"
fpm_radalt_N.stringdefs     = font_size_default                                     -- {0.006,0.006}
fpm_radalt_N.parent_element = vth_fpm.name
fpm_radalt_N.value          = "****"
fpm_radalt_N.controllers    = {{"app_wd_radalt_n"}}
AddHUDElement(fpm_radalt_N)


-- OUTER/MIDDLE/INNER MARKER
local txt_omi_marker        = CreateElement "ceStringPoly"
txt_omi_marker.name         = "txt_omi_marker"
txt_omi_marker.material     = indication_font
txt_omi_marker.init_pos     = {0.0,54.0}
txt_omi_marker.alignment    = "CenterCenter"
txt_omi_marker.value        = "M"
txt_omi_marker.stringdefs   = {0.01, 0.01}
txt_omi_marker.controllers  = {{"appr_ils_marker"}}
AddHUDElement(txt_omi_marker)

-- ILS
local ILS_center              = CreateElement "ceSimple"
ILS_center.name               = "ILS_center"
ILS_center.init_pos           = vth_base_init_pos
ILS_center.controllers        = {{"hud_roll" ,1.0}, {"hud_elev_horiz", -0.1}}
AddHUDElement(ILS_center)

local ils_rw_marker           = create_vth_textured_box(210, 75, 218, 107)
ils_rw_marker.name            = "ils_rw_marker"
ils_rw_marker.init_pos        = {0,3.0,0}
ils_rw_marker.parent_element  = ILS_center.name
AddHUDElement(ils_rw_marker)

local ils_rw_hdg              = create_vth_textured_box(5, 340, 11, 1017, nil, 1017) -- (6, 147, 10, 995, nil, 995)
ils_rw_hdg.name               = "ils_rw_hdg"
ils_rw_hdg.init_pos           = {0,0,0}
ils_rw_hdg.parent_element     = ILS_center.name
ils_rw_hdg.controllers        = {{"appr_rwy"}}
AddHUDElement(ils_rw_hdg)

local ils_loc_wnd             = create_vth_textured_box(350, 285, 393, 330)       -- (291, 291, 338, 330)
ils_loc_wnd.name              = "ils_loc_wnd"
ils_loc_wnd.init_pos          = {0,0,0}
ils_loc_wnd.parent_element    = ILS_center.name
ils_loc_wnd.controllers       = {{"appr_loc_window", 0.6}}
AddHUDElement(ils_loc_wnd)

local ils_gsi_wnd             = create_vth_textured_box(298, 285, 341, 330)       -- (291, 286, 338, 330)
ils_gsi_wnd.name              = "ils_gsi_wnd"
ils_gsi_wnd.init_pos          = {-1.5,-1.5,0}
ils_gsi_wnd.parent_element    = vth_fpm.name
ils_gsi_wnd.controllers       = {{"appr_ils_window", 0.6}}
AddHUDElement(ils_gsi_wnd)

local ils_gsi_tlow            = create_vth_textured_box(805, 20, 833, 52)         -- (807, 22, 832, 51)
ils_gsi_tlow.name             = "ils_gsi_tlow"
ils_gsi_tlow.init_pos         = {0.0,-13.0,0}                                     -- {1.0,-13.0,0}
ils_gsi_tlow.parent_element   = ils_gsi_wnd.name
ils_gsi_tlow.controllers      = {{"appr_ils_tlow"}}
AddHUDElement(ils_gsi_tlow)

local ils_gsi_thigh           = create_vth_textured_box(805, 86, 833, 118)        -- (807, 89, 832, 118)
ils_gsi_thigh.name            = "ils_gsi_thigh"
ils_gsi_thigh.init_pos        = {0.0,13.0,0}                                      -- {1.0,13.0,0}
ils_gsi_thigh.parent_element  = ils_gsi_wnd.name
ils_gsi_thigh.controllers     = {{"appr_ils_thigh"}}
AddHUDElement(ils_gsi_thigh)

local ils_gsi_tleft           = create_vth_textured_box(802, 56, 834, 84)         -- (804, 58, 833, 83)
ils_gsi_tleft.name            = "ils_gsi_tleft"
ils_gsi_tleft.init_pos        = {-13.0,0.0,0}
ils_gsi_tleft.parent_element  = ils_gsi_wnd.name
ils_gsi_tleft.controllers     = {{"appr_ils_tleft"}}
AddHUDElement(ils_gsi_tleft)

local ils_gsi_tright          = create_vth_textured_box(844, 56, 876, 84)         -- (841, 58, 875, 83)
ils_gsi_tright.name           = "ils_gsi_tright"
ils_gsi_tright.init_pos       = {13.0,0.0,0}
ils_gsi_tright.parent_element = ils_gsi_wnd.name
ils_gsi_tright.controllers    = {{"appr_ils_tright"}}
AddHUDElement(ils_gsi_tright)

-- NAV Mode Elements
local wp_dist11NM             = CreateElement "ceStringPoly"
wp_dist11NM.name              = "wp_dist11NM"
wp_dist11NM.material          = indication_font
wp_dist11NM.init_pos          = {113.5, 62.0, 0.0}                                -- {96.0, 60.0}
wp_dist11NM.alignment         = "RightTop"
wp_dist11NM.formats           = {"%1.fN%2d"}                                      -- {"%1.f N %02d"}
wp_dist11NM.stringdefs        = font_size_default                                 -- {0.006,0.006}
wp_dist11NM.controllers       = {{"wp_dist11NM",0}}
AddHUDElement(wp_dist11NM)

local wp_dist10NM             = CreateElement "ceStringPoly"
wp_dist10NM.name              = "wp_dist10NM"
wp_dist10NM.material          = indication_font
wp_dist10NM.init_pos          = {113.5, 62.0, 0.0}                                -- {96.0, 60.0}
wp_dist10NM.alignment         = "RightTop"
wp_dist10NM.formats           = {"%1.1fN%2d"}                                     -- {"%1.1f N %02d"}
wp_dist10NM.stringdefs        = font_size_default                                 -- {0.006,0.006}
wp_dist10NM.controllers       = {{"wp_dist10NM",0}}
AddHUDElement(wp_dist10NM)

local wp_trackerror_to          = create_vth_textured_box(881, 17, 917, 61, nil, 59) -- ( 883, 19, 916, 60, nil, 60)
wp_trackerror_to.name           = "wp_trackerror_to"
wp_trackerror_to.init_pos       = {0,0,0}
wp_trackerror_to.parent_element = vth_fpm.name
wp_trackerror_to.controllers    = {{"wp_trk_err_t", 0.6}}
AddHUDElement(wp_trackerror_to)


-- SYNTHETIC RUNWAY
local synthetic_runway          = CreateElement "ceSimpleLineObject"
synthetic_runway.name           = "synthetic_runway"
synthetic_runway.material       = vth_line_material                               -- MakeMaterial(nil,{20,255,20,225})
synthetic_runway.init_pos       = {0,0,0}
synthetic_runway.width          = 0.7
synthetic_runway.parent_element = VTH_center.name
synthetic_runway.controllers    = {{"appr_synth_rwy"}}
AddHUDElement(synthetic_runway)

-- Weight On Wheels Elements
local takeoff_pitch             = create_vth_textured_box(20, 80, 192, 110)       -- ( 20, 80, 190, 110)
takeoff_pitch.name              = "takeoff_caret"
takeoff_pitch.init_pos          = {0, -130, 0}                                    -- {0, -130, 0}
takeoff_pitch.controllers       = {{"vis_wdown"}}
AddHUDElement(takeoff_pitch)

-- DEBUG
--[[
local txt_loc_dev			= CreateElement "ceStringPoly"
txt_loc_dev.name			= "txt_loc_dev"
txt_loc_dev.material		= indication_font
txt_loc_dev.init_pos		= {110.0,21.0}
txt_loc_dev.alignment		= "RightTop"
txt_loc_dev.formats			= {"%d/%d"}
txt_loc_dev.stringdefs	    = {0.006,0.006}
txt_loc_dev.controllers 	= {{"txt_vvx"}}
AddHUDElement(txt_loc_dev)

local txt_loc_gsd			= CreateElement "ceStringPoly"
txt_loc_gsd.name			= "txt_loc_gsd"
txt_loc_gsd.material		= indication_font
txt_loc_gsd.init_pos		= {110.0,6.0}
txt_loc_gsd.alignment		= "RightTop"
txt_loc_gsd.formats			= {"%03.2f"}
txt_loc_gsd.stringdefs	    = {0.006,0.006}
txt_loc_gsd.controllers 	= {{"txt_vvy"}}
AddHUDElement(txt_loc_gsd)
--]]
