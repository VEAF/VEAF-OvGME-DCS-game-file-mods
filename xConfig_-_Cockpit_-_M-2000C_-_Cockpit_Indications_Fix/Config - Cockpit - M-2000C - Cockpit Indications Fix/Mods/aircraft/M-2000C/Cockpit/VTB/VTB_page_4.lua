-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 2.4 (2021-02-04) for DCS World 2.5.6.60966 (2021-02-03)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."VTB/"
dofile(my_path.."VTB_definitions.lua")
dofile(my_path.."VTB_MDO_Menu.lua")

local DBG_RED = MakeMaterial(nil, {255,0,0,50})

-- Heading Tape
vtb_tape_begin                  = CreateElement "ceMeshPoly"
vtb_tape_begin.name             = "vtb_tape_begin"
vtb_tape_begin.vertices         = {{0.64, 0.1}, {-0.79, 0.1}, {-0.79,-0.1}, {0.64, -0.1}} -- { {0.82, 0.10}, { -0.82, 0.10}, { -0.82,-0.10}, {0.82, -0.10}, }
vtb_tape_begin.indices          = {0,1,2 ; 0,2,3}
vtb_tape_begin.init_pos         = {0.03, -0.85, 0}                                -- {0, -0.81, 0}
vtb_tape_begin.material         = DBG_RED
vtb_tape_begin.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
vtb_tape_begin.level            = VTB_DEFAULT_LEVEL
vtb_tape_begin.isvisible        = false
vtb_tape_begin.collimated       = false
vtb_tape_begin.z_enabled        = false
Add(vtb_tape_begin)

vtb_tape_hdg                    = create_vtb_hdg_ar_box( 0, 0, 3072, 62, 346)     -- ( 0, 0, 3448, 50, 440)
vtb_tape_hdg.name               = "vtb_tape_hdg"
vtb_tape_hdg.init_pos           = {0.03 ,-0.85, 0}                                -- {0 ,-0.81, 0}
vtb_tape_hdg.h_clip_relation    = h_clip_relations.COMPARE
vtb_tape_hdg.level              = VTB_DEFAULT_LEVEL + 1
vtb_tape_hdg.controllers        = {{"vtb_hdg" , -0.0609}}                         --{{"vtb_hdg" , -0.07049}}
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


-- Info Messages
-- Top
vtb_r_txt_rng                 = CreateElement "ceStringPoly"
vtb_r_txt_rng.name            = "vtb_r_txt_rng"
vtb_r_txt_rng.material        = vtb_indication_font
vtb_r_txt_rng.init_pos        = {0.07, 0.67, 0.0}                                  -- {0.07, 0.68, 0.0}
vtb_r_txt_rng.alignment       = "CenterCenter"
vtb_r_txt_rng.formats         = {"%d"}
vtb_r_txt_rng.stringdefs      = vtb_font_size_small                                -- {0.004,0.004}
vtb_r_txt_rng.controllers     = {{"txt_radar_rng"}}
Add_VTB_Element(vtb_r_txt_rng)

vtb_r_txt_aamod               = CreateElement "ceStringPoly"
vtb_r_txt_aamod.name          = "vtb_r_txt_aamod"
vtb_r_txt_aamod.material      = vtb_indication_font
vtb_r_txt_aamod.init_pos      = {0.64, 0.7, 0.0}                                  --  {0.65, 0.67, 0.0}
vtb_r_txt_aamod.alignment     = "CenterCenter"
vtb_r_txt_aamod.formats       = {"%s"}
vtb_r_txt_aamod.stringdefs    = vtb_font_size_default                             -- {0.005,0.005}
vtb_r_txt_aamod.controllers   = {{"txt_radar_aamod"}}
Add_VTB_Element(vtb_r_txt_aamod)

vtb_r_txt_jammed              = CreateElement "ceStringPoly"
vtb_r_txt_jammed.name         = "vtb_r_txt_jammed"
vtb_r_txt_jammed.material     = vtb_indication_font
vtb_r_txt_jammed.init_pos     = {-0.64, 0.7, 0.0}                                 -- {-0.65, 0.67, 0.0}
vtb_r_txt_jammed.alignment    = "CenterCenter"
vtb_r_txt_jammed.formats      = {"%s"}
vtb_r_txt_jammed.stringdefs   = vtb_font_size_default                             -- {0.005,0.005}
vtb_r_txt_jammed.controllers  = {{"txt_radar_jammed"}}
Add_VTB_Element(vtb_r_txt_jammed)


-- Lubber Line
local vtb_lubber_ind            = create_vtb_textured_box(636, 4, 677, 41)        -- (640, 5, 677, 38)
vtb_lubber_ind.name             = "vtb_lubber_ind"
vtb_lubber_ind.init_pos         = {0.03,-0.79,0}                                  -- {0,-0.785 ,0}
vtb_lubber_ind.controllers      = {{"vtb_lubber_ind"}}
vtb_lubber_ind.additive_alpha   = true
Add_VTB_Element(vtb_lubber_ind)

