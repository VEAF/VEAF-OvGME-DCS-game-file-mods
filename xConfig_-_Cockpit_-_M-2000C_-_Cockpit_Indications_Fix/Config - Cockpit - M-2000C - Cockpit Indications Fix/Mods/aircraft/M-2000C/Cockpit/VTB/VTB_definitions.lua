-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 2.4 (2021-02-04) for DCS World 2.5.6.60966 (2021-02-03)
-- -----------------------------------------------------------------------------
dofile(LockOn_Options.common_script_path.."elements_defs.lua")

VTB_DEFAULT_LEVEL     = 4

SetScale(FOV)

vtb_ind_color     = {96,  255,  50, 255}
vtb_ind_color_att = {96,  255,  50, 128}                                          -- added
vtb_stt_color     = {255, 255,  50, 255}
vtb_stt_color_att = {255, 255,  50, 128}                                          -- added
vtb_wrn_color     = {255, 80,   0,  255}

vtb_scale = 0.55/275
vtb_grid_scale = 0.5/275
vtb_hdg_scale = 0.7/275
vtb_hdg_displ = (3448 * vtb_hdg_scale / 480) * GetScale()

symbol_pixels_x = 24                                                              -- 44.0 * 2 : adapted for 256x256 texture
symbol_pixels_y = 38                                                              -- 72.0 * 2 : adapted for 256x256 texture

--------- Materials ------------
-- Heading Ruler
vtb_hdg_material    	= "vtb_hdg_material"
vtb_hdg_ar_material   = "vtb_hdg_ar_material"

-- Grids
vtb_Grid_0_material 	= "vtb_Grid_0_material"
vtb_Grid_1_material 	= "vtb_Grid_1_material"
vtb_Grid_2_material 	= "vtb_Grid_2_material"
vtb_Grid_3_material   = "vtb_Grid_3_material"
vtb_line_material		  = "vtb_line_material"
vtb_line_material_DO	= "vtb_line_material_DO"

-- Symbols
vtb_ind_material    	= "vtb_ind_material"
vtb_stt_material    	= "vtb_stt_material"
vtb_wrn_material    	= "vtb_wrn_material"
vtb_rdr_ind_material	= "vtb_rdr_ind_material"

-- Page 2
vtb_pg2_material    	= "vtb_pg2_material"

----------- Fonts --------------
vtb_indication_font 	= "vtb_indication_font"
vtb_stt_indication_font = "vtb_stt_indication_font"
vtb_font_size_default	= {0.0040,0.0040}                   -- {0.005,0.005}
vtb_font_size_small	  = {0.0035,0.0035}                   -- added
vtb_font_size_big	    = {0.0045,0.0045}                   -- added
--------------------------------

-- Texture Boxes

-- Page 1
-- VTB Heading
local vtb_hdg_text_size_x = 4096                                                  -- 3528
local vtb_hdg_text_size_y = 64                                                    -- 72

function vtb_hdg_texture_box (UL_X,UL_Y,W,H)
local ux = UL_X / vtb_hdg_text_size_x
local uy = UL_Y / vtb_hdg_text_size_y
local w  = W / vtb_hdg_text_size_x
local h  = H / vtb_hdg_text_size_y
return {{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}}
end

box_indices ={ 0,1,2;0,2,3 }

function create_vtb_hdg_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = vtb_hdg_scale
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

vtb_hdg_text_size_y = 64 -- 72

local object = CreateElement "ceTexPoly"
	  object.material =  vtb_hdg_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = vtb_hdg_texture_box(UL_X,UL_Y,W,H)
	  object.indices	= box_indices
	  return object
end

function create_vtb_hdg_ar_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = vtb_hdg_scale
local W          = DR_X - UL_X
local H          = DR_Y - UL_Y
local cx         = (UL_X + 0.5 * W)
local cy         = (UL_Y + 0.5 * H)

local CENTER_X     = CENTER_X or cx
local CENTER_Y     = CENTER_Y or cy
local dcx        = mils_per_pixel * (CENTER_X - cx)
local dcy          = mils_per_pixel * (CENTER_Y - cy)

local half_x     = 0.5 * W * mils_per_pixel
local half_y     = 0.5 * H * mils_per_pixel

vtb_hdg_text_size_y = 64 -- 50

