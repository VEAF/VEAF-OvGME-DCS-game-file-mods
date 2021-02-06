-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 2.4 (2021-02-04) for DCS World 2.5.6.60966 (2021-02-03)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."VTB/"
dofile(my_path.."VTB_definitions.lua")
dofile(my_path.."VTB_page_0.lua")

-- Scales & Sweep
vtb_rdr_sweep                       = create_vtb_textured_box(1004, 6, 1014, 32,  nil, 750) -- (997, 8, 1003, 30, nil, 750)
vtb_rdr_sweep.name                  = "vtb_rdr_sweep"
vtb_rdr_sweep.init_pos              = {0.0,-0.7, 0.0}
vtb_rdr_sweep.controllers           = {{"vtb_sweep", 1.0}}
vtb_rdr_sweep.additive_alpha        = true
Add_VTB_Element(vtb_rdr_sweep)

vtb_rdr_sweep_lckd                  = create_vtb_textured_box(993, 6, 1003, 745, nil, 745) -- (997, 8, 1003, 745, nil, 745)
vtb_rdr_sweep_lckd.name             = "vtb_rdr_sweep_lckd"
vtb_rdr_sweep_lckd.init_pos         = {0.0,-0.7, 0.0}
vtb_rdr_sweep_lckd.controllers      = {{"vtb_sweep_locked", 1.0}}
vtb_rdr_sweep_lckd.additive_alpha   = true
Add_VTB_Element(vtb_rdr_sweep_lckd)

vtb_rdr_sweep_lckd_j                = create_vtb_textured_box(1004, 6, 1014, 745, nil, 475) -- (1010, 8, 1014, 745, nil, 745)
vtb_rdr_sweep_lckd_j.name           = "vtb_rdr_sweep_lckd_j"
vtb_rdr_sweep_lckd_j.init_pos       = {0.0,-0.7, 0.0}
vtb_rdr_sweep_lckd_j.controllers    = {{"vtb_sweep_locked_j", 1.0}}
vtb_rdr_sweep_lckd_j.additive_alpha = true
Add_VTB_Element(vtb_rdr_sweep_lckd_j)

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

-- IFF Interrogation
-- PPI
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
vtb_rdr_IFF_ppi_30_int.init_pos       = {0.0, -0.7, 0.0}
vtb_rdr_IFF_ppi_30_int.controllers    = {{"vis_grid_IFF_ppi_30_int"}}
vtb_rdr_IFF_ppi_30_int.additive_alpha = true
Add_VTB_Element(vtb_rdr_IFF_ppi_30_int)

vtb_rdr_IFF_ppi_30_mem                = create_vtb_grid_2_box(62, 654, 962, 766, nil, 1419) -- ( 0, 153, 806, 267, nil, 918)
vtb_rdr_IFF_ppi_30_mem.name           = "vtb_rdr_IFF_ppi_30_mem"
vtb_rdr_IFF_ppi_30_mem.init_pos       = {0.0, -0.7, 0.0}
vtb_rdr_IFF_ppi_30_mem.controllers    = {{"vis_grid_IFF_ppi_30_mem"}}
vtb_rdr_IFF_ppi_30_mem.additive_alpha = true
Add_VTB_Element(vtb_rdr_IFF_ppi_30_mem)

vtb_rdr_IFF_ppi_15_int                = create_vtb_grid_2_box(62, 384, 962, 417, nil, 1149) -- ( 0, 634, 418, 667, nil, 1388)
vtb_rdr_IFF_ppi_15_int.name           = "vtb_rdr_IFF_ppi_15_int"
vtb_rdr_IFF_ppi_15_int.init_pos       = {0.0, -0.7, 0.0}
vtb_rdr_IFF_ppi_15_int.controllers    = {{"vis_grid_IFF_ppi_15_int"}}
vtb_rdr_IFF_ppi_15_int.additive_alpha = true
Add_VTB_Element(vtb_rdr_IFF_ppi_15_int)

vtb_rdr_IFF_ppi_15_mem                = create_vtb_grid_2_box(62, 784, 962, 817, nil, 1549) -- ( 0, 287, 418, 320, nil, 1053)
vtb_rdr_IFF_ppi_15_mem.name           = "vtb_rdr_IFF_ppi_15_mem"
vtb_rdr_IFF_ppi_15_mem.init_pos       = {0.0, -0.7, 0.0}
vtb_rdr_IFF_ppi_15_mem.controllers    = {{"vis_grid_IFF_ppi_15_mem"}}
vtb_rdr_IFF_ppi_15_mem.additive_alpha = true
Add_VTB_Element(vtb_rdr_IFF_ppi_15_mem)

