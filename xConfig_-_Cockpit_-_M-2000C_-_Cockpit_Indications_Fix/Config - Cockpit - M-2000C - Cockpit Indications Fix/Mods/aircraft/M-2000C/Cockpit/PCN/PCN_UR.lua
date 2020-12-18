-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 1.82 (10/05/2020) for DCS World 2.5.6.55743 (09/30/2020)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."PCN/"
dofile(my_path.."PCN_definitions.lua")

-- ** LEFT LCD ** --
local	text_PCN_NORD					      = CreateElement "ceStringPoly"
		text_PCN_NORD.name				    = "text_PCN_NORD"
		text_PCN_NORD.material			  = pcn_gauge_font
		text_PCN_NORD.init_pos			  = {-1.0, 0.06,0}                          -- {-1.0, 0.06,0}
		text_PCN_NORD.alignment			  = "LeftCenter"
		text_PCN_NORD.value				    = "N"
		text_PCN_NORD.stringdefs		  = {0.004,0.004}
		text_PCN_NORD.controllers 		= {{"PCN_ULN_WINDOW"}}
Add_PCN_Element(text_PCN_NORD)

local	text_PCN_SUD					      = CreateElement "ceStringPoly"
		text_PCN_SUD.name				      = "text_PCN_SUD"
		text_PCN_SUD.material			    = pcn_gauge_font
		text_PCN_SUD.init_pos			    = {-1.0, -0.04,0}                         -- {-1.0, -0.04,0}
		text_PCN_SUD.alignment			  = "LeftCenter"
		text_PCN_SUD.value				    = "S"
		text_PCN_SUD.stringdefs			  = {0.004,0.004}
		text_PCN_SUD.controllers 		  = {{"PCN_ULS_WINDOW"}}
Add_PCN_Element(text_PCN_SUD)

local	text_PCN_PLUS_L					    = CreateElement "ceStringPoly"
		text_PCN_PLUS_L.name			    = "text_PCN_PLUS_L"
		text_PCN_PLUS_L.material		  = pcn_gauge_font
		text_PCN_PLUS_L.init_pos		  = {-0.95, 0.05,0}                         -- {-0.92, 0.04,0}
		text_PCN_PLUS_L.alignment		  = "LeftCenter"
		text_PCN_PLUS_L.value			    = "+"
		text_PCN_PLUS_L.stringdefs		= {0.006,0.006}                           -- {0.005,0.005}
		text_PCN_PLUS_L.controllers 	= {{"PCN_ULP_WINDOW"}}
Add_PCN_Element(text_PCN_PLUS_L)

local	text_PCN_MOINS_L				    = CreateElement "ceStringPoly"
		text_PCN_MOINS_L.name			    = "text_PCN_MOINS_L"
		text_PCN_MOINS_L.material		  = pcn_gauge_font
		text_PCN_MOINS_L.init_pos		  = {-0.95, -0.04,0}                        -- {-0.92, -0.04,0}
		text_PCN_MOINS_L.alignment		= "LeftCenter"
		text_PCN_MOINS_L.value			  = "-"
		text_PCN_MOINS_L.stringdefs		= {0.006,0.006}                           -- {0.005,0.005}
		text_PCN_MOINS_L.controllers 	= {{"PCN_ULM_WINDOW"}}
Add_PCN_Element(text_PCN_MOINS_L)

-- ** DATA ** --
-- TR/VS
local	text_PCN_L_TR				        = CreateElement "ceStringPoly"
		text_PCN_L_TR.name			      = "text_PCN_L_TR"
		text_PCN_L_TR.material		    = pcn_gauge_font
		text_PCN_L_TR.init_pos		    = {-0.13,0.005,0.0}
		text_PCN_L_TR.alignment		    = "RightCenter"
		text_PCN_L_TR.formats		      = {"%d.%02d"}
		text_PCN_L_TR.stringdefs	    = pcn_font_size_default
		text_PCN_L_TR.controllers 	  = {{"PCN_UL_TR"}}
Add_PCN_Element(text_PCN_L_TR)