local object = CreateElement "ceTexPoly"
    object.material =  vtb_hdg_ar_material
    object.vertices =  {{-half_x - dcx, half_y + dcy},
              { half_x - dcx, half_y + dcy},
              { half_x - dcx,-half_y + dcy},
              {-half_x - dcx,-half_y + dcy}}
    object.tex_coords = vtb_hdg_texture_box(UL_X,UL_Y,W,H)
    object.indices  = box_indices
    return object
end

-- VTB Radar
local vtb_texture_size_x = 1024
local vtb_texture_size_y = 1024

local vtb_grid_size_x = 1024                                                      -- 908
local vtb_grid_size_y = 1024                                                      -- 908

function vtb_texture_box (UL_X,UL_Y,W,H)
local ux = UL_X / vtb_texture_size_x
local uy = UL_Y / vtb_texture_size_y
local w  = W / vtb_texture_size_x
local h  = H / vtb_texture_size_y
return {{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}}
end

function vtb_grid_box (UL_X,UL_Y,W,H)
local ux = UL_X / vtb_grid_size_x
local uy = UL_Y / vtb_grid_size_y
local w  = W / vtb_grid_size_x
local h  = H / vtb_grid_size_y
return {{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}}
end

-- Grids
function create_vtb_grid_0_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = vtb_grid_scale
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
	  object.material =  vtb_Grid_0_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = vtb_grid_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices
	  return object
end

function create_vtb_grid_1_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = vtb_grid_scale
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
	  object.material =  vtb_Grid_1_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = vtb_grid_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices
	  return object
end

function create_vtb_grid_2_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = vtb_grid_scale
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
	  object.material =  vtb_Grid_2_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = vtb_grid_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices
	  return object
end

function create_vtb_grid_3_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)
  
  local mils_per_pixel = vtb_grid_scale
  local W          = DR_X - UL_X
  local H          = DR_Y - UL_Y
  local cx         = (UL_X + 0.5 * W)
  local cy         = (UL_Y + 0.5 * H)
  
  local CENTER_X     = CENTER_X or cx
  local CENTER_Y     = CENTER_Y or cy
  local dcx        = mils_per_pixel * (CENTER_X - cx)
  local dcy          = mils_per_pixel * (CENTER_Y - cy)
  
  local half_x     = 0.5 * W * mils_per_pixel
  local half_y     = 0.5 * H * mils_per_pixel
  
  
  local object = CreateElement "ceTexPoly"
    object.material =  vtb_Grid_3_material
    object.vertices =  {{-half_x - dcx, half_y + dcy},
              { half_x - dcx, half_y + dcy},
              { half_x - dcx,-half_y + dcy},
              {-half_x - dcx,-half_y + dcy}}
    object.tex_coords = vtb_texture_box(UL_X,UL_Y,W,H)
    object.indices    = box_indices
    
  return object
end

-- VTB Indicators
function create_vtb_textured_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = vtb_scale
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
	  object.material =  vtb_ind_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = vtb_texture_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices
	  return object
end

function create_rdr_textured_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)
	
	local mils_per_pixel = vtb_scale
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
		object.material =  vtb_rdr_ind_material
		object.vertices =  {{-half_x - dcx, half_y + dcy},
							{ half_x - dcx, half_y + dcy},
							{ half_x - dcx,-half_y + dcy},
							{-half_x - dcx,-half_y + dcy}}
		object.tex_coords = vtb_texture_box(UL_X,UL_Y,W,H)
		object.indices	  = box_indices
		
	return object
end


function create_vtb_stt_textured_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = vtb_scale
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
	  object.material =  vtb_stt_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = vtb_texture_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices
	  return object
end

function create_vtb_wrn_textured_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = vtb_scale
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
	  object.material =  vtb_wrn_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = vtb_texture_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices
	  return object
end

-- Page 2
local vtb_page2_size_x = 1024                                                     -- 800
local vtb_page2_size_y = 1024                                                     -- 800

function vtb_page2_box (UL_X,UL_Y,W,H)
local ux = UL_X / vtb_page2_size_x
local uy = UL_Y / vtb_page2_size_y
local w  = W / vtb_page2_size_x
local h  = H / vtb_page2_size_y
return {{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}}
end

function create_vtb_page2_textured_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)

local mils_per_pixel = vtb_scale
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
	  object.material =  vtb_pg2_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = vtb_page2_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices
	  return object
end

--all object passed to this function will be cliped by FOV and VTB Glass
function Add_VTB_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = VTB_DEFAULT_LEVEL
	object.additive_alpha    = true --additive blending
	object.collimated 		  = false
	Add(object)
end

