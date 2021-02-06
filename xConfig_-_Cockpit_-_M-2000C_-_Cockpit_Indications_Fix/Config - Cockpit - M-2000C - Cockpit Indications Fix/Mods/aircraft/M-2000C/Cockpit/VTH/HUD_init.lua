-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 2.4 (2021-02-04) for DCS World 2.5.6.60966 (2021-02-03)
-- -----------------------------------------------------------------------------
dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COLLIMATOR  -- ensure that this is HUD
purposes 	   = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}  -- HUD will be rendered on hud only view

-------PAGE IDs-------
PAGE_0		= 0	-- NAV
PAGE_1		= 1	-- AA
PAGE_2		= 2	-- AG
PAGE_3		= 3	-- STANDBY
PAGE_4		= 4	-- NAV: APPROACH
PAGE_5		= 5	-- AA POL
PAGE_6		= 6	-- AG CCRP

--Source files for page subsets
SRC_HUD_GLASS	= 0
SRC_HUD_BASE	= 1
SRC_HUD_0		= 2	-- NAV
SRC_HUD_1		= 3	-- AA
SRC_HUD_2		= 4	-- AG
SRC_HUD_3		= 5	-- STBY
SRC_HUD_4		= 6	-- APPROACH
SRC_HUD_5		= 7	-- POLICE
SRC_HUD_6		= 8	-- CCRP

--subsets declare lua indication source files which will be used to combines pages

local my_path = LockOn_Options.script_path.."VTH/"

page_subsets = {
	[SRC_HUD_GLASS]	= my_path.."HUD_glass.lua",
	[SRC_HUD_BASE]	= my_path.."HUD_base.lua",
	[SRC_HUD_0]		= my_path.."HUD_page_0.lua",
	[SRC_HUD_1]		= my_path.."HUD_page_1.lua",
	[SRC_HUD_2]		= my_path.."HUD_page_2.lua",
	[SRC_HUD_3]		= my_path.."HUD_page_3.lua",
	[SRC_HUD_4]		= my_path.."HUD_page_appr.lua",
	[SRC_HUD_5]		= my_path.."HUD_page_5.lua",
	[SRC_HUD_6]		= my_path.."HUD_page_6.lua",
}

--[[
SRC_HUD_GLASS,SRC_HUD_BASE  will be background for all other pages
--]]
----------------------
pages = {
	[PAGE_0]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_0},
	[PAGE_1]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_1},
	[PAGE_2]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_2},
	[PAGE_3]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_3},
	[PAGE_4]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_4},
	[PAGE_5]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_5},
	[PAGE_6]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_6},
}

-- set this page on start
init_pageID			= PAGE_0

-- Collimator value can be modified from 0.6 to 0.4 to correct the 
-- HUD Z fight with HUD glass frame polygons, however this change 
-- behaviors of many elements in addition to heading 
-- tape angle/pixel ratio and font sizing... 
-- To avoid any other unexpeted result or missalignment, and since I 
-- don't know exactly how this value is used, I decided to let it to 
-- its default value.
collimator_default_distance_factor = {0.6,0,0} -- angular size operations will use this as reference to calculate coverage and collimation

used_render_mask = "interleave2.bmp" --default mask for TV

-- VTH Brightness
opacity_sensitive_materials = {
	"vth_ind_material",
	"vth_hdg_material",
  "vth_line_material",
	"vth_indication_font",
  "vth_indication_font_big",                                                    -- ADDED
}
