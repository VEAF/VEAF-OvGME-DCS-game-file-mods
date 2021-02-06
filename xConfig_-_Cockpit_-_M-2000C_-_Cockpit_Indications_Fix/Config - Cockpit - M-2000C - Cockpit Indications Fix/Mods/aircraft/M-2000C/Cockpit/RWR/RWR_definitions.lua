-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 2.4 (2021-02-04) for DCS World 2.5.6.60966 (2021-02-03)
-- -----------------------------------------------------------------------------
dofile(LockOn_Options.common_script_path.."elements_defs.lua")

RWR_DEFAULT_LEVEL     = 6

--all vertices in files who include this file will be scaled in millyradians
SetScale(MILLYRADIANS)

rwr_indicator_color   = {122,255,4,255}                                          -- {0,255,0,255}
rwr_font_color        = {122,255,4,255}                                          -- {0,255,0,255}

-- Textures
rwr_ind_material		= "rwr_ind_material"
rwr_indication_font		= "rwr_indication_font"
rwr_font_size_default = {0.0045,0.0045}                                           -- {0.005,0.005}


--texture size is 1024 x 1024

local texture_size_x = 1024
local texture_size_y = 1024

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

box_indices =
{
	0,1,2;0,2,3
}


function create_rwr_textured_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y) -- function that creates textured square

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
	  object.material =  rwr_ind_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = texture_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices
	  return object
end


--all object passed to this function will be cliped by FOV and VTB Glass
function Add_RWR_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = RWR_DEFAULT_LEVEL
	object.additive_alpha     = true --additive blending
	object.collimated 		  = false
	Add(object)
end