-- D/RLT + Rho/Theta
local	text_PCN_L_DR				        = CreateElement "ceStringPoly"
		text_PCN_L_DR.name			      = "text_PCN_L_DR"
		text_PCN_L_DR.material		    = pcn_gauge_font
		text_PCN_L_DR.init_pos		    = {-0.13,0.005,0.0}
		text_PCN_L_DR.alignment		    = "RightCenter"
		text_PCN_L_DR.formats		      = {"%03.2f"}
		text_PCN_L_DR.stringdefs	    = pcn_font_size_default
		text_PCN_L_DR.controllers	    = {{"PCN_UL_DS_RHO"}}
Add_PCN_Element(text_PCN_L_DR)

-- CP/PD + RD/TD + DV/FV + DEC
local	text_PCN_L_DEG				      = CreateElement "ceStringPoly"
		text_PCN_L_DEG.name			      = "text_PCN_L_DEG"
		text_PCN_L_DEG.material		    = pcn_gauge_font
		text_PCN_L_DEG.init_pos		    = {-0.13,0.005,0.0}
		text_PCN_L_DEG.alignment	    = "RightCenter"
		text_PCN_L_DEG.formats		    = {"%03.1f"}
		text_PCN_L_DEG.stringdefs	    = pcn_font_size_default
		text_PCN_L_DEG.controllers 	  = {{"PCN_UL_CP_RD_DV_DEC"}}
Add_PCN_Element(text_PCN_L_DEG)

-- ALT + DALT
local	text_PCN_L_INT				      = CreateElement "ceStringPoly"
		text_PCN_L_INT.name			      = "text_PCN_L_INT"
		text_PCN_L_INT.material		    = pcn_gauge_font
		text_PCN_L_INT.init_pos		    = {-0.13,0.005,0.0}
		text_PCN_L_INT.alignment	    = "RightCenter"
		text_PCN_L_INT.formats		    = {"%d"}
		text_PCN_L_INT.stringdefs	    = pcn_font_size_default
		text_PCN_L_INT.controllers 	  = {{"PCN_UL_AL_DA"}}
Add_PCN_Element(text_PCN_L_INT)

-- DL/DG
local	text_PCN_L_DLB				      = CreateElement "ceStringPoly"
		text_PCN_L_DLB.name			      = "text_PCN_L_DLB"
		text_PCN_L_DLB.material		    = pcn_gauge_font
		text_PCN_L_DLB.init_pos		    = {-0.13,0.005,0.0}
		text_PCN_L_DLB.alignment	    = "RightCenter"
		text_PCN_L_DLB.formats		    = {"%1.3f"}
		text_PCN_L_DLB.stringdefs	    = pcn_font_size_default
		text_PCN_L_DLB.controllers 	  = {{"PCN_UL_DL"}}
Add_PCN_Element(text_PCN_L_DLB)

-- L/G LEFT
local	text_PCN_L_LG					      = CreateElement "ceStringPoly"
		text_PCN_L_LG.name				    = "text_PCN_L_LG"
		text_PCN_L_LG.material			  = pcn_gauge_font
		text_PCN_L_LG.init_pos			  = {-0.13,0.005,0.0}
		text_PCN_L_LG.alignment			  = "RightCenter"
		text_PCN_L_LG.formats			    = {"%02d%02d%02d"}
		text_PCN_L_LG.stringdefs		  = pcn_font_size_default
		text_PCN_L_LG.controllers		  = {{"PCN_UL_LA"}}
Add_PCN_Element(text_PCN_L_LG)

local	text_PCN_L_Dots					    = CreateElement "ceStringPoly"
		text_PCN_L_Dots.name			    = "text_PCN_L_Dots"
		text_PCN_L_Dots.material		  = pcn_gauge_font
		text_PCN_L_Dots.init_pos		  = {-0.065,0.005,0.0}
		text_PCN_L_Dots.alignment		  = "RightCenter"
		text_PCN_L_Dots.formats			  = {"        . .  "}
		text_PCN_L_Dots.stringdefs		= pcn_font_size_default
		text_PCN_L_Dots.controllers		= {{"PCN_UL_LA"}}
Add_PCN_Element(text_PCN_L_Dots)

