-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.8 (06/17/2020) for DCS World 2.5.6.49798 (05/29/2020)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."VTB/"
dofile(my_path.."VTB_definitions.lua")
dofile(my_path.."VTB_MDO_Menu.lua")

local DBG_RED = MakeMaterial(nil, {255,0,0,50})

-- Heading Tape
vtb_tape_begin                  = CreateElement "ceMeshPoly"
vtb_tape_begin.name             = "vtb_tape_begin"
vtb_tape_begin.vertices         = {{0.64, 0.1}, {-0.79, 0.1}, {-0.79,-0.1}, {0.64, -0.1}}  -- { {0.82, 0.1}, {-0.82, 0.1}, {-0.82,-0.1}, {0.82, -0.1}, }
vtb_tape_begin.indices          = {0,1,2 ; 0,2,3}
vtb_tape_begin.init_pos         = {0.03, -0.85, 0}                                -- {0, -0.8, 0}
vtb_tape_begin.material         = DBG_RED
vtb_tape_begin.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
vtb_tape_begin.level            = VTB_DEFAULT_LEVEL
vtb_tape_begin.isvisible        = false
vtb_tape_begin.collimated       = false
vtb_tape_begin.z_enabled        = false
Add(vtb_tape_begin)

vtb_tape_hdg                    = create_vtb_hdg_box( 0, 0, 3072, 62, 346)        -- ( 0, 0, 3448, 72, 440)
vtb_tape_hdg.name               = "vtb_tape_hdg"
vtb_tape_hdg.init_pos           = {0.03 ,-0.85, 0}                                -- {0 ,-0.8, 0}
vtb_tape_hdg.h_clip_relation    = h_clip_relations.COMPARE
vtb_tape_hdg.level              = VTB_DEFAULT_LEVEL + 1
vtb_tape_hdg.controllers        = {{"vtb_hdg" , -0.0609}}                        -- {{"vtb_hdg" , -0.07049}}
vtb_tape_hdg.isvisible          = true
vtb_tape_hdg.collimated         = false
vtb_tape_hdg.use_mipfilter      = true
vtb_tape_hdg.additive_alpha     = true
Add(vtb_tape_hdg)

vtb_tape_end                    = CreateElement "ceMeshPoly"
vtb_tape_end.name               = "vtb_tape_end"
vtb_tape_end.vertices           = vtb_tape_begin.vertices
vtb_tape_end.indices            = vtb_tape_begin.indices
vtb_tape_end.init_pos           = vtb_tape_begin.init_pos
vtb_tape_end.material           = vtb_tape_begin.material
vtb_tape_end.h_clip_relation    = h_clip_relations.DECREASE_IF_LEVEL
vtb_tape_end.level              = VTB_DEFAULT_LEVEL + 1
vtb_tape_end.isvisible          = false
vtb_tape_end.collimated         = false
vtb_tape_end.z_enabled          = false
Add(vtb_tape_end)

vtb_tape_idx                    = create_vtb_textured_box(1004, 6, 1015, 32)      -- ( 217, 0,227, 40)
vtb_tape_idx.name               = "vtb_tape_idx"
vtb_tape_idx.init_pos           = {0.03,-0.75,0}                                   -- {0.0,-0.7,0}
Add_VTB_Element(vtb_tape_idx)

-- Lubber Line
local vtb_lubber_ind            = create_vtb_textured_box(636, 4, 677, 41)        -- (640, 5, 677, 38)
vtb_lubber_ind.name             = "vtb_lubber_ind"
vtb_lubber_ind.init_pos         = {0.03,-0.79,0}                                  -- {0,-0.8,0}
vtb_lubber_ind.additive_alpha   = true
Add_VTB_Element(vtb_lubber_ind)

-- Velocity Vector
local ac_vvector                = CreateElement "ceSimpleLineObject"
ac_vvector.name                 = "ac_vvector"
ac_vvector.material             = vtb_line_material
ac_vvector.width                = 0.005                                           -- 0.005
ac_vvector.init_pos             = {0.0,-0.77,0}                                   -- {0,-0.65,0}
ac_vvector.controllers          = {{"vtb_ac_gsp"}}
Add_VTB_Element(ac_vvector)

