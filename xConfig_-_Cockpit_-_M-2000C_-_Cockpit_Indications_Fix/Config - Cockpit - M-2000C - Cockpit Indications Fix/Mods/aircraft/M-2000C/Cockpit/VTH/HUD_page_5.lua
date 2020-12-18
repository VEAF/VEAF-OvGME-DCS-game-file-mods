-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.82 (10/05/2020) for DCS World 2.5.6.55743 (09/30/2020)
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
txt_asi.controllers           = {{"vis_adnorm"}, {"txt_asi"}}
AddHUDElement(txt_asi)

local txt_mach                = CreateElement "ceStringPoly"
txt_mach.name                 = "txt_mach"
txt_mach.material             = indication_font
txt_mach.init_pos             = {-65, 120.0}                                      -- {-80.0, 120.0}
txt_mach.alignment            = "RightTop"
txt_mach.formats              = {"%01.2f"}
txt_mach.stringdefs           = font_size_default                                 -- {0.006,0.006}
txt_mach.controllers          = {{"vis_adnorm"}, {"txt_mach"}}
AddHUDElement(txt_mach)

-- Right Side
local txt_balt_T              = CreateElement "ceStringPoly"
txt_balt_T.name               = "txt_balt"
txt_balt_T.material           = indication_font_light                             -- indication_font
txt_balt_T.init_pos           = {88.0, 134}                                       -- {92.0, 135.0}
txt_balt_T.alignment          = "RightTop"
txt_balt_T.formats            = {"%01.f"}
txt_balt_T.stringdefs         = font_size_large                                   -- {0.008,0.008}
txt_balt_T.controllers        = {{"vis_adnorm"}, {"txt_balt_T"}}
AddHUDElement(txt_balt_T)

local txt_balt_H              = CreateElement "ceStringPoly"
txt_balt_H.name               = "txt_balt_H"
txt_balt_H.material           = indication_font
txt_balt_H.init_pos           = {101.0, 130.5}                                    -- {106.0, 132.0}
txt_balt_H.alignment          = "RightTop"
txt_balt_H.formats            = {"%02.f"}
txt_balt_H.stringdefs         = font_size_default                                 -- {0.006,0.006}
txt_balt_H.controllers        = {{"vis_adnorm"}, {"txt_balt_H"}}
AddHUDElement(txt_balt_H)

local txt_radalt_H            = CreateElement "ceStringPoly"
txt_radalt_H.name             = "txt_radalt_H"
txt_radalt_H.material         = indication_font
txt_radalt_H.init_pos         = {101.0, 120.0}                                    -- {106.0, 120.0}
txt_radalt_H.alignment        = "RightTop"
txt_radalt_H.formats          = {"%01.f"}
txt_radalt_H.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_radalt_H.controllers      = {{"vis_adnorm"}, {"vis_radalt"}, {"txt_radalt"}}
AddHUDElement(txt_radalt_H)

local txt_radalt_N            = CreateElement "ceStringPoly"
txt_radalt_N.name             = "txt_radalt_N"
txt_radalt_N.material         = indication_font
txt_radalt_N.init_pos         = {101.0, 120.0}                                    -- {106.0, 120.0, 0.0}
txt_radalt_N.alignment        = "RightTop"
txt_radalt_N.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_radalt_N.value            = "*****"
txt_radalt_N.controllers      = {{"vis_adnorm"}, {"vis_radalt_n"}}
AddHUDElement(txt_radalt_N)

local txt_radalt_L            = CreateElement "ceStringPoly"
txt_radalt_L.name             = "txt_radalt_L"
txt_radalt_L.material         = indication_font
txt_radalt_L.init_pos         = {107.5, 120.0}                                    -- {108.0, 120.0, 0.0}
txt_radalt_L.alignment        = "LeftTop" 
txt_radalt_L.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_radalt_L.value            = "H"
txt_radalt_L.controllers      = {{"vis_adnorm"}, {"vis_radalt_l"}}
AddHUDElement(txt_radalt_L)

