-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.81 (10/01/2020) for DCS World 2.5.6.55743 (09/30/2020)
-- -----------------------------------------------------------------------------
dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

-- Font description creation function added for  M-2000C Cockpit Indications Fix
function create_font_description(TEX_PATH, TEX_RES, GLYPH_W, GLYPH_H, CUST_DOT_W)

  local DOT_W

  if(CUST_DOT_W ~= nil) 
  then
    DOT_W = CUST_DOT_W
  else 
    DOT_W = GLYPH_W
  end
  
  local font_desc  = {
    texture     = LockOn_Options.script_path.."Resources/IndicationTextures/"..TEX_PATH, 
    size        = {7, 7},
    resolution  = {TEX_RES, TEX_RES},
    default     = {GLYPH_W, GLYPH_H},
    chars	    = {
       [1]   = {32, GLYPH_W, GLYPH_H}, -- [space]
       [2]   = {42, GLYPH_W, GLYPH_H}, -- *
       [3]   = {43, GLYPH_W, GLYPH_H}, -- +
       [4]   = {45, GLYPH_W, GLYPH_H}, -- -
       [5]   = {46, DOT_W,   GLYPH_H}, -- .
       [6]   = {47, GLYPH_W, GLYPH_H}, -- /
       [7]   = {48, GLYPH_W, GLYPH_H}, -- 0
       [8]   = {49, GLYPH_W, GLYPH_H}, -- 1
       [9]   = {50, GLYPH_W, GLYPH_H}, -- 2
       [10]  = {51, GLYPH_W, GLYPH_H}, -- 3
       [11]  = {52, GLYPH_W, GLYPH_H}, -- 4
       [12]  = {53, GLYPH_W, GLYPH_H}, -- 5
       [13]  = {54, GLYPH_W, GLYPH_H}, -- 6
       [14]  = {55, GLYPH_W, GLYPH_H}, -- 7
       [15]  = {56, GLYPH_W, GLYPH_H}, -- 8
       [16]  = {57, GLYPH_W, GLYPH_H}, -- 9
       [17]  = {58, GLYPH_W, GLYPH_H}, -- :
       [18]  = {65, GLYPH_W, GLYPH_H}, -- A
       [19]  = {66, GLYPH_W, GLYPH_H}, -- B
       [20]  = {67, GLYPH_W, GLYPH_H}, -- C
       [21]  = {68, GLYPH_W, GLYPH_H}, -- D
       [22]  = {69, GLYPH_W, GLYPH_H}, -- E
       [23]  = {70, GLYPH_W, GLYPH_H}, -- F
       [24]  = {71, GLYPH_W, GLYPH_H}, -- G
       [25]  = {72, GLYPH_W, GLYPH_H}, -- H
       [26]  = {73, GLYPH_W, GLYPH_H}, -- I
       [27]  = {74, GLYPH_W, GLYPH_H}, -- J
       [28]  = {75, GLYPH_W, GLYPH_H}, -- K
       [29]  = {76, GLYPH_W, GLYPH_H}, -- L
       [30]  = {77, GLYPH_W, GLYPH_H}, -- M
       [31]  = {78, GLYPH_W, GLYPH_H}, -- N
       [32]  = {79, GLYPH_W, GLYPH_H}, -- O
       [33]  = {80, GLYPH_W, GLYPH_H}, -- P
       [34]  = {81, GLYPH_W, GLYPH_H}, -- Q
       [35]  = {82, GLYPH_W, GLYPH_H}, -- R
       [36]  = {83, GLYPH_W, GLYPH_H}, -- S
       [37]  = {84, GLYPH_W, GLYPH_H}, -- T
       [38]  = {85, GLYPH_W, GLYPH_H}, -- U
       [39]  = {86, GLYPH_W, GLYPH_H}, -- V
       [40]  = {87, GLYPH_W, GLYPH_H}, -- W
       [41]  = {88, GLYPH_W, GLYPH_H}, -- X
       [42]  = {89, GLYPH_W, GLYPH_H}, -- Y
       [43]  = {90, GLYPH_W, GLYPH_H}, -- Z
       [44]  = {91, GLYPH_W, GLYPH_H}, -- [
       [45]  = {93, GLYPH_W, GLYPH_H}, -- ]
       [46]  = {62, GLYPH_W, GLYPH_H}, -- >
       [47]  = {111, GLYPH_W, GLYPH_H}, -- o
       [48]  = {94 , GLYPH_W, GLYPH_H}  -- ^
    }
  }
  
  return font_desc
  