-- Velocity Vector
local ac_vvector                = CreateElement "ceSimpleLineObject"
ac_vvector.name                 = "ac_vvector"
ac_vvector.material             = vtb_line_material
ac_vvector.width                = 0.005
ac_vvector.init_pos             = {0,0,0}
ac_vvector.controllers          = {{"vtb_ac_gsp"}}
Add_VTB_Element(ac_vvector)

local ac_vv_arrow               = create_vtb_textured_box(781, 3, 814, 37)        -- ( 789, 13, 809, 31)
ac_vv_arrow.name                = "ac_vv_arrow"
ac_vv_arrow.init_pos            = {0.0,0.05,0}                                    -- {0, 0.05,0}
ac_vv_arrow.controllers         = {{"vtb_ac_arrow"}}
ac_vv_arrow.additive_alpha      = true
Add_VTB_Element(ac_vv_arrow)

-- RS Arrow
local ac_rsvector               = CreateElement "ceSimpleLineObject"
ac_rsvector.name                = "ac_rsvector"
ac_rsvector.material            = vtb_line_material
ac_rsvector.width               = 0.005
ac_rsvector.init_pos            = {0, -0.65,0}
ac_rsvector.controllers         = {{"vtb_rs_gsp"}}
Add_VTB_Element(ac_rsvector)

local ac_rs_arrow               = create_vtb_textured_box(686, 890 ,794, 988) -- (684, 905, 791, 999)
ac_rs_arrow.name                = "ac_rs_arrow"
ac_rs_arrow.init_pos            = {0, -0.1,0}
ac_rs_arrow.controllers         = {{"vtb_rs_arrow"}}
ac_rs_arrow.additive_alpha      = true
Add_VTB_Element(ac_rs_arrow)

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

local vtb_txt_ralt              = CreateElement "ceStringPoly"
vtb_txt_ralt.name               = "vtb_txt_ralt"
vtb_txt_ralt.material           = vtb_indication_font
vtb_txt_ralt.init_pos           = {0.65, -0.965, 0.0}                               -- {0.8, -0.96, 0.0}
vtb_txt_ralt.alignment          = "RightCenter"
vtb_txt_ralt.formats            = {"%01.f"}
vtb_txt_ralt.stringdefs         = vtb_font_size_default                           -- {0.004,0.004}
vtb_txt_ralt.controllers        = {{"txt_ralt"}}
Add_VTB_Element(vtb_txt_ralt)

-- Waypoints
for i=0,4 do
  local	vtb_wp_i_pos                = create_vtb_textured_box(23, 223, 58, 258)       -- (23, 221, 60, 258)
  vtb_wp_i_pos.name                 = "vtb_wp_"..i.."_pos"
  vtb_wp_i_pos.init_pos             = {0.0,-0.7, 0.0}
  vtb_wp_i_pos.controllers          = {{"wp_pos", 1.0*i}}
  Add_VTB_Element(vtb_wp_i_pos)

  local	vtb_wp_i_lbl                = CreateElement "ceStringPoly"
  vtb_wp_i_lbl.name                 = "vtb_wp_"..i.."_lbl"
  vtb_wp_i_lbl.material             = vtb_indication_font
  vtb_wp_i_lbl.init_pos             = {0.07,0.0, 0.0}
  vtb_wp_i_lbl.alignment            = "CenterCenter"
  vtb_wp_i_lbl.formats              = {"%d"}
  vtb_wp_i_lbl.stringdefs           = vtb_font_size_default                           -- {0.004,0.004}
  vtb_wp_i_lbl.parent_element       = vtb_wp_i_pos.name
  vtb_wp_i_lbl.controllers          = {{"wp_lbl", 1.0*i}}
  Add_VTB_Element(vtb_wp_i_lbl)
end

-- Radar lock mode
vtb_r_txt_aalmod                    = CreateElement "ceStringPoly"
vtb_r_txt_aalmod.name               = "vtb_r_txt_aalmod"
vtb_r_txt_aalmod.material           = vtb_indication_font
vtb_r_txt_aalmod.init_pos           = {0.75, -0.65, 0.0}                                -- {0.6, -0.6, 0.0}
vtb_r_txt_aalmod.alignment          = "CenterCenter"
vtb_r_txt_aalmod.formats            = {"%s"}
vtb_r_txt_aalmod.stringdefs         = vtb_font_size_default                             -- {0.005,0.005}
vtb_r_txt_aalmod.controllers        = {{"txt_radar_lmod"}}
Add_VTB_Element(vtb_r_txt_aalmod)

-- DO Track
local	vtb_rdr_trk_DO                = create_vtb_stt_textured_box(811, 99, 897, 181)  -- ( 825, 103, 891, 179)
vtb_rdr_trk_DO.name                 = "vtb_rdr_trk_DO"
vtb_rdr_trk_DO.init_pos             = {0.0,0.0,0.0}
vtb_rdr_trk_DO.controllers          = {{"rdr_track_DO_pos"}}
vtb_rdr_trk_DO.additive_alpha       = true
Add_VTB_Element(vtb_rdr_trk_DO)

