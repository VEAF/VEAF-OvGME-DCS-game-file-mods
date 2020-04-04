dofile(LockOn_Options.common_script_path.."devices_defs.lua")
local my_path = LockOn_Options.script_path.."RWR/"

indicator_type = indicator_types.COMMON

PAGE_0		= 0

SRC_RWR_BASE	= 0
SRC_RWR_0		= 1

page_subsets = {
	[SRC_RWR_BASE]	= my_path.."RWR_base.lua",
	[SRC_RWR_0]		= my_path.."RWR_page.lua",
}

----------------------
pages = {
	[PAGE_0]		= {SRC_RWR_BASE,SRC_RWR_0},
}
init_pageID			= PAGE_0

used_render_mask = "interleave2.bmp" --default mask for TV

brightness_sensitive_materials	= { "rwr_ind_material", "rwr_indication_font", }
opacity_sensitive_materials		= { "rwr_ind_material", "rwr_indication_font", }

dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
try_find_assigned_viewport("M2KC_RWR")