-- B Mode
vtb_rdr_IFF_bmode_int                   = create_vtb_grid_2_box(0, 855, 1024, 865) -- ( 0, 711, 900, 715)
vtb_rdr_IFF_bmode_int.name              = "vtb_rdr_IFF_bmode_int"
vtb_rdr_IFF_bmode_int.init_pos          = {0.0, 0.68, 0.0}                        -- {0.0, 0.64, 0.0}
vtb_rdr_IFF_bmode_int.controllers       = {{"vis_grid_IFF_bmod_int"}}
vtb_rdr_IFF_bmode_int.additive_alpha    = true
Add_VTB_Element(vtb_rdr_IFF_bmode_int)

vtb_rdr_IFF_bmode_mem                   = create_vtb_grid_2_box(0, 875, 1024, 885) -- ( 0, 692, 900, 696)
vtb_rdr_IFF_bmode_mem.name              = "vtb_rdr_IFF_bmode_mem"
vtb_rdr_IFF_bmode_mem.init_pos          = {0.0, 0.68, 0.0}                        -- {0.0, 0.64, 0.0}
vtb_rdr_IFF_bmode_mem.controllers       = {{"vis_grid_IFF_bmod_mem"}}
vtb_rdr_IFF_bmode_mem.additive_alpha    = true
Add_VTB_Element(vtb_rdr_IFF_bmode_mem)

vtb_rdr_IFF_bmode_30_int                = create_vtb_grid_2_box(62, 905, 962, 915) -- ( 0, 749, 453, 754)
vtb_rdr_IFF_bmode_30_int.name           = "vtb_rdr_IFF_bmode_30_int"
vtb_rdr_IFF_bmode_30_int.init_pos       = {0.0, 0.68, 0.0}                        -- {0.0, 0.64, 0.0}
vtb_rdr_IFF_bmode_30_int.controllers    = {{"vis_grid_IFF_bmod_30_int"}}
vtb_rdr_IFF_bmode_30_int.additive_alpha = true
Add_VTB_Element(vtb_rdr_IFF_bmode_30_int)

vtb_rdr_IFF_bmode_30_mem                = create_vtb_grid_2_box(62, 925, 962, 935) -- ( 0, 729, 453, 734)
vtb_rdr_IFF_bmode_30_mem.name           = "vtb_rdr_IFF_bmode_30_mem"
vtb_rdr_IFF_bmode_30_mem.init_pos       = {0.0, 0.68, 0.0}                        -- {0.0, 0.64, 0.0}
vtb_rdr_IFF_bmode_30_mem.controllers    = {{"vis_grid_IFF_bmod_30_mem"}}
vtb_rdr_IFF_bmode_30_mem.additive_alpha = true
Add_VTB_Element(vtb_rdr_IFF_bmode_30_mem)

vtb_rdr_IFF_bmode_15_int                = create_vtb_grid_2_box(62, 955, 962, 965) -- ( 561, 749, 789, 754)
vtb_rdr_IFF_bmode_15_int.name           = "vtb_rdr_IFF_bmode_15_int"
vtb_rdr_IFF_bmode_15_int.init_pos       = {0.0, 0.68, 0.0}                        -- {0.0, 0.64, 0.0}
vtb_rdr_IFF_bmode_15_int.controllers    = {{"vis_grid_IFF_bmod_15_int"}}
vtb_rdr_IFF_bmode_15_int.additive_alpha = true
Add_VTB_Element(vtb_rdr_IFF_bmode_15_int)

vtb_rdr_IFF_bmode_15_mem                = create_vtb_grid_2_box(62, 975, 962, 985) -- ( 561, 729, 789, 734)
vtb_rdr_IFF_bmode_15_mem.name           = "vtb_rdr_IFF_bmode_15_mem"
vtb_rdr_IFF_bmode_15_mem.init_pos       = {0.0, 0.68, 0.0}                        -- {0.0, 0.64, 0.0}
vtb_rdr_IFF_bmode_15_mem.controllers    = {{"vis_grid_IFF_bmod_15_mem"}}
vtb_rdr_IFF_bmode_15_mem.additive_alpha = true
Add_VTB_Element(vtb_rdr_IFF_bmode_15_mem)

-- Info Messages
-- Top

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