local	vtb_rdr_trk_MDO               = create_vtb_stt_textured_box(774, 41, 848, 92)    -- (785, 54, 835, 90)
vtb_rdr_trk_MDO.name                = "vtb_rdr_trk_MDO"
vtb_rdr_trk_MDO.init_pos            = {0.0, 0.0, 0.0}
vtb_rdr_trk_MDO.parent_element      = vtb_rdr_trk_DO.name
vtb_rdr_trk_MDO.controllers         = {{"rdr_track_MDO_pos"}}
vtb_rdr_trk_MDO.additive_alpha      = true
Add_VTB_Element(vtb_rdr_trk_MDO)

local	vtb_trk_DO_vvector            = CreateElement "ceSimpleLineObject"
vtb_trk_DO_vvector.name             = "vtb_trk_DO_vvector"
vtb_trk_DO_vvector.material         = vtb_line_material_DO
vtb_trk_DO_vvector.width            = 0.005                                             -- 0.005
vtb_trk_DO_vvector.init_pos         = {0.0,0.0,0.0}
vtb_trk_DO_vvector.controllers      = {{"rdr_track_DO_th"}}
Add_VTB_Element(vtb_trk_DO_vvector)

local	vtb_trk_DO_vv_arrow           = create_vtb_stt_textured_box(781, 3, 814, 36)      -- ( 789, 13, 809, 31)
vtb_trk_DO_vv_arrow.name            = "vtb_trk_DO_vv_arrow"
vtb_trk_DO_vv_arrow.init_pos        = {0,0,0}
vtb_trk_DO_vv_arrow.parent_element  = vtb_trk_DO_vvector.name
vtb_trk_DO_vv_arrow.controllers     = {{"rdr_track_DO_ah"}}
vtb_trk_DO_vv_arrow.additive_alpha  = true
Add_VTB_Element(vtb_trk_DO_vv_arrow)

local	vtb_trk_DO_b_angle            = CreateElement "ceStringPoly"
vtb_trk_DO_b_angle.name             = "vtb_trk_DO_b_angle"
vtb_trk_DO_b_angle.material         = vtb_stt_indication_font
vtb_trk_DO_b_angle.init_pos         = {0.0, -0.05, 0.0}
vtb_trk_DO_b_angle.alignment        = "CenterCenter"
vtb_trk_DO_b_angle.formats          = {"%01.f"}
vtb_trk_DO_b_angle.stringdefs       = vtb_font_size_default                     -- {0.004,0.004}
vtb_trk_DO_b_angle.controllers      = {{"rdr_track_DO_b_angle"}, {"rdr_track_DO_pos"}}
vtb_trk_DO_b_angle.additive_alpha   = true
Add_VTB_Element(vtb_trk_DO_b_angle)

local	vtb_trk_DO_sweep              = create_vtb_stt_textured_box(993, 6, 1003, 745, nil, 745)     -- ( 997, 8, 1003, 745, nil, 745)
vtb_trk_DO_sweep.name               = "vtb_trk_DO_sweep"
vtb_trk_DO_sweep.init_pos           = {0.0,0.0,0.0}
vtb_trk_DO_sweep.controllers        = {{"vtb_sweep_DO", 1.0}}
vtb_trk_DO_sweep.additive_alpha     = true
Add_VTB_Element(vtb_trk_DO_sweep)

-- DO Track Data
local vtb_r_txt_DO_abc              = CreateElement "ceStringPoly"
vtb_r_txt_DO_abc.name               = "vtb_r_txt_DO_abc"
vtb_r_txt_DO_abc.material           = vtb_stt_indication_font
vtb_r_txt_DO_abc.init_pos           = {0.55, 0.83, 0.0}                              -- {0.6, 0.8, 0.0}
vtb_r_txt_DO_abc.alignment          = "RightCenter"
vtb_r_txt_DO_abc.formats            = {"%1.f"}
vtb_r_txt_DO_abc.stringdefs         = vtb_font_size_default                          -- {0.004,0.004}
vtb_r_txt_DO_abc.controllers        = {{"vis_ddo"}, {"txt_DO_abc"}}
Add_VTB_Element(vtb_r_txt_DO_abc)

local vtb_r_txt_DO_vrc_l            = CreateElement "ceStringPoly"
vtb_r_txt_DO_vrc_l.name             = "vtb_r_txt_DO_vrc_l"
vtb_r_txt_DO_vrc_l.material         = vtb_stt_indication_font
vtb_r_txt_DO_vrc_l.init_pos         = {0.16, 0.825, 0.0}                             -- {0.26, 0.8, 0.0}
vtb_r_txt_DO_vrc_l.alignment        = "LeftCenter"
vtb_r_txt_DO_vrc_l.value            = "VR"
vtb_r_txt_DO_vrc_l.stringdefs       = {0.003,0.003}
vtb_r_txt_DO_vrc_l.controllers      = {{"vis_ddo"}}
Add_VTB_Element(vtb_r_txt_DO_vrc_l)