local ac_vv_arrow               = create_vtb_textured_box(781, 3, 814, 37)        -- ( 789, 13, 809, 31)
ac_vv_arrow.name                = "ac_vv_arrow"
ac_vv_arrow.init_pos            = {0.0,-0.77,0}                                   -- {0,-0.65,0}
ac_vv_arrow.controllers         = {{"vtb_ac_arrow"}}
ac_vv_arrow.additive_alpha      = true
Add_VTB_Element(ac_vv_arrow)

-- ADI
local vtb_roll_ind              = create_vtb_textured_box(71, 3, 391, 17)          -- (7, 9, 459, 13)
vtb_roll_ind.name               = "vtb_roll_ind"
vtb_roll_ind.init_pos           = {0,0,0}
vtb_roll_ind.controllers        = {{"vtb_ac_attitude", 0.5, -0.05}}
vtb_roll_ind.additive_alpha     = true
Add_VTB_Element(vtb_roll_ind)

local vtb_pitch_ind             = create_vtb_textured_box(593, 53, 719, 94)   -- ( 591, 55, 724, 90)
vtb_pitch_ind.name              = "vtb_pitch_ind"
vtb_pitch_ind.init_pos          = {0,0.0,0}
vtb_pitch_ind.additive_alpha    = true
Add_VTB_Element(vtb_pitch_ind)

-- Warning Messages
local vtb_rdr_disabled          = create_vtb_textured_box(804, 805, 986, 987)    -- (797, 806, 986, 995)
vtb_rdr_disabled.name           = "vtb_rdr_disabled"
vtb_rdr_disabled.init_pos       = {0.0, 0.0, 0.0}
vtb_rdr_disabled.controllers    = {{"vis_radar"}}
vtb_rdr_disabled.additive_alpha = true
Add_VTB_Element(vtb_rdr_disabled)

local vtb_rdr_stby              = create_vtb_textured_box(195, 109, 283, 149)     -- (190, 107, 280, 151)
vtb_rdr_stby.name               = "vtb_rdr_stby"
vtb_rdr_stby.init_pos           = {0.0,-0.15, 0.0}
vtb_rdr_stby.controllers        = {{"vis_sil"}}
vtb_rdr_stby.additive_alpha     = true
Add_VTB_Element(vtb_rdr_stby)

local vtb_rdr_pheat             = create_vtb_textured_box(314, 109, 343, 149)     -- (321, 107, 349, 148)
vtb_rdr_pheat.name              = "vtb_rdr_pheat"
vtb_rdr_pheat.init_pos          = {0.0,-0.15, 0.0}
vtb_rdr_pheat.controllers       = {{"vis_pheat"}}
vtb_rdr_pheat.additive_alpha    = true
Add_VTB_Element(vtb_rdr_pheat)

-- Info Messages
-- Bottom
local vtb_txt_asi               = CreateElement "ceStringPoly"
vtb_txt_asi.name                = "vtb_txt_asi"
vtb_txt_asi.material            = vtb_indication_font
vtb_txt_asi.init_pos            = {-0.69, -0.91, 0.0}                             -- {-0.6, -0.9, 0.0}
vtb_txt_asi.alignment           = "LeftCenter"                                    -- "RightCenter"
vtb_txt_asi.formats             = {"%01.f"}
vtb_txt_asi.stringdefs          = vtb_font_size_default                           -- {0.004,0.004}
vtb_txt_asi.controllers         = {{"txt_asi",0}}
Add_VTB_Element(vtb_txt_asi)

local vtb_txt_mach              = CreateElement "ceStringPoly"
vtb_txt_mach.name               = "vtb_txt_mach"
vtb_txt_mach.material           = vtb_indication_font
vtb_txt_mach.init_pos           = {-0.69, -0.965, 0.0}                              -- {-0.6, -0.96, 0.0}
vtb_txt_mach.alignment          = "LeftCenter"                                      -- "RightCenter"
vtb_txt_mach.formats            = {"%01.1f"}                                        -- {"%01.2f"}
vtb_txt_mach.stringdefs         = vtb_font_size_default                           -- {0.004,0.004}
vtb_txt_mach.controllers        = {{"txt_mach",0}}
Add_VTB_Element(vtb_txt_mach)

local vtb_txt_balt              = CreateElement "ceStringPoly"
vtb_txt_balt.name               = "vtb_txt_balt"
vtb_txt_balt.material           = vtb_indication_font
vtb_txt_balt.init_pos           = {0.65, -0.91, 0.0}                                -- {0.8, -0.9, 0.0}
vtb_txt_balt.alignment          = "RightCenter"
vtb_txt_balt.formats            = {"%01.f"}
vtb_txt_balt.stringdefs         = vtb_font_size_default                           -- {0.004,0.004}
vtb_txt_balt.controllers        = {{"txt_balt",0}}
Add_VTB_Element(vtb_txt_balt)