-- NO DATA
local	text_PCN_L_NODATA				    = CreateElement "ceStringPoly"
		text_PCN_L_NODATA.name			  = "text_PCN_L_NODATA"
		text_PCN_L_NODATA.material		= pcn_gauge_font
		text_PCN_L_NODATA.init_pos		= {-0.13,0.005,0.0}
		text_PCN_L_NODATA.alignment		= "RightCenter"
		text_PCN_L_NODATA.value			  = "--"
		text_PCN_L_NODATA.stringdefs	= pcn_font_size_default
		text_PCN_L_NODATA.controllers	= {{"PCN_UL_NODATA"}}
Add_PCN_Element(text_PCN_L_NODATA)

-- DATA ENTRY
local	text_PCN_LDE					      = CreateElement "ceStringPoly"
		text_PCN_LDE.name				      = "text_PCN_LDE"
		text_PCN_LDE.material			    = pcn_gauge_font
		text_PCN_LDE.init_pos			    = {-0.13,0.005,0.0}
		text_PCN_LDE.alignment			  = "RightCenter"
		text_PCN_LDE.formats			    = {"%s"}
		text_PCN_LDE.stringdefs			  = pcn_font_size_default
		text_PCN_LDE.controllers 		  = {{"PCN_UL_EDIT"}}
Add_PCN_Element(text_PCN_LDE)

local	text_PCN_LDE_Dots				    = CreateElement "ceStringPoly"
		text_PCN_LDE_Dots.name			  = "text_PCN_LDE_Dots"
		text_PCN_LDE_Dots.material		= pcn_gauge_font
		text_PCN_LDE_Dots.init_pos		= {-0.065,0.005,0.0}
		text_PCN_LDE_Dots.alignment		= "RightCenter"
		text_PCN_LDE_Dots.value			  = "        . .  "
		text_PCN_LDE_Dots.stringdefs	= pcn_font_size_default
		text_PCN_LDE_Dots.controllers	= {{"PCN_UL_EDIT_LL"}}
Add_PCN_Element(text_PCN_LDE_Dots)

-- TEXT MESSAGES
local	text_PCN_MSG					      = CreateElement "ceStringPoly"
		text_PCN_MSG.name				      = "text_PCN_MSG"
		text_PCN_MSG.material			    = pcn_gauge_font
		text_PCN_MSG.init_pos			    = {-0.13,0.005,0.0}
		text_PCN_MSG.alignment			  = "RightCenter"
		text_PCN_MSG.formats			    = {"%s"}
		text_PCN_MSG.stringdefs			  = pcn_font_size_default
		text_PCN_MSG.controllers 		  = {{"PCN_UL_MSG"}}
Add_PCN_Element(text_PCN_MSG)

-- ALIGNMENT
local	text_PCN_L_ACLASS				    = CreateElement "ceStringPoly"
		text_PCN_L_ACLASS.name			  = "text_PCN_L_ACLASS"
		text_PCN_L_ACLASS.material		= pcn_gauge_font
		text_PCN_L_ACLASS.init_pos		= {-0.7,0,0}
		text_PCN_L_ACLASS.alignment		= "RightCenter"
		text_PCN_L_ACLASS.formats		  = {"%d"}
		text_PCN_L_ACLASS.stringdefs	= pcn_font_size_default
		text_PCN_L_ACLASS.controllers = {{"PCN_UL_ALG_CLASS"}}
Add_PCN_Element(text_PCN_L_ACLASS)

local	text_PCN_L_ACTMR				    = CreateElement "ceStringPoly"
		text_PCN_L_ACTMR.name			    = "text_PCN_L_ACTMR"
		text_PCN_L_ACTMR.material		  = pcn_gauge_font
		text_PCN_L_ACTMR.init_pos		  = {-0.13,0.005,0.0}
		text_PCN_L_ACTMR.alignment		= "RightCenter"
		text_PCN_L_ACTMR.formats		  = {"%03d"}
		text_PCN_L_ACTMR.stringdefs		= pcn_font_size_default
		text_PCN_L_ACTMR.controllers 	= {{"PCN_UL_ALG_TIMER"}}
Add_PCN_Element(text_PCN_L_ACTMR)