local vtb_r_txt_DO_vrc              = CreateElement "ceStringPoly"
vtb_r_txt_DO_vrc.name               = "vtb_r_txt_DO_vrc"
vtb_r_txt_DO_vrc.material           = vtb_stt_indication_font
vtb_r_txt_DO_vrc.init_pos           = {0.15, 0.83, 0.0}                              -- {0.25, 0.8, 0.0}
vtb_r_txt_DO_vrc.alignment          = "RightCenter"
vtb_r_txt_DO_vrc.formats            = {"%1.f"}
vtb_r_txt_DO_vrc.stringdefs         = vtb_font_size_default                           -- {0.004,0.004}
vtb_r_txt_DO_vrc.controllers        = {{"vis_ddo"}, {"txt_DO_vrc"}}
Add_VTB_Element(vtb_r_txt_DO_vrc)

local vtb_r_txt_DO_rbc              = CreateElement "ceStringPoly"
vtb_r_txt_DO_rbc.name               = "vtb_r_txt_DO_vrc"
vtb_r_txt_DO_rbc.material           = vtb_stt_indication_font
vtb_r_txt_DO_rbc.init_pos           = {-0.32, 0.83, 0.0}                             -- {-0.3, 0.8, 0.0}
vtb_r_txt_DO_rbc.alignment          = "LeftCenter"
vtb_r_txt_DO_rbc.formats            = {"%03.f"}
vtb_r_txt_DO_rbc.stringdefs         = vtb_font_size_default                           -- {0.004,0.004}
vtb_r_txt_DO_rbc.controllers        = {{"vis_ddo"}, {"txt_DO_rbc"}}
Add_VTB_Element(vtb_r_txt_DO_rbc)

local vtb_r_txt_DO_rbc_l            = CreateElement "ceStringPoly"
vtb_r_txt_DO_rbc_l.name             = "vtb_r_txt_DO_rbc_l"
vtb_r_txt_DO_rbc_l.material         = vtb_stt_indication_font
vtb_r_txt_DO_rbc_l.init_pos         = {-0.38, 0.825, 0.0}                           -- {-0.38, 0.8, 0.0}
vtb_r_txt_DO_rbc_l.alignment        = "LeftCenter"
vtb_r_txt_DO_rbc_l.value            = "RB"
vtb_r_txt_DO_rbc_l.stringdefs       = {0.003,0.003}
vtb_r_txt_DO_rbc_l.controllers      = {{"vis_ddo"}}
Add_VTB_Element(vtb_r_txt_DO_rbc_l)

local vtb_r_txt_DO_mnc              = CreateElement "ceStringPoly"
vtb_r_txt_DO_mnc.name               = "vtb_r_txt_DO_mnc"
vtb_r_txt_DO_mnc.material           = vtb_stt_indication_font
vtb_r_txt_DO_mnc.init_pos           = {-0.68, 0.83, 0.0}                              -- {-0.6, 0.8, 0.0}
vtb_r_txt_DO_mnc.alignment          = "LeftCenter"
vtb_r_txt_DO_mnc.formats            = {"%1.1f"}
vtb_r_txt_DO_mnc.stringdefs         = vtb_font_size_default                           -- {0.004,0.004}
vtb_r_txt_DO_mnc.controllers        = {{"vis_ddo"}, {"txt_DO_mnc"}}
Add_VTB_Element(vtb_r_txt_DO_mnc)

local vtb_r_txt_DO_RAZ              = CreateElement "ceStringPoly"
vtb_r_txt_DO_RAZ.name               = "vtb_r_txt_DO_RAZ"
vtb_r_txt_DO_RAZ.material           = vtb_stt_indication_font
vtb_r_txt_DO_RAZ.init_pos           = {-0.9, -0.82, 0.0}                              -- {-0.9, -0.95, 0.0}
vtb_r_txt_DO_RAZ.alignment          = "LeftCenter"
vtb_r_txt_DO_RAZ.value              = "RAZ"
vtb_r_txt_DO_RAZ.stringdefs         = vtb_font_size_default                           -- {0.004,0.004}
vtb_r_txt_DO_RAZ.controllers        = {{"vis_ddo_RAZ"}}
Add_VTB_Element(vtb_r_txt_DO_RAZ)

-- GRID
vtb_rdr_grid_ar                     = create_vtb_grid_3_box( 0, 0, 1024, 1024)
vtb_rdr_grid_ar.name                = "vtb_rdr_grid_ar"
vtb_rdr_grid_ar.init_pos            = {0.0, 0.0, 0.0}
vtb_rdr_grid_ar.controllers         = {{"vis_grid_ar"}}
vtb_rdr_grid_ar.additive_alpha      = true
Add_VTB_Element(vtb_rdr_grid_ar)

-- Scales
vtb_rdr_scale                       = create_vtb_textured_box(914, 24, 978, 749) -- (917, 24, 981, 749)
vtb_rdr_scale.name                  = "vtb_rdr_scale"
vtb_rdr_scale.init_pos              = { -0.88, 0.0, 0.0 }                          -- { -0.9, 0.0, 0.0 }
vtb_rdr_scale.controllers           = {{"vis_scale"}}
vtb_rdr_scale.additive_alpha        = true
Add_VTB_Element(vtb_rdr_scale)

