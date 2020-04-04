dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_materials.lua")

opacity_sensitive_materials = 
{
	MDG_font_name(MDG_SELF_IDS.HI),
	MDG_material_name(MDG_SELF_IDS.HI),
	"MPD_DMC_OUTLINE",
	"font_MPD_DMC_outline",
	"font_MPD_DMC_main",
}

-- Parameters handling functions
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/InitParams.lua")

indicator_type = indicator_types.COMMON

-- for test purposes  HUD only added
purposes	   = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}
shaderLineParamsUpdatable  = true
shaderLineDefaultThickness = 0.4
shaderLineDefaultFuzziness = 0.2
shaderLineDrawAsWire 	   = false
shaderLineUseSpecularPass  = true

-- Parameters to customize common symbology properties
writeParameter("MDG_init_specifics", LockOn_Options.script_path.."Multipurpose_Display_Group/AMPCD/indicator/AMPCD_specifics.lua")
writeParameter("MDG_init_DEFAULT_LEVEL", 8)

-- page specific for the indicator, implements indicator border/FOV
BasePage              = LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_base.lua"
-- Cautions/Advisories and MENU label
IndicatorSpecificPage = LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/CautAdvAndMenuPage.lua"
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_AdvisoriesDefs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Common_init.lua")



-- for test purposes  HUD only added
--ViewportHandling
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
----------------------------------------------------------------------
local w = LockOn_Options.screen.width;
local h = LockOn_Options.screen.height;
	
if LockOn_Options.screen.oculus_rift then 
	local ui_x,ui_y,ui_w,ui_h = get_UIMainView()
	w = ui_w;
	h = ui_h;
end	
	
local size  = 0.5 * h
if size > h then
   size = h
end
if size > 0.5 * w then
   size = 0.5 * w
end
	
dedicated_viewport 		  = {0.5 * w - 0.5 * size,h - size,size,size}
dedicated_viewport_arcade =  dedicated_viewport
----------------------------------------------------------------------
try_find_assigned_viewport("CENTER_MFCD")