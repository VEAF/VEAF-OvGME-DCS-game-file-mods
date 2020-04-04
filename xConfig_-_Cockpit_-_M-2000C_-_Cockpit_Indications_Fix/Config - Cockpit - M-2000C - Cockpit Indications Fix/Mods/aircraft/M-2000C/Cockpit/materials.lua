-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.4 (04/01/2020) for DCS World 2.5.6.45915 (03/31/2020)
-- -----------------------------------------------------------------------------
dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

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

materials["VTH_GREEN"]                  = {0, 255, 68, 255}                       -- {20, 255, 20, 225}
materials["GREENBOX_GREEN"]			        = {0, 255, 68, 255}                       -- {20, 255, 20, 225}
materials["LCD_RED"]			              = {255, 0, 0, 255}

-- Specific color for HUD's dynamic vectorial elements
--
-- Dynamical vector elements do not pass through filtering like textures, it 
-- results on a pure color/alpha component without alteration, so we need to 
-- slightly attenuate alpha channnel to keep them harmonized with all others 
-- elements
materials["VTH_GREEN_ATT"]              = {0, 255, 68, 225} -- attenuated         -- Added

materials["VTB_IND_COLOR"]		          = {96,  255,  50, 255}                    -- { 60, 250, 60, 255}
materials["VTB_IND_COLOR_ATT"]		      = {96,  255,  50, 200} -- attenuated      -- Added
materials["VTB_STT_COLOR"]		          = {255, 255,  50, 255}                    -- {218, 180, 32, 255}
materials["VTB_WRN_COLOR"]		          = {255, 80,   0,  255}                    -- {255,   0,  0, 255}

-- Added dedicated color for RWR material and font
materials["RWR_GREEN"]                  = {122,255,4,255}                         -- Added

-------TEXTURES-------
textures = {}

textures["ARCADE"]            = {"arcade.tga", materials["INDICATION_COMMON_RED"]}
textures["ARCADE_PUPRLE"]     = {"arcade.tga", materials["PURPLE"]}
textures["ARCADE_WHITE"]      = {"arcade.tga", materials["SIMPLE_WHITE"]}

---- VTH ----
textures["vth_ind_material"]  = {LockOn_Options.script_path.."Resources/IndicationTextures/Indication_hud_M2KC.tga",  materials["VTH_GREEN"]}
textures["vth_hdg_material"]  = {LockOn_Options.script_path.."Resources/IndicationTextures/headingtape_hud_M2KC.tga", materials["VTH_GREEN"]}
textures["vth_line_material"]	= {nil, materials["VTH_GREEN_ATT"]} -- {nil, materials["VTH_GREEN"]}

---- VTB ----
-- Heading Ruler
textures["vtb_hdg_material"]      = {LockOn_Options.script_path.."Resources/IndicationTextures/headingtape_vtb_M2KC.tga", materials["VTB_IND_COLOR"]} 

-- Grids
textures["vtb_Grid_0_material"]   = {LockOn_Options.script_path.."Resources/IndicationTextures/M2KC_VTB_Grid_0.tga", materials["VTB_IND_COLOR"]}
textures["vtb_Grid_1_material"]   = {LockOn_Options.script_path.."Resources/IndicationTextures/M2KC_VTB_Grid_1.tga", materials["VTB_IND_COLOR"]}
textures["vtb_Grid_2_material"]   = {LockOn_Options.script_path.."Resources/IndicationTextures/M2KC_VTB_Grid_2.tga", materials["VTB_IND_COLOR"]}

-- Symbols
textures["vtb_ind_material"]      = {LockOn_Options.script_path.."Resources/IndicationTextures/Indication_VTB_M2KC.tga", materials["VTB_IND_COLOR"]}
textures["vtb_rdr_ind_material"]  = {LockOn_Options.script_path.."Resources/IndicationTextures/Indication_VTB_M2KC.tga", materials["VTB_IND_COLOR"]}
textures["vtb_stt_material"]      = {LockOn_Options.script_path.."Resources/IndicationTextures/Indication_VTB_M2KC.tga", materials["VTB_STT_COLOR"]}
textures["vtb_wrn_material"]      = {LockOn_Options.script_path.."Resources/IndicationTextures/Indication_VTB_M2KC.tga", materials["VTB_WRN_COLOR"]}
textures["vtb_line_material"]     = {nil, materials["VTB_IND_COLOR_ATT"]} -- {nil, materials["VTB_IND_COLOR"]}

-- Page 2
textures["vtb_pg2_material"]      = {LockOn_Options.script_path.."Resources/IndicationTextures/M2KC_VTB_Page_2.tga", materials["VTB_IND_COLOR"]}

---- SERVAL ----
textures["rwr_ind_material"]				=  {LockOn_Options.script_path.."Resources/IndicationTextures/Indication_VTB_M2KC.tga", materials["RWR_GREEN"]} -- materials["GREENBOX_GREEN"]}

-------FONTS----------
fontdescription = {}
fontdescription["font_general_loc"]   = fontdescription_cmn["font_general_loc"]

