-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 2.4 (2021-02-04) for DCS World 2.5.6.60966 (2021-02-03)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."VTH/"
dofile(my_path.."HUD_definitions.lua")
dofile(my_path.."HUD_page_base.lua")

local sensor_data = get_base_data()

-- Left Side
local txt_asi                 = CreateElement "ceStringPoly"
txt_asi.name                  = "txt_asi"
txt_asi.material              = indication_font_light                             -- indication_font
txt_asi.init_pos              = {-66, 94}                                         -- {-112.0,90.0}
txt_asi.alignment             = "RightTop"                                        -- "LeftTop"
txt_asi.formats               = {"%03.f"}
txt_asi.stringdefs            = font_size_stb_large                               -- {0.011,0.011}
txt_asi.controllers           = {{"txt_asi",0}}
AddHUDElement(txt_asi)

local txt_mach                = CreateElement "ceStringPoly"
txt_mach.name                 = "txt_mach"
txt_mach.material             = indication_font_light                             -- indication_font
txt_mach.init_pos             = {-65, 77.0}                                       -- {-80.0,72.0}
txt_mach.alignment            = "RightTop"
txt_mach.formats              = {"%01.2f"}
txt_mach.stringdefs           = font_size_stb_small                               -- {0.008,0.008}
txt_mach.controllers          = {{"txt_mach",0}}
AddHUDElement(txt_mach)

-- Right Side
local txt_balt_T              = CreateElement "ceStringPoly"
txt_balt_T.name               = "txt_balt"
txt_balt_T.material           = indication_font_light                             -- indication_font
txt_balt_T.init_pos           = {84.0, 94}                                        -- {93.0,90.0}
txt_balt_T.alignment          = "RightTop"
txt_balt_T.formats            = {"%01.f"}
txt_balt_T.stringdefs         = font_size_stb_large                               -- {0.011,0.011}
txt_balt_T.controllers        = {{"txt_balt_T",0}}
AddHUDElement(txt_balt_T)

local txt_balt_H              = CreateElement "ceStringPoly"
txt_balt_H.name               = "txt_balt_H"
txt_balt_H.material           = indication_font_light                             -- indication_font
txt_balt_H.init_pos           = {101.0, 90.0}                                     -- {110.0,86.0}
txt_balt_H.alignment          = "RightTop"
txt_balt_H.formats            = {"%02.f"}
txt_balt_H.stringdefs         = font_size_stb_small                               -- {0.008,0.008}
txt_balt_H.controllers        = {{"txt_balt_H",0}}
AddHUDElement(txt_balt_H)

local txt_radalt_H            = CreateElement "ceStringPoly"
txt_radalt_H.name             = "txt_radalt_H"
txt_radalt_H.material         = indication_font_light                             -- indication_font
txt_radalt_H.init_pos         = {101.0, 77.0}                                     -- {110.0,70.0}
txt_radalt_H.alignment        = "RightTop"
txt_radalt_H.formats          = {"%01.f"}
txt_radalt_H.stringdefs       = font_size_stb_small                               -- {0.008,0.008}
txt_radalt_H.controllers      = {{"vis_radalt"}, {"txt_radalt",0}}
AddHUDElement(txt_radalt_H)

local txt_radalt_N            = CreateElement "ceStringPoly"
txt_radalt_N.name             = "txt_radalt_N"
txt_radalt_N.material         = indication_font_light                             -- indication_font
txt_radalt_N.init_pos         = {101.0, 77.0}                                     -- {110.0, 70.0, 0.0}
txt_radalt_N.alignment        = "RightTop"
txt_radalt_N.stringdefs       = font_size_stb_small                               -- {0.008,0.008}
txt_radalt_N.value            = "*****"
txt_radalt_N.controllers      = {{"vis_radalt_n"}}
AddHUDElement(txt_radalt_N)

local txt_radalt_L            = CreateElement "ceStringPoly"
txt_radalt_L.name             = "txt_radalt_L"
txt_radalt_L.material         = indication_font_light                             -- indication_font
txt_radalt_L.init_pos         = {107.5, 77.0}                                     -- {112.0, 70.0, 0.0}
txt_radalt_L.alignment        = "LeftTop" 
txt_radalt_L.stringdefs       = font_size_stb_small                               -- {0.008,0.008}
txt_radalt_L.value            = "H"
txt_radalt_L.controllers      = {{"vis_radalt_l"}}
AddHUDElement(txt_radalt_L)

local txt_hautgr_H            = CreateElement "ceStringPoly"
txt_hautgr_H.name             = "txt_hautgr_H"
txt_hautgr_H.material         = indication_font_light                             -- indication_font
txt_hautgr_H.init_pos         = {101.0, 64.0}                                     -- {110.0,54.0}
txt_hautgr_H.alignment        = "RightTop"
txt_hautgr_H.formats          = {"%01.f"}
txt_hautgr_H.stringdefs       = font_size_stb_small                               -- {0.008,0.008}
txt_hautgr_H.controllers      = {{"vis_hautg"},{"txt_hautg",0}}
AddHUDElement(txt_hautgr_H)

local txt_hautgr_L            = CreateElement "ceStringPoly"
txt_hautgr_L.name             = "txt_hautgr_L"
txt_hautgr_L.material         = indication_font_light                             -- indication_font
txt_hautgr_L.init_pos         = {107.5, 64.0}                                     -- {112.0, 54.0, 0.0}
txt_hautgr_L.alignment        = "LeftTop"
txt_hautgr_L.stringdefs       = font_size_stb_small                               -- {0.008,0.008}
txt_hautgr_L.value            = "HG"
txt_hautgr_L.controllers      = {{"vis_hautg"}}
AddHUDElement(txt_hautgr_L)

-- Waterline
local Waterline                   = create_vth_textured_box(600, 675, 715, 705)   -- (900, 575, 1015, 605) => Texture blank
Waterline.name                    = "Waterline"
Waterline.init_pos                = {0,-10,0}
AddHUDElement(Waterline)

Gun_Cross_AG              = create_vth_textured_box(970, 23, 1007, 60)            -- ( 970, 20, 1010,65)
Gun_Cross_AG.name         = "Gun_Cross_AG"
Gun_Cross_AG.init_pos     = {0,0,0}
AddHUDElement(Gun_Cross_AG)