local vtb_txt_ralt_h            = CreateElement "ceStringPoly"
vtb_txt_ralt_h.name             = "vtb_txt_ralt_h"
vtb_txt_ralt_h.material         = vtb_indication_font
vtb_txt_ralt_h.init_pos         = {0.38, -0.965, 0.0}                               -- {0.55, -0.96, 0.0}
vtb_txt_ralt_h.alignment        = "LeftCenter"
vtb_txt_ralt_h.value            = "H"
vtb_txt_ralt_h.stringdefs       = vtb_font_size_default                           -- {0.004,0.004}
vtb_txt_ralt_h.controllers      = {{"vis_ralt"}}
Add_VTB_Element(vtb_txt_ralt_h)

local vtb_txt_ralt              = CreateElement "ceStringPoly"
vtb_txt_ralt.name               = "vtb_txt_ralt"
vtb_txt_ralt.material           = vtb_indication_font
vtb_txt_ralt.init_pos           = {0.65, -0.965, 0.0}                               -- {0.8, -0.96, 0.0}
vtb_txt_ralt.alignment          = "RightCenter"
vtb_txt_ralt.formats            = {"%01.f"}
vtb_txt_ralt.stringdefs         = vtb_font_size_default                           -- {0.004,0.004}
vtb_txt_ralt.controllers        = {{"txt_ralt"}}
Add_VTB_Element(vtb_txt_ralt)

local vtb_txt_ralt_i            = CreateElement "ceStringPoly"
vtb_txt_ralt_i.name             = "vtb_txt_ralt_i"
vtb_txt_ralt_i.material         = vtb_indication_font
vtb_txt_ralt_i.init_pos         = {0.65, -0.965, 0.0}                               -- {0.8, -0.96, 0.0}
vtb_txt_ralt_i.alignment        = "RightCenter"
vtb_txt_ralt_i.value            = "****"
vtb_txt_ralt_i.stringdefs       = vtb_font_size_default                           -- {0.004,0.004}
vtb_txt_ralt_i.controllers      = {{"vis_ralt_i"}}
Add_VTB_Element(vtb_txt_ralt_i)

-- NAV Data
local vtb_nav_wpn               = CreateElement "ceStringPoly"
vtb_nav_wpn.name                = "vtb_nav_wpn"
vtb_nav_wpn.material            = vtb_indication_font
vtb_nav_wpn.init_pos            = {-0.68, -0.57, 0.0}                             -- {-0.55, -0.58, 0.0}
vtb_nav_wpn.alignment           = "CenterCenter"
vtb_nav_wpn.formats             = {"%02d"}
vtb_nav_wpn.stringdefs          = vtb_font_size_small                             -- {0.004,0.004}
vtb_nav_wpn.controllers         = {{"txt_nav_wpn"}}
Add_VTB_Element(vtb_nav_wpn)

local vtb_nav_wpr0              = CreateElement "ceStringPoly"
vtb_nav_wpr0.name               = "vtb_nav_wpr0"
vtb_nav_wpr0.material           = vtb_indication_font
vtb_nav_wpr0.init_pos           = {-0.68, -0.65, 0.0}                             -- {-0.55, -0.65, 0.0}
vtb_nav_wpr0.alignment          = "CenterCenter"
vtb_nav_wpr0.formats            = {"%1.1f/%03d"}
vtb_nav_wpr0.stringdefs         = vtb_font_size_small                             -- {0.004,0.004}
vtb_nav_wpr0.controllers        = {{"txt_nav_wpr0"}}
Add_VTB_Element(vtb_nav_wpr0)

local vtb_nav_wpr1              = CreateElement "ceStringPoly"
vtb_nav_wpr1.name               = "vtb_nav_wpr1"
vtb_nav_wpr1.material           = vtb_indication_font
vtb_nav_wpr1.init_pos           = {-0.68, -0.65, 0.0}                             -- {-0.55, -0.65, 0.0}
vtb_nav_wpr1.alignment          = "CenterCenter"
vtb_nav_wpr1.formats            = {"%1.f/%03d"}
vtb_nav_wpr1.stringdefs         = vtb_font_size_small                             -- {0.004,0.004}
vtb_nav_wpr1.controllers        = {{"txt_nav_wpr1"}}
Add_VTB_Element(vtb_nav_wpr1)

