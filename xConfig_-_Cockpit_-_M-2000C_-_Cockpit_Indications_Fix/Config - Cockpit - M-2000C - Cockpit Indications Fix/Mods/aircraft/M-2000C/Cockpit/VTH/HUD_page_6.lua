-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.8 (06/17/2020) for DCS World 2.5.6.49798 (05/29/2020)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."VTH/"
dofile(my_path.."HUD_definitions.lua")
dofile(my_path.."HUD_page_base.lua")

local TFOV_radius  =  130	-- mils

-- HUD Center
local FOV_center2           = CreateElement "ceSimple"
FOV_center2.name            = "FOV_center2"
FOV_center2.init_pos        = vth_base_init_pos
AddHUDElement(FOV_center2)

local  vth_fpm_ccip         = CreateElement "ceSimple"
vth_fpm_ccip.name           = "vth_fpm_ccip"
vth_fpm_ccip.init_pos       = {0,0,0}
vth_fpm_ccip.parent_element = FOV_center2.name
vth_fpm_ccip.controllers    = {{"hud_fpm"}, {"hud_svz", 0.6}, {"hud_svy", 0.6}}
AddHUDElement(vth_fpm_ccip)

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

-- RIGHT
local txt_grd_rng             = CreateElement "ceStringPoly"
txt_grd_rng.name              = "txt_grd_rng"
txt_grd_rng.material          = indication_font
txt_grd_rng.init_pos          = {120.0, 20.0, 0.0}                                -- {110.0, 0.0, 0.0}
txt_grd_rng.alignment         = "RightTop"
txt_grd_rng.formats           = {"%1.1f KM"}
txt_grd_rng.stringdefs        = font_size_default                                 -- {0.006,0.006}
txt_grd_rng.controllers       = {{"txt_g_range"}}
AddHUDElement(txt_grd_rng)

local txt_grd_rng_ob          = CreateElement "ceStringPoly"
txt_grd_rng_ob.name           = "txt_grd_rng_ob"
txt_grd_rng_ob.material       = indication_font
txt_grd_rng_ob.init_pos       = {120.0, 20.0, 0.0}                                -- {110.0, 0.0, 0.0}
txt_grd_rng_ob.alignment      = "RightTop"
txt_grd_rng_ob.value          = "**** KM" 
txt_grd_rng_ob.stringdefs     = font_size_default                                 -- {0.006,0.006}
txt_grd_rng_ob.controllers    = {{"vis_gun_rng"}}
AddHUDElement(txt_grd_rng_ob)

local txt_grd_rng_nr          = CreateElement "ceStringPoly"
txt_grd_rng_nr.name           = "txt_grd_rng_nr"
txt_grd_rng_nr.material       = indication_font
txt_grd_rng_nr.init_pos       = {120.0, 20.0, 0.0}                                -- {110.0, 0.0, 0.0}
txt_grd_rng_nr.alignment      = "RightTop"
txt_grd_rng_nr.value          = "KM"
txt_grd_rng_nr.stringdefs     = font_size_default                                 -- {0.006,0.006}
txt_grd_rng_nr.controllers    = {{"vis_gun_no_rng"}}
AddHUDElement(txt_grd_rng_nr)

-- BOTTOM DATA
-- Gun Ammo
local txt_g_ammo_L            = CreateElement "ceStringPoly"
txt_g_ammo_L.name             = "txt_g_ammo_L"
txt_g_ammo_L.material         = indication_font
txt_g_ammo_L.init_pos         = {-20.0, -89}                                      -- {-50.0, -99.5}
txt_g_ammo_L.alignment        = "CenterCenter"
txt_g_ammo_L.formats          = {"%d"}
txt_g_ammo_L.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_g_ammo_L.controllers      = {{"vis_gun_cas"}, {"txt_gammo_l"}}
AddHUDElement(txt_g_ammo_L)

local txt_g_ammo_R            = CreateElement "ceStringPoly"
txt_g_ammo_R.name             = "txt_g_ammo_R"
txt_g_ammo_R.material         = indication_font
txt_g_ammo_R.init_pos         = {20.0, -89}                                       -- {52.0, -99.5}
txt_g_ammo_R.alignment        = "CenterCenter"
txt_g_ammo_R.formats          = {"%d"}
txt_g_ammo_R.stringdefs       = font_size_default                                 -- {0.006,0.006}
txt_g_ammo_R.controllers      = {{"vis_gun_cas"}, {"txt_gammo_r"}}
AddHUDElement(txt_g_ammo_R)