end


-- SPECIAL Font description creation function FOR RWR added for  M-2000C Cockpit Indications Fix
function create_RWR_font_description(TEX_PATH, TEX_RES, GLYPH_W, GLYPH_H)

  local font_desc  = {
    texture     = LockOn_Options.script_path.."Resources/IndicationTextures/"..TEX_PATH, 
    size        = {7, 7},
    resolution  = {TEX_RES, TEX_RES},
    default     = {GLYPH_W, GLYPH_H},
    chars	    = {
       [1]   = {32, GLYPH_W, GLYPH_H}, -- [space]
       [2]   = {42, GLYPH_W, GLYPH_H}, -- *
       [3]   = {43, GLYPH_W, GLYPH_H}, -- +
       [4]   = {45, GLYPH_W, GLYPH_H}, -- -
       [5]   = {59, GLYPH_W, GLYPH_H}, -- ; -- Specific to RWR Fontmap
       [6]   = {46, GLYPH_W, GLYPH_H}, -- .
       [7]   = {48, GLYPH_W, GLYPH_H}, -- 0
       [8]   = {49, GLYPH_W, GLYPH_H}, -- 1
       [9]   = {50, GLYPH_W, GLYPH_H}, -- 2
       [10]  = {51, GLYPH_W, GLYPH_H}, -- 3
       [11]  = {52, GLYPH_W, GLYPH_H}, -- 4
       [12]  = {53, GLYPH_W, GLYPH_H}, -- 5
       [13]  = {54, GLYPH_W, GLYPH_H}, -- 6
       [14]  = {55, GLYPH_W, GLYPH_H}, -- 7
       [15]  = {56, GLYPH_W, GLYPH_H}, -- 8
       [16]  = {57, GLYPH_W, GLYPH_H}, -- 9
       [17]  = {58, GLYPH_W, GLYPH_H}, -- :
       [18]  = {65, GLYPH_W, GLYPH_H}, -- A
       [19]  = {66, GLYPH_W, GLYPH_H}, -- B
       [20]  = {67, GLYPH_W, GLYPH_H}, -- C
       [21]  = {68, GLYPH_W, GLYPH_H}, -- D
       [22]  = {69, GLYPH_W, GLYPH_H}, -- E
       [23]  = {70, GLYPH_W, GLYPH_H}, -- F
       [24]  = {71, GLYPH_W, GLYPH_H}, -- G
       [25]  = {72, GLYPH_W, GLYPH_H}, -- H
       [26]  = {73, GLYPH_W, GLYPH_H}, -- I
       [27]  = {74, GLYPH_W, GLYPH_H}, -- J
       [28]  = {75, GLYPH_W, GLYPH_H}, -- K
       [29]  = {76, GLYPH_W, GLYPH_H}, -- L
       [30]  = {77, GLYPH_W, GLYPH_H}, -- M
       [31]  = {78, GLYPH_W, GLYPH_H}, -- N
       [32]  = {79, GLYPH_W, GLYPH_H}, -- O
       [33]  = {80, GLYPH_W, GLYPH_H}, -- P
       [34]  = {81, GLYPH_W, GLYPH_H}, -- Q
       [35]  = {82, GLYPH_W, GLYPH_H}, -- R
       [36]  = {83, GLYPH_W, GLYPH_H}, -- S
       [37]  = {84, GLYPH_W, GLYPH_H}, -- T
       [38]  = {85, GLYPH_W, GLYPH_H}, -- U
       [39]  = {86, GLYPH_W, GLYPH_H}, -- V
       [40]  = {87, GLYPH_W, GLYPH_H}, -- W
       [41]  = {88, GLYPH_W, GLYPH_H}, -- X
       [42]  = {89, GLYPH_W, GLYPH_H}, -- Y
       [43]  = {90, GLYPH_W, GLYPH_H}, -- Z
       [44]  = {60, GLYPH_W, GLYPH_H}, -- <  -- Specific to RWR Fontmap
       [45]  = {62, GLYPH_W, GLYPH_H}, -- =  -- Specific to RWR Fontmap
       [46]  = {61, GLYPH_W, GLYPH_H}, -- >  -- Specific to RWR Fontmap
       [47]  = {63, GLYPH_W, GLYPH_H}, -- ?  -- Specific to RWR Fontmap
       [48]  = {64, GLYPH_W, GLYPH_H} -- ^  -- Specific to RWR Fontmap
    }
  }
  
  return font_desc
  