local txt_hautgr_H            = CreateElement "ceStringPoly"
txt_hautgr_H.name             = "txt_hautgr_H"
txt_hautgr_H.material         = indication_font
txt_hautgr_H.init_pos         = {101.0, 110.0}                                    -- {106.0, 107.0, 0.0}
txt_hautgr_H.alignment        = "RightTop"
txt_hautgr_H.formats          = {"%01.f"}
txt_hautgr_H.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_hautgr_H.controllers      = {{"vis_adnorm"}, {"vis_hautg"}, {"txt_hautg"}}
AddHUDElement(txt_hautgr_H)

local txt_hautgr_L            = CreateElement "ceStringPoly"
txt_hautgr_L.name             = "txt_hautgr_L"
txt_hautgr_L.material         = indication_font
txt_hautgr_L.init_pos         = {107.5, 110.0}                                    -- {108.0, 107.0, 0.0}
txt_hautgr_L.alignment        = "LeftTop"
txt_hautgr_L.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_hautgr_L.value            = "HG"
txt_hautgr_L.controllers      = {{"vis_adnorm"}, {"vis_hautg"}}
AddHUDElement(txt_hautgr_L)

-- WEAPONS DATA
-- LEFT SIDE DATA
local txt_weapon              = CreateElement "ceStringPoly"
txt_weapon.name               = "txt_weapon"
txt_weapon.material           = indication_font
txt_weapon.init_pos           = {-112.0, 20.0, 0.0}                               -- {-112.0, 0.0, 0.0}
txt_weapon.alignment          = "LeftTop"
txt_weapon.material           = indication_font
txt_weapon.formats            = {"%s"}
txt_weapon.stringdefs         = font_size_default                                 -- {0.006,0.006}
txt_weapon.controllers        = {{"vis_selwp"},{"txt_selwp",0}}
AddHUDElement(txt_weapon)

local txt_gmeter              = CreateElement "ceStringPoly"
txt_gmeter.name               = "txt_gmeter"
txt_gmeter.material           = indication_font
txt_gmeter.init_pos           = {-88.0, 9.0}                                      -- {-87.0,-10.0}
txt_gmeter.alignment          = "RightTop"
txt_gmeter.formats            = {"%01.1f"}
txt_gmeter.stringdefs         = font_size_default                                 -- {0.006,0.006}
txt_gmeter.controllers        = {{"txt_gmeter",0}}
AddHUDElement(txt_gmeter)

local txt_GMeter_L            = CreateElement "ceStringPoly"
txt_GMeter_L.name             = "txt_GMeter_L"
txt_GMeter_L.material         = indication_font
txt_GMeter_L.init_pos         = {-87.0, 9.0, 0.0}                                 -- {-82.0, -10.0, 0.0}
txt_GMeter_L.alignment        = "LeftTop"
txt_GMeter_L.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_GMeter_L.value            = "G"
AddHUDElement(txt_GMeter_L)

local aoa_symbol              = create_vth_textured_box(932, 291, 961, 317)       -- ( 967, 293, 997, 320)
aoa_symbol.name               = "aoa_symbol"
aoa_symbol.alignment          = "LeftTop"                                         -- ADDED
aoa_symbol.init_pos           = {-115.0, -6.0}                                    -- {-80.0 ,-25.0, 0.0}
aoa_symbol.controllers	      = {{"AOA_in_HUD"}}
AddHUDElement(aoa_symbol)

local txt_AOA                 = CreateElement "ceStringPoly"
txt_AOA.name                  = "txt_AOA"
txt_AOA.material              = indication_font
txt_AOA.init_pos              = {-88.0, -1.0}                                     -- {-87.0,-20.0, 0.0}
txt_AOA.alignment             = "RightTop"
txt_AOA.formats               = {"%01.1f"}
txt_AOA.stringdefs            = font_size_default                                 -- {0.006,0.006}
txt_AOA.controllers           = {{"AOA_in_HUD"}, {"txt_AOA"}}
AddHUDElement(txt_AOA)

-- Close Air Combat Mode
local Ret_AA_CCM_Boresight          = create_vth_textured_box(515, 131, 718, 334) -- ( 530, 130,715,315)
Ret_AA_CCM_Boresight.name           = "Ret_AA_CCM_Boresight"
Ret_AA_CCM_Boresight.init_pos       = {0, 92, 0}                                  -- {0, 90, 0}
Ret_AA_CCM_Boresight.controllers    = {{"aa_cam_bore"}}
AddHUDElement(Ret_AA_CCM_Boresight)