vtb_rdr_ant_elev                    = create_vtb_textured_box(930, 6, 980, 16)    -- ( 735, 224, 799, 228)
vtb_rdr_ant_elev.name               = "vtb_rdr_ant_elev"
vtb_rdr_ant_elev.init_pos           = {-0.84,0.0, 0.0}                            -- {-0.85,0.0, 0.0}
vtb_rdr_ant_elev.controllers        = {{"rdr_ant_elev", 0.87}}
vtb_rdr_ant_elev.additive_alpha     = true
Add_VTB_Element(vtb_rdr_ant_elev)

vtb_ant_bar                         = CreateElement "ceStringPoly"
vtb_ant_bar.name                    = "vtb_ant_bar"
vtb_ant_bar.material                = vtb_indication_font
vtb_ant_bar.init_pos                = {-0.79, 0.0, 0.0}                            -- {-0.75, 0.0, 0.0}
vtb_ant_bar.alignment               = "LeftCenter"
vtb_ant_bar.formats                 = {"%1.f"}
vtb_ant_bar.stringdefs              = vtb_font_size_default                        -- {0.004,0.004}
vtb_ant_bar.controllers             = {{"txt_radar_bar", 0}, {"rdr_ant_elev", 0.87}}
Add_VTB_Element(vtb_ant_bar)


-- Flight Director
vtb_rdr_pol_bore                  = create_vtb_textured_box(519, 118, 698, 297)   -- (502, 100, 718, 316)
vtb_rdr_pol_bore.name             = "vtb_rdr_pol_bore"
vtb_rdr_pol_bore.init_pos         = {0.0, 0.0, 0.0}
vtb_rdr_pol_bore.controllers      = {{"vis_pol_bore"}}
vtb_rdr_pol_bore.additive_alpha   = true
Add_VTB_Element(vtb_rdr_pol_bore)

vtb_rdr_pol_director              = create_vtb_textured_box(822, 7, 849, 34)      -- (825, 8, 850, 33)
vtb_rdr_pol_director.name         = "vtb_rdr_pol_director"
vtb_rdr_pol_director.init_pos     = {0.0, 0.0, 0.0}
vtb_rdr_pol_director.controllers  = {{"vis_pol_drct"}}
vtb_rdr_pol_director.additive_alpha = true
Add_VTB_Element(vtb_rdr_pol_director)

-- IFF Interrogation
vtb_rdr_IFF_ppi_int                   = create_vtb_grid_2_box(0, 44, 1024, 245, nil, 809) -- ( 0, 350, 900, 500)
vtb_rdr_IFF_ppi_int.name              = "vtb_rdr_IFF_ppi_int"
vtb_rdr_IFF_ppi_int.init_pos          = {0.0, -0.7, 0.0}                          -- {0.0, 0.55, 0.0}
vtb_rdr_IFF_ppi_int.controllers       = {{"vis_grid_IFF_ppi_int"}}
vtb_rdr_IFF_ppi_int.additive_alpha    = true
Add_VTB_Element(vtb_rdr_IFF_ppi_int)

vtb_rdr_IFF_ppi_mem                   = create_vtb_grid_2_box(0, 444, 1024, 645, nil, 1209) -- ( 0, 0, 900, 150)
vtb_rdr_IFF_ppi_mem.name              = "vtb_rdr_IFF_ppi_mem"
vtb_rdr_IFF_ppi_mem.init_pos          = {0.0, -0.7, 0.0}                          -- {0.0, 0.55, 0.0}
vtb_rdr_IFF_ppi_mem.controllers       = {{"vis_grid_IFF_ppi_mem"}}
vtb_rdr_IFF_ppi_mem.additive_alpha    = true
Add_VTB_Element(vtb_rdr_IFF_ppi_mem)

vtb_rdr_IFF_ppi_30_int                = create_vtb_grid_2_box(62, 254, 962, 366, nil, 1019) -- ( 0, 510, 806, 622, nil, 1268)
vtb_rdr_IFF_ppi_30_int.name           = "vtb_rdr_IFF_ppi_30_int"
vtb_rdr_IFF_ppi_30_int.init_pos       = {0.0, -0.7, 0.0}                                    -- {0.0, 0, 0.0}
vtb_rdr_IFF_ppi_30_int.controllers    = {{"vis_grid_IFF_ppi_30_int"}}
vtb_rdr_IFF_ppi_30_int.additive_alpha = true
Add_VTB_Element(vtb_rdr_IFF_ppi_30_int)