end

-------MATERIALS-------

materials = {}   
materials["INDICATION_COMMON_RED"]      = {255, 0, 0, 255}
materials["INDICATION_COMMON_WHITE"]    = {255, 255, 255, 255}
materials["MASK_MATERIAL"]              = {255, 0, 255, 50}

materials["HUD_IND_YELLOW"]             = {243, 116, 13, 255}
materials["INDICATION_COMMON_RED"]      = {255, 0, 0, 255}

materials["LBLUE"]                      = {173, 216, 230, 255}

materials["DBG_GREY"]                   = {25, 25, 25, 255}
materials["DBG_BLACK"]                  = {0, 0, 0, 100}
materials["DBG_RED"]                    = {255, 0, 0, 100}
materials["DBG_GREEN"]                  = {0, 255, 0, 100}
materials["BLACK"]                      = {0, 0, 0, 255}
materials["SIMPLE_WHITE"]               = {255, 255, 255, 255}
materials["PURPLE"]                     = {255, 0, 255, 255}

materials["GENERAL_INFO_GOLD"]          = {255, 197, 3, 255}
materials["YELLOW"]                     = {255, 255, 0, 255}
materials["BLUE"]                       = {255, 0, 0, 255}
materials["RED"]                        = {255, 0, 0, 255}

materials["VTH_GREEN"]                  = {0, 255, 30, 220}                       -- {20, 255, 20, 225}
-- Specific opacity for HUD's dynamic non-textures line elements
materials["VTH_GREEN_ATT"]              = {0, 255, 30, 160} -- attenuated alpha   -- Added

materials["GREENBOX_GREEN"]			        = {0, 255, 70, 220}                       -- {20, 255, 20, 225}
materials["LCD_GREEN"]			            = {0, 255, 32, 220}                       -- Added
materials["LCD_RED"]			              = {255,  0, 0, 255}



materials["VTB_IND_COLOR"]		          = {64,  255,  30, 220}                      -- { 60, 250, 60, 255}
materials["VTB_IND_COLOR_ATT"]		      = {64,  255,  30, 128} -- attenuated alpha  -- Added
materials["VTB_STT_COLOR"]		          = {255, 255,  30, 220}                      -- {218, 180, 32, 255}
materials["VTB_STT_COLOR_ATT"]		      = {255, 255,  30, 128} -- attenuated alpha  -- Added
materials["VTB_WRN_COLOR"]		          = {255, 50,   30, 220}                      -- {255,   0,  0, 255}

-- Added dedicated color for RWR material and font
materials["RWR_GREEN"]                  = {128, 255,  20, 255}                      -- Added

