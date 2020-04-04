________________________________________________________________________________

                    Cockpit Indications Fix by Sedenion
                      for DCS Mirage 2000C by RAZBAM

            v1.4 (04/01/2020) for DCS World 2.5.6.45915 (03/31/2020)
________________________________________________________________________________


DESCRIPTION
________________________________________________________________________________

Unofficial patch/mod for DCS Mirage 2000C by RAZBAM to fix and enhance the visual 
of cockpit main displays and indicators such as HUD, radar screen, RWR and liquid 
cristal displays for both a better fidelity to the real aircraft and a better 
visual experience.

All symbology elements size, position and proportion of elements with each 
others were carefully and patientely adjusted to better reflect the real ones 
according footages, photographies and best guess. If you noticed a mistake or 
if you have remarks, please contact me via the Eagle Dynamics DCS Forum : 

                https://forums.eagle.ru/member.php?u=56192

INSTALLATION
________________________________________________________________________________


* Using JSGME

  1. Extract the "M-2000C - Cockpit Indication Fix" folder into the proper 
     JSGME's _MOD folder.
     
  2. Run the proper JSGME instance then install the mod.


* Using OVGM

  1. Place the "M-2000C - Cockpit Indication Fix.zip" file into the proper 
     OVGME's Mods folder.
     
  2. Run OVGME, go to the proper configuration, then install the mod.


* Manual Install

  1. [Backup] - Go to your DCS World installation folder, then copy following 
     files and/or folders into a safe location:
     
      - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures
      - \Mods\aircraft\M-2000C\Cockpit\materials.lua
      - \Mods\aircraft\M-2000C\Cockpit\PCA_PPA
      - \Mods\aircraft\M-2000C\Cockpit\RWR
      - \Mods\aircraft\M-2000C\Cockpit\VTB
      - \Mods\aircraft\M-2000C\Cockpit\VTH

  2. [Install] - Open the "M-2000C - Cockpit Indication Fix.zip", go inside 
     the "M-2000C - Cockpit Indication Fix" folder within the zip structure then 
     extract its content into your DCS World installation folder overwriting 
     original files.



MODIFICATIONS DETAILS
________________________________________________________________________________


* HUD Symbology Rework

  - New HUD font, two separate textures for large and small text

  - Adjusted HUD font dot character width for correct font spacing

  - New "zoom-proof" HUD heading tape texture with corrected ratio

  - Fixed HUD heading tape mipmaping problem

  - New "zoom-proof" HUD symbology texture with harmonized style and tickness

  - HUD elements rationally aligned together according real data & best guess

  - Fixel HUD dynamic elements opacity and brighness control

  - HUD symbology color adjusted and default opacity fixed.


* VTB (radar screen) Symbology Rework

  - New VTB font texture

  - New "zoom-proof" VTB grid textures with correct alignment

  - Fixed VTB grid textures mipmaping problem

  - New "zoom-proof" VTB heading tape textures with corrected ratio

  - Fixed VTB heading tape mipmaping problem

  - New "zoom-proof" VTB symbology texture

  - VTB grid, font and symbology textures style harmonized with screen effect

  - VTB elements rationally aligned together according real data & best guess

  - VTB symbology color slightly adjusted


* RWR Symbology Rework

  - New dedicated RWR font texture

  - New RWR symbology texture

  - RWR font and symbology style harmonized with screen effect

  - RWR elements rationally aligned and adjusted for better readability

  - RWR symbology color adjusted


* Miscellaneous Cockpit Displays Rework

  - New PCA font texture closer to the real digital display

  - PCA digits position slightly corrected

  - PCA digits color slightly adjusted

  - New common digital cristal font texture




PACKAGE DETAILS
________________________________________________________________________________

Added files:
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_HUD_light_M2KC.tga
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_RWR_M2KC.tga
 
Modified files:
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_HUD_M2KC.tga
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_LCD_M2KC.tga
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_PCA_M2KC.tga
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_VTB_M2KC.tga
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\headingtape_hud_M2KC.tga
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\headingtape_vtb_M2KC.tga
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\indication_hud_M2KC.tga
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\indication_VTB_M2KC.tga
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Grid_0.tga
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Grid_1.tga
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Grid_2.tga
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Page_2.tga
 - \Mods\aircraft\M-2000C\Cockpit\materials.lua
 - \Mods\aircraft\M-2000C\Cockpit\PCA_PPA\PCA_definition.lua
 - \Mods\aircraft\M-2000C\Cockpit\PCA_PPA\PCA_BR.lua
 - \Mods\aircraft\M-2000C\Cockpit\PCA_PPA\PCA_UR.lua
 - \Mods\aircraft\M-2000C\Cockpit\RWR\RWR_definitions.lua
 - \Mods\aircraft\M-2000C\Cockpit\RWR\RWR_page.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTB\VTB_definitions.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTB\VTB_page_0.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTB\VTB_page_1.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTB\VTB_page_2.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTB\VTB_page_3.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_definitions.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_init.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_base.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_base.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_0.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_1.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_2.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_3.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_5.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_6.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_base_appr.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_appr.lua



Version History
________________________________________________________________________________

v1.4 (04/01/2020) for DCS World 2.5.6.45915 (03/31/2020)
 - Adaptation and update to fit the 2.5.6.45915 release.
 
v1.3 (03/28/2020) for DCS World 2.5.6.45317 (03/20/2020)
 - Fix HUD "vth_line_material" material not declared
 - Set HUD collimator factor back to default (0.6) to prevent misalignments
 - Adjust font size and heading tape angle/pixel ratio to fit collimator factor
 - Fix VTB PIC/PID indication
 - Fix VTB locked target NCTR indication

v1.2 (03/25/2020) for DCS World 2.5.6.45317 (03/20/2020)
 - Adaptation and update to fit the 2.5.6.45317 release.

v1.1 (12/10/2019) for DCS World 2.5.5.40647 (12/05/2019)
 - Fixed HUD and VTB heading tape texture for correct true north aligment

v1.0 (11/15/2019) for DCS World 2.5.5.39384 (11/13/2019)
 - First public release