-- Waypoints
local vtb_wp_1_pos              = create_vtb_textured_box(23, 223, 58, 258)       -- (23, 221, 60, 258)
vtb_wp_1_pos.name               = "vtb_wp_1_pos"
vtb_wp_1_pos.init_pos           = {0.0,-0.7, 0.0}
vtb_wp_1_pos.controllers        = {{"wp01_pos"}}
Add_VTB_Element(vtb_wp_1_pos)

local vtb_wp_1_lbl              = CreateElement "ceStringPoly"
vtb_wp_1_lbl.name               = "vtb_wp_1_lbl"
vtb_wp_1_lbl.material           = vtb_indication_font
vtb_wp_1_lbl.init_pos           = {0.07,0.0, 0.0}
vtb_wp_1_lbl.alignment          = "CenterCenter"
vtb_wp_1_lbl.formats            = {"%d"}
vtb_wp_1_lbl.stringdefs         = vtb_font_size_default                           -- {0.004,0.004}
vtb_wp_1_lbl.parent_element     = vtb_wp_1_pos.name
vtb_wp_1_lbl.controllers        = {{"wp01_lbl"}}
Add_VTB_Element(vtb_wp_1_lbl)

local vtb_wp_2_pos              = create_vtb_textured_box(23, 223, 58, 258)       -- (23, 221, 60, 258)
vtb_wp_2_pos.name               = "vtb_wp_2_pos"
vtb_wp_2_pos.init_pos           = {0.0,-0.7, 0.0}
vtb_wp_2_pos.controllers        = {{"wp02_pos"}}
Add_VTB_Element(vtb_wp_2_pos)

local vtb_wp_2_lbl              = CreateElement "ceStringPoly"
vtb_wp_2_lbl.name               = "vtb_wp_2_lbl"
vtb_wp_2_lbl.material           = vtb_indication_font
vtb_wp_2_lbl.init_pos           = {0.07,0.0, 0.0}
vtb_wp_2_lbl.alignment          = "CenterCenter"
vtb_wp_2_lbl.formats            = {"%d"}
vtb_wp_2_lbl.stringdefs         = vtb_font_size_default                           -- {0.004,0.004}
vtb_wp_2_lbl.parent_element     = vtb_wp_2_pos.name
vtb_wp_2_lbl.controllers        = {{"wp02_lbl"}}
Add_VTB_Element(vtb_wp_2_lbl)

local vtb_wp_3_pos              = create_vtb_textured_box(23, 223, 58, 258)       -- (23, 221, 60, 258)
vtb_wp_3_pos.name               = "vtb_wp_3_pos"
vtb_wp_3_pos.init_pos           = {0.0,-0.7, 0.0}
vtb_wp_3_pos.controllers        = {{"wp03_pos"}}
Add_VTB_Element(vtb_wp_3_pos)

local vtb_wp_3_lbl              = CreateElement "ceStringPoly"
vtb_wp_3_lbl.name               = "vtb_wp_3_lbl"
vtb_wp_3_lbl.material           = vtb_indication_font
vtb_wp_3_lbl.init_pos           = {0.07,0.0, 0.0}
vtb_wp_3_lbl.alignment          = "CenterCenter"
vtb_wp_3_lbl.formats            = {"%d"}
vtb_wp_3_lbl.stringdefs         = vtb_font_size_default                           -- {0.004,0.004}
vtb_wp_3_lbl.parent_element     = vtb_wp_3_pos.name
vtb_wp_3_lbl.controllers        = {{"wp03_lbl"}}
Add_VTB_Element(vtb_wp_3_lbl)

local vtb_wp_4_pos              = create_vtb_textured_box(23, 223, 58, 258)       -- (23, 221, 60, 258)
vtb_wp_4_pos.name               = "vtb_wp_4_pos"
vtb_wp_4_pos.init_pos           = {0.0,-0.7, 0.0}
vtb_wp_4_pos.controllers        = {{"wp04_pos"}}
Add_VTB_Element(vtb_wp_4_pos)