-- POSITION UPDATE
local	text_PCN_L_POS_UPDATE_1				= CreateElement "ceStringPoly"
		text_PCN_L_POS_UPDATE_1.name		= "text_PCN_L_POS_UPDATE_1"
		text_PCN_L_POS_UPDATE_1.material	= pcn_gauge_font
		text_PCN_L_POS_UPDATE_1.init_pos	= {-0.13,0.005,0.0}
		text_PCN_L_POS_UPDATE_1.alignment	= "RightCenter"
		text_PCN_L_POS_UPDATE_1.formats		= {"%02d.%03d"}
		text_PCN_L_POS_UPDATE_1.stringdefs	= pcn_font_size_default
		text_PCN_L_POS_UPDATE_1.controllers = {{"PCN_UL_POS_UDATE_1"}}
Add_PCN_Element(text_PCN_L_POS_UPDATE_1)

local	text_PCN_L_POS_UPDATE_2				= CreateElement "ceStringPoly"
		text_PCN_L_POS_UPDATE_2.name		= "text_PCN_L_POS_UPDATE_2"
		text_PCN_L_POS_UPDATE_2.material	= pcn_gauge_font
		text_PCN_L_POS_UPDATE_2.init_pos	= {-0.13,0.005,0.0}
		text_PCN_L_POS_UPDATE_2.alignment	= "RightCenter"
		text_PCN_L_POS_UPDATE_2.formats		= {"%02d.%03d"}
		text_PCN_L_POS_UPDATE_2.stringdefs	= pcn_font_size_default
		text_PCN_L_POS_UPDATE_2.controllers = {{"PCN_UL_POS_UDATE_2"}}
Add_PCN_Element(text_PCN_L_POS_UPDATE_2)

-- POSITION MARK LEFT
local	text_PCN_L_MRQ_LAT				  = CreateElement "ceStringPoly"
		text_PCN_L_MRQ_LAT.name			  = "text_PCN_L_MRQ_LAT"
		text_PCN_L_MRQ_LAT.material		= pcn_gauge_font
		text_PCN_L_MRQ_LAT.init_pos		= {-0.13,0.005,0.0}
		text_PCN_L_MRQ_LAT.alignment	= "RightCenter"
		text_PCN_L_MRQ_LAT.formats		= {"%02d%02d%02d"}
		text_PCN_L_MRQ_LAT.stringdefs	= pcn_font_size_default
		text_PCN_L_MRQ_LAT.controllers	= {{"PCN_UL_MARK_LAT"}}
Add_PCN_Element(text_PCN_L_MRQ_LAT)

-- POSITION MARK LEFT PERIOD
local	text_PCN_L_MRQ_LAT				  = CreateElement "ceStringPoly"
		text_PCN_L_MRQ_LAT.name			  = "text_PCN_L_MRQ_LAT"
		text_PCN_L_MRQ_LAT.material		= pcn_gauge_font
		text_PCN_L_MRQ_LAT.init_pos		= {-0.065,0.005,0.0}
		text_PCN_L_MRQ_LAT.alignment	= "RightCenter"
		text_PCN_L_MRQ_LAT.formats		= {"        . .  "}
		text_PCN_L_MRQ_LAT.stringdefs	= pcn_font_size_default
		text_PCN_L_MRQ_LAT.controllers	= {{"PCN_UL_MARK_LAT"}}
Add_PCN_Element(text_PCN_L_MRQ_LAT)

-- ** RIGHT LCD ** --
local	text_PCN_EST					      = CreateElement "ceStringPoly"
		text_PCN_EST.name				      = "text_PCN_EST"
		text_PCN_EST.material			    = pcn_gauge_font
		text_PCN_EST.init_pos			    = {-0.05, 0.06,0}
		text_PCN_EST.alignment			  = "LeftCenter"
		text_PCN_EST.value				    = "E"
		text_PCN_EST.stringdefs			  = {0.004,0.004}                           -- {0.005,0.005}
		text_PCN_EST.controllers 		  = {{"PCN_URE_WINDOW"}}
Add_PCN_Element(text_PCN_EST)