vtb_rdr_IFF_ppi_30_mem                = create_vtb_grid_2_box(62, 654, 962, 766, nil, 1419) -- ( 0, 153, 806, 267, nil, 918)
vtb_rdr_IFF_ppi_30_mem.name           = "vtb_rdr_IFF_ppi_30_mem"
vtb_rdr_IFF_ppi_30_mem.init_pos       = {0.0, -0.7, 0.0}                                    -- {0.0, 0, 0.0}
vtb_rdr_IFF_ppi_30_mem.controllers    = {{"vis_grid_IFF_ppi_30_mem"}}
vtb_rdr_IFF_ppi_30_mem.additive_alpha = true
Add_VTB_Element(vtb_rdr_IFF_ppi_30_mem)

vtb_rdr_IFF_ppi_15_int                = create_vtb_grid_2_box(62, 384, 962, 417, nil, 1149) -- ( 0, 634, 418, 667, nil, 1388)
vtb_rdr_IFF_ppi_15_int.name           = "vtb_rdr_IFF_ppi_15_int"
vtb_rdr_IFF_ppi_15_int.init_pos       = {0.0, -0.7, 0.0}                                    -- {0.0, 0, 0.0}
vtb_rdr_IFF_ppi_15_int.controllers    = {{"vis_grid_IFF_ppi_15_int"}}
vtb_rdr_IFF_ppi_15_int.additive_alpha = true
Add_VTB_Element(vtb_rdr_IFF_ppi_15_int)

vtb_rdr_IFF_ppi_15_mem                = create_vtb_grid_2_box(62, 784, 962, 817, nil, 1549) -- ( 0, 287, 418, 320, nil, 1053)
vtb_rdr_IFF_ppi_15_mem.name           = "vtb_rdr_IFF_ppi_15_mem"
vtb_rdr_IFF_ppi_15_mem.init_pos       = {0.0, -0.7, 0.0}                                    -- {0.0, 0, 0.0}
vtb_rdr_IFF_ppi_15_mem.controllers    = {{"vis_grid_IFF_ppi_15_mem"}}
vtb_rdr_IFF_ppi_15_mem.additive_alpha = true
Add_VTB_Element(vtb_rdr_IFF_ppi_15_mem)


-- STT Track Symbols
vtb_rdr_trk_STT                         = create_vtb_textured_box(722, 183, 808, 265)  -- ( 734, 187, 800, 263)
vtb_rdr_trk_STT.name                    = "vtb_rdr_trk_STT"
vtb_rdr_trk_STT.init_pos                = {0.0, 0, 0.0}
vtb_rdr_trk_STT.controllers             = {{"vis_track_stt"}, {"rdr_track_stt_pos", 1.0}}
vtb_rdr_trk_STT.additive_alpha          = true
Add_VTB_Element(vtb_rdr_trk_STT)

vtb_rdr_trk_STT_friend                  = create_vtb_textured_box(811, 266, 897, 348)  -- (815, 270, 896, 345)
vtb_rdr_trk_STT_friend.name             = "vtb_rdr_trk_STT_friend"
vtb_rdr_trk_STT_friend.init_pos         = {0.0, 0.0, 0.0}
vtb_rdr_trk_STT_friend.parent_element   = vtb_rdr_trk_STT.name
vtb_rdr_trk_STT_friend.controllers      = {{"rdr_track_stt_friend"}}
vtb_rdr_trk_STT_friend.additive_alpha   = true
Add_VTB_Element(vtb_rdr_trk_STT_friend)

vtb_trk_STT_vvector                     = CreateElement "ceSimpleLineObject"
vtb_trk_STT_vvector.name                = "vtb_trk_STT_vvector"
vtb_trk_STT_vvector.material            = vtb_line_material
vtb_trk_STT_vvector.width               = 0.005
vtb_trk_STT_vvector.init_pos            = {0, 0, 0}
vtb_trk_STT_vvector.controllers         = {{"vis_track_stt"}, {"rdr_track_stt_th", 1.0}}
Add_VTB_Element(vtb_trk_STT_vvector)

vtb_trk_stt_vv_arrow                    = create_vtb_stt_textured_box(781, 3, 814, 36)  -- ( 789, 13, 809, 31)
vtb_trk_stt_vv_arrow.name               = "vtb_trk_stt_vv_arrow"
vtb_trk_stt_vv_arrow.init_pos           = {0,0,0}
vtb_trk_stt_vv_arrow.parent_element     = vtb_trk_STT_vvector.name
vtb_trk_stt_vv_arrow.controllers        = {{"rdr_track_stt_ah", 0.01}}
vtb_trk_stt_vv_arrow.additive_alpha     = true
Add_VTB_Element(vtb_trk_stt_vv_arrow)

-- STT Track Text
vtb_rdr_trk_STT_mach                    = CreateElement "ceStringPoly"
vtb_rdr_trk_STT_mach.name               = "vtb_rdr_trk_STT_mach"
vtb_rdr_trk_STT_mach.material           = vtb_indication_font
vtb_rdr_trk_STT_mach.init_pos           = {0.19, -0.04, 0.0}                      -- {0.18, -0.05, 0.0}
vtb_rdr_trk_STT_mach.alignment          = "RightCenter"
vtb_rdr_trk_STT_mach.formats            = {"%1.1f"}
vtb_rdr_trk_STT_mach.stringdefs         = vtb_font_size_default                   -- {0.004,0.004}
vtb_rdr_trk_STT_mach.parent_element     = vtb_rdr_trk_STT.name
vtb_rdr_trk_STT_mach.controllers        = {{"rdr_track_stt_mach"}}
vtb_rdr_trk_STT_mach.additive_alpha     = true
Add_VTB_Element(vtb_rdr_trk_STT_mach)