local vtb_wp_4_lbl              = CreateElement "ceStringPoly"
vtb_wp_4_lbl.name               = "vtb_wp_4_lbl"
vtb_wp_4_lbl.material           = vtb_indication_font
vtb_wp_4_lbl.init_pos           = {0.07,0.0, 0.0}
vtb_wp_4_lbl.alignment          = "CenterCenter"
vtb_wp_4_lbl.formats            = {"%d"}
vtb_wp_4_lbl.stringdefs         = vtb_font_size_default                           -- {0.004,0.004}
vtb_wp_4_lbl.parent_element     = vtb_wp_4_pos.name
vtb_wp_4_lbl.controllers        = {{"wp04_lbl"}}
Add_VTB_Element(vtb_wp_4_lbl)

local vtb_wp_5_pos              = create_vtb_textured_box(23, 223, 58, 258)       -- (23, 221, 60, 258)
vtb_wp_5_pos.name               = "vtb_wp_5_pos"
vtb_wp_5_pos.init_pos           = {0.0,-0.7, 0.0}
vtb_wp_5_pos.controllers        = {{"wp05_pos"}}
Add_VTB_Element(vtb_wp_5_pos)

local vtb_wp_5_lbl              = CreateElement "ceStringPoly"
vtb_wp_5_lbl.name               = "vtb_wp_5_lbl"
vtb_wp_5_lbl.material           = vtb_indication_font
vtb_wp_5_lbl.init_pos           = {0.07,0.0, 0.0}
vtb_wp_5_lbl.alignment          = "CenterCenter"
vtb_wp_5_lbl.formats            = {"%d"}
vtb_wp_5_lbl.stringdefs         = vtb_font_size_default                           -- {0.004,0.004}
vtb_wp_5_lbl.parent_element     = vtb_wp_5_pos.name
vtb_wp_5_lbl.controllers        = {{"wp05_lbl"}}
Add_VTB_Element(vtb_wp_5_lbl)

-- Radar lock mode
vtb_r_txt_aalmod                = CreateElement "ceStringPoly"
vtb_r_txt_aalmod.name           = "vtb_r_txt_aalmod"
vtb_r_txt_aalmod.material       = vtb_indication_font
vtb_r_txt_aalmod.init_pos       = {0.75, -0.65, 0.0}                                -- {0.6, -0.6, 0.0}
vtb_r_txt_aalmod.alignment      = "CenterCenter"
vtb_r_txt_aalmod.formats        = {"%s"}
vtb_r_txt_aalmod.stringdefs     = vtb_font_size_default                             -- {0.005,0.005}
vtb_r_txt_aalmod.controllers    = {{"txt_radar_lmod"}}
Add_VTB_Element(vtb_r_txt_aalmod)

-- TDC
vtb_rdr_TDC                         = create_vtb_textured_box(81, 157, 197, 269)  -- ( 81, 157, 197, 268)
vtb_rdr_TDC.name                    = "vtb_rdr_TDC"
vtb_rdr_TDC.init_pos                = {0.0, -0.7, 0.0}
vtb_rdr_TDC.controllers             = {{"rdr_TDC_pos"}}
vtb_rdr_TDC.additive_alpha          = true
Add_VTB_Element(vtb_rdr_TDC)

rdr_TDC_rng_1                       = CreateElement "ceStringPoly"
rdr_TDC_rng_1.name                  = "rdr_TDC_rng_1"
rdr_TDC_rng_1.material              = vtb_indication_font
rdr_TDC_rng_1.init_pos              = {-0.13, 0.03, 0.0}                          -- {-0.13, 0.0, 0.0}
rdr_TDC_rng_1.alignment             = "RightCenter"
rdr_TDC_rng_1.formats               = {"%1.f"}
rdr_TDC_rng_1.stringdefs            = vtb_font_size_big                           -- {0.005,0.005}
rdr_TDC_rng_1.controllers           = {{"rdr_TDC_rng"}}
rdr_TDC_rng_1.parent_element        = vtb_rdr_TDC.name
rdr_TDC_rng_1.additive_alpha        = true
Add_VTB_Element(rdr_TDC_rng_1)

rdr_TDC_rng_0                       = CreateElement "ceStringPoly"
rdr_TDC_rng_0.name                  = "rdr_TDC_rng_0"
rdr_TDC_rng_0.material              = vtb_indication_font
rdr_TDC_rng_0.init_pos              = {-0.13, 0.03, 0.0}                          -- {-0.13, 0.0, 0.0}
rdr_TDC_rng_0.alignment             = "RightCenter"
rdr_TDC_rng_0.formats               = {"%1.1f"}
rdr_TDC_rng_0.stringdefs            = vtb_font_size_big                           -- {0.005,0.005}
rdr_TDC_rng_0.controllers           = {{"rdr_TDC_rng_0"}}
rdr_TDC_rng_0.parent_element        = vtb_rdr_TDC.name
rdr_TDC_rng_0.additive_alpha        = true
Add_VTB_Element(rdr_TDC_rng_0)

