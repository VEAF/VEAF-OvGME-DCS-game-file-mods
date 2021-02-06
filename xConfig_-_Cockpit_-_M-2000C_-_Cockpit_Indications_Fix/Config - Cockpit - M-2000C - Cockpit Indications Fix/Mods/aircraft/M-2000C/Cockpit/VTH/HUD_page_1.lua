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

-- HUD Center
local FOV_center              = CreateElement "ceSimple"
FOV_center.name               = "FOV_center"
FOV_center.init_pos           = vth_base_init_pos
AddHUDElement(FOV_center)

-- Aircraft Data
-- S530D
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

-- Magic IIs and Guns
-- Left Side
local txt_asi                 = CreateElement "ceStringPoly"
txt_asi.name                  = "txt_asi"
txt_asi.material              = indication_font_light                             -- indication_font
txt_asi.init_pos              = {-66, 57.0}                                       -- {-112.0, 30.0}
txt_asi.alignment             = "RightTop"                                        -- "LeftTop"
txt_asi.formats               = {"%03.f"}
txt_asi.stringdefs            = font_size_large                                   -- {0.008,0.008}
txt_asi.controllers           = {{"vis_admagic"}, {"txt_asi"}}
AddHUDElement(txt_asi)

local txt_mach                = CreateElement "ceStringPoly"
txt_mach.name                 = "txt_mach"
txt_mach.material             = indication_font
txt_mach.init_pos             = {-65, 43.0}                                       -- {-80.0, 15.0}
txt_mach.alignment            = "RightTop"
txt_mach.formats              = {"%01.2f"}
txt_mach.stringdefs           = font_size_default                                   -- {0.006,0.006}
txt_mach.controllers          = {{"vis_admagic"}, {"txt_mach"}}
AddHUDElement(txt_mach)

-- Right Side
local txt_balt_T              = CreateElement "ceStringPoly"
txt_balt_T.name               = "txt_balt"
txt_balt_T.material           = indication_font_light                             -- indication_font
txt_balt_T.init_pos           = {88.0, 57.0}                                      -- {92.0, 30.0}
txt_balt_T.alignment          = "RightTop"
txt_balt_T.formats            = {"%01.f"}
txt_balt_T.stringdefs         = font_size_large                                   -- {0.008,0.008}
txt_balt_T.controllers        = {{"vis_admagic"}, {"txt_balt_T"}}
AddHUDElement(txt_balt_T)

local txt_balt_H              = CreateElement "ceStringPoly"
txt_balt_H.name               = "txt_balt_H"
txt_balt_H.material           = indication_font
txt_balt_H.init_pos           = {101.0, 53.5}                                     -- {106.0, 28.0}
txt_balt_H.alignment          = "RightTop"
txt_balt_H.formats            = {"%02.f"}
txt_balt_H.stringdefs         = font_size_default                                 -- {0.006,0.006}
txt_balt_H.controllers        = {{"vis_admagic"}, {"txt_balt_H"}}
AddHUDElement(txt_balt_H)

local txt_radalt_H            = CreateElement "ceStringPoly"
txt_radalt_H.name             = "txt_radalt_H"
txt_radalt_H.material         = indication_font
txt_radalt_H.init_pos         = {101.0, 43.0}                                     -- {106.0, 15.0}
txt_radalt_H.alignment        = "RightTop"
txt_radalt_H.formats          = {"%01.f"}
txt_radalt_H.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_radalt_H.controllers      = {{"vis_admagic"}, {"vis_radalt"}, {"txt_radalt"}}
AddHUDElement(txt_radalt_H)

local txt_radalt_N            = CreateElement "ceStringPoly"
txt_radalt_N.name             = "txt_radalt_N"
txt_radalt_N.material         = indication_font
txt_radalt_N.init_pos         = {101.0, 43.0}                                     -- {106.0, 15.0, 0.0}
txt_radalt_N.alignment        = "RightTop"
txt_radalt_N.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_radalt_N.value            = "*****"
txt_radalt_N.controllers      = {{"vis_admagic"}, {"vis_radalt_n"}}
AddHUDElement(txt_radalt_N)