-- Font definitions are modified for M-2000C Cockpit Indications Fix, we now
-- have two 512x512 textures instead of only one 1024x1024. Notice that 512x512
-- is way sufficient since you never can zoom enough to use the full resolution 
-- texture, the render engine always use a smaller mipmap. Also, smaller 
-- textures save graphical memory and GPU bandwidth.

symbol_pixels_x =  44                                                             -- * 2 : adatped for 512x512 texture
symbol_pixels_y =  72                                                             -- * 2 : adatped for 512x512 texture

-- The following font definition was added for M-2000C Cockpit Indications Fix,
-- this is a secondary fontmap, thinner (light weight) than the standard one to
-- be used for large HUD text
fontdescription["VTH_font_light"]  = {
	texture     = LockOn_Options.script_path.."Resources/IndicationTextures/font_HUD_light_M2KC.tga", 
	size        = {7, 7},
	resolution  = {512, 512},                                                       -- {1024, 1024},
	default     = {symbol_pixels_x, symbol_pixels_y},
	chars	    = {
		 [1]   = {32, symbol_pixels_x, symbol_pixels_y}, -- [space]
		 [2]   = {42, symbol_pixels_x, symbol_pixels_y}, -- *
		 [3]   = {43, symbol_pixels_x, symbol_pixels_y}, -- +
		 [4]   = {45, symbol_pixels_x, symbol_pixels_y}, -- -
		 [5]   = {46,              25, symbol_pixels_y}, -- .                         -- {46, symbol_pixels_x, symbol_pixels_y}, -- .
		 [6]   = {47, symbol_pixels_x, symbol_pixels_y}, -- /
		 [7]   = {48, symbol_pixels_x, symbol_pixels_y}, -- 0
		 [8]   = {49, symbol_pixels_x, symbol_pixels_y}, -- 1
		 [9]   = {50, symbol_pixels_x, symbol_pixels_y}, -- 2
		 [10]  = {51, symbol_pixels_x, symbol_pixels_y}, -- 3
		 [11]  = {52, symbol_pixels_x, symbol_pixels_y}, -- 4
		 [12]  = {53, symbol_pixels_x, symbol_pixels_y}, -- 5
		 [13]  = {54, symbol_pixels_x, symbol_pixels_y}, -- 6
		 [14]  = {55, symbol_pixels_x, symbol_pixels_y}, -- 7
		 [15]  = {56, symbol_pixels_x, symbol_pixels_y}, -- 8
		 [16]  = {57, symbol_pixels_x, symbol_pixels_y}, -- 9
		 [17]  = {58, symbol_pixels_x, symbol_pixels_y}, -- :
		 [18]  = {65, symbol_pixels_x, symbol_pixels_y}, -- A
		 [19]  = {66, symbol_pixels_x, symbol_pixels_y}, -- B
		 [20]  = {67, symbol_pixels_x, symbol_pixels_y}, -- C
		 [21]  = {68, symbol_pixels_x, symbol_pixels_y}, -- D
		 [22]  = {69, symbol_pixels_x, symbol_pixels_y}, -- E
		 [23]  = {70, symbol_pixels_x, symbol_pixels_y}, -- F
		 [24]  = {71, symbol_pixels_x, symbol_pixels_y}, -- G
		 [25]  = {72, symbol_pixels_x, symbol_pixels_y}, -- H
		 [26]  = {73, symbol_pixels_x, symbol_pixels_y}, -- I
		 [27]  = {74, symbol_pixels_x, symbol_pixels_y}, -- J
		 [28]  = {75, symbol_pixels_x, symbol_pixels_y}, -- K
		 [29]  = {76, symbol_pixels_x, symbol_pixels_y}, -- L
		 [30]  = {77, symbol_pixels_x, symbol_pixels_y}, -- M
		 [31]  = {78, symbol_pixels_x, symbol_pixels_y}, -- N
		 [32]  = {79, symbol_pixels_x, symbol_pixels_y}, -- O
		 [33]  = {80, symbol_pixels_x, symbol_pixels_y}, -- P
		 [34]  = {81, symbol_pixels_x, symbol_pixels_y}, -- Q
		 [35]  = {82, symbol_pixels_x, symbol_pixels_y}, -- R
		 [36]  = {83, symbol_pixels_x, symbol_pixels_y}, -- S
		 [37]  = {84, symbol_pixels_x, symbol_pixels_y}, -- T
		 [38]  = {85, symbol_pixels_x, symbol_pixels_y}, -- U
		 [39]  = {86, symbol_pixels_x, symbol_pixels_y}, -- V
		 [40]  = {87, symbol_pixels_x, symbol_pixels_y}, -- W
		 [41]  = {88, symbol_pixels_x, symbol_pixels_y}, -- X
		 [42]  = {89, symbol_pixels_x, symbol_pixels_y}, -- Y
		 [43]  = {90, symbol_pixels_x, symbol_pixels_y}, -- Z
		 [44]  = {91, symbol_pixels_x, symbol_pixels_y}, -- [
		 [45]  = {93, symbol_pixels_x, symbol_pixels_y}, -- ]
		 [46]  = {62, symbol_pixels_x, symbol_pixels_y}, -- >
		 [47]  = {111, symbol_pixels_x, symbol_pixels_y}, -- o
		 [48]  = {94 , symbol_pixels_x, symbol_pixels_y}  -- ^
	}
}