local	text_PCN_OUEST					    = CreateElement "ceStringPoly"
		text_PCN_OUEST.name				    = "text_PCN_OUEST"
		text_PCN_OUEST.material			  = pcn_gauge_font
		text_PCN_OUEST.init_pos			  = {-0.05, -0.04,0}
		text_PCN_OUEST.alignment		  = "LeftCenter"
		text_PCN_OUEST.value			    = "W"
		text_PCN_OUEST.stringdefs		  = {0.004,0.004}                           -- {0.005,0.005}
		text_PCN_OUEST.controllers 		= {{"PCN_URW_WINDOW"}}
Add_PCN_Element(text_PCN_OUEST)

local	text_PCN_PLUS_R					    = CreateElement "ceStringPoly"
		text_PCN_PLUS_R.name			    = "text_PCN_PLUS_R"
		text_PCN_PLUS_R.material		  = pcn_gauge_font
		text_PCN_PLUS_R.init_pos		  = {0.0, 0.05,0}
		text_PCN_PLUS_R.alignment		  = "LeftCenter"
		text_PCN_PLUS_R.value			    = "+"
		text_PCN_PLUS_R.stringdefs		= {0.006,0.006}                           -- {0.005,0.005}
		text_PCN_PLUS_R.controllers 	= {{"PCN_URP_WINDOW"}}
Add_PCN_Element(text_PCN_PLUS_R)

local	text_PCN_MOINS_R				    = CreateElement "ceStringPoly"
		text_PCN_MOINS_R.name			    = "text_PCN_MOINS_R"
		text_PCN_MOINS_R.material		  = pcn_gauge_font
		text_PCN_MOINS_R.init_pos		  = {0.0, -0.04,0}
		text_PCN_MOINS_R.alignment		= "LeftCenter"
		text_PCN_MOINS_R.value			  = "-"
		text_PCN_MOINS_R.stringdefs		= {0.006,0.006}                           -- {0.005,0.005}
		text_PCN_MOINS_R.controllers 	= {{"PCN_URM_WINDOW"}}
Add_PCN_Element(text_PCN_MOINS_R)

-- ** DATA ** --
-- TR/VS + ALT + DALT + DV/FV
local	text_PCN_R_INT					    = CreateElement "ceStringPoly"
		text_PCN_R_INT.name				    = "text_PCN_R_INT"
		text_PCN_R_INT.material			  = pcn_gauge_font
		text_PCN_R_INT.init_pos			  = {0.94,0.005,0}
		text_PCN_R_INT.alignment		  = "RightCenter"
		text_PCN_R_INT.formats			  = {"%d"}
		text_PCN_R_INT.stringdefs		  = pcn_font_size_default
		text_PCN_R_INT.controllers		= {{"PCN_UR_VS_AL_DA_FV"}}
Add_PCN_Element(text_PCN_R_INT)

-- TR/VS + DL/DG
local	text_PCN_R_DBL					    = CreateElement "ceStringPoly"
		text_PCN_R_DBL.name				    = "text_PCN_R_DBL"
		text_PCN_R_DBL.material			  = pcn_gauge_font
		text_PCN_R_DBL.init_pos			  = {0.94,0.005,0}
		text_PCN_R_DBL.alignment		  = "RightCenter"
		text_PCN_R_DBL.formats			  = {"%1.3f"}
		text_PCN_R_DBL.stringdefs		  = pcn_font_size_default
		text_PCN_R_DBL.controllers		= {{"PCN_UR_DG"}}
Add_PCN_Element(text_PCN_R_DBL)

-- D/RLT + CP/PD + Rho/Theta
local	text_PCN_R_DEG					    = CreateElement "ceStringPoly"
		text_PCN_R_DEG.name				    = "text_PCN_R_DEG"
		text_PCN_R_DEG.material			  = pcn_gauge_font
		text_PCN_R_DEG.init_pos			  = {0.94,0.005,0}
		text_PCN_R_DEG.alignment		  = "RightCenter"
		text_PCN_R_DEG.formats			  = {"%03.1f"}
		text_PCN_R_DEG.stringdefs		  = pcn_font_size_default
		text_PCN_R_DEG.controllers		= {{"PCN_UR_RL_PD_TH"}}