local txt_radalt_L            = CreateElement "ceStringPoly"
txt_radalt_L.name             = "txt_radalt_L"
txt_radalt_L.material         = indication_font
txt_radalt_L.init_pos         = {107.5, 43.0}                                     -- {108.0, 15.0, 0.0}
txt_radalt_L.alignment        = "LeftTop" 
txt_radalt_L.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_radalt_L.value            = "H"
txt_radalt_L.controllers      = {{"vis_admagic"}, {"vis_radalt_l"}}
AddHUDElement(txt_radalt_L)

local txt_hautgr_H            = CreateElement "ceStringPoly"
txt_hautgr_H.name             = "txt_hautgr_H"
txt_hautgr_H.material         = indication_font
txt_hautgr_H.init_pos         = {101.0, 33.0}                                     -- {106.0, 2.0, 0.0}
txt_hautgr_H.alignment        = "RightTop"
txt_hautgr_H.formats          = {"%01.f"}
txt_hautgr_H.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_hautgr_H.controllers      = {{"vis_admagic"}, {"vis_hautg"}, {"txt_hautg"}}
AddHUDElement(txt_hautgr_H)

local txt_hautgr_L            = CreateElement "ceStringPoly"
txt_hautgr_L.name             = "txt_hautgr_L"
txt_hautgr_L.material         = indication_font
txt_hautgr_L.init_pos         = {107.5, 33.0}                                     -- {108.0, 2.0, 0.0}
txt_hautgr_L.alignment        = "LeftTop"
txt_hautgr_L.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_hautgr_L.value            = "HG"
txt_hautgr_L.controllers      = {{"vis_admagic"}, {"vis_hautg"}}
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
aoa_symbol.controllers	      = {{"hud_no_ins"}, {"AOA_in_HUD"}}
AddHUDElement(aoa_symbol)

local txt_AOA                 = CreateElement "ceStringPoly"
txt_AOA.name                  = "txt_AOA"
txt_AOA.material              = indication_font
txt_AOA.init_pos              = {-88.0, -1.0}                                     -- {-87.0,-20.0, 0.0}
txt_AOA.alignment             = "RightTop"
txt_AOA.formats               = {"%01.1f"}
txt_AOA.stringdefs            = font_size_default                                 -- {0.006,0.006}
txt_AOA.controllers           = {{"hud_no_ins"}, {"AOA_in_HUD"}, {"txt_AOA"}}
AddHUDElement(txt_AOA)

-- BOTTOM DATA
-- Missiles
-- G: Gauche - Left
local txt_wgauche             = CreateElement "ceStringPoly"
txt_wgauche.name              = "txt_wgauche"
txt_wgauche.material          = indication_font
txt_wgauche.init_pos          = {-40, -89}                                        -- {-50.0, -99.5, 0.0}
txt_wgauche.alignment         = "CenterCenter"
txt_wgauche.stringdefs        = font_size_default                                 -- {0.007,0.007}
txt_wgauche.value             = "G"
txt_wgauche.controllers       = {{"vis_arm_g"}}
AddHUDElement(txt_wgauche)

local gauche_sel              = create_vth_textured_box(952, 502, 1001, 549)       -- ( 940, 340, 1005, 405)
gauche_sel.name               = "gauche_sel"
gauche_sel.init_pos           = {-40, -89}                                        -- {-50,-98.5,0}
gauche_sel.controllers        = {{"vis_gauche"}}
AddHUDElement(gauche_sel)