fontdescription["VTH_font"]  = {
	texture     = LockOn_Options.script_path.."Resources/IndicationTextures/font_HUD_M2KC.tga",
	size        = {7, 7},
	resolution  = {512, 512},                                                       -- {1024, 1024},
	default     = {symbol_pixels_x, symbol_pixels_y},
	chars	    = {
		 [1]   = {32, symbol_pixels_x, symbol_pixels_y}, -- [space]
		 [2]   = {42, symbol_pixels_x, symbol_pixels_y}, -- *
		 [3]   = {43, symbol_pixels_x, symbol_pixels_y}, -- +
		 [4]   = {45, symbol_pixels_x, symbol_pixels_y}, -- -
		 [5]   = {46,              25, symbol_pixels_y}, -- .                         -- {46, symbol_pixels_x, symbol_pixels_y}, -- .
		 [6]   = {47, symbol_pixels_x, symbol_pixels_y}, -- /
		 [7]   = {48, symbol_pixels_x, symbol_pixels_y}, -- 0
		 [8]   = {49, symbol_pixels_x, symbol_pixels_y}, -- 1
		 [9]   = {50, symbol_pixels_x, symbol_pixels_y}, -- 2
		 [10]  = {51, symbol_pixels_x, symbol_pixels_y}, -- 3
		 [11]  = {52, symbol_pixels_x, symbol_pixels_y}, -- 4
		 [12]  = {53, symbol_pixels_x, symbol_pixels_y}, -- 5
		 [13]  = {54, symbol_pixels_x, symbol_pixels_y}, -- 6
		 [14]  = {55, symbol_pixels_x, symbol_pixels_y}, -- 7
		 [15]  = {56, symbol_pixels_x, symbol_pixels_y}, -- 8
		 [16]  = {57, symbol_pixels_x, symbol_pixels_y}, -- 9
		 [17]  = {58, symbol_pixels_x, symbol_pixels_y}, -- :
		 [18]  = {65, symbol_pixels_x, symbol_pixels_y}, -- A
		 [19]  = {66, symbol_pixels_x, symbol_pixels_y}, -- B
		 [20]  = {67, symbol_pixels_x, symbol_pixels_y}, -- C
		 [21]  = {68, symbol_pixels_x, symbol_pixels_y}, -- D
		 [22]  = {69, symbol_pixels_x, symbol_pixels_y}, -- E
		 [23]  = {70, symbol_pixels_x, symbol_pixels_y}, -- F
		 [24]  = {71, symbol_pixels_x, symbol_pixels_y}, -- G
		 [25]  = {72, symbol_pixels_x, symbol_pixels_y}, -- H
		 [26]  = {73, symbol_pixels_x, symbol_pixels_y}, -- I
		 [27]  = {74, symbol_pixels_x, symbol_pixels_y}, -- J
		 [28]  = {75, symbol_pixels_x, symbol_pixels_y}, -- K
		 [29]  = {76, symbol_pixels_x, symbol_pixels_y}, -- L
		 [30]  = {77, symbol_pixels_x, symbol_pixels_y}, -- M
		 [31]  = {78, symbol_pixels_x, symbol_pixels_y}, -- N
		 [32]  = {79, symbol_pixels_x, symbol_pixels_y}, -- O
		 [33]  = {80, symbol_pixels_x, symbol_pixels_y}, -- P
		 [34]  = {81, symbol_pixels_x, symbol_pixels_y}, -- Q
		 [35]  = {82, symbol_pixels_x, symbol_pixels_y}, -- R
		 [36]  = {83, symbol_pixels_x, symbol_pixels_y}, -- S
		 [37]  = {84, symbol_pixels_x, symbol_pixels_y}, -- T
		 [38]  = {85, symbol_pixels_x, symbol_pixels_y}, -- U
		 [39]  = {86, symbol_pixels_x, symbol_pixels_y}, -- V
		 [40]  = {87, symbol_pixels_x, symbol_pixels_y}, -- W
		 [41]  = {88, symbol_pixels_x, symbol_pixels_y}, -- X
		 [42]  = {89, symbol_pixels_x, symbol_pixels_y}, -- Y
		 [43]  = {90, symbol_pixels_x, symbol_pixels_y}, -- Z
		 [44]  = {91, symbol_pixels_x, symbol_pixels_y}, -- [
		 [45]  = {93, symbol_pixels_x, symbol_pixels_y}, -- ]
		 [46]  = {62, symbol_pixels_x, symbol_pixels_y}, -- >
		 [47]  = {111, symbol_pixels_x, symbol_pixels_y}, -- o
		 [48]  = {94 , symbol_pixels_x, symbol_pixels_y}  -- ^
	}
}