rdr_TDC_alt_h                       = CreateElement "ceStringPoly"
rdr_TDC_alt_h.name                  = "rdr_TDC_alt_h"
rdr_TDC_alt_h.material              = vtb_indication_font
rdr_TDC_alt_h.init_pos              = {0.16, 0.11, 0.0}                           -- {0.25, 0.06, 0.0}
rdr_TDC_alt_h.alignment             = "RightCenter"
rdr_TDC_alt_h.formats               = {"%1.f"}
rdr_TDC_alt_h.stringdefs            = vtb_font_size_default                       -- {0.004,0.004}
rdr_TDC_alt_h.controllers           = {{"rdr_TDC_alt_h"}}
rdr_TDC_alt_h.parent_element        = vtb_rdr_TDC.name
rdr_TDC_alt_h.additive_alpha        = true
Add_VTB_Element(rdr_TDC_alt_h)

rdr_TDC_alt_m                       = CreateElement "ceStringPoly"
rdr_TDC_alt_m.name                  = "rdr_TDC_alt_m"
rdr_TDC_alt_m.material              = vtb_indication_font
rdr_TDC_alt_m.init_pos              = {0.16, 0.0, 0.0}                            -- {0.25, 0.0, 0.0}
rdr_TDC_alt_m.alignment             = "RightCenter"
rdr_TDC_alt_m.formats               = {"%1.f"}
rdr_TDC_alt_m.stringdefs            = vtb_font_size_default                       -- {0.004,0.004}
rdr_TDC_alt_m.controllers           = {{"rdr_TDC_alt_m"}}
rdr_TDC_alt_m.parent_element        = vtb_rdr_TDC.name
rdr_TDC_alt_m.additive_alpha        = true
Add_VTB_Element(rdr_TDC_alt_m)

rdr_TDC_alt_l                       = CreateElement "ceStringPoly"
rdr_TDC_alt_l.name                  = "rdr_TDC_alt_l"
rdr_TDC_alt_l.material              = vtb_indication_font
rdr_TDC_alt_l.init_pos              = {0.16, -0.11, 0.0}                          -- {0.25, -0.06, 0.0}
rdr_TDC_alt_l.alignment             = "RightCenter"
rdr_TDC_alt_l.formats               = {"%1.f"}
rdr_TDC_alt_l.stringdefs            = vtb_font_size_default                       -- {0.004,0.004}
rdr_TDC_alt_l.controllers           = {{"rdr_TDC_alt_l"}}
rdr_TDC_alt_l.parent_element        = vtb_rdr_TDC.name
rdr_TDC_alt_l.additive_alpha        = true
Add_VTB_Element(rdr_TDC_alt_l)

-- DO Track
local	vtb_rdr_trk_DO						      = create_vtb_stt_textured_box(811, 99, 897, 181)      -- ( 825, 103, 891, 179)
		vtb_rdr_trk_DO.name					      = "vtb_rdr_trk_DO"
		vtb_rdr_trk_DO.init_pos				    = {0.0, -0.7, 0.0}
		vtb_rdr_trk_DO.controllers			  = {{"rdr_track_DO_pos"}}
		vtb_rdr_trk_DO.additive_alpha		  = true
Add_VTB_Element(vtb_rdr_trk_DO)

local	vtb_rdr_trk_MDO						      = create_vtb_stt_textured_box(774, 41, 848, 92)      -- (785, 54, 835, 90)
		vtb_rdr_trk_MDO.name				      = "vtb_rdr_trk_MDO"
		vtb_rdr_trk_MDO.init_pos			    = {0.0, 0.0, 0.0}
		vtb_rdr_trk_MDO.parent_element		= vtb_rdr_trk_DO.name
		vtb_rdr_trk_MDO.controllers			  = {{"rdr_track_MDO_pos"}}
		vtb_rdr_trk_MDO.additive_alpha		= true
Add_VTB_Element(vtb_rdr_trk_MDO)

