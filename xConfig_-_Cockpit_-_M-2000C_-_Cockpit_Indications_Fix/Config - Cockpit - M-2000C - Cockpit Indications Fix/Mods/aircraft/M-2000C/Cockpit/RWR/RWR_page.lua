-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.4 (04/01/2020) for DCS World 2.5.6.45915 (03/31/2020)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."RWR/"
dofile(my_path.."RWR_definitions.lua")

local RWR_Center              = create_rwr_textured_box(742, 673, 789, 718)       -- ( 23, 221, 60, 258)
RWR_Center.name               = "RWR_Center"
RWR_Center.init_pos           = {0, 0, 0}
Add_RWR_Element(RWR_Center)

local	RWR_Center_POS 				  = create_rwr_textured_box(742, 673, 789, 718)       -- ( 23, 221, 60, 258)
RWR_Center_POS.name			      = "RWR_Center_POS"
RWR_Center_POS.init_pos		    = {0, 0, 0}
RWR_Center_POS.controllers	  = {{"RWR_Center_Pos", 0.125}}
Add_RWR_Element(RWR_Center_POS)

-- Self test
local RWR_BIT_TF_Pass         = create_rwr_textured_box( 742, 540, 791, 583)
RWR_BIT_TF_Pass.name          = "RWR_BIT_TF_Pass"
RWR_BIT_TF_Pass.init_pos      = {0.0, 50.0, 0.0}
RWR_BIT_TF_Pass.controllers   = {{"RWR_Test_TF_Pass"}}
Add_RWR_Element(RWR_BIT_TF_Pass)

local RWR_BIT_TF_Fail         = create_rwr_textured_box( 745, 589, 788, 633)
RWR_BIT_TF_Fail.name          = "RWR_BIT_TF_Fail"
RWR_BIT_TF_Fail.init_pos      = {0.0, 50.0, 0.0}
RWR_BIT_TF_Fail.controllers   = {{"RWR_Test_TF_Fail"}}
Add_RWR_Element(RWR_BIT_TF_Fail)

local RWR_BIT_TR_Pass         = create_rwr_textured_box( 742, 540, 791, 583)
RWR_BIT_TR_Pass.name          = "RWR_BIT_TR_Pass"
RWR_BIT_TR_Pass.init_pos      = {0.0, -50.0, 0.0}
RWR_BIT_TR_Pass.controllers   = {{"RWR_Test_TR_Pass"}}
Add_RWR_Element(RWR_BIT_TR_Pass)

local RWR_BIT_TR_Fail         = create_rwr_textured_box( 745, 589, 788, 633)
RWR_BIT_TR_Fail.name          = "RWR_BIT_TR_Fail"
RWR_BIT_TR_Fail.init_pos      = {0.0, -50.0, 0.0}
RWR_BIT_TR_Fail.controllers   = {{"RWR_Test_TR_Fail"}}
Add_RWR_Element(RWR_BIT_TR_Fail)

local RWR_BIT_LW_Pass         = create_rwr_textured_box( 742, 540, 791, 583)
RWR_BIT_LW_Pass.name          = "RWR_BIT_LW_Pass"
RWR_BIT_LW_Pass.init_pos      = {-50.0, 0.0, 0.0}
RWR_BIT_LW_Pass.controllers   = {{"RWR_Test_LW_Pass"}}
Add_RWR_Element(RWR_BIT_LW_Pass)

local RWR_BIT_LW_Fail         = create_rwr_textured_box( 745, 589, 788, 633)
RWR_BIT_LW_Fail.name          = "RWR_BIT_LW_Fail"
RWR_BIT_LW_Fail.init_pos      = {-50.0, 0.0, 0.0}
RWR_BIT_LW_Fail.controllers   = {{"RWR_Test_LW_Fail"}}
Add_RWR_Element(RWR_BIT_LW_Fail)

local RWR_BIT_RW_Pass         = create_rwr_textured_box( 742, 540, 791, 583)
RWR_BIT_RW_Pass.name          = "RWR_BIT_RW_Pass"
RWR_BIT_RW_Pass.init_pos      = {50.0, 0.0, 0.0}
RWR_BIT_RW_Pass.controllers   = {{"RWR_Test_RW_Pass"}}
Add_RWR_Element(RWR_BIT_RW_Pass)

