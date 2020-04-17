-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.5 (04/17/2020) for DCS World 2.5.6.47224 (04/16/2020)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."VTB/"
dofile(my_path.."VTB_definitions.lua")

local vtb_bckgrd            = create_vtb_page2_textured_box(62, 0, 962, 900)      -- ( 0, 0, 900, 900)
vtb_bckgrd.name             = "vtb_bckgrd"
vtb_bckgrd.init_pos         = {0.0, 0.0, 0.0}                                     -- {0.0, 0.0, 0.0}
vtb_bckgrd.additive_alpha   = true
Add_VTB_Element(vtb_bckgrd)

-- Gun Ammo Count
local txt_lg_ammo           = CreateElement "ceStringPoly"
txt_lg_ammo.name            = "txt_lg_ammo"
txt_lg_ammo.material        = vtb_stt_indication_font
txt_lg_ammo.init_pos        = {-0.3, 0.3, 0.0}                                    -- {-0.3, 0.4, 0.0}
txt_lg_ammo.alignment       = "CenterCenter"
txt_lg_ammo.formats         = {"%d"}
txt_lg_ammo.stringdefs      = {0.004,0.004}                                       -- {0.005,0.005}
txt_lg_ammo.controllers     = {{"wd_lg_ammo_count"}}
Add_VTB_Element(txt_lg_ammo)

local txt_lg_OBUS           = CreateElement "ceStringPoly"
txt_lg_OBUS.name            = "txt_lg_OBUS"
txt_lg_OBUS.material        = vtb_stt_indication_font
txt_lg_OBUS.init_pos        = {-0.3, 0.2, 0.0}                                    -- {-0.3, 0.3, 0.0}
txt_lg_OBUS.alignment       = "CenterCenter"
txt_lg_OBUS.stringdefs      = {0.004,0.004}                                       -- {0.005,0.005}
txt_lg_OBUS.value           = "OBUS"
Add_VTB_Element(txt_lg_OBUS)

local txt_rg_ammo           = CreateElement "ceStringPoly"
txt_rg_ammo.name            = "txt_rg_ammo"
txt_rg_ammo.material        = vtb_stt_indication_font
txt_rg_ammo.init_pos        = {0.3, 0.3, 0.0}                                     -- {0.3, 0.4, 0.0}
txt_rg_ammo.alignment       = "CenterCenter"
txt_rg_ammo.formats         = {"%d"}
txt_rg_ammo.stringdefs      = {0.004,0.004}                                       -- {0.005,0.005}
txt_rg_ammo.controllers     = {{"wd_rg_ammo_count"}}
Add_VTB_Element(txt_rg_ammo)

local txt_rg_OBUS           = CreateElement "ceStringPoly"
txt_rg_OBUS.name            = "txt_rg_OBUS"
txt_rg_OBUS.material        = vtb_stt_indication_font
txt_rg_OBUS.init_pos        = {0.3, 0.2, 0.0}                                     -- {0.3, 0.3, 0.0}
txt_rg_OBUS.alignment       = "CenterCenter"
txt_rg_OBUS.stringdefs      = {0.004,0.004}                                       -- {0.005,0.005}
txt_rg_OBUS.value           = "OBUS"
Add_VTB_Element(txt_rg_OBUS)

-- Left Outboard Pylon
local txt_pylon_1_c         = CreateElement "ceStringPoly"
txt_pylon_1_c.name          = "txt_pylon_1_c"
txt_pylon_1_c.material      = vtb_stt_indication_font
txt_pylon_1_c.init_pos      = {-0.55, -0.60, 0.0}                                 -- {-0.55, -0.50, 0.0}
txt_pylon_1_c.alignment     = "CenterCenter"
txt_pylon_1_c.formats       = {"%dX"}
txt_pylon_1_c.stringdefs    = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_1_c.controllers   = {{"wd_lop_weapon_c"}}
Add_VTB_Element(txt_pylon_1_c)