local txt_m_ftime_l           = CreateElement "ceStringPoly"
txt_m_ftime_l.name            = "txt_m_ftime_l"
txt_m_ftime_l.material        = indication_font
txt_m_ftime_l.init_pos        = {-40, -75}                                        -- {-50.0, -80.5}
txt_m_ftime_l.alignment       = "CenterCenter"
txt_m_ftime_l.formats         = {"%1.f"}
txt_m_ftime_l.stringdefs      = font_size_default                                 -- {0.006,0.006}
txt_m_ftime_l.controllers     = {{"aam_S530_TOF_G"}}
AddHUDElement(txt_m_ftime_l)

-- D: Destro - Right
local txt_wdestro             = CreateElement "ceStringPoly"
txt_wdestro.name              = "txt_wdestro"
txt_wdestro.material          = indication_font
txt_wdestro.init_pos          = {40, -89}                                       -- {50.0, -99.5, 0.0}
txt_wdestro.alignment         = "CenterCenter"
txt_wdestro.stringdefs        = font_size_default                                 -- {0.007,0.007}
txt_wdestro.value             = "D"
txt_wdestro.controllers       = {{"vis_arm_d"}}
AddHUDElement(txt_wdestro)

local destro_sel              = create_vth_textured_box(952, 502, 1001, 549)       -- ( 940, 340, 1005, 405)
destro_sel.name               = "destro_sel"
destro_sel.init_pos           = {40.0, -89}                                       -- {50, -98.5,0}
destro_sel.controllers        = {{"vis_destro"}}
AddHUDElement(destro_sel)

local txt_m_ftime_r           = CreateElement "ceStringPoly"
txt_m_ftime_r.name            = "txt_m_ftime_r"
txt_m_ftime_r.material        = indication_font
txt_m_ftime_r.init_pos        = {40.0, -75}                                       -- {50.0, -80.5}
txt_m_ftime_r.alignment       = "CenterCenter"
txt_m_ftime_r.formats         = {"%1.f"}
txt_m_ftime_r.stringdefs      = font_size_default                                 -- {0.006,0.006}
txt_m_ftime_r.controllers     = {{"aam_S530_TOF_D"}}
AddHUDElement(txt_m_ftime_r)

-- Gun Ammo
local txt_g_ammo_L            = CreateElement "ceStringPoly"
txt_g_ammo_L.name             = "txt_g_ammo_L"
txt_g_ammo_L.material         = indication_font
txt_g_ammo_L.init_pos         = {-20.0, -89}                                      -- {-50.0, -99.5}
txt_g_ammo_L.alignment        = "CenterCenter"
txt_g_ammo_L.formats          = {"%d"}
txt_g_ammo_L.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_g_ammo_L.controllers      = {{"vis_gun_can"}, {"txt_gammo_l"}}
AddHUDElement(txt_g_ammo_L)

local txt_g_ammo_R            = CreateElement "ceStringPoly"
txt_g_ammo_R.name             = "txt_g_ammo_R"
txt_g_ammo_R.material         = indication_font
txt_g_ammo_R.init_pos         = {20.0, -89}                                       -- {52.0, -99.5}
txt_g_ammo_R.alignment        = "CenterCenter"
txt_g_ammo_R.formats          = {"%d"}
txt_g_ammo_R.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_g_ammo_R.controllers      = {{"vis_gun_can"}, {"txt_gammo_r"}}
AddHUDElement(txt_g_ammo_R)

-- Close Air Combat Mode
local Ret_AA_CCM_Boresight          = create_vth_textured_box(515, 131, 718, 334) -- ( 530, 130,715,315)
Ret_AA_CCM_Boresight.name           = "Ret_AA_CCM_Boresight"
Ret_AA_CCM_Boresight.init_pos       = {0, 92, 0}                                  -- {0, 90, 0}
Ret_AA_CCM_Boresight.controllers    = {{"hud_aa_mode"}, {"aa_cam_bore"}}
AddHUDElement(Ret_AA_CCM_Boresight)