-------TEXTURES-------
-- All textures files format  modified for M-2000C Cockpit Indications Fix. The file
-- format is now DDS instead of TGA. The DDS format offer a better mipmaping alpha
-- computation, the result is that downsampled sprites are way less blury than with
-- the dynamicaly generated mipmapping.
textures = {}

textures["ARCADE"]            = {"arcade.tga", materials["INDICATION_COMMON_RED"]}
textures["ARCADE_PUPRLE"]     = {"arcade.tga", materials["PURPLE"]}
textures["ARCADE_WHITE"]      = {"arcade.tga", materials["SIMPLE_WHITE"]}


---- VTH ----
textures["vth_ind_material"]  = {LockOn_Options.script_path.."Resources/IndicationTextures/Indication_hud_M2KC.dds",  materials["VTH_GREEN"]}
textures["vth_hdg_material"]  = {LockOn_Options.script_path.."Resources/IndicationTextures/headingtape_hud_M2KC.dds", materials["VTH_GREEN"]}
textures["vth_line_material"]	= {nil, materials["VTH_GREEN_ATT"]} -- {nil, materials["VTH_GREEN"]}

---- VTB ----
-- Heading Ruler
textures["vtb_hdg_material"]      = {LockOn_Options.script_path.."Resources/IndicationTextures/headingtape_vtb_M2KC.dds", materials["VTB_IND_COLOR"]} 

-- Grids
textures["vtb_Grid_0_material"]   = {LockOn_Options.script_path.."Resources/IndicationTextures/M2KC_VTB_Grid_0.dds", materials["VTB_IND_COLOR"]}
textures["vtb_Grid_1_material"]   = {LockOn_Options.script_path.."Resources/IndicationTextures/M2KC_VTB_Grid_1.dds", materials["VTB_IND_COLOR"]}
textures["vtb_Grid_2_material"]   = {LockOn_Options.script_path.."Resources/IndicationTextures/M2KC_VTB_Grid_2.dds", materials["VTB_IND_COLOR"]}

-- Symbols
textures["vtb_ind_material"]      = {LockOn_Options.script_path.."Resources/IndicationTextures/Indication_VTB_M2KC.dds", materials["VTB_IND_COLOR"]}
textures["vtb_rdr_ind_material"]  = {LockOn_Options.script_path.."Resources/IndicationTextures/Indication_VTB_M2KC.dds", materials["VTB_IND_COLOR"]}
textures["vtb_stt_material"]      = {LockOn_Options.script_path.."Resources/IndicationTextures/Indication_VTB_M2KC.dds", materials["VTB_STT_COLOR"]}
textures["vtb_wrn_material"]      = {LockOn_Options.script_path.."Resources/IndicationTextures/Indication_VTB_M2KC.dds", materials["VTB_WRN_COLOR"]}
textures["vtb_line_material"]     = {nil, materials["VTB_IND_COLOR_ATT"]} -- {nil, materials["VTB_IND_COLOR"]}
textures["vtb_line_material_DO"]	= {nil, materials["VTB_STT_COLOR_ATT"]}

-- Page 2
textures["vtb_pg2_material"]      = {LockOn_Options.script_path.."Resources/IndicationTextures/M2KC_VTB_Page_2.dds", materials["VTB_IND_COLOR"]}

---- SERVAL ----
textures["rwr_ind_material"]			=  {LockOn_Options.script_path.."Resources/IndicationTextures/Indication_VTB_M2KC.dds", materials["RWR_GREEN"]} -- materials["GREENBOX_GREEN"]}

-------FONTS----------
fontdescription = {}
fontdescription["font_general_loc"]   = fontdescription_cmn["font_general_loc"]

