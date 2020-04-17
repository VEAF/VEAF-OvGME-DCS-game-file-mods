dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

indicator_type = indicator_types.COMMON
purposes 	   = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW, render_purpose.SCREENSPACE_INSIDE_COCKPIT}

VTB_PAGE_0		= 0
VTB_PAGE_1		= 1
VTB_PAGE_2		= 2
VTB_PAGE_3		= 3

SRC_VTB_BASE	= 0
SRC_VTB_0		= 1
SRC_VTB_1		= 2
SRC_VTB_2		= 3
SRC_VTB_3		= 4


local my_path = LockOn_Options.script_path.."VTB/"

page_subsets = {
	[SRC_VTB_BASE]	= my_path.."VTB_base.lua",
	[SRC_VTB_0]		= my_path.."VTB_page_0.lua",
	[SRC_VTB_1]		= my_path.."VTB_page_1.lua",
	[SRC_VTB_2]		= my_path.."VTB_page_2.lua",
	[SRC_VTB_3]		= my_path.."VTB_page_3.lua",
}

----------------------
pages = {
	[VTB_PAGE_0]		= {SRC_VTB_BASE,SRC_VTB_0},
	[VTB_PAGE_1]		= {SRC_VTB_BASE,SRC_VTB_1},
	[VTB_PAGE_2]		= {SRC_VTB_BASE,SRC_VTB_2},
	[VTB_PAGE_3]		= {SRC_VTB_BASE,SRC_VTB_3},
}

init_pageID			= VTB_PAGE_0

used_render_mask = "interleave2.bmp" --default mask for TV
update_screenspace_diplacement(SelfWidth/SelfHeight,false)
try_find_assigned_viewport("RIGHT_MFCD")

brightness_sensitive_materials = {
	"vtb_hdg_material",
	"vtb_ind_material",
	"vtb_stt_material",
	"vtb_wrn_material",
	"vtb_line_material",
	"vtb_line_material_DO",
	"vtb_pg2_material",
	"vtb_indication_font",
	"vtb_stt_indication_font",
}

opacity_sensitive_materials = {
	"vtb_Grid_0_material",
	"vtb_Grid_1_material",
	"vtb_Grid_2_material",
	"vtb_rdr_ind_material",
}