------ Radar Tracks ------
for i = 0, 9 do

  -- LPRF
  local vtb_rdr_trk_bfr                 = create_rdr_textured_box(167, 341, 210, 384)  -- ( 744, 275, 788, 319)
  vtb_rdr_trk_bfr.name                  = "vtb_rdr_trk_bfr_" .. i
  vtb_rdr_trk_bfr.init_pos              = {0.0, -0.7, 0.0}
  vtb_rdr_trk_bfr.controllers           = {{"rdr_track_bfr",i}, {"rdr_track", i}}
  vtb_rdr_trk_bfr.additive_alpha        = true
  Add_VTB_Element(vtb_rdr_trk_bfr)

  local vtb_rdr_trk_bfr_friend          = create_rdr_textured_box(822, 7, 849, 34)  -- ( 687, 4, 712, 38)
  vtb_rdr_trk_bfr_friend.name           = "vtb_rdr_trk_bfr_friend_" .. i  .. "_friend"
  vtb_rdr_trk_bfr_friend.init_pos       = {0.0, 0.0, 0.0}
  vtb_rdr_trk_bfr_friend.parent_element = "vtb_rdr_trk_bfr_" .. i
  vtb_rdr_trk_bfr_friend.controllers    = {{"rdr_track_friend", i}}
  vtb_rdr_trk_bfr_friend.additive_alpha = true
  Add_VTB_Element(vtb_rdr_trk_bfr_friend)

  -- INT/HPRF
  local vtb_track                         = CreateElement "ceSimple"
  vtb_track.name                          = "vtb_track_" .. i
  vtb_track.init_pos                      = {0.0, -0.7, 0.0}
  vtb_track.controllers                   = {{"rdr_track", i}}
  vtb_track.additive_alpha                = true
  Add_VTB_Element(vtb_track)

  local vtb_rdr_track                     = create_rdr_textured_box(4, 159, 77, 210)  -- ( 12, 160, 71, 213)
  vtb_rdr_track.name                      = "vtb_rdr_track_" .. i
  vtb_rdr_track.init_pos                  = {0.0, 0.0 , 0.0}
  vtb_rdr_track.parent_element            = "vtb_track_" .. i
  vtb_rdr_track.controllers               = {{"rdr_track_rws"}, {"rdr_track_pos", i}}
  vtb_rdr_track.additive_alpha            = true
  Add_VTB_Element(vtb_rdr_track)

  local vtb_rdr_track_friend              = create_rdr_textured_box(684, 3, 713, 41)   -- ( 684, 1, 715, 41)
  vtb_rdr_track_friend.name               = "vtb_rdr_track_friend" .. i  .. "_friend"
  vtb_rdr_track_friend.init_pos           = {0.0, 0.0, 0.0}
  vtb_rdr_track_friend.parent_element     = "vtb_track_" .. i
  vtb_rdr_track_friend.controllers        = {{"rdr_track_friend", i}}
  vtb_rdr_track_friend.additive_alpha     = true
  Add_VTB_Element(vtb_rdr_track_friend)

  local vtb_rdr_track_top                 = create_rdr_textured_box(4, 272, 77, 323)  -- ( 1, 270,  82, 323)
  vtb_rdr_track_top.name                  = "vtb_rdr_track_" .. i .. "_top"
  vtb_rdr_track_top.init_pos              = {0.0, 0.0, 0.0}
  vtb_rdr_track_top.parent_element        = "vtb_track_" .. i
  vtb_rdr_track_top.controllers           = {{"vtb_rdr_track_top", i}}
  vtb_rdr_track_top.additive_alpha        = true
  Add_VTB_Element(vtb_rdr_track_top)

  local vtb_rdr_track_bottom              = create_rdr_textured_box(4, 339, 77, 390)  -- ( 14, 337, 73, 390)
  vtb_rdr_track_bottom.name               = "vtb_rdr_track_" .. i .. "_bottom"
  vtb_rdr_track_bottom.init_pos           = {0.0, 0.0 , 0.0}
  vtb_rdr_track_bottom.parent_element     = "vtb_track_" .. i
  vtb_rdr_track_bottom.controllers        = {{"vtb_rdr_track_botton", i}}
  vtb_rdr_track_bottom.additive_alpha     = true
  Add_VTB_Element(vtb_rdr_track_bottom)

  local vtb_rdr_track_rev                 = create_rdr_textured_box(4, 398, 77, 449)   -- ( 12, 398, 71, 449)
  vtb_rdr_track_rev.name                  = "vtb_rdr_track_" .. i .. "_rev"
  vtb_rdr_track_rev.init_pos              = {0.0, 0.0, 0.0}
  vtb_rdr_track_rev.parent_element        = "vtb_track_" .. i
  vtb_rdr_track_rev.controllers           = {{"rdr_track_pos_rev", i}}
  vtb_rdr_track_rev.additive_alpha        = true
  Add_VTB_Element(vtb_rdr_track_rev)

  local vtb_rdr_track_rev_top             = create_rdr_textured_box(78, 272, 151, 323)  -- (81, 270, 141, 323)
  vtb_rdr_track_rev_top.name              = "vtb_rdr_track_rev_" .. i .. "_top"
  vtb_rdr_track_rev_top.init_pos          = {0.0, 0.0, 0.0}
  vtb_rdr_track_rev_top.parent_element    = "vtb_track_" .. i
  vtb_rdr_track_rev_top.controllers       = {{"vtb_rdr_track_rev_top", i}}
  vtb_rdr_track_rev_top.additive_alpha    = true
  Add_VTB_Element(vtb_rdr_track_rev_top)

  local vtb_rdr_track_rev_bottom          = create_rdr_textured_box(78, 339, 151, 390)  -- (74, 337, 153, 390)
  vtb_rdr_track_rev_bottom.name           = "vtb_rdr_track_rev_" .. i .. "_bottom"
  vtb_rdr_track_rev_bottom.init_pos       = {0.0, 0.0 , 0.0}
  vtb_rdr_track_rev_bottom.parent_element = "vtb_track_" .. i
  vtb_rdr_track_rev_bottom.controllers    = {{"vtb_rdr_track_rev_botton", i}}
  vtb_rdr_track_rev_bottom.additive_alpha = true
  Add_VTB_Element(vtb_rdr_track_rev_bottom)

  -- TWS Data
  local vtb_trklck                  = create_rdr_textured_box(722, 100, 808, 182)  -- ( 734, 103, 800, 179)
  vtb_trklck.name                   = "vtb_trk_" .. i .. "_lck"
  vtb_trklck.init_pos               = {0.0, 0.0, 0.0}
  vtb_trklck.parent_element         = "vtb_track_" .. i
  vtb_trklck.controllers            = {{"rdr_track_lck",i}}
  vtb_trklck.additive_alpha         = true
  Add_VTB_Element(vtb_trklck)

  local vtb_trklck_frnd             = create_rdr_textured_box(811, 266, 897, 348)  -- (815, 270, 896, 345)
  vtb_trklck_frnd.name              = "vtb_trk_" .. i .. "_lck_frnd"
  vtb_trklck_frnd.init_pos          = {0.0, 0.0, 0.0}
  vtb_trklck_frnd.parent_element    = "vtb_track_" .. i
  vtb_trklck_frnd.controllers       = {{"rdr_track_lck_friend",i}}
  vtb_trklck_frnd.additive_alpha    = true
  Add_VTB_Element(vtb_trklck_frnd)
  
  local vtb_trkvvector              = CreateElement "ceSimpleLineObject"
  vtb_trkvvector.name               = "vtb_trk_" .. i .. "_vvector"
  vtb_trkvvector.material           = vtb_line_material
  vtb_trkvvector.width              = 0.005                                       -- 0.005
  vtb_trkvvector.init_pos	          = {0, -0.7, 0}
  vtb_trkvvector.controllers        = {{"rdr_track_th", i}}
  Add_VTB_Element(vtb_trkvvector)

  local vtb_trkvv_arrow             = create_rdr_textured_box(781, 3, 814, 36)    -- ( 789, 13, 809, 31)
  vtb_trkvv_arrow.name              = "vtb_trk_" .. i .. "_vv_arrow"
  vtb_trkvv_arrow.init_pos          = {0,0,0}                                     -- {0.0 ,0.0, 0.0}
  vtb_trkvv_arrow.parent_element    = "vtb_trk_" .. i .. "_vvector"
  vtb_trkvv_arrow.controllers       = {{"rdr_track_ah",i}}
  vtb_trkvv_arrow.additive_alpha    = true
  Add_VTB_Element(vtb_trkvv_arrow)

  local vtb_rdr_trkmach             = CreateElement "ceStringPoly"
  vtb_rdr_trkmach.name              = "vtb_rdr_trk_" .. i .. "_mach"
  vtb_rdr_trkmach.material          = vtb_indication_font
  vtb_rdr_trkmach.init_pos          = {0.08, -0.07, 0.0}                         -- {0.04, -0.06, 0.0}
  vtb_rdr_trkmach.formats           = {"%01.1f"}
  vtb_rdr_trkmach.parent_element    = "vtb_track_" .. i
  vtb_rdr_trkmach.stringdefs        = vtb_font_size_small                        -- {0.003,0.003}
  vtb_rdr_trkmach.controllers       = {{"rdr_track_mach",i}}
  vtb_rdr_trkmach.additive_alpha    = true
  Add_VTB_Element(vtb_rdr_trkmach)

  local vtb_rdr_trkrng0             = CreateElement "ceStringPoly"
  vtb_rdr_trkrng0.name              = "vtb_rdr_trk_" .. i .. "_rng0"
  vtb_rdr_trkrng0.material          = vtb_indication_font
  vtb_rdr_trkrng0.init_pos          = {-0.13, -0.65, 0.0}                         -- {-0.15, -0.7, 0.0}
  vtb_rdr_trkrng0.alignment         = "RightCenter"
  vtb_rdr_trkrng0.formats           = {"%01.f"}
  vtb_rdr_trkrng0.stringdefs        = vtb_font_size_big                           -- {0.005,0.005}
  vtb_rdr_trkrng0.controllers       = {{"rdr_track_rng0",i}, {"rdr_track", i}}
  vtb_rdr_trkrng0.additive_alpha    = true
  Add_VTB_Element(vtb_rdr_trkrng0)

  local vtb_rdr_trkrng1             = CreateElement "ceStringPoly"
  vtb_rdr_trkrng1.name              = "vtb_rdr_trk_" .. i .. "_rng1"
  vtb_rdr_trkrng1.material          = vtb_indication_font
  vtb_rdr_trkrng1.init_pos          = {-0.13, -0.65, 0.0}                         -- {-0.15, -0.7, 0.0}
  vtb_rdr_trkrng1.alignment         = "RightCenter"
  vtb_rdr_trkrng1.formats           = {"%01.1f"}
  vtb_rdr_trkrng1.stringdefs        = vtb_font_size_big                           -- {0.005,0.005}
  vtb_rdr_trkrng1.controllers       = {{"rdr_track_rng1",i}, {"rdr_track", i}}
  vtb_rdr_trkrng1.additive_alpha    = true
  Add_VTB_Element(vtb_rdr_trkrng1)

  local vtb_rdr_trkb_angle          = CreateElement "ceStringPoly"
  vtb_rdr_trkb_angle.name           = "vtb_rdr_trk_" .. i .. "_b_angle"
  vtb_rdr_trkb_angle.material       = vtb_indication_font
  vtb_rdr_trkb_angle.init_pos       = {0.0, -0.75, 0.0}
  vtb_rdr_trkb_angle.alignment      = "CenterCenter"
  vtb_rdr_trkb_angle.formats        = {"%01.f"}
  vtb_rdr_trkb_angle.stringdefs     = vtb_font_size_default                        -- {0.004,0.004}
  vtb_rdr_trkb_angle.controllers    = {{"rdr_track_b_angle",i}, {"rdr_track", i}}
  vtb_rdr_trkb_angle.additive_alpha = true
  Add_VTB_Element(vtb_rdr_trkb_angle)

  -- Jamming
  local vtb_rdr_trkjam_bt           = create_vtb_textured_box(1004, 6, 1014, 748, nil, 748) -- ( 1010, 8, 1014, 745, nil, 745)
  vtb_rdr_trkjam_bt.name            = "vtb_rdr_trk_" .. i .. "_jam_bt"
  vtb_rdr_trkjam_bt.init_pos        = {0.0,-0.7, 0.0}
  vtb_rdr_trkjam_bt.controllers     = {{"rdr_track_jam_bt", i}}
  vtb_rdr_trkjam_bt.additive_alpha  = true
  Add_VTB_Element(vtb_rdr_trkjam_bt)