-- font definition modified for M-2000C Cockpit Indications Fix, now a dedicated 
-- 256x256 texture is used as fontmap. Notice that 1024x1024 fontmap texture 
-- is an overkill since RWR texts are very small and always mipmaped. 256x256 
-- texture will save some graphical memory and bandwidth.
symbol_pixels_x       = 27                                                       -- 44 * 2 : Adjusted for 256 tex & to increase space between letters
symbol_pixels_y       = 38                                                       -- 72 * 2 : Adjusted for 256 tex
fontdescription["RWR_font"]  = {
  texture     = "Mods/aircraft/M-2000C/Cockpit/Resources/IndicationTextures/font_RWR_M2KC.tga",  -- font_HUD_M2KC.tga
	size        = {7, 7},
	resolution  = {256, 256},                                                       -- {1024, 1024},
	default     = {symbol_pixels_x, symbol_pixels_y},
	chars	    = {

		 [1]   = {32, symbol_pixels_x, symbol_pixels_y}, -- [space]
		 [2]   = {42, symbol_pixels_x, symbol_pixels_y}, -- *
		 [3]   = {43, symbol_pixels_x, symbol_pixels_y}, -- +
		 [4]   = {45, symbol_pixels_x, symbol_pixels_y}, -- -
		 [5]   = {46, symbol_pixels_x, symbol_pixels_y}, -- .
		 [6]   = {47, symbol_pixels_x, symbol_pixels_y}, -- /
		 [7]   = {48, symbol_pixels_x, symbol_pixels_y}, -- 0
		 [8]   = {49, symbol_pixels_x, symbol_pixels_y}, -- 1
		 [9]   = {50, symbol_pixels_x, symbol_pixels_y}, -- 2
		 [10]  = {51, symbol_pixels_x, symbol_pixels_y}, -- 3
		 [11]  = {52, symbol_pixels_x, symbol_pixels_y}, -- 4
		 [12]  = {53, symbol_pixels_x, symbol_pixels_y}, -- 5
		 [13]  = {54, symbol_pixels_x, symbol_pixels_y}, -- 6
		 [14]  = {55, symbol_pixels_x, symbol_pixels_y}, -- 7
		 [15]  = {56, symbol_pixels_x, symbol_pixels_y}, -- 8
		 [16]  = {57, symbol_pixels_x, symbol_pixels_y}, -- 9
		 [17]  = {58, symbol_pixels_x, symbol_pixels_y}, -- :
		 [18]  = {65, symbol_pixels_x, symbol_pixels_y}, -- A
		 [19]  = {66, symbol_pixels_x, symbol_pixels_y}, -- B
		 [20]  = {67, symbol_pixels_x, symbol_pixels_y}, -- C
		 [21]  = {68, symbol_pixels_x, symbol_pixels_y}, -- D
		 [22]  = {69, symbol_pixels_x, symbol_pixels_y}, -- E
		 [23]  = {70, symbol_pixels_x, symbol_pixels_y}, -- F
		 [24]  = {71, symbol_pixels_x, symbol_pixels_y}, -- G
		 [25]  = {72, symbol_pixels_x, symbol_pixels_y}, -- H
		 [26]  = {73, symbol_pixels_x, symbol_pixels_y}, -- I
		 [27]  = {74, symbol_pixels_x, symbol_pixels_y}, -- J
		 [28]  = {75, symbol_pixels_x, symbol_pixels_y}, -- K
		 [29]  = {76, symbol_pixels_x, symbol_pixels_y}, -- L
		 [30]  = {77, symbol_pixels_x, symbol_pixels_y}, -- M
		 [31]  = {78, symbol_pixels_x, symbol_pixels_y}, -- N
		 [32]  = {79, symbol_pixels_x, symbol_pixels_y}, -- O
		 [33]  = {80, symbol_pixels_x, symbol_pixels_y}, -- P
		 [34]  = {81, symbol_pixels_x, symbol_pixels_y}, -- Q
		 [35]  = {82, symbol_pixels_x, symbol_pixels_y}, -- R
		 [36]  = {83, symbol_pixels_x, symbol_pixels_y}, -- S
		 [37]  = {84, symbol_pixels_x, symbol_pixels_y}, -- T
		 [38]  = {85, symbol_pixels_x, symbol_pixels_y}, -- U
		 [39]  = {86, symbol_pixels_x, symbol_pixels_y}, -- V
		 [40]  = {87, symbol_pixels_x, symbol_pixels_y}, -- W
		 [41]  = {88, symbol_pixels_x, symbol_pixels_y}, -- X
		 [42]  = {89, symbol_pixels_x, symbol_pixels_y}, -- Y
		 [43]  = {90, symbol_pixels_x, symbol_pixels_y}, -- Z
		 [44]  = {91, symbol_pixels_x, symbol_pixels_y}, -- [
		 [45]  = {93, symbol_pixels_x, symbol_pixels_y}, -- ]
		 [46]  = {62, symbol_pixels_x, symbol_pixels_y}, -- >
		 [47]  = {111, symbol_pixels_x, symbol_pixels_y}, -- o
		 [48]  = {94 , symbol_pixels_x, symbol_pixels_y}} -- ^
}