-- 530D Salvo fire
local txt_salvo_fire          = CreateElement "ceStringPoly"
txt_salvo_fire.name           = "txt_salvo_fire"
txt_salvo_fire.material       = indication_font
txt_salvo_fire.init_pos       = {0.0, -89}                                        -- {0.0, -99.5, 0.0}
txt_salvo_fire.alignment      = "CenterCenter"
txt_salvo_fire.stringdefs     = font_size_default                                 -- {0.007,0.007}
txt_salvo_fire.value          = "S"
txt_salvo_fire.controllers    = {{"vis_530D_salvo"}}
AddHUDElement(txt_salvo_fire)

-- RETICLES
-- CCRP NORMAL
local Ret_CCRP_Sight              = create_vth_textured_box(710, 61, 793, 118)    -- ( 713, 63, 791, 116)
Ret_CCRP_Sight.name               = "Ret_CCRP_Sight"
Ret_CCRP_Sight.init_pos           = {0, 0.0, 0}
Ret_CCRP_Sight.parent_element     = FOV_center2.name
Ret_CCRP_Sight.controllers        = {{"ag_ccrp_sight"}}
AddHUDElement(Ret_CCRP_Sight)

local Ret_CCRP_Sight_Az           = create_vth_textured_box(90, 212, 250, 219)    -- ( 92, 213, 248, 216)
Ret_CCRP_Sight_Az.name            = "Ret_CCRP_Sight_Az"
Ret_CCRP_Sight_Az.init_pos        = {0, 0, 0}
Ret_CCRP_Sight_Az.parent_element  = Ret_CCRP_Sight.name
Ret_CCRP_Sight_Az.controllers     = {{"ag_ccrp_ERR", 0.8}}
AddHUDElement(Ret_CCRP_Sight_Az)

local Ret_CCRP_Sight_Cue          = create_vth_textured_box(266, 212, 426, 219)   -- ( 268, 214, 372, 218)
Ret_CCRP_Sight_Cue.name           = "Ret_CCRP_Sight_Cue"
Ret_CCRP_Sight_Cue.init_pos       = {0, 0, 0}
Ret_CCRP_Sight_Cue.parent_element = Ret_CCRP_Sight.name
Ret_CCRP_Sight_Cue.controllers    = {{"ag_ccrp_CUE", 0.8}}
AddHUDElement(Ret_CCRP_Sight_Cue)

-- CCRP IP
local CCRP_IP_reticule            =  create_vth_textured_box(525, 57, 583, 114)   -- ( 526, 59, 581, 113)
CCRP_IP_reticule.name             = "CCRP_IP_reticule"
CCRP_IP_reticule.init_pos         = {0, 0, 0}
CCRP_IP_reticule.parent_element   = FOV_center2.name
CCRP_IP_reticule.controllers      = {{"ag_ccrp_IP_TGT"}}
AddHUDElement(CCRP_IP_reticule)

local Ret_CCRP_IP_TRK_ERR         = create_vth_textured_box(806, 887, 1013, 894)  -- ( 808, 888, 1001, 892)
Ret_CCRP_IP_TRK_ERR.name          = "Ret_CCRP_IP_TRK_ERR"
Ret_CCRP_IP_TRK_ERR.init_pos      = {0, 0, 0}
Ret_CCRP_IP_TRK_ERR.parent_element= vth_fpm_ccip.name
Ret_CCRP_IP_TRK_ERR.controllers   = {{"ag_ccrp_IP_ERR", 0.8}}
AddHUDElement(Ret_CCRP_IP_TRK_ERR)

local Ret_CCRP_IP_REL_Cue         = create_vth_textured_box(266, 212, 426, 219)   -- ( 268, 214, 372, 218)
Ret_CCRP_IP_REL_Cue.name          = "Ret_CCRP_IP_REL_Cue"
Ret_CCRP_IP_REL_Cue.init_pos      = {0, 0, 0}
Ret_CCRP_IP_REL_Cue.parent_element= vth_fpm_ccip.name
Ret_CCRP_IP_REL_Cue.controllers   = {{"ag_ccrp_IP_CUE", 0.8}}
AddHUDElement(Ret_CCRP_IP_REL_Cue)