vtb_rdr_trk_STT_rng0                    = CreateElement "ceStringPoly"
vtb_rdr_trk_STT_rng0.name               = "vtb_rdr_trk_stt_rng0"
vtb_rdr_trk_STT_rng0.material           = vtb_indication_font
vtb_rdr_trk_STT_rng0.init_pos           = {-0.13, -0.0, 0.0}                      -- {-0.15, 0, 0.0}
vtb_rdr_trk_STT_rng0.alignment          = "RightCenter"
vtb_rdr_trk_STT_rng0.formats            = {"%01.f"}
vtb_rdr_trk_STT_rng0.stringdefs         = vtb_font_size_big                        -- {0.005,0.005}
vtb_rdr_trk_STT_rng0.controllers        = {{"vis_track_stt"}, {"rdr_track_stt_rng0"}, {"rdr_track_stt_pos", 1.0}}
vtb_rdr_trk_STT_rng0.additive_alpha     = true
Add_VTB_Element(vtb_rdr_trk_STT_rng0)

vtb_rdr_trk_STT_rng1                    = CreateElement "ceStringPoly"
vtb_rdr_trk_STT_rng1.name               = "vtb_rdr_trk_stt_rng1"
vtb_rdr_trk_STT_rng1.material           = vtb_indication_font
vtb_rdr_trk_STT_rng1.init_pos           = {-0.13, -0.0, 0.0}                      -- {-0.15, 0, 0.0}
vtb_rdr_trk_STT_rng1.alignment          = "RightCenter"
vtb_rdr_trk_STT_rng1.formats            = {"%01.1f"}
vtb_rdr_trk_STT_rng1.stringdefs         = vtb_font_size_big                         -- {0.005,0.005}
vtb_rdr_trk_STT_rng1.controllers        = {{"vis_track_stt"}, {"rdr_track_stt_rng1"}, {"rdr_track_stt_pos", 1.0}}
vtb_rdr_trk_STT_rng1.additive_alpha     = true
Add_VTB_Element(vtb_rdr_trk_STT_rng1)

vtb_rdr_trk_STT_b_angle                 = CreateElement "ceStringPoly"
vtb_rdr_trk_STT_b_angle.name            = "vtb_rdr_trk_stt_b_angle"
vtb_rdr_trk_STT_b_angle.material        = vtb_indication_font
vtb_rdr_trk_STT_b_angle.init_pos        = {0.0, -0.05, 0.0}
vtb_rdr_trk_STT_b_angle.alignment       = "CenterCenter"
vtb_rdr_trk_STT_b_angle.formats         = {"%01.f"}
vtb_rdr_trk_STT_b_angle.stringdefs      = vtb_font_size_default                     -- {0.004,0.004}
vtb_rdr_trk_STT_b_angle.controllers     = {{"vis_track_stt"}, {"rdr_track_stt_b_angle"}, {"rdr_track_stt_pos", 1.0}}
vtb_rdr_trk_STT_b_angle.additive_alpha  = true
Add_VTB_Element(vtb_rdr_trk_STT_b_angle)

vtb_rdr_trk_STT_nctr                    = CreateElement "ceStringPoly"
vtb_rdr_trk_STT_nctr.name               = "vtb_rdr_trk_STT_nctr"
vtb_rdr_trk_STT_nctr.material           = vtb_indication_font
vtb_rdr_trk_STT_nctr.init_pos           = {0.75, 0.2, 0.0}                      -- {0.6, 0.2, 0.0}
vtb_rdr_trk_STT_nctr.alignment          = "CenterCenter"
vtb_rdr_trk_STT_nctr.formats            = {"%s"}
vtb_rdr_trk_STT_nctr.stringdefs         = vtb_font_size_default                   -- {0.004,0.004}
vtb_rdr_trk_STT_nctr.controllers        = {{"rdr_track_stt_nctr"}}
vtb_rdr_trk_STT_nctr.additive_alpha     = true
Add_VTB_Element(vtb_rdr_trk_STT_nctr)

-- STT Track Jamming
vtb_rdr_trk_STT_jam_bt                  = create_vtb_textured_box(1004, 6, 1014, 748, nil, 748) -- ( 1010, 8, 1014, 745, nil, 745)
vtb_rdr_trk_STT_jam_bt.name             = "vtb_rdr_trk_STT_jam_bt"
vtb_rdr_trk_STT_jam_bt.init_pos         = {0.0,0.0,0.0}                 -- {0.0,0, 0.0}
vtb_rdr_trk_STT_jam_bt.controllers      = {{"rdr_track_stt_jam_bt", 1.0}}
vtb_rdr_trk_STT_jam_bt.additive_alpha   = true
Add_VTB_Element(vtb_rdr_trk_STT_jam_bt)

