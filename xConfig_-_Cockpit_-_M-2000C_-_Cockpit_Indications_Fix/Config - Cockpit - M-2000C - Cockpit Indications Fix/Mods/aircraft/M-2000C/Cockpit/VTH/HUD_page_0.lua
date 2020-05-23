-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.6 (05/22/2020) for DCS World 2.5.6.49314 (05/20/2020)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."VTH/"
dofile(my_path.."HUD_definitions.lua")
dofile(my_path.."HUD_page_base.lua")

-- HUD Center
local FOV_center              = CreateElement "ceSimple"
FOV_center.name               = "FOV_center"
FOV_center.init_pos           = vth_base_init_pos
AddHUDElement(FOV_center)

-- Aircraft Data
-- Left Side
local txt_asi                 = CreateElement "ceStringPoly"
txt_asi.name                  = "txt_asi"
txt_asi.material              = indication_font_light                             -- indication_font
txt_asi.init_pos              = {-66, 134}                                        -- {-112.0, 135.0}
txt_asi.alignment             = "RightTop"                                        -- "LeftTop"
txt_asi.formats               = {"%03.f"}
txt_asi.stringdefs            = font_size_large                                   -- {0.008,0.008}
txt_asi.controllers           = {{"txt_asi"}}
AddHUDElement(txt_asi)

local txt_mach                = CreateElement "ceStringPoly"
txt_mach.name                 = "txt_mach"
txt_mach.material             = indication_font
txt_mach.init_pos             = {-65, 120.0}                                      -- {-80.0, 120.0}
txt_mach.alignment            = "RightTop"
txt_mach.formats              = {"%01.2f"}
txt_mach.stringdefs           = font_size_default                                 -- {0.006,0.006}
txt_mach.controllers          = {{"txt_mach"}}
AddHUDElement(txt_mach)

-- Right Side
local txt_balt_T              = CreateElement "ceStringPoly"
txt_balt_T.name               = "txt_balt"
txt_balt_T.material           = indication_font_light                             -- indication_font
txt_balt_T.init_pos           = {88.0, 134}                                       -- {92.0, 135.0}
txt_balt_T.alignment          = "RightTop"
txt_balt_T.formats            = {"%01.f"}
txt_balt_T.stringdefs         = font_size_large                                   -- {0.008,0.008}
txt_balt_T.controllers        = {{"txt_balt_T"}}
AddHUDElement(txt_balt_T)

local txt_balt_H              = CreateElement "ceStringPoly"
txt_balt_H.name               = "txt_balt_H"
txt_balt_H.material           = indication_font
txt_balt_H.init_pos           = {101.0, 130.5}                                    -- {106.0, 132.0}
txt_balt_H.alignment          = "RightTop"
txt_balt_H.formats            = {"%02.f"}
txt_balt_H.stringdefs         = font_size_default                                 -- {0.006,0.006}
txt_balt_H.controllers        = {{"txt_balt_H"}}
AddHUDElement(txt_balt_H)

local txt_radalt_H            = CreateElement "ceStringPoly"
txt_radalt_H.name             = "txt_radalt_H"
txt_radalt_H.material         = indication_font
txt_radalt_H.init_pos         = {101.0, 120.0}                                    -- {106.0, 120.0}
txt_radalt_H.alignment        = "RightTop"
txt_radalt_H.formats          = {"%01.f"}
txt_radalt_H.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_radalt_H.controllers      = {{"vis_radalt"}, {"txt_radalt"}}
AddHUDElement(txt_radalt_H)

local txt_radalt_N            = CreateElement "ceStringPoly"
txt_radalt_N.name             = "txt_radalt_N"
txt_radalt_N.material         = indication_font
txt_radalt_N.init_pos         = {101.0, 120.0}                                    -- {106.0, 120.0, 0.0}
txt_radalt_N.alignment        = "RightTop"
txt_radalt_N.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_radalt_N.value            = "*****"
txt_radalt_N.controllers      = {{"vis_radalt_n"}}
AddHUDElement(txt_radalt_N)