-- CCIP
local Ret_CCIP_Sight              = create_vth_textured_box(594, 71, 703, 107)    -- ( 596, 71, 700, 105)
Ret_CCIP_Sight.name               = "Ret_CCIP_Sight"
Ret_CCIP_Sight.init_pos           = {0,0,0}
Ret_CCIP_Sight.parent_element     = FOV_center2.name
Ret_CCIP_Sight.controllers        = {{"ag_ccip_sight", 0.8}}
AddHUDElement(Ret_CCIP_Sight)

local Ret_CCIP_BFL                = CreateElement "ceSimpleLineObject"
Ret_CCIP_BFL.name                 = "Ret_CCIP_BFL"
Ret_CCIP_BFL.material             = vth_line_material                             -- MakeMaterial(nil,vth_ind_color)
Ret_CCIP_BFL.width                = 0.8                                           -- 0.7
Ret_CCIP_BFL.init_pos             = {0.2,0,0}                                     -- {0,0,0}
Ret_CCIP_BFL.parent_element       = vth_fpm_ccip.name
Ret_CCIP_BFL.controllers          = {{"ag_ccip_bfl", 0.8}}
AddHUDElement(Ret_CCIP_BFL)

local Ret_MinSafe_Height          = create_vth_textured_box(885, 262, 992, 280)   -- ( 887, 264, 989, 277)
Ret_MinSafe_Height.name           = "Ret_MinSafe_Height"
Ret_MinSafe_Height.init_pos       = {0, 0, 0}
Ret_MinSafe_Height.parent_element = vth_fpm_ccip.name
Ret_MinSafe_Height.controllers    = {{"ag_minsafe_height"}}
AddHUDElement(Ret_MinSafe_Height)

-- No Release Cue
local AG_No_Release_Cue           = create_vth_textured_box(805, 635, 1020, 840)  -- (805, 630, 1020, 845)
AG_No_Release_Cue.name            = "AG_No_Release_Cue"
AG_No_Release_Cue.init_pos        = {0.0 ,0.0 , 0.0}
AG_No_Release_Cue.controllers     = {{"ag_no_release"}}
AddHUDElement(AG_No_Release_Cue)

-- AG Gun & Rockets Reticle
local AG_Gun_Reticle              = create_vth_textured_box(719, 137, 875, 293)   -- ( 722, 140, 873, 291)
AG_Gun_Reticle.name               = "AG_Gun_Reticle"
AG_Gun_Reticle.init_pos           = {0, 0, 0}
AG_Gun_Reticle.parent_element     = FOV_center2.name
AG_Gun_Reticle.controllers        = {{"ag_gun_cross"}}
AddHUDElement(AG_Gun_Reticle)

local AG_Gun_Range                = CreateElement "ceSimpleLineObject"
AG_Gun_Range.name                 = "AG_Gun_Range"
AG_Gun_Range.material             = vth_line_material
AG_Gun_Range.width                = 0.8                                           -- 0.8
AG_Gun_Range.init_pos             = {0, 0, 0}
AG_Gun_Range.parent_element       = AG_Gun_Reticle.name
AG_Gun_Range.controllers          = {{"ag_gun_range"}}
AddHUDElement(AG_Gun_Range)

-- CCRP Nav cues
local wp_ccrp_trkerr_to           = create_vth_textured_box(881, 17, 918, 61, nil, 59) -- ( 883, 19, 916, 60, nil, 60)
wp_ccrp_trkerr_to.name            = "wp_ccrp_trkerr_to"
wp_ccrp_trkerr_to.init_pos        = {0,0,0}
wp_ccrp_trkerr_to.parent_element  = Ret_CCRP_Sight.name
wp_ccrp_trkerr_to.controllers     = {{"wp_trk_err_t", 0.6}}
AddHUDElement(wp_ccrp_trkerr_to)

local wp_ccrp_trkerr_frm          = create_vth_textured_box(922, 20, 959, 65, nil, 21)  -- ( 925, 23, 957, 64)
wp_ccrp_trkerr_frm.name           = "wp_ccrp_trkerr_frm"
wp_ccrp_trkerr_frm.init_pos       = {0,-10.0,0}
wp_ccrp_trkerr_frm.parent_element = Ret_CCRP_Sight.name
wp_ccrp_trkerr_frm.controllers    = {{"wp_trk_err_f", 0.6}}
AddHUDElement(wp_ccrp_trkerr_frm)