-- Font definitions are modified for M-2000C Cockpit Indications Fix, we now
-- have two 512x512 textures instead of only one 1024x1024. Notice that 512x512
-- is way sufficient since you never can zoom enough to use the full resolution 
-- texture, the render engine always use a smaller mipmap. Also, smaller 
-- textures save graphical memory and GPU bandwidth.
fontdescription["VTH_font"]         = create_font_description("font_HUD_M2KC.dds", 512, 44, 72, 25)
-- The following font definition is added for M-2000C Cockpit Indications Fix,
-- this is a secondary fontmap, thinner (light weight) than the standard one to
-- be used for large HUD text
fontdescription["VTH_font_big"]     = create_font_description("font_HUD_big_M2KC.dds", 512, 44, 72, 25)

-- RWR font definition modified for M-2000C Cockpit Indications Fix, has a specific char Mapping
fontdescription["SERVAL_font"]      = create_RWR_font_description("font_RWR_M2KC.dds", 256, 22, 38)

fontdescription["VTB_font"]         = create_font_description("font_VTB_M2KC.dds", 256, 24, 38, 13)

-- font definition modified for M-2000C Cockpit Indications Fix, now only 512x512. 
fontdescription["PCA_font"]         = create_font_description("font_PCA_M2KC.dds", 512, 58, 72, nil) -- 1024, 116, 144

-- Modified LDC font for M-2000C Cockpit Indications Fix with larger
-- digit spacing
fontdescription["LCD_font"]         = create_font_description("font_LCD_M2KC.dds", 512, 56, 72, nil) -- 1024, 88, 144

fontdescription["RADIO_font"]       = create_font_description("font_GreenBoxRadio_M2KC.dds", 512, 62, 72, nil)  -- 1024, 88, 144

-- PCN font definition added for M-2000C Cockpit Indications Fix, now a dedicated 
-- font definition for the PCN with proper digit spacing
fontdescription["PCN_font"]         = create_font_description("font_LCD_M2KC.dds", 512, 44, 72, nil) -- 1024, 88, 144
  
fonts = {}
fonts["font_general_keys"]				= {fontdescription["font_general_loc"], 10, {255,75,75,255}}
fonts["font_hints_kneeboard"]			= {fontdescription["font_general_loc"], 10, {100,0,100,255}}

-- VTH
fonts["vth_indication_font_big"]  = {fontdescription["VTH_font_big"],   10, materials["VTH_GREEN"]} -- ADDED
fonts["vth_indication_font"]        = {fontdescription["VTH_font"],     10, materials["VTH_GREEN"]}

-- VTB
fonts["vtb_indication_font"]			= {fontdescription["VTB_font"], 10, materials["VTB_IND_COLOR"]}
fonts["vtb_stt_indication_font"]		= {fontdescription["VTB_font"], 10, materials["VTB_STT_COLOR"]}

-- PCA/PPA
fonts["pca_gauge_font"]				= {fontdescription["PCA_font"], 10, materials["GREENBOX_GREEN"]}
fonts["PPA_gauge_font"]				= {fontdescription["LCD_font"], 10, materials["LCD_GREEN"]}

-- PCN
fonts["pcn_gauge_font"]				= {fontdescription["PCN_font"], 10, materials["LCD_GREEN"]} -- changed from LCD_font to PCN_font
fonts["pcn_gauge_rfont"]			= {fontdescription["PCN_font"], 10, materials["LCD_RED"]}   -- changed from LCD_font to PCN_font

-- SERVAL
fonts["rwr_indication_font"]		= {fontdescription["SERVAL_font"], 10, materials["RWR_GREEN"]} -- {fontdescription["VTH_font"], 10, materials["GREENBOX_GREEN"]}

-- RADIO
fonts["COM_gauge_font"]				  = {fontdescription["LCD_font"], 10, materials["LCD_GREEN"]}
fonts["COM_greenbox_font"]			= {fontdescription["RADIO_font"], 10, materials["GREENBOX_GREEN"]}

-- FUEL Gauge font definition added in this file for M-2000C Cockpit Indications Fix

-- FUEL
fonts["fuel_gauge_font"]				= {fontdescription["LCD_font"], 10, materials["LCD_GREEN"]}