symbol_pixels_x = 24                                                              -- 44.0 * 2 : adapted for 256x256 texture
symbol_pixels_y = 38                                                              -- 72.0 * 2 : adapted for 256x256 texture
fontdescription["VTB_font"]  = {
	texture     = LockOn_Options.script_path.."Resources/IndicationTextures/font_VTB_M2KC.tga",
	size        = {7, 7},
	resolution  = {256, 256},                                                       -- {1024, 1024},
	default     = {symbol_pixels_x, symbol_pixels_y},
	chars	    = {

		 [1]   = {32, symbol_pixels_x, symbol_pixels_y}, -- [space]
		 [2]   = {42, symbol_pixels_x, symbol_pixels_y}, -- *
		 [3]   = {43, symbol_pixels_x, symbol_pixels_y}, -- +
		 [4]   = {45, symbol_pixels_x, symbol_pixels_y}, -- -
		 [5]   = {46,              13, symbol_pixels_y}, -- .                         -- [5]   = {46, symbol_pixels_x, symbol_pixels_y}, -- .
		 [6]   = {47, symbol_pixels_x, symbol_pixels_y}, -- /
		 [7]   = {48, symbol_pixels_x, symbol_pixels_y}, -- 0
		 [8]   = {49, symbol_pixels_x, symbol_pixels_y}, -- 1
		 [9]   = {50, symbol_pixels_x, symbol_pixels_y}, -- 2
		 [10]  = {51, symbol_pixels_x, symbol_pixels_y}, -- 3
		 [11]  = {52, symbol_pixels_x, symbol_pixels_y}, -- 4
		 [12]  = {53, symbol_pixels_x, symbol_pixels_y}, -- 5
		 [13]  = {54, symbol_pixels_x, symbol_pixels_y}, -- 6
		 [14]  = {55, symbol_pixels_x, symbol_pixels_y}, -- 7
		 [15]  = {56, symbol_pixels_x, symbol_pixels_y}, -- 8
		 [16]  = {57, symbol_pixels_x, symbol_pixels_y}, -- 9
		 [17]  = {58, symbol_pixels_x, symbol_pixels_y}, -- :
		 [18]  = {65, symbol_pixels_x, symbol_pixels_y}, -- A
		 [19]  = {66, symbol_pixels_x, symbol_pixels_y}, -- B
		 [20]  = {67, symbol_pixels_x, symbol_pixels_y}, -- C
		 [21]  = {68, symbol_pixels_x, symbol_pixels_y}, -- D
		 [22]  = {69, symbol_pixels_x, symbol_pixels_y}, -- E
		 [23]  = {70, symbol_pixels_x, symbol_pixels_y}, -- F
		 [24]  = {71, symbol_pixels_x, symbol_pixels_y}, -- G
		 [25]  = {72, symbol_pixels_x, symbol_pixels_y}, -- H
		 [26]  = {73, symbol_pixels_x, symbol_pixels_y}, -- I
		 [27]  = {74, symbol_pixels_x, symbol_pixels_y}, -- J
		 [28]  = {75, symbol_pixels_x, symbol_pixels_y}, -- K
		 [29]  = {76, symbol_pixels_x, symbol_pixels_y}, -- L
		 [30]  = {77, symbol_pixels_x, symbol_pixels_y}, -- M
		 [31]  = {78, symbol_pixels_x, symbol_pixels_y}, -- N
		 [32]  = {79, symbol_pixels_x, symbol_pixels_y}, -- O
		 [33]  = {80, symbol_pixels_x, symbol_pixels_y}, -- P
		 [34]  = {81, symbol_pixels_x, symbol_pixels_y}, -- Q
		 [35]  = {82, symbol_pixels_x, symbol_pixels_y}, -- R
		 [36]  = {83, symbol_pixels_x, symbol_pixels_y}, -- S
		 [37]  = {84, symbol_pixels_x, symbol_pixels_y}, -- T
		 [38]  = {85, symbol_pixels_x, symbol_pixels_y}, -- U
		 [39]  = {86, symbol_pixels_x, symbol_pixels_y}, -- V
		 [40]  = {87, symbol_pixels_x, symbol_pixels_y}, -- W
		 [41]  = {88, symbol_pixels_x, symbol_pixels_y}, -- X
		 [42]  = {89, symbol_pixels_x, symbol_pixels_y}, -- Y
		 [43]  = {90, symbol_pixels_x, symbol_pixels_y}, -- Z
		 [44]  = {91, symbol_pixels_x, symbol_pixels_y}, -- [
		 [45]  = {93, symbol_pixels_x, symbol_pixels_y}, -- ]
		 [46]  = {62, symbol_pixels_x, symbol_pixels_y}, -- >
		 [47]  = {111, symbol_pixels_x, symbol_pixels_y}, -- o
		 [48]  = {94 ,  symbol_pixels_x, symbol_pixels_y}} -- ^
}

symbol_pixels_x =  58 * 2                                                         -- 44 * 2 -- pi
symbol_pixels_y =  72 * 2