local txt_radalt_L            = CreateElement "ceStringPoly"
txt_radalt_L.name             = "txt_radalt_L"
txt_radalt_L.material         = indication_font
txt_radalt_L.init_pos         = {107.5, 120.0}                                    -- {108.0, 120.0, 0.0}
txt_radalt_L.alignment        = "LeftTop" 
txt_radalt_L.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_radalt_L.value            = "H"
txt_radalt_L.controllers      = {{"vis_radalt_l"}}
AddHUDElement(txt_radalt_L)

local txt_hautgr_H            = CreateElement "ceStringPoly"
txt_hautgr_H.name             = "txt_hautgr_H"
txt_hautgr_H.material         = indication_font
txt_hautgr_H.init_pos         = {101.0, 110.0}                                    -- {106.0, 107.0, 0.0}
txt_hautgr_H.alignment        = "RightTop"
txt_hautgr_H.formats          = {"%01.f"}
txt_hautgr_H.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_hautgr_H.controllers      = {{"vis_hautg"}, {"txt_hautg"}}
AddHUDElement(txt_hautgr_H)

local txt_hautgr_L            = CreateElement "ceStringPoly"
txt_hautgr_L.name             = "txt_hautgr_L"
txt_hautgr_L.material         = indication_font
txt_hautgr_L.init_pos         = {107.5, 110.0}                                    -- {108.0, 107.0, 0.0}
txt_hautgr_L.alignment        = "LeftTop"
txt_hautgr_L.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_hautgr_L.value            = "HG"
txt_hautgr_L.controllers      = {{"vis_hautg"}}
AddHUDElement(txt_hautgr_L)

-- Weight On Wheels Elements
local takeoff_pitch           = create_vth_textured_box(20, 80, 192, 110)         -- ( 20, 80, 190, 110)
takeoff_pitch.name            = "takeoff_caret"
takeoff_pitch.init_pos        = {0, -130, 0}
takeoff_pitch.controllers     = {{"vis_wdown"}}
AddHUDElement(takeoff_pitch)

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

-- NAV Mode Elements
local wp_dist11NM             = CreateElement "ceStringPoly"
wp_dist11NM.name              = "wp_dist11NM"
wp_dist11NM.material          = indication_font
wp_dist11NM.init_pos          = {113.5, 62.0, 0.0}                                -- {104.5, 5.0, 0.0}
wp_dist11NM.alignment         = "RightTop"
wp_dist11NM.formats           = {"%1.fN%2d"}                                      -- {"%1.f N %02d"}
wp_dist11NM.stringdefs        = font_size_default                                 -- {0.006,0.006}
wp_dist11NM.controllers       = {{"wp_dist11NM"}}
AddHUDElement(wp_dist11NM)

local wp_dist10NM             = CreateElement "ceStringPoly"
wp_dist10NM.name              = "wp_dist10NM"
wp_dist10NM.material          = indication_font
wp_dist10NM.init_pos          = {113.5, 62.0, 0.0}                                -- {104.5, 5.0, 0.0}
wp_dist10NM.alignment         = "RightTop"
wp_dist10NM.formats           = {"%1.1fN%2d"}                                     -- {"%1.1f N %02d"}
wp_dist10NM.stringdefs        = font_size_default                                 -- {0.006,0.006}
wp_dist10NM.controllers       = {{"wp_dist10NM"}}
AddHUDElement(wp_dist10NM)

local wp_dist_offset          = CreateElement "ceStringPoly"
wp_dist_offset.name           = "wp_dist_offset"
wp_dist_offset.material       = indication_font
wp_dist_offset.init_pos       = {119.8, 62.0, 0.0}                                -- {112.0, 5.0, 0.0}
wp_dist_offset.alignment      = "RightTop"
wp_dist_offset.value          = "*"
wp_dist_offset.stringdefs     = font_size_default                                 -- {0.006,0.006}
wp_dist_offset.controllers    = {{"wp_but_offset"}}
AddHUDElement(wp_dist_offset)

-- DEBUG: TO BE DELETED
--[[
local txt_pitch				= CreateElement "ceStringPoly"
txt_pitch.name				= "txt_pitch"
txt_pitch.material			= indication_font
txt_pitch.init_pos			= {-80.0, 105.0}
txt_pitch.alignment			= "RightTop"
txt_pitch.formats			= {"%01.2f"}
txt_pitch.stringdefs		= {0.006,0.006}
txt_pitch.controllers 		= {{"txt_vvx"}}
AddHUDElement(txt_pitch)
--]]
