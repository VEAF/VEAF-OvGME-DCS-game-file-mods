dofile(LockOn_Options.common_script_path.."devices_defs.lua")
local my_path = LockOn_Options.script_path.."RWR/"

indicator_type = indicator_types.COMMON

PAGE_0		= 0

SRC_ECM_CHF_BASE	= 0
SRC_ECM_CHF			= 1

page_subsets = {
	[SRC_ECM_CHF_BASE]	= my_path.."ECM_CHF_base.lua",
	[SRC_ECM_CHF]		= my_path.."ECM_CHF_page.lua",
}

----------------------
pages = {
	[PAGE_0]		= {SRC_ECM_CHF_BASE,SRC_ECM_CHF},
}

init_pageID			= PAGE_0

collimator_default_distance_factor = {0.6,0,0}

dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
try_find_assigned_viewport("ECM_CHF")