fontdescription["PCA_font"]  = {
	texture     = LockOn_Options.script_path.."Resources/IndicationTextures/font_PCA_M2KC.tga",
	size        = {7, 7},
	resolution  = {1024, 1024},
	default     = {symbol_pixels_x, symbol_pixels_y},
	chars	    = {

		 [1]   = {32, symbol_pixels_x, symbol_pixels_y}, -- [space]
		 [2]   = {42, symbol_pixels_x, symbol_pixels_y}, -- *
		 [3]   = {43, symbol_pixels_x, symbol_pixels_y}, -- +
		 [4]   = {45, symbol_pixels_x, symbol_pixels_y}, -- -
		 [5]   = {46, symbol_pixels_x, symbol_pixels_y}, -- .
		 [6]   = {47, symbol_pixels_x, symbol_pixels_y}, -- /
		 [7]   = {48, symbol_pixels_x, symbol_pixels_y}, -- 0
		 [8]   = {49, symbol_pixels_x, symbol_pixels_y}, -- 1
		 [9]   = {50, symbol_pixels_x, symbol_pixels_y}, -- 2
		 [10]  = {51, symbol_pixels_x, symbol_pixels_y}, -- 3
		 [11]  = {52, symbol_pixels_x, symbol_pixels_y}, -- 4
		 [12]  = {53, symbol_pixels_x, symbol_pixels_y}, -- 5
		 [13]  = {54, symbol_pixels_x, symbol_pixels_y}, -- 6
		 [14]  = {55, symbol_pixels_x, symbol_pixels_y}, -- 7
		 [15]  = {56, symbol_pixels_x, symbol_pixels_y}, -- 8
		 [16]  = {57, symbol_pixels_x, symbol_pixels_y}, -- 9
		 [17]  = {58, symbol_pixels_x, symbol_pixels_y}, -- :
		 [18]  = {65, symbol_pixels_x, symbol_pixels_y}, -- A
		 [19]  = {66, symbol_pixels_x, symbol_pixels_y}, -- B
		 [20]  = {67, symbol_pixels_x, symbol_pixels_y}, -- C
		 [21]  = {68, symbol_pixels_x, symbol_pixels_y}, -- D
		 [22]  = {69, symbol_pixels_x, symbol_pixels_y}, -- E
		 [23]  = {70, symbol_pixels_x, symbol_pixels_y}, -- F
		 [24]  = {71, symbol_pixels_x, symbol_pixels_y}, -- G
		 [25]  = {72, symbol_pixels_x, symbol_pixels_y}, -- H
		 [26]  = {73, symbol_pixels_x, symbol_pixels_y}, -- I
		 [27]  = {74, symbol_pixels_x, symbol_pixels_y}, -- J
		 [28]  = {75, symbol_pixels_x, symbol_pixels_y}, -- K
		 [29]  = {76, symbol_pixels_x, symbol_pixels_y}, -- L
		 [30]  = {77, symbol_pixels_x, symbol_pixels_y}, -- M
		 [31]  = {78, symbol_pixels_x, symbol_pixels_y}, -- N
		 [32]  = {79, symbol_pixels_x, symbol_pixels_y}, -- O
		 [33]  = {80, symbol_pixels_x, symbol_pixels_y}, -- P
		 [34]  = {81, symbol_pixels_x, symbol_pixels_y}, -- Q
		 [35]  = {82, symbol_pixels_x, symbol_pixels_y}, -- R
		 [36]  = {83, symbol_pixels_x, symbol_pixels_y}, -- S
		 [37]  = {84, symbol_pixels_x, symbol_pixels_y}, -- T
		 [38]  = {85, symbol_pixels_x, symbol_pixels_y}, -- U
		 [39]  = {86, symbol_pixels_x, symbol_pixels_y}, -- V
		 [40]  = {87, symbol_pixels_x, symbol_pixels_y}, -- W
		 [41]  = {88, symbol_pixels_x, symbol_pixels_y}, -- X
		 [42]  = {89, symbol_pixels_x, symbol_pixels_y}, -- Y
		 [43]  = {90, symbol_pixels_x, symbol_pixels_y}, -- Z
		 [44]  = {91, symbol_pixels_x, symbol_pixels_y}, -- [
		 [45]  = {93, symbol_pixels_x, symbol_pixels_y}, -- ]
		 [46]  = {62, symbol_pixels_x, symbol_pixels_y}, -- >
		 [47]  = {111, symbol_pixels_x, symbol_pixels_y}, -- o
		 [48]  = {94 ,  symbol_pixels_x, symbol_pixels_y}} -- ^
}

symbol_pixels_x =  44 * 2
symbol_pixels_y =  72 * 2

