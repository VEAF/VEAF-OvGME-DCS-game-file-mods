-- -----------------------------------------------------------------------------
-- This file is a non official modified version and part of the Cockpit 
-- Indications Fix by Sedenion for DCS Mirage 2000C by RAZBAM.
--
-- Mod target   : DCS Mirage 2000C by RAZBAM
-- Mod version  : 2.4 (2021-02-04) for DCS World 2.5.6.60966 (2021-02-03)
-- -----------------------------------------------------------------------------
local my_path = LockOn_Options.script_path.."VTB/"

dofile(my_path.."VTB_definitions.lua")

--local half_width   = GetHalfWidth()
--local half_height  = GetHalfHeight()
local half_width    = GetScale()
local half_height   = GetAspect() * half_width

local aspect        = GetAspect() -- GetHalfHeight()/GetHalfWidth()

vtb_base            = CreateElement "ceMeshPoly" -- untextured shape
vtb_base.name       = "VTB"
vtb_base.material   = MakeMaterial(nil,{255,0,0,50})
vtb_base.h_clip_relation  = h_clip_relations.REWRITE_LEVEL  -- check clipping : pixel on glass then increase level from GLASS_LEVEL to GLASS_LEVEL+1 = HUD_DEFAULT_LEVEL
vtb_base.level      = VTB_DEFAULT_LEVEL
vtb_base.collimated = false
vtb_base.isvisible  = false
vtb_base.z_enable   = false
vtb_base.vertices   = { {-1, aspect}, {1, aspect}, {1, -aspect}, {-1, -aspect}, }
vtb_base.indices    =  {0,1,2 ;  -- first triangle
                        0,2,3 }  -- second
Add(vtb_base)