Add_PCN_Element(text_PCN_R_DEG)

-- L/G RIGHT
local	text_PCN_R_LG					      = CreateElement "ceStringPoly"
		text_PCN_R_LG.name				    = "text_PCN_R_LG"
		text_PCN_R_LG.material			  = pcn_gauge_font
		text_PCN_R_LG.init_pos			  = {0.94,0.005,0}
		text_PCN_R_LG.alignment			  = "RightCenter"
		text_PCN_R_LG.formats			    = {"%03d%02d%02d"}
		text_PCN_R_LG.stringdefs		  = pcn_font_size_default
		text_PCN_R_LG.controllers		  = {{"PCN_UR_LO"}}
Add_PCN_Element(text_PCN_R_LG)

local	text_PCN_R_Dots					    = CreateElement "ceStringPoly"
		text_PCN_R_Dots.name			    = "text_PCN_R_Dots"
		text_PCN_R_Dots.material		  = pcn_gauge_font
		text_PCN_R_Dots.init_pos		  = {1.0,0.005,0.0}
		text_PCN_R_Dots.alignment		  = "RightCenter"
		text_PCN_R_Dots.value			    = "         . .  "
		text_PCN_R_Dots.stringdefs		= pcn_font_size_default
		text_PCN_R_Dots.controllers		= {{"PCN_UR_LO"}}
Add_PCN_Element(text_PCN_R_Dots)

-- RD/TD
local	text_PCN_R_TD					      = CreateElement "ceStringPoly"
		text_PCN_R_TD.name				    = "text_PCN_R_TD"
		text_PCN_R_TD.material			  = pcn_gauge_font
		text_PCN_R_TD.init_pos			  = {0.94,0.005,0}
		text_PCN_R_TD.alignment			  = "RightCenter"
		text_PCN_R_TD.formats			    = {"%03d%02d"}
		text_PCN_R_TD.stringdefs		  = pcn_font_size_default
		text_PCN_R_TD.controllers		  = {{"PCN_UR_TD"}}
Add_PCN_Element(text_PCN_R_TD)

-- NO DATA
local	text_PCN_R_NODATA				    = CreateElement "ceStringPoly"
		text_PCN_R_NODATA.name			  = "text_PCN_R_NODATA"
		text_PCN_R_NODATA.material		= pcn_gauge_font
		text_PCN_R_NODATA.init_pos		= {0.94,0.005,0}
		text_PCN_R_NODATA.alignment		= "RightCenter"
		text_PCN_R_NODATA.value			  = "--"
		text_PCN_R_NODATA.stringdefs	= pcn_font_size_default
		text_PCN_R_NODATA.controllers	= {{"PCN_UR_NODATA"}}
Add_PCN_Element(text_PCN_R_NODATA)

-- DATA ENTRY
local	text_PCN_RDE					      = CreateElement "ceStringPoly"
		text_PCN_RDE.name				      = "text_PCN_RDE"
		text_PCN_RDE.material			    = pcn_gauge_font
		text_PCN_RDE.init_pos			    = {0.94,0.005,0}
		text_PCN_RDE.alignment			  = "RightCenter"
		text_PCN_RDE.formats			    = {"%s"}
		text_PCN_RDE.stringdefs			  = pcn_font_size_default
		text_PCN_RDE.controllers 		  = {{"PCN_UR_EDIT"}}
Add_PCN_Element(text_PCN_RDE)

local	text_PCN_RDE_Dots				      = CreateElement "ceStringPoly"
		text_PCN_RDE_Dots.name			    = "text_PCN_RDE_Dots"
		text_PCN_RDE_Dots.material		  = pcn_gauge_font
		text_PCN_RDE_Dots.init_pos		  = {1.0,0.005,0.0}
		text_PCN_RDE_Dots.alignment		  = "RightCenter"
		text_PCN_RDE_Dots.value			    = "         . .  "
		text_PCN_RDE_Dots.stringdefs	  = pcn_font_size_default
		text_PCN_RDE_Dots.controllers	  = {{"PCN_UR_EDIT_LL"}}
Add_PCN_Element(text_PCN_RDE_Dots)