end

-- STT Track Symbols
vtb_rdr_trk_STT                         = create_vtb_textured_box(722, 183, 808, 265)  -- ( 734, 187, 800, 263)
vtb_rdr_trk_STT.name                    = "vtb_rdr_trk_STT"
vtb_rdr_trk_STT.init_pos                = {0.0, -0.7, 0.0}
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
vtb_trk_STT_vvector.width               = 0.005                                    -- 0.005
vtb_trk_STT_vvector.init_pos            = {0, -0.7, 0}
vtb_trk_STT_vvector.controllers         = {{"vis_track_stt"}, {"rdr_track_stt_th", 1.0}}
Add_VTB_Element(vtb_trk_STT_vvector)

vtb_trk_stt_vv_arrow                    = create_vtb_stt_textured_box(781, 3, 814, 36)  -- ( 789, 13, 809, 31)
vtb_trk_stt_vv_arrow.name               = "vtb_trk_stt_vv_arrow"
vtb_trk_stt_vv_arrow.init_pos           = {0,0,0}                              -- {0,0,0}
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
vtb_rdr_trk_STT_rng0.init_pos           = {-0.13, -0.65, 0.0}                      -- {-0.15, -0.7, 0.0}
vtb_rdr_trk_STT_rng0.alignment          = "RightCenter"
vtb_rdr_trk_STT_rng0.formats            = {"%01.f"}
vtb_rdr_trk_STT_rng0.stringdefs         = vtb_font_size_big                        -- {0.005,0.005}
vtb_rdr_trk_STT_rng0.controllers        = {{"vis_track_stt"}, {"rdr_track_stt_rng0"}, {"rdr_track_stt_pos", 1.0}}
vtb_rdr_trk_STT_rng0.additive_alpha     = true
Add_VTB_Element(vtb_rdr_trk_STT_rng0)