local Ret_AA_CCM_VScan              = create_vth_textured_box(774, 632, 804, 987) -- ( 774, 632, 807, 988)
Ret_AA_CCM_VScan.name               = "Ret_AA_CCM_VScan"
Ret_AA_CCM_VScan.init_pos           = {0, 15, 0}
Ret_AA_CCM_VScan.controllers        = {{"hud_aa_mode"}, {"aa_cam_vscan"}}
AddHUDElement(Ret_AA_CCM_VScan)

local Ret_AA_CCM_HScan              = create_vth_textured_box(771, 990, 1016, 1020) -- ( 771, 990, 1018, 1023)
Ret_AA_CCM_HScan.name               = "Ret_AA_CCM_HScan"
Ret_AA_CCM_HScan.init_pos           = {0, 80, 0}
Ret_AA_CCM_HScan.controllers        = {{"hud_aa_mode"}, {"aa_cam_hscan"}}
AddHUDElement(Ret_AA_CCM_HScan)

local AA_CCM_Text_SMode             = CreateElement "ceStringPoly"
AA_CCM_Text_SMode.name              = "AA_CCM_Text_SMode"
AA_CCM_Text_SMode.material          = indication_font
--AA_CCM_Text_SMode.init_pos          = {114.0, 33.0}                               -- {90.0, 12.0, 0}
--AA_CCM_Text_SMode.init_pos          = {127.0, 21.0}                               -- {90.0, 12.0, 0}
AA_CCM_Text_SMode.init_pos          = {114.0, 73.0}                               -- {90.0, 12.0, 0}
AA_CCM_Text_SMode.alignment         = "RightTop"                                  -- "LeftCenter"
AA_CCM_Text_SMode.formats           = {"%s"}
AA_CCM_Text_SMode.stringdefs        = font_size_default                           -- {0.006,0.006}
AA_CCM_Text_SMode.controllers       = {{"hud_aa_mode"}, {"aa_cam_text_smode"}}
AddHUDElement(AA_CCM_Text_SMode)

-- WEAPONS CUES
local txt_dom_magic             = CreateElement "ceStringPoly"
txt_dom_magic.name              = "txt_dom_magic"
txt_dom_magic.material          = indication_font_light                           -- indication_font
txt_dom_magic.init_pos          = {0.0, -52.0, 0.0}                                -- {0.0, -50.0, 0.0}
txt_dom_magic.alignment         = "CenterCenter"
txt_dom_magic.stringdefs        = font_size_large                                 -- {0.009,0.009}
txt_dom_magic.value             = "DOM"
txt_dom_magic.controllers       = {{"vis_gun_dom"}}
AddHUDElement(txt_dom_magic)

local txt_shoot_cue             = CreateElement "ceStringPoly"
txt_shoot_cue.name              = "txt_shoot_cue"
txt_shoot_cue.material          = indication_font_light                           -- indication_font
txt_shoot_cue.init_pos          = {0.0, -52.0, 0.0}                                -- {0.0, -50.0, 0.0}
txt_shoot_cue.alignment         = "CenterCenter"
txt_shoot_cue.stringdefs        = font_size_large                                 -- {0.009,0.009}
txt_shoot_cue.formats           = {"%s"}
txt_shoot_cue.controllers       = {{"aam_shoot_cue"}}
AddHUDElement(txt_shoot_cue)

local AAM_No_Shoot_Cue          = create_vth_textured_box(805, 635, 1020, 840)    -- (805, 630, 1020, 845)
AAM_No_Shoot_Cue.name           = "AAM_No_Shoot_Cue"
AAM_No_Shoot_Cue.init_pos       = {0.0 ,0.0, 0.0}
AAM_No_Shoot_Cue.controllers    = {{"vis_aam_nscue"}}
AddHUDElement(AAM_No_Shoot_Cue)