local Ret_AA_CCM_VScan              = create_vth_textured_box(774, 632, 804, 987) -- ( 774, 632, 807, 988)
Ret_AA_CCM_VScan.name               = "Ret_AA_CCM_VScan"
Ret_AA_CCM_VScan.init_pos           = {0, 15, 0}
Ret_AA_CCM_VScan.controllers        = {{"aa_cam_vscan"}}
AddHUDElement(Ret_AA_CCM_VScan)

local Ret_AA_CCM_HScan              = create_vth_textured_box(771, 990, 1016, 1020) -- ( 771, 990, 1018, 1023)
Ret_AA_CCM_HScan.name               = "Ret_AA_CCM_HScan"
Ret_AA_CCM_HScan.init_pos           = {0, 80, 0}
Ret_AA_CCM_HScan.controllers        = {{"aa_cam_hscan"}}
AddHUDElement(Ret_AA_CCM_HScan)

local AA_CCM_Icon_Boresight         = create_vth_textured_box(405, 278, 434, 308) -- ( 407, 283, 429, 305)
AA_CCM_Icon_Boresight.name          = "AA_CCM_Icon_Boresight"
AA_CCM_Icon_Boresight.init_pos      = {-83, 15.5, 0}                                -- {-85, -4, 0}
AA_CCM_Icon_Boresight.controllers   = {{"aa_cam_icon_bore"}}
AddHUDElement(AA_CCM_Icon_Boresight)

local AA_CCM_Icon_VScan             = create_vth_textured_box(410, 225, 426, 261) -- ( 410, 236, 425, 258)
AA_CCM_Icon_VScan.name              = "AA_CCM_Icon_VScan"
AA_CCM_Icon_VScan.init_pos          = {-83, 15.5, 0}                                -- {-85, -4, 0}
AA_CCM_Icon_VScan.controllers       = {{"aa_cam_icon_vscan"}}
AddHUDElement(AA_CCM_Icon_VScan)

local AA_CCM_Icon_HScan             = create_vth_textured_box(403, 262, 439, 276) -- ( 405, 261, 430, 276)
AA_CCM_Icon_HScan.name              = "AA_CCM_Icon_HScan"
AA_CCM_Icon_HScan.init_pos          = {-83, 15.5, 0}                                -- {-85, -4, 0}
AA_CCM_Icon_HScan.controllers       = {{"aa_cam_icon_hscan"}}
AddHUDElement(AA_CCM_Icon_HScan)

local AA_CCM_Text_SMode             = CreateElement "ceStringPoly"
AA_CCM_Text_SMode.name              = "AA_CCM_Text_SMode"
AA_CCM_Text_SMode.material          = indication_font
AA_CCM_Text_SMode.init_pos          = {101.0, 33.0}                               -- {90.0, 12.0, 0}
AA_CCM_Text_SMode.alignment         = "RightTop"                                  -- "LeftCenter"
AA_CCM_Text_SMode.formats           = {"%s"}
AA_CCM_Text_SMode.stringdefs        = font_size_default                           -- {0.006,0.006}
AA_CCM_Text_SMode.controllers       = {{"aa_cam_text_smode"}}
AddHUDElement(AA_CCM_Text_SMode)

-- WEAPONS CUES
local txt_dom_magic                 = CreateElement "ceStringPoly"
txt_dom_magic.name                  = "txt_dom_magic"
txt_dom_magic.material              = indication_font_light                           -- indication_font
txt_dom_magic.init_pos              = {0.0, -52.0, 0.0}                               -- {0.0, -50.0, 0.0}
txt_dom_magic.alignment             = "CenterCenter"
txt_dom_magic.stringdefs            = font_size_large                                 -- {0.009,0.009}
txt_dom_magic.value                 = "DOM"
txt_dom_magic.controllers           = {{"vis_gun_dom"}}
AddHUDElement(txt_dom_magic)

-- Missiles
local AAM_NEZ_Ring                  = create_vth_textured_box(198, 649, 339, 790)     -- ( 192, 643, 346, 797)
AAM_NEZ_Ring.name                   = "AAM_NEZ_Ring"
AAM_NEZ_Ring.init_pos               = {0, -4, 0}                                      -- {0, 0, 0}
AAM_NEZ_Ring.controllers            = {{"vis_aam_nez"}}
AddHUDElement(AAM_NEZ_Ring)