fontdescription["LCD_font"]  = {
	texture     = LockOn_Options.script_path.."Resources/IndicationTextures/font_LCD_M2KC.tga",
	size        = {7, 7},
	resolution  = {1024, 1024},
	default     = {symbol_pixels_x, symbol_pixels_y},
	chars	    = {
	 [1]   = {32, symbol_pixels_x, symbol_pixels_y}, -- [space]
	 [2]   = {42, symbol_pixels_x, symbol_pixels_y}, -- *
	 [3]   = {43, symbol_pixels_x, symbol_pixels_y}, -- +
	 [4]   = {45, symbol_pixels_x, symbol_pixels_y}, -- -
	 [5]   = {46, symbol_pixels_x, symbol_pixels_y}, -- .
	 [6]   = {47, symbol_pixels_x, symbol_pixels_y}, -- /
	 [7]   = {48, symbol_pixels_x, symbol_pixels_y}, -- 0
	 [8]   = {49, symbol_pixels_x, symbol_pixels_y}, -- 1
	 [9]   = {50, symbol_pixels_x, symbol_pixels_y}, -- 2
	 [10]  = {51, symbol_pixels_x, symbol_pixels_y}, -- 3
	 [11]  = {52, symbol_pixels_x, symbol_pixels_y}, -- 4
	 [12]  = {53, symbol_pixels_x, symbol_pixels_y}, -- 5
	 [13]  = {54, symbol_pixels_x, symbol_pixels_y}, -- 6
	 [14]  = {55, symbol_pixels_x, symbol_pixels_y}, -- 7
	 [15]  = {56, symbol_pixels_x, symbol_pixels_y}, -- 8
	 [16]  = {57, symbol_pixels_x, symbol_pixels_y}, -- 9
	 [17]  = {58, symbol_pixels_x, symbol_pixels_y}, -- :
	 [18]  = {65, symbol_pixels_x, symbol_pixels_y}, -- A
	 [19]  = {66, symbol_pixels_x, symbol_pixels_y}, -- B
	 [20]  = {67, symbol_pixels_x, symbol_pixels_y}, -- C
	 [21]  = {68, symbol_pixels_x, symbol_pixels_y}, -- D
	 [22]  = {69, symbol_pixels_x, symbol_pixels_y}, -- E
	 [23]  = {70, symbol_pixels_x, symbol_pixels_y}, -- F
	 [24]  = {71, symbol_pixels_x, symbol_pixels_y}, -- G
	 [25]  = {72, symbol_pixels_x, symbol_pixels_y}, -- H
	 [26]  = {73, symbol_pixels_x, symbol_pixels_y}, -- I
	 [27]  = {74, symbol_pixels_x, symbol_pixels_y}, -- J
	 [28]  = {75, symbol_pixels_x, symbol_pixels_y}, -- K
	 [29]  = {76, symbol_pixels_x, symbol_pixels_y}, -- L
	 [30]  = {77, symbol_pixels_x, symbol_pixels_y}, -- M
	 [31]  = {78, symbol_pixels_x, symbol_pixels_y}, -- N
	 [32]  = {79, symbol_pixels_x, symbol_pixels_y}, -- O
	 [33]  = {80, symbol_pixels_x, symbol_pixels_y}, -- P
	 [34]  = {81, symbol_pixels_x, symbol_pixels_y}, -- Q
	 [35]  = {82, symbol_pixels_x, symbol_pixels_y}, -- R
	 [36]  = {83, symbol_pixels_x, symbol_pixels_y}, -- S
	 [37]  = {84, symbol_pixels_x, symbol_pixels_y}, -- T
	 [38]  = {85, symbol_pixels_x, symbol_pixels_y}, -- U
	 [39]  = {86, symbol_pixels_x, symbol_pixels_y}, -- V
	 [40]  = {87, symbol_pixels_x, symbol_pixels_y}, -- W
	 [41]  = {88, symbol_pixels_x, symbol_pixels_y}, -- X
	 [42]  = {89, symbol_pixels_x, symbol_pixels_y}, -- Y
	 [43]  = {90, symbol_pixels_x, symbol_pixels_y}, -- Z
	 [44]  = {91, symbol_pixels_x, symbol_pixels_y}, -- [
	 [45]  = {93, symbol_pixels_x, symbol_pixels_y}, -- ]
	 [46]  = {62, symbol_pixels_x, symbol_pixels_y}, -- >
	 [47]  = {111, symbol_pixels_x, symbol_pixels_y}, -- o
	 [48]  = {94 , symbol_pixels_x, symbol_pixels_y} -- ^
	}
}