local RWR_BIT_RW_Fail         = create_rwr_textured_box( 745, 589, 788, 633)
RWR_BIT_RW_Fail.name          = "RWR_BIT_RW_Fail"
RWR_BIT_RW_Fail.init_pos      = {50.0, 0.0, 0.0}
RWR_BIT_RW_Fail.controllers   = {{"RWR_Test_RW_Fail"}}
Add_RWR_Element(RWR_BIT_RW_Fail)

for i = 0, 15 do
	local text_RWR_Tr01				        = CreateElement "ceStringPoly"
	text_RWR_Tr01.name				        = "text_RWR_Tr" .. string.format("%02d", i)
	text_RWR_Tr01.material			      = rwr_indication_font
	text_RWR_Tr01.init_pos			      = {0.0, 0.0, 0.0}
	text_RWR_Tr01.alignment			      = "CenterCenter"
	text_RWR_Tr01.formats			        = {"%s"}
	text_RWR_Tr01.stringdefs		      = rwr_font_size_default
	text_RWR_Tr01.controllers 		    = {{"RWR_Code", i, 0.125}}
	Add_RWR_Element(text_RWR_Tr01)
	
	local text_RWR_Tr01A			        = create_rwr_textured_box(742, 391, 789, 421)       -- ( 742, 394, 790, 418)
	text_RWR_Tr01A.name				        = "text_RWR_Tr" .. string.format("%02d", i) .. "A"
	text_RWR_Tr01A.init_pos			      = {-0.5, 3.5, 0}                                    -- {0.0, 3.5, 0}
	text_RWR_Tr01A.parent_element	    = "text_RWR_Tr" .. string.format("%02d", i)
	text_RWR_Tr01A.controllers		    = {{"RWR_AIR", i}}
	Add_RWR_Element(text_RWR_Tr01A)
	
	local text_RWR_Tr01G			        = create_rwr_textured_box(742, 273, 790, 321)     -- (744, 275, 788, 319)
	text_RWR_Tr01G.name				        = "text_RWR_Tr" .. string.format("%02d", i) .. "G"
	text_RWR_Tr01G.init_pos			      = {-0.5, 0, 0}                                    -- {0, 0, 0}
	text_RWR_Tr01G.parent_element	    = "text_RWR_Tr" .. string.format("%02d", i)
	text_RWR_Tr01G.controllers		    = {{"RWR_GRD", i}}
	Add_RWR_Element(text_RWR_Tr01G)
	
	local text_RWR_Tr01M			        = create_rwr_textured_box( 736, 327, 796, 387)
	text_RWR_Tr01M.name				        = "text_RWR_Tr" .. string.format("%02d", i) .. "M"
	text_RWR_Tr01M.init_pos			      = {-0.5, 0, 0}                                    -- {0, 0, 0}
	text_RWR_Tr01M.parent_element	    = "text_RWR_Tr" .. string.format("%02d", i)
	text_RWR_Tr01M.controllers		    = {{"RWR_WPN", i}}
	Add_RWR_Element(text_RWR_Tr01M)
	
	local text_RWR_Tr01L			        = create_rwr_textured_box(736, 429, 800, 493)     -- ( 736, 429, 800, 494)
	text_RWR_Tr01L.name				        = "text_RWR_Tr" .. string.format("%02d", i) .. "L"
	text_RWR_Tr01L.init_pos			      = {-0.5, 0, 0}                                    -- {0, 0, 0}
	text_RWR_Tr01L.parent_element	    = "text_RWR_Tr" .. string.format("%02d", i)
	text_RWR_Tr01L.controllers		    = {{"RWR_LCKD", i}}
	Add_RWR_Element(text_RWR_Tr01L)
end

-- DDM 01
local DDM_Tr01_AZ         = create_rwr_textured_box(1016, 10, 1022, 170, nil, 170) -- (998, 10, 1002, 170, nil, 170)
DDM_Tr01_AZ.name          = "DDM_Tr01_AZ"
DDM_Tr01_AZ.init_pos      = {0, 0, 0}
DDM_Tr01_AZ.controllers   = {{"DDM_01_THREAT"}}
Add_RWR_Element(DDM_Tr01_AZ)