local txt_pylon_1_d         = CreateElement "ceStringPoly"
txt_pylon_1_d.name          = "txt_pylon_1_d"
txt_pylon_1_d.material      = vtb_stt_indication_font
txt_pylon_1_d.init_pos      = {-0.55, -0.70, 0.0}                                 -- {-0.55, -0.60, 0.0}
txt_pylon_1_d.alignment     = "CenterCenter"
txt_pylon_1_d.formats       = {"%s"}
txt_pylon_1_d.stringdefs    = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_1_d.controllers   = {{"wd_lop_weapon_d"}}
Add_VTB_Element(txt_pylon_1_d)

-- Left Inboard Pylon
local txt_pylon_2_c         = CreateElement "ceStringPoly"
txt_pylon_2_c.name          = "txt_pylon_2_c"
txt_pylon_2_c.material      = vtb_stt_indication_font
txt_pylon_2_c.init_pos      = {-0.30, -0.60, 0.0}                                 -- {-0.30, -0.50, 0.0}
txt_pylon_2_c.alignment     = "CenterCenter"
txt_pylon_2_c.formats       = {"%dX"}
txt_pylon_2_c.stringdefs    = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_2_c.controllers   = {{"wd_lip_weapon_c"}}
Add_VTB_Element(txt_pylon_2_c)

local txt_pylon_2_d         = CreateElement "ceStringPoly"
txt_pylon_2_d.name          = "txt_pylon_2_d"
txt_pylon_2_d.material      = vtb_stt_indication_font
txt_pylon_2_d.init_pos      = {-0.30, -0.70, 0.0}                                 -- {-0.30, -0.60, 0.0}
txt_pylon_2_d.alignment     = "CenterCenter"
txt_pylon_2_d.formats       = {"%s"}
txt_pylon_2_d.stringdefs    = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_2_d.controllers   = {{"wd_lip_weapon_d"}}
Add_VTB_Element(txt_pylon_2_d)

-- Left Wing Root Pylons
local txt_pylon_34_c        = CreateElement "ceStringPoly"
txt_pylon_34_c.name         = "txt_pylon_34_c"
txt_pylon_34_c.material     = vtb_stt_indication_font
txt_pylon_34_c.init_pos     = {-0.50, -0.00, 0.0}
txt_pylon_34_c.alignment    = "CenterCenter"
txt_pylon_34_c.formats      = {"%dX"}
txt_pylon_34_c.stringdefs   = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_34_c.controllers  = {{"wd_lcp_weapon_c"}}
Add_VTB_Element(txt_pylon_34_c)

local txt_pylon_34_d        = CreateElement "ceStringPoly"
txt_pylon_34_d.name         = "txt_pylon_34_d"
txt_pylon_34_d.material     = vtb_stt_indication_font
txt_pylon_34_d.init_pos     = {-0.50, -0.10, 0.0}
txt_pylon_34_d.alignment    = "CenterCenter"
txt_pylon_34_d.formats      = {"%s"}
txt_pylon_34_d.stringdefs   = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_34_d.controllers  = {{"wd_lcp_weapon_d"}}
Add_VTB_Element(txt_pylon_34_d)

-- Center Pylon
local txt_pylon_5_c         = CreateElement "ceStringPoly"
txt_pylon_5_c.name          = "txt_pylon_5_c"
txt_pylon_5_c.material      = vtb_stt_indication_font
txt_pylon_5_c.init_pos      = {0.0, -0.20, 0.0}
txt_pylon_5_c.alignment     = "CenterCenter"
txt_pylon_5_c.formats       = {"%dX"}
txt_pylon_5_c.stringdefs    = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_5_c.controllers   = {{"wd_ctp_weapon_c"}}
Add_VTB_Element(txt_pylon_5_c)

local txt_pylon_5_d         = CreateElement "ceStringPoly"
txt_pylon_5_d.name          = "txt_pylon_5_d"
txt_pylon_5_d.material      = vtb_stt_indication_font
txt_pylon_5_d.init_pos      = {0.0, -0.30, 0.0}
txt_pylon_5_d.alignment     = "CenterCenter"
txt_pylon_5_d.formats       = {"%s"}
txt_pylon_5_d.stringdefs    = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_5_d.controllers   = {{"wd_ctp_weapon_d"}}
Add_VTB_Element(txt_pylon_5_d)