local	vtb_trk_DO_vvector					    = CreateElement "ceSimpleLineObject"
		vtb_trk_DO_vvector.name				    = "vtb_trk_DO_vvector"
		vtb_trk_DO_vvector.material   	  = vtb_line_material_DO
		vtb_trk_DO_vvector.width       	  = 0.005                                    -- 0.005
		vtb_trk_DO_vvector.init_pos			  = {0, -0.7, 0}                            -- {0, -0.7, 0} 
		vtb_trk_DO_vvector.controllers    = {{"rdr_track_DO_th"}}
Add_VTB_Element(vtb_trk_DO_vvector)

local	vtb_trk_DO_vv_arrow 				      = create_vtb_stt_textured_box(781, 3, 814, 36)  -- ( 789, 13, 809, 31)
		vtb_trk_DO_vv_arrow.name			      = "vtb_trk_DO_vv_arrow"
		vtb_trk_DO_vv_arrow.init_pos		    = {0,0,0}                              -- {0,0,0}
		vtb_trk_DO_vv_arrow.parent_element	= vtb_trk_DO_vvector.name
		vtb_trk_DO_vv_arrow.controllers  	  = {{"rdr_track_DO_ah"}}
		vtb_trk_DO_vv_arrow.additive_alpha	= true
Add_VTB_Element(vtb_trk_DO_vv_arrow)

local	vtb_trk_DO_b_angle					    = CreateElement "ceStringPoly"
		vtb_trk_DO_b_angle.name				    = "vtb_trk_DO_b_angle"
		vtb_trk_DO_b_angle.material			  = vtb_stt_indication_font
		vtb_trk_DO_b_angle.init_pos			  = {0.0, -0.75, 0.0}
		vtb_trk_DO_b_angle.alignment		  = "CenterCenter"
		vtb_trk_DO_b_angle.formats			  = {"%01.f"}
		vtb_trk_DO_b_angle.stringdefs		  = vtb_font_size_default                     -- {0.004,0.004}
		vtb_trk_DO_b_angle.controllers		= {{"rdr_track_DO_b_angle"}, {"rdr_track_DO_pos"}}
		vtb_trk_DO_b_angle.additive_alpha	= true
Add_VTB_Element(vtb_trk_DO_b_angle)

local	vtb_trk_DO_sweep					      = create_vtb_stt_textured_box(993, 6, 1003, 745, nil, 745)     -- ( 997, 8, 1003, 745, nil, 745)
		vtb_trk_DO_sweep.name				      = "vtb_trk_DO_sweep"
		vtb_trk_DO_sweep.init_pos			    = {0.0,-0.7, 0.0}
		vtb_trk_DO_sweep.controllers		  = {{"vtb_sweep_DO", 1.0}}
		vtb_trk_DO_sweep.additive_alpha	  = true
Add_VTB_Element(vtb_trk_DO_sweep)

-- DO Track Data
local	vtb_r_txt_DO_abc				        = CreateElement "ceStringPoly"
		vtb_r_txt_DO_abc.name			        = "vtb_r_txt_DO_abc"
		vtb_r_txt_DO_abc.material		      = vtb_stt_indication_font
		vtb_r_txt_DO_abc.init_pos		      = {0.55, 0.83, 0.0}                              -- {0.6, 0.8, 0.0}
		vtb_r_txt_DO_abc.alignment		    = "RightCenter"
		vtb_r_txt_DO_abc.formats		      = {"%1.f"}
		vtb_r_txt_DO_abc.stringdefs		    = vtb_font_size_default                          -- {0.004,0.004}
		vtb_r_txt_DO_abc.controllers 	    = {{"vis_ddo"}, {"txt_DO_abc"}}
Add_VTB_Element(vtb_r_txt_DO_abc)

local	vtb_r_txt_DO_vrc_l				      = CreateElement "ceStringPoly"
		vtb_r_txt_DO_vrc_l.name			      = "vtb_r_txt_DO_vrc_l"
		vtb_r_txt_DO_vrc_l.material		    = vtb_stt_indication_font
		vtb_r_txt_DO_vrc_l.init_pos		    = {0.16, 0.825, 0.0}                             -- {0.26, 0.8, 0.0}
		vtb_r_txt_DO_vrc_l.alignment	    = "LeftCenter"
		vtb_r_txt_DO_vrc_l.value		      = "VR"
		vtb_r_txt_DO_vrc_l.stringdefs	    = {0.003,0.003}
		vtb_r_txt_DO_vrc_l.controllers	  = {{"vis_ddo"}}
Add_VTB_Element(vtb_r_txt_DO_vrc_l)