vtb_rdr_trk_STT_rng1                    = CreateElement "ceStringPoly"
vtb_rdr_trk_STT_rng1.name               = "vtb_rdr_trk_stt_rng1"
vtb_rdr_trk_STT_rng1.material           = vtb_indication_font
vtb_rdr_trk_STT_rng1.init_pos           = {-0.13, -0.65, 0.0}                      -- {-0.15, -0.7, 0.0}
vtb_rdr_trk_STT_rng1.alignment          = "RightCenter"
vtb_rdr_trk_STT_rng1.formats            = {"%01.1f"}
vtb_rdr_trk_STT_rng1.stringdefs         = vtb_font_size_big                         -- {0.005,0.005}
vtb_rdr_trk_STT_rng1.controllers        = {{"vis_track_stt"}, {"rdr_track_stt_rng1"}, {"rdr_track_stt_pos", 1.0}}
vtb_rdr_trk_STT_rng1.additive_alpha     = true
Add_VTB_Element(vtb_rdr_trk_STT_rng1)

vtb_rdr_trk_STT_b_angle                 = CreateElement "ceStringPoly"
vtb_rdr_trk_STT_b_angle.name            = "vtb_rdr_trk_stt_b_angle"
vtb_rdr_trk_STT_b_angle.material        = vtb_indication_font
vtb_rdr_trk_STT_b_angle.init_pos        = {0.0, -0.75, 0.0}
vtb_rdr_trk_STT_b_angle.alignment       = "CenterCenter"
vtb_rdr_trk_STT_b_angle.formats         = {"%01.f"}
vtb_rdr_trk_STT_b_angle.stringdefs      = vtb_font_size_default                     -- {0.004,0.004}
vtb_rdr_trk_STT_b_angle.controllers     = {{"vis_track_stt"}, {"rdr_track_stt_b_angle"}, {"rdr_track_stt_pos", 1.0}}
vtb_rdr_trk_STT_b_angle.additive_alpha  = true
Add_VTB_Element(vtb_rdr_trk_STT_b_angle)