-- ALIGNMENT
local	text_PCN_R_ASTS					      = CreateElement "ceStringPoly"
		text_PCN_R_ASTS.name			      = "text_PCN_R_ASTS"
		text_PCN_R_ASTS.material		    = pcn_gauge_font
		text_PCN_R_ASTS.init_pos		    = {0.94,0.005,0}
		text_PCN_R_ASTS.alignment		    = "RightCenter"
		text_PCN_R_ASTS.formats			    = {"%03d"}
		text_PCN_R_ASTS.stringdefs		  = pcn_font_size_default
		text_PCN_R_ASTS.controllers		  = {{"PCN_UR_ALG_PRCNT"}}
Add_PCN_Element(text_PCN_R_ASTS)

-- POSITION UPDATE
local	text_PCN_R_POS_UPDATE_1				= CreateElement "ceStringPoly"
		text_PCN_R_POS_UPDATE_1.name		= "text_PCN_R_POS_UPDATE_1"
		text_PCN_R_POS_UPDATE_1.material	= pcn_gauge_font
		text_PCN_R_POS_UPDATE_1.init_pos	= {0.94,0.005,0}
		text_PCN_R_POS_UPDATE_1.alignment	= "RightCenter"
		text_PCN_R_POS_UPDATE_1.formats		= {"%02d.%03d"}
		text_PCN_R_POS_UPDATE_1.stringdefs	= pcn_font_size_default
		text_PCN_R_POS_UPDATE_1.controllers	= {{"PCN_UR_POS_UDATE_1"}}
Add_PCN_Element(text_PCN_R_POS_UPDATE_1)

local	text_PCN_R_POS_UPDATE_2				= CreateElement "ceStringPoly"
		text_PCN_R_POS_UPDATE_2.name		= "text_PCN_R_POS_UPDATE_2"
		text_PCN_R_POS_UPDATE_2.material	= pcn_gauge_font
		text_PCN_R_POS_UPDATE_2.init_pos	= {0.94,0.005,0}
		text_PCN_R_POS_UPDATE_2.alignment	= "RightCenter"
		text_PCN_R_POS_UPDATE_2.formats		= {"%03.1f"}
		text_PCN_R_POS_UPDATE_2.stringdefs	= pcn_font_size_default
		text_PCN_R_POS_UPDATE_2.controllers	= {{"PCN_UR_POS_UDATE_2"}}
Add_PCN_Element(text_PCN_R_POS_UPDATE_2)

-- POSITION MARK RIGHT 
local	text_PCN_R_MRQ_LON				    = CreateElement "ceStringPoly"
		text_PCN_R_MRQ_LON.name			    = "text_PCN_R_MRQ_LON"
		text_PCN_R_MRQ_LON.material		  = pcn_gauge_font
		text_PCN_R_MRQ_LON.init_pos		  = {0.94,0.005,0}
		text_PCN_R_MRQ_LON.alignment	  = "RightCenter"
		text_PCN_R_MRQ_LON.formats		  = {"%03d%02d%02d"}
		text_PCN_R_MRQ_LON.stringdefs	  = pcn_font_size_default
		text_PCN_R_MRQ_LON.controllers	= {{"PCN_UR_MARK_LON"}}
Add_PCN_Element(text_PCN_R_MRQ_LON)

-- POSITION MARK RIGHT PERIOD
local	text_PCN_R_MRQ_Dots				    = CreateElement "ceStringPoly"
		text_PCN_R_MRQ_Dots.name		    = "text_PCN_R_MRQ_Dots"
		text_PCN_R_MRQ_Dots.material	  = pcn_gauge_font
		text_PCN_R_MRQ_Dots.init_pos	  = {1.0,0.005,0.0}
		text_PCN_R_MRQ_Dots.alignment	  = "RightCenter"
		text_PCN_R_MRQ_Dots.formats		  = {"         . .  "}
		text_PCN_R_MRQ_Dots.stringdefs	= pcn_font_size_default
		text_PCN_R_MRQ_Dots.controllers	= {{"PCN_UR_MARK_LON"}}
Add_PCN_Element(text_PCN_R_MRQ_Dots)