-- Locked Track Data
vtb_r_txt_trk_abc                 = CreateElement "ceStringPoly"
vtb_r_txt_trk_abc.name            = "vtb_r_txt_trk_abc"
vtb_r_txt_trk_abc.material        = vtb_indication_font 
vtb_r_txt_trk_abc.init_pos        = {0.55, 0.83, 0.0}                              -- {0.6, 0.8, 0.0}
vtb_r_txt_trk_abc.alignment       = "RightCenter"
vtb_r_txt_trk_abc.formats         = {"%1.f"}
vtb_r_txt_trk_abc.stringdefs      = vtb_font_size_default                         -- {0.004,0.004}
vtb_r_txt_trk_abc.controllers     = {{"vis_dcible"}, {"txt_abc"}}
Add_VTB_Element(vtb_r_txt_trk_abc)

vtb_r_txt_trk_vrc_l               = CreateElement "ceStringPoly"
vtb_r_txt_trk_vrc_l.name          = "vtb_r_txt_trk_vrc_l"
vtb_r_txt_trk_vrc_l.material      = vtb_indication_font 
vtb_r_txt_trk_vrc_l.init_pos      = {0.16, 0.825, 0.0}                             -- {0.26, 0.8, 0.0}
vtb_r_txt_trk_vrc_l.alignment     = "LeftCenter"
vtb_r_txt_trk_vrc_l.value         = "VR"
vtb_r_txt_trk_vrc_l.stringdefs    = {0.003,0.003}
vtb_r_txt_trk_vrc_l.controllers   = {{"vis_dcible"}}
Add_VTB_Element(vtb_r_txt_trk_vrc_l)

vtb_r_txt_trk_vrc                 = CreateElement "ceStringPoly"
vtb_r_txt_trk_vrc.name            = "vtb_r_txt_trk_vrc"
vtb_r_txt_trk_vrc.material        = vtb_indication_font 
vtb_r_txt_trk_vrc.init_pos        = {0.15, 0.83, 0.0}                              -- {0.25, 0.8, 0.0}
vtb_r_txt_trk_vrc.alignment       = "RightCenter"
vtb_r_txt_trk_vrc.formats         = {"%1.f"}
vtb_r_txt_trk_vrc.stringdefs      = vtb_font_size_default                         -- {0.004,0.004}
vtb_r_txt_trk_vrc.controllers     = {{"vis_dcible"}, {"txt_vrc"}}
Add_VTB_Element(vtb_r_txt_trk_vrc)

vtb_r_txt_trk_rbc                 = CreateElement "ceStringPoly"
vtb_r_txt_trk_rbc.name            = "vtb_r_txt_trk_vrc"
vtb_r_txt_trk_rbc.material        = vtb_indication_font 
vtb_r_txt_trk_rbc.init_pos        = {-0.32, 0.83, 0.0}                             -- {-0.3, 0.8, 0.0}
vtb_r_txt_trk_rbc.alignment       = "LeftCenter"
vtb_r_txt_trk_rbc.formats         = {"%03.f"}
vtb_r_txt_trk_rbc.stringdefs      = vtb_font_size_default                         -- {0.004,0.004}
vtb_r_txt_trk_rbc.controllers     = {{"vis_dcible"}, {"txt_rbc"}}
Add_VTB_Element(vtb_r_txt_trk_rbc)

vtb_r_txt_trk_rbc_l               = CreateElement "ceStringPoly"
vtb_r_txt_trk_rbc_l.name          = "vtb_r_txt_trk_rbc_l"
vtb_r_txt_trk_rbc_l.material      = vtb_indication_font 
vtb_r_txt_trk_rbc_l.init_pos      = {-0.38, 0.825, 0.0}                           -- {-0.35, 0.8, 0.0}
vtb_r_txt_trk_rbc_l.alignment     = "LeftCenter"
vtb_r_txt_trk_rbc_l.value         = "AB"
vtb_r_txt_trk_rbc_l.stringdefs    = {0.003,0.003}
vtb_r_txt_trk_rbc_l.controllers   = {{"vis_dcible"}}
Add_VTB_Element(vtb_r_txt_trk_rbc_l)

vtb_r_txt_trk_mnc                 = CreateElement "ceStringPoly"
vtb_r_txt_trk_mnc.name            = "vtb_r_txt_trk_mnc"
vtb_r_txt_trk_mnc.material        = vtb_indication_font 
vtb_r_txt_trk_mnc.init_pos        = {-0.68, 0.83, 0.0}                              -- {-0.6, 0.8, 0.0}
vtb_r_txt_trk_mnc.alignment       = "LeftCenter"
vtb_r_txt_trk_mnc.formats         = {"%1.1f"}
vtb_r_txt_trk_mnc.stringdefs      = vtb_font_size_default                         -- {0.004,0.004}
vtb_r_txt_trk_mnc.controllers     = {{"vis_dcible"}, {"txt_mnc"}}
Add_VTB_Element(vtb_r_txt_trk_mnc)