fontdescription["RADIO_font"]  = {
	texture     = LockOn_Options.script_path.."Resources/IndicationTextures/font_GreenBoxRadio_M2KC.tga",
	size        = {7, 7},
	resolution  = {1024, 1024},
	default     = {symbol_pixels_x, symbol_pixels_y},
	chars	    = {
		 [1]   = {32, symbol_pixels_x, symbol_pixels_y}, -- [space]
		 [2]   = {42, symbol_pixels_x, symbol_pixels_y}, -- *
		 [3]   = {43, symbol_pixels_x, symbol_pixels_y}, -- +
		 [4]   = {45, symbol_pixels_x, symbol_pixels_y}, -- -
		 [5]   = {46, symbol_pixels_x, symbol_pixels_y}, -- .
		 [6]   = {47, symbol_pixels_x, symbol_pixels_y}, -- /
		 [7]   = {48, symbol_pixels_x, symbol_pixels_y}, -- 0
		 [8]   = {49, symbol_pixels_x, symbol_pixels_y}, -- 1
		 [9]   = {50, symbol_pixels_x, symbol_pixels_y}, -- 2
		 [10]  = {51, symbol_pixels_x, symbol_pixels_y}, -- 3
		 [11]  = {52, symbol_pixels_x, symbol_pixels_y}, -- 4
		 [12]  = {53, symbol_pixels_x, symbol_pixels_y}, -- 5
		 [13]  = {54, symbol_pixels_x, symbol_pixels_y}, -- 6
		 [14]  = {55, symbol_pixels_x, symbol_pixels_y}, -- 7
		 [15]  = {56, symbol_pixels_x, symbol_pixels_y}, -- 8
		 [16]  = {57, symbol_pixels_x, symbol_pixels_y}, -- 9
		 [17]  = {58, symbol_pixels_x, symbol_pixels_y}, -- :
		 [18]  = {65, symbol_pixels_x, symbol_pixels_y}, -- A
		 [19]  = {66, symbol_pixels_x, symbol_pixels_y}, -- B
		 [20]  = {67, symbol_pixels_x, symbol_pixels_y}, -- C
		 [21]  = {68, symbol_pixels_x, symbol_pixels_y}, -- D
		 [22]  = {69, symbol_pixels_x, symbol_pixels_y}, -- E
		 [23]  = {70, symbol_pixels_x, symbol_pixels_y}, -- F
		 [24]  = {71, symbol_pixels_x, symbol_pixels_y}, -- G
		 [25]  = {72, symbol_pixels_x, symbol_pixels_y}, -- H
		 [26]  = {73, symbol_pixels_x, symbol_pixels_y}, -- I
		 [27]  = {74, symbol_pixels_x, symbol_pixels_y}, -- J
		 [28]  = {75, symbol_pixels_x, symbol_pixels_y}, -- K
		 [29]  = {76, symbol_pixels_x, symbol_pixels_y}, -- L
		 [30]  = {77, symbol_pixels_x, symbol_pixels_y}, -- M
		 [31]  = {78, symbol_pixels_x, symbol_pixels_y}, -- N
		 [32]  = {79, symbol_pixels_x, symbol_pixels_y}, -- O
		 [33]  = {80, symbol_pixels_x, symbol_pixels_y}, -- P
		 [34]  = {81, symbol_pixels_x, symbol_pixels_y}, -- Q
		 [35]  = {82, symbol_pixels_x, symbol_pixels_y}, -- R
		 [36]  = {83, symbol_pixels_x, symbol_pixels_y}, -- S
		 [37]  = {84, symbol_pixels_x, symbol_pixels_y}, -- T
		 [38]  = {85, symbol_pixels_x, symbol_pixels_y}, -- U
		 [39]  = {86, symbol_pixels_x, symbol_pixels_y}, -- V
		 [40]  = {87, symbol_pixels_x, symbol_pixels_y}, -- W
		 [41]  = {88, symbol_pixels_x, symbol_pixels_y}, -- X
		 [42]  = {89, symbol_pixels_x, symbol_pixels_y}, -- Y
		 [43]  = {90, symbol_pixels_x, symbol_pixels_y}, -- Z
		 [44]  = {91, symbol_pixels_x, symbol_pixels_y}, -- [
		 [45]  = {93, symbol_pixels_x, symbol_pixels_y}, -- ]
		 [46]  = {62, symbol_pixels_x, symbol_pixels_y}, -- >
		 [47]  = {111, symbol_pixels_x, symbol_pixels_y}, -- o
		 [48]  = {94 , symbol_pixels_x, symbol_pixels_y}  -- ^
	}
}

fonts = {}
fonts["font_general_keys"]				= {fontdescription["font_general_loc"], 10, {255,75,75,255}}
fonts["font_hints_kneeboard"]			= {fontdescription["font_general_loc"], 10, {100,0,100,255}}

-- VTH
fonts["vth_indication_font_light"]  = {fontdescription["VTH_font_light"], 10, materials["VTH_GREEN"]} -- ADDED
fonts["vth_indication_font"]        = {fontdescription["VTH_font"],       10, materials["VTH_GREEN"]}

-- VTB
fonts["vtb_indication_font"]			= {fontdescription["VTB_font"], 10, materials["VTB_IND_COLOR"]}
fonts["vtb_stt_indication_font"]		= {fontdescription["VTB_font"], 10, materials["VTB_STT_COLOR"]}

-- PCA/PPA
fonts["pca_gauge_font"]				= {fontdescription["PCA_font"], 10, materials["GREENBOX_GREEN"]}
fonts["PPA_gauge_font"]				= {fontdescription["LCD_font"], 10, materials["GREENBOX_GREEN"]}

-- PCN
fonts["pcn_gauge_font"]				= {fontdescription["LCD_font"], 10, materials["GREENBOX_GREEN"]}
fonts["pcn_gauge_rfont"]			= {fontdescription["LCD_font"], 10, materials["LCD_RED"]}

-- SERVAL
fonts["rwr_indication_font"]		= {fontdescription["RWR_font"], 10, materials["RWR_GREEN"]} -- {fontdescription["VTH_font"], 10, materials["GREENBOX_GREEN"]}

-- RADIO
fonts["COM_gauge_font"]				= {fontdescription["LCD_font"], 10, materials["GREENBOX_GREEN"]}
fonts["COM_greenbox_font"]			= {fontdescription["RADIO_font"], 10, materials["GREENBOX_GREEN"]}