local	vtb_r_txt_DO_vrc				        = CreateElement "ceStringPoly"
		vtb_r_txt_DO_vrc.name			        = "vtb_r_txt_DO_vrc"
		vtb_r_txt_DO_vrc.material		      = vtb_stt_indication_font
		vtb_r_txt_DO_vrc.init_pos		      = {0.15, 0.83, 0.0}                              -- {0.25, 0.8, 0.0}
		vtb_r_txt_DO_vrc.alignment		    = "RightCenter"
		vtb_r_txt_DO_vrc.formats		      = {"%1.f"}
		vtb_r_txt_DO_vrc.stringdefs		    = vtb_font_size_default                           -- {0.004,0.004}
		vtb_r_txt_DO_vrc.controllers 	    = {{"vis_ddo"}, {"txt_DO_vrc"}}
Add_VTB_Element(vtb_r_txt_DO_vrc)

local	vtb_r_txt_DO_rbc				        = CreateElement "ceStringPoly"
		vtb_r_txt_DO_rbc.name			        = "vtb_r_txt_DO_vrc"
		vtb_r_txt_DO_rbc.material		      = vtb_stt_indication_font
		vtb_r_txt_DO_rbc.init_pos		      = {-0.32, 0.83, 0.0}                             -- {-0.3, 0.8, 0.0}
		vtb_r_txt_DO_rbc.alignment		    = "LeftCenter"
		vtb_r_txt_DO_rbc.formats		      = {"%03.f"}
		vtb_r_txt_DO_rbc.stringdefs		    = vtb_font_size_default                           -- {0.004,0.004}
		vtb_r_txt_DO_rbc.controllers 	    = {{"vis_ddo"}, {"txt_DO_rbc"}}
Add_VTB_Element(vtb_r_txt_DO_rbc)

local	vtb_r_txt_DO_rbc_l				      = CreateElement "ceStringPoly"
		vtb_r_txt_DO_rbc_l.name			      = "vtb_r_txt_DO_rbc_l"
		vtb_r_txt_DO_rbc_l.material		    = vtb_stt_indication_font
		vtb_r_txt_DO_rbc_l.init_pos		    = {-0.38, 0.825, 0.0}                           -- {-0.35, 0.8, 0.0}
		vtb_r_txt_DO_rbc_l.alignment	    = "LeftCenter"
		vtb_r_txt_DO_rbc_l.value		      = "RB"
		vtb_r_txt_DO_rbc_l.stringdefs	    = {0.003,0.003}
		vtb_r_txt_DO_rbc_l.controllers 	  = {{"vis_ddo"}}
Add_VTB_Element(vtb_r_txt_DO_rbc_l)

local	vtb_r_txt_DO_mnc				        = CreateElement "ceStringPoly"
		vtb_r_txt_DO_mnc.name			        = "vtb_r_txt_DO_mnc"
		vtb_r_txt_DO_mnc.material		      = vtb_stt_indication_font
		vtb_r_txt_DO_mnc.init_pos		      = {-0.68, 0.83, 0.0}                              -- {-0.6, 0.8, 0.0}
		vtb_r_txt_DO_mnc.alignment		    = "LeftCenter"
		vtb_r_txt_DO_mnc.formats		      = {"%1.1f"}
		vtb_r_txt_DO_mnc.stringdefs		    = vtb_font_size_default                           -- {0.004,0.004}
		vtb_r_txt_DO_mnc.controllers 	    = {{"vis_ddo"}, {"txt_DO_mnc"}}
Add_VTB_Element(vtb_r_txt_DO_mnc)

local	vtb_r_txt_DO_RAZ				        = CreateElement "ceStringPoly"
		vtb_r_txt_DO_RAZ.name			        = "vtb_r_txt_DO_RAZ"
		vtb_r_txt_DO_RAZ.material		      = vtb_stt_indication_font
		vtb_r_txt_DO_RAZ.init_pos		      = {-0.9, -0.82, 0.0}                              -- {-0.9, -0.75, 0.0}
		vtb_r_txt_DO_RAZ.alignment		    = "LeftCenter"
		vtb_r_txt_DO_RAZ.value			      = "RAZ"
		vtb_r_txt_DO_RAZ.stringdefs		    = vtb_font_size_default                           -- {0.004,0.004}
		vtb_r_txt_DO_RAZ.controllers 	    = {{"vis_ddo_RAZ"}}
Add_VTB_Element(vtb_r_txt_DO_RAZ)
