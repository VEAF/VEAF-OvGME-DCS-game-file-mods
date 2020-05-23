-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.6 (05/22/2020) for DCS World 2.5.6.49314 (05/20/2020)
-- -----------------------------------------------------------------------------
dofile(LockOn_Options.common_script_path.."elements_defs.lua")

GLASS_LEVEL         = 8   -- need to be mathed with declared in HUD_glass.lua
HUD_DEFAULT_LEVEL   = GLASS_LEVEL + 1

GFOV_radius         = 10 -- mils
NFOV_radius         = 125 -- mils
TFOV_radius         = 115 -- mils
RFOV_radius         = 135 -- mils

--all vertices in files who include this file will be scaled in millyradians
SetScale(MILLYRADIANS)

vth_indicator_color = {20,255,20,255} -- {0,204,102,255}
vth_ind_color = {20,255,20,255}

vth_base_init_pos = {0.0, 92.5, 0.0} -- 92.5

vth_ind_material    = "vth_ind_material"
vth_hdg_material    = "vth_hdg_material"
vth_line_material	  = "vth_line_material"
-- indicaton_material = MakeMaterial("Mods/aircraft/M-2000C/Cockpit/Resources/IndicationTextures/Indication_hud_ka-50.tga",vth_indicator_color)
-- vth_align_material = MakeMaterial("Mods/aircraft/M-2000C/Cockpit/Resources/IndicationTextures/M2KC_VTH_Alignment.tga", {255,0,0,255})
-- vth_test_material  = MakeMaterial("Mods/aircraft/M-2000C/Cockpit/Resources/IndicationTextures/Indication_hud_M2KC.tga", {255,255,0,255})

-- VTH Font
indication_font       = "vth_indication_font"       -- Normal font for default text 
indication_font_light = "vth_indication_font_light" -- Light font for large text  -- Added

-- Notice that changing collimator distance factor need huge font size 
-- adjustement, size for original colimator distance should be 0.0063 and 0.009
font_size_default     = {0.006,0.006}                                           -- {0.005,0.005}
font_size_large       = {0.009,0.009}                                             -- Added


-- Texture Functions
local texture_size_x = 1024
local texture_size_y = 1024

local hdg_text_size_x = 4096                                                      -- 3721
local hdg_text_size_y = 64                                                        -- 80

function texture_box (UL_X,UL_Y,W,H)
local ux = UL_X / texture_size_x
local uy = UL_Y / texture_size_y
local w  = W / texture_size_x
local h  = H / texture_size_y
return {{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}}
end

function hdg_texture_box (UL_X,UL_Y,W,H)
local ux = UL_X / hdg_text_size_x
local uy = UL_Y / hdg_text_size_y
local w  = W / hdg_text_size_x
local h  = H / hdg_text_size_y
return {{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}}
end


box_indices =
{
	0,1,2;0,2,3
}


function create_textured_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = 100/275
local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.5 * W * mils_per_pixel
local half_y 		 = 0.5 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  indicaton_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = texture_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices
	  return object
end

function create_vth_textured_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = 100/275
local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.5 * W * mils_per_pixel
local half_y 		 = 0.5 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  vth_ind_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = texture_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices
	  return object
end

function create_hdg_textr_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = 100/275
local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.5 * W * mils_per_pixel
local half_y 		 = 0.5 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  vth_hdg_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = hdg_texture_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices
	  return object
end

--all object passed to this function will be collimated and cliped by FOV and HUD Glass
function AddHUDElement(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level              = HUD_DEFAULT_LEVEL
	object.additive_alpha     = true --additive blending
	object.collimated         = true
	Add(object)
end


-- DEBUG functions that must be deleted on final release

function create_vth_alignment_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = 100/275
local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.5 * W * mils_per_pixel
local half_y 		 = 0.5 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  vth_align_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = texture_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices
	  return object
end

function create_vth_test_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = 100/275
local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.5 * W * mils_per_pixel
local half_y 		 = 0.5 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  vth_test_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = texture_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices
	  return object
end