-- DDM 02
local DDM_Tr02_AZ         = create_rwr_textured_box(1016, 10, 1022, 170, nil, 170) -- (998, 10, 1002, 170, nil, 170)
DDM_Tr02_AZ.name          = "DDM_Tr02_AZ"
DDM_Tr02_AZ.init_pos      = {0, 0, 0}
DDM_Tr02_AZ.controllers   = {{"DDM_02_THREAT"}}
Add_RWR_Element(DDM_Tr02_AZ)

-- DDM 03
local DDM_Tr03_AZ         = create_rwr_textured_box(1016, 10, 1022, 170, nil, 170) -- (998, 10, 1002, 170, nil, 170)
DDM_Tr03_AZ.name          = "DDM_Tr03_AZ"
DDM_Tr03_AZ.init_pos      = {0, 0, 0}
DDM_Tr03_AZ.controllers   = {{"DDM_03_THREAT"}}
Add_RWR_Element(DDM_Tr03_AZ)

-- DDM 04
local DDM_Tr04_AZ         = create_rwr_textured_box(1016, 10, 1022, 170, nil, 170) -- (998, 10, 1002, 170, nil, 170)
DDM_Tr04_AZ.name          = "DDM_Tr04_AZ"
DDM_Tr04_AZ.init_pos      = {0, 0, 0}
DDM_Tr04_AZ.controllers   = {{"DDM_04_THREAT"}}
Add_RWR_Element(DDM_Tr04_AZ)

-- DDM 05
local DDM_Tr05_AZ         = create_rwr_textured_box(1016, 6, 1022, 170, nil, 170) -- (998, 10, 1002, 170, nil, 170)
DDM_Tr05_AZ.name          = "DDM_Tr05_AZ"
DDM_Tr05_AZ.init_pos      = {0, 0, 0}
DDM_Tr05_AZ.controllers   = {{"DDM_05_THREAT"}}
Add_RWR_Element(DDM_Tr05_AZ)

-- DDM 06
local DDM_Tr06_AZ         = create_rwr_textured_box(1016, 6, 1022, 170, nil, 170) -- (998, 10, 1002, 170, nil, 170)
DDM_Tr06_AZ.name          = "DDM_Tr06_AZ"
DDM_Tr06_AZ.init_pos      = {0, 0, 0}
DDM_Tr06_AZ.controllers   = {{"DDM_06_THREAT"}}
Add_RWR_Element(DDM_Tr06_AZ)

-- DDM 07
local DDM_Tr07_AZ         = create_rwr_textured_box(1016, 6, 1022, 170, nil, 170) -- (998, 10, 1002, 170, nil, 170)
DDM_Tr07_AZ.name          = "DDM_Tr07_AZ"
DDM_Tr07_AZ.init_pos      = {0, 0, 0}
DDM_Tr07_AZ.controllers   = {{"DDM_07_THREAT"}}
Add_RWR_Element(DDM_Tr07_AZ)

-- DDM 08
local DDM_Tr08_AZ         = create_rwr_textured_box(1016, 6, 1022, 170, nil, 170) -- (998, 10, 1002, 170, nil, 170)
DDM_Tr08_AZ.name          = "DDM_Tr08_AZ"
DDM_Tr08_AZ.init_pos      = {0, 0, 0}
DDM_Tr08_AZ.controllers   = {{"DDM_08_THREAT"}}
Add_RWR_Element(DDM_Tr08_AZ)

-- DDM 09
local DDM_Tr09_AZ         = create_rwr_textured_box(1016, 6, 1022, 170, nil, 170) -- (998, 10, 1002, 170, nil, 170)
DDM_Tr09_AZ.name          = "DDM_Tr09_AZ"
DDM_Tr09_AZ.init_pos      = {0, 0, 0}
DDM_Tr09_AZ.controllers   = {{"DDM_09_THREAT"}}
Add_RWR_Element(DDM_Tr09_AZ)

-- DDM 10
local DDM_Tr10_AZ         = create_rwr_textured_box(1016, 6, 1022, 170, nil, 170) -- (998, 10, 1002, 170, nil, 170)
DDM_Tr10_AZ.name          = "DDM_Tr10_AZ"
DDM_Tr10_AZ.init_pos      = {0, 0, 0}
DDM_Tr10_AZ.controllers   = {{"DDM_10_THREAT"}}
Add_RWR_Element(DDM_Tr10_AZ)