vtb_rdr_trk_STT_nctr                    = CreateElement "ceStringPoly"
vtb_rdr_trk_STT_nctr.name               = "vtb_rdr_trk_STT_nctr"
vtb_rdr_trk_STT_nctr.material           = vtb_indication_font
vtb_rdr_trk_STT_nctr.init_pos           = {0.75, -0.57, 0.0}                      -- {0.6, -0.5, 0.0}
vtb_rdr_trk_STT_nctr.alignment          = "CenterCenter"
vtb_rdr_trk_STT_nctr.formats            = {"%s"}
vtb_rdr_trk_STT_nctr.stringdefs         = vtb_font_size_default                   -- {0.004,0.004}
vtb_rdr_trk_STT_nctr.controllers        = {{"rdr_track_stt_nctr"}}
vtb_rdr_trk_STT_nctr.additive_alpha     = true
Add_VTB_Element(vtb_rdr_trk_STT_nctr)

-- STT Track Jamming
vtb_rdr_trk_STT_jam_bt                  = create_vtb_textured_box(1004, 6, 1014, 748, nil, 748) -- ( 1010, 8, 1014, 745, nil, 745)
vtb_rdr_trk_STT_jam_bt.name             = "vtb_rdr_trk_STT_jam_bt"
vtb_rdr_trk_STT_jam_bt.init_pos         = {0.0,-0.7, 0.0}
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