-- RETICLES
local Ret_Gun_Cross             = create_vth_textured_box(970, 23, 1007, 60)      -- ( 970, 20, 1010, 60)
Ret_Gun_Cross.name              = "Ret_Gun_Cross"
Ret_Gun_Cross.init_pos          = {0, 0, 0}
Ret_Gun_Cross.parent_element    = FOV_center.name
Ret_Gun_Cross.controllers       = {{"vis_gun_cross"}}
AddHUDElement(Ret_Gun_Cross)

-- AA - Gun
local feds_line_snake               = CreateElement "ceSimpleLineObject"
feds_line_snake.name                = "feds_line_snake"
feds_line_snake.material            = vth_line_material
feds_line_snake.width               = 0.8                                         -- 0.8
feds_line_snake.parent_element      = FOV_center.name
feds_line_snake.controllers         = {{"hud_no_ins"}, {"aa_gs_snake_vis"}, {"aa_gs_snake"}}
AddHUDElement(feds_line_snake)

local GS_Aperture_1a                = CreateElement "ceSimpleLineObject"
GS_Aperture_1a.name                 = "GS_Aperture_1a"
GS_Aperture_1a.material             = vth_line_material
GS_Aperture_1a.width                = 0.8                                         -- 0.8
GS_Aperture_1a.init_pos             = {0, 0, 0}
GS_Aperture_1a.parent_element       = FOV_center.name
GS_Aperture_1a.controllers          = {{"hud_no_ins"}, {"aa_gs_snake_vis"}, {"aa_gs_snake_p1"}}
AddHUDElement(GS_Aperture_1a)

local GS_Aperture_1b                = CreateElement "ceSimpleLineObject"
GS_Aperture_1b.name                 = "GS_Aperture_1b"
GS_Aperture_1b.material             = vth_line_material
GS_Aperture_1b.width                = 0.8                                        -- 0.8
GS_Aperture_1b.init_pos             = {0, 0, 0}
GS_Aperture_1b.parent_element       = FOV_center.name
GS_Aperture_1b.controllers          = {{"hud_no_ins"}, {"aa_gs_snake_vis"}, {"aa_gs_snake_p2"}}
AddHUDElement(GS_Aperture_1b)

local GS_Gun_Radar_Cross            = create_vth_textured_box(721, 139, 873, 291) -- ( 722, 140, 873, 291)
GS_Gun_Radar_Cross.name             = "GS_Gun_Radar_Cross"
GS_Gun_Radar_Cross.init_pos         = {0, 0, 0}
GS_Gun_Radar_Cross.parent_element   = FOV_center.name
GS_Gun_Radar_Cross.controllers      = {{"hud_no_ins"}, {"aa_gs_snake_vis"}, {"aa_gs_cross"}}
AddHUDElement(GS_Gun_Radar_Cross)

local GS_Radar_Cross_Range          = CreateElement "ceSimpleLineObject"
GS_Radar_Cross_Range.name           = "GS_Radar_Cross_Range"
GS_Radar_Cross_Range.material       = vth_line_material
GS_Radar_Cross_Range.width          = 0.8                                       -- 0.8
GS_Radar_Cross_Range.init_pos       = {0, 0, 0}
GS_Radar_Cross_Range.parent_element = GS_Gun_Radar_Cross.name
GS_Radar_Cross_Range.controllers    = {{"hud_no_ins"}, {"aa_gs_snake_vis"}, {"aa_gs_range"}}
AddHUDElement(GS_Radar_Cross_Range)

-- Missiles
local AAM_NEZ_Ring                  = create_vth_textured_box(198, 649, 339, 790)       -- ( 192, 643, 346, 797)
AAM_NEZ_Ring.name                   = "AAM_NEZ_Ring"
AAM_NEZ_Ring.init_pos               = {0, -4, 0}                                        -- {0, 0, 0}
AAM_NEZ_Ring.controllers            = {{"vis_aam_nez"}}
AddHUDElement(AAM_NEZ_Ring)