-- Right Wing Root Pylons
local txt_pylon_67_c        = CreateElement "ceStringPoly"
txt_pylon_67_c.name         = "txt_pylon_67_c"
txt_pylon_67_c.material     = vtb_stt_indication_font
txt_pylon_67_c.init_pos     = {0.50, 0.00, 0.0}
txt_pylon_67_c.alignment    = "CenterCenter"
txt_pylon_67_c.formats      = {"%dX"}
txt_pylon_67_c.stringdefs   = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_67_c.controllers  = {{"wd_rcp_weapon_c"}}
Add_VTB_Element(txt_pylon_67_c)

local txt_pylon_67_d        = CreateElement "ceStringPoly"
txt_pylon_67_d.name         = "txt_pylon_67_d"
txt_pylon_67_d.material     = vtb_stt_indication_font
txt_pylon_67_d.init_pos     = {0.50, -0.10, 0.0}
txt_pylon_67_d.alignment    = "CenterCenter"
txt_pylon_67_d.formats      = {"%s"}
txt_pylon_67_d.stringdefs   = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_67_d.controllers  = {{"wd_rcp_weapon_d"}}
Add_VTB_Element(txt_pylon_67_d)

-- Right Inboard Pylon
local txt_pylon_8_c         = CreateElement "ceStringPoly"
txt_pylon_8_c.name          = "txt_pylon_8_c"
txt_pylon_8_c.material      = vtb_stt_indication_font
txt_pylon_8_c.init_pos      = {0.30, -0.60, 0.0}                                  -- {0.30, -0.50, 0.0}
txt_pylon_8_c.alignment     = "CenterCenter"
txt_pylon_8_c.formats       = {"%dX"}
txt_pylon_8_c.stringdefs    = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_8_c.controllers   = {{"wd_rip_weapon_c"}}
Add_VTB_Element(txt_pylon_8_c)

local txt_pylon_8_d         = CreateElement "ceStringPoly"
txt_pylon_8_d.name          = "txt_pylon_8_d"
txt_pylon_8_d.material      = vtb_stt_indication_font
txt_pylon_8_d.init_pos      = {0.30, -0.70, 0.0}                                  -- {0.30, -0.60, 0.0}
txt_pylon_8_d.alignment     = "CenterCenter"
txt_pylon_8_d.formats       = {"%s"}
txt_pylon_8_d.stringdefs    = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_8_d.controllers   = {{"wd_rip_weapon_d"}}
Add_VTB_Element(txt_pylon_8_d)

-- Right Outboard Pylon
local txt_pylon_9_c         = CreateElement "ceStringPoly"
txt_pylon_9_c.name          = "txt_pylon_9_c"
txt_pylon_9_c.material      = vtb_stt_indication_font
txt_pylon_9_c.init_pos      = {0.55, -0.60, 0.0}                                  -- {0.55, -0.50, 0.0}
txt_pylon_9_c.alignment     = "CenterCenter"
txt_pylon_9_c.formats       = {"%dX"}
txt_pylon_9_c.stringdefs    = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_9_c.controllers   = {{"wd_rop_weapon_c"}}
Add_VTB_Element(txt_pylon_9_c)

local txt_pylon_9_d         = CreateElement "ceStringPoly"
txt_pylon_9_d.name          = "txt_pylon_9_d"
txt_pylon_9_d.material      = vtb_stt_indication_font
txt_pylon_9_d.init_pos      = {0.55, -0.70, 0.0}                                  -- {0.55, -0.60, 0.0}
txt_pylon_9_d.alignment     = "CenterCenter"
txt_pylon_9_d.formats       = {"%s"}
txt_pylon_9_d.stringdefs    = {0.004,0.004}                                       -- {0.005,0.005}
txt_pylon_9_d.controllers   = {{"wd_rop_weapon_d"}}
Add_VTB_Element(txt_pylon_9_d)


