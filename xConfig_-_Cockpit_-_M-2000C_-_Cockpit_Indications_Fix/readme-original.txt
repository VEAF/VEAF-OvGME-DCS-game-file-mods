________________________________________________________________________________

                    Cockpit Indications Fix by Sedenion
                      for DCS Mirage 2000C by RAZBAM

           v2.2 (2020-12-19) for DCS World 2.5.6.59398 (2020-12-17)
________________________________________________________________________________


DESCRIPTION
________________________________________________________________________________

Unofficial patch/mod for DCS Mirage 2000C by RAZBAM to fix and enhance the visual 
of cockpit main displays and indicators such as HUD, radar screen, RWR and liquid 
cristal displays for both a better fidelity to the real aircraft and a better 
visual experience.

All symbologies and fonts texture are fully redone from scratch using 
pixel-aligned vector graphic and converted in DDS format for a better alpha 
mipmapping and optimization.

symbology elements size, position and proportion of elements with each 
others were carefully and patientely adjusted to better reflect the real ones 
according footages, photographies and best guess. If you noticed a mistake or 
if you have remarks, please contact me via the Eagle Dynamics DCS Forum : 

                https://forums.eagle.ru/member.php?u=56192

INSTALLATION
________________________________________________________________________________


* Using JSGME

  1. Extract the "M-2000C_-_Cockpit_Indication_Fix_v#.#" folder into the proper 
     JSGME's _MOD folder.
     
  2. Run the proper JSGME instance then install the mod.


* Using OVGM

  1. Place the "M-2000C_-_Cockpit_Indication_Fix_v#.#.zip" file into the proper 
     OVGME's Mods folder.
     
  2. Run OVGME, go to the proper configuration, then install the mod.


* Using Open Mod Manager

  1. Place the "M-2000C_-_Cockpit_Indication_Fix_v#.#.zip" file into the
     Library folder of your proper Context/Location for DCS World (install dir).
     
  2. Run Open Mod Manager, go to the proper Context/Location then install the mod.


* Manual Install

  1. [Backup] - Go to your DCS World installation folder, then copy following 
     files and/or folders into a safe location:
     
      - \Mods\aircraft\M-2000C\Cockpit\COM
      - \Mods\aircraft\M-2000C\Cockpit\FUEL
      - \Mods\aircraft\M-2000C\Cockpit\PCA_PPA
      - \Mods\aircraft\M-2000C\Cockpit\PCN
      - \Mods\aircraft\M-2000C\Cockpit\RWR
      - \Mods\aircraft\M-2000C\Cockpit\VTB
      - \Mods\aircraft\M-2000C\Cockpit\VTH
      - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures
      - \Mods\aircraft\M-2000C\Cockpit\materials.lua

  2. [Install] - Open the "M-2000C_-_Cockpit_Indication_Fix_v#.#.zip", go inside 
     the "M-2000C_-_Cockpit_Indication_Fix_v#.#" folder within the zip structure 
     then extract its content into your DCS World installation folder overwriting 
     original files.



MODIFICATIONS DETAILS
________________________________________________________________________________

* General
   
  - All symbologies and fonts textures redone using pixel-aligned vector graphic
  - New textures pack in DDS format for better quality alpha mipmapping

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
  - New common LCD font texture.
  - Adjusted position for fuel gauge and PPA bomb display
  - New radio Dot-Matrix font texture.
  - Changed UHF radio display from LCD to Dot-Matrix



PACKAGE DETAILS
________________________________________________________________________________

Added files:
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_GreenBoxRadio_M2KC.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_HUD_big_M2KC.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_HUD_M2KC.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_LCD_M2KC.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_PCA_M2KC.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_RWR_M2KC.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_VTB_M2KC.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\headingtape_hud_M2KC.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\headingtape_vtb_M2KC.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\Indication_hud_M2KC.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\Indication_vtb_M2KC.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Grid_0.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Grid_1.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Grid_2.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Page_2.dds
 - \Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Cadr_AR.dds

Modified files:
 - \Mods\aircraft\M-2000C\Cockpit\materials.lua
 - \Mods\aircraft\M-2000C\Cockpit\COM\COM_display.lua
 - \Mods\aircraft\M-2000C\Cockpit\COM\COM_GreenBox_display.lua
 - \Mods\aircraft\M-2000C\Cockpit\FUEL\FUEL_definitions.lua
 - \Mods\aircraft\M-2000C\Cockpit\FUEL\FUEL_gauge.lua
 - \Mods\aircraft\M-2000C\Cockpit\PCA_PPA\PCA_BR.lua
 - \Mods\aircraft\M-2000C\Cockpit\PCA_PPA\PCA_UR.lua
 - \Mods\aircraft\M-2000C\Cockpit\PCA_PPA\PPA_display.lua
 - \Mods\aircraft\M-2000C\Cockpit\PCN\PCN_UR.lua
 - \Mods\aircraft\M-2000C\Cockpit\RWR\RWR_definitions.lua
 - \Mods\aircraft\M-2000C\Cockpit\RWR\RWR_page.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTB\VTB_definitions.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTB\VTB_base.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTB\VTB_page_0.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTB\VTB_page_1.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTB\VTB_page_2.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTB\VTB_page_3.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTB\VTB_MDO_Menu.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_definitions.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_init.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_base.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_base_appr.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_0.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_1.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_2.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_3.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_4.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_5.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_6.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_base.lua
 - \Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_appr.lua



Version History
________________________________________________________________________________

v2.2 (2020-12-19) for DCS World 2.5.6.59398 (2020-12-17)
 - Adaptation and update to fit the 2.5.6.59398 release.

v2.1.1 (2020-11-19) for DCS World 2.5.6.57949 (2020-11-18)
 - Fix VTB Preheat warning "P" size and position

v2.1 (2020-11-19) for DCS World 2.5.6.57949 (2020-11-18)
 - Adaptation and update to fit the 2.5.6.57949 release.
 
v2.0 (2020-11-05) for DCS World 2.5.6.57264 (2020-11-04)
 - Adaptation and update to fit the 2.5.6.57264 release.

v1.9 (10/05/2020) for DCS World 2.5.6.55960 (10/09/2020)
 - Repack for DCS World stable release.

v1.82 (10/05/2020) for DCS World 2.5.6.55743 (09/30/2020)
 - Fix pitch Ladder for HUD Approach mode.

v1.81 (10/01/2020) for DCS World 2.5.6.55743 (09/30/2020)
 - Correct VTB/RWR texture according new symbology.
 - Correct RWR Font texture with new symbology.
 - Update RWR LUA for new logic.
 - Update HUD LUA file according new logic.
 - Adding VTB_Cadr_AR texture.
 - Global Adaptation for DCS World 2.5.6.55743 release.

v1.8 (06/17/2020) for DCS World 2.5.6.49798 (05/29/2020)
 - Fixed CCRP Sight position.
 - Fixed OBL reticle position.
 - Moved CC Radar Mode text.
 - Adjusted AP FMP size.
 - Tuned font for HUD, RWR and VTB (better aligned).
 - New LCD font with proper elements for INS.
 - New dedicated material for INS LCD display.
 - Fixed INS display bad or unreadable symbols (N, S, E, W, +, -).
 - Tuned LCD font material.
 - Fixed Fuel LCD Gauge material (now same as others LCD).
 - Tuned Fuel LCD Gauge size and placement.
 - New Radio (Dot-Matrix) font.
 - Changed Radio UHF display font to Dot-Matrix.
 - Tuned Radio VHF display size and alignment.
 - New PCA font with new numbers schems (according photography).
 - Tuned PPA LCD size and placement.
 - All textures converted to DDS format for better rendering.
 - Recreated all textures using pixel-aligned vector graphics.
 - Readjusted alignment of some HUD and VTB elements.

v1.7.2 (06/10/2020) for DCS World 2.5.6.49798 (05/29/2020)
 - Fixed HUD test/standby mode.
 - Fixed HUD half-sized horizon line in approach mode.
 - Modified HUD RS alert.
 - Tuned HUD font sizing.
 - Tuned HUD ILS guide indicators.
 - Removed VTB glow effect on texture.

v1.7.1 (06/08/2020) for DCS World 2.5.6.49798 (05/29/2020)
 - Modified RWR Air threat symbol.
 - Fixed RWR DDM threat sprite.
 - Fixed HUD half-sized horizon line.
 - Fixel HUD dynmatic line element color mismatch.
 - Tuned colors.

v1.7 (06/05/2020) for DCS World 2.5.6.49798 (05/29/2020)
 - Tuned HUD interception and NEZ ring width and placement.
 - Corrected HUD AA mode TIR and DOM position (now out of NEZ ring).
 - Tuned HUD dynamic line elements width and opacity.
 - Modified HUD texture for ground pitch ladder steps (adding spaces).
 - Tuned HUD target NEZ scale position.
 - Corrected HUD heading tape numbers size and thickness.
 - Corrected HUD pitch ladder numbers size and thickness.
 - Alignment of VTB MDO mode elements.
 - Tuned VTB heading tape font size.
 - Tuned VTB dynamic line elements width and opacity.
 - Tuned RWR font spacing and symbols aligment.
 - Tuned RWR symbology and alignment.
 - New digital/liquid crystal numbers font.
 - New PCA font.
 - New LCD font.
 - Adjusted colors.
 - All screenshots updated.
 
v1.62 (05/31/2020) for DCS World 2.5.6.49798 (05/29/2020)
 - Corrected digital crystal font "1" digit.

v1.61 (05/30/2020) for DCS World 2.5.6.49798 (05/29/2020)
 - Adapt and repack for the 2.5.6.49798 stable release.

v1.6 (05/22/2020) for DCS World 2.5.6.49314 (05/20/2020)
 - Adaptation and update to fit the 2.5.6.49314 release.

v1.5 (04/17/2020) for DCS World 2.5.6.47224 (04/16/2020)
 - Adaptation and update to fit the 2.5.6.47224 release.
  
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


-- END OF DESCRIPTION ---------------------------------------------------------

Open Mod Manager Package file for "M-2000C_-_Cockpit_Indications_Fix_v2.2" Mod.

This Mod Package was created using Open Mod Manager and is intended to be
installed using Open Mod Manager or any other compatible software.

If you want to install this Mod manually, you will find the Mod files into
the following folder : 

  "M-2000C_-_Cockpit_Indications_Fix_v2.2"

Its content is respecting the destination folder tree and includes files to
be overwritten or added :

   Mods\
   Mods\aircraft\
   Mods\aircraft\M-2000C\
   Mods\aircraft\M-2000C\Cockpit\
   Mods\aircraft\M-2000C\Cockpit\COM\
   Mods\aircraft\M-2000C\Cockpit\COM\COM_display.lua
   Mods\aircraft\M-2000C\Cockpit\COM\COM_GreenBox_display.lua
   Mods\aircraft\M-2000C\Cockpit\FUEL\
   Mods\aircraft\M-2000C\Cockpit\FUEL\FUEL_definitions.lua
   Mods\aircraft\M-2000C\Cockpit\FUEL\FUEL_gauge.lua
   Mods\aircraft\M-2000C\Cockpit\materials.lua
   Mods\aircraft\M-2000C\Cockpit\PCA_PPA\
   Mods\aircraft\M-2000C\Cockpit\PCA_PPA\PCA_BR.lua
   Mods\aircraft\M-2000C\Cockpit\PCA_PPA\PCA_UR.lua
   Mods\aircraft\M-2000C\Cockpit\PCA_PPA\PPA_display.lua
   Mods\aircraft\M-2000C\Cockpit\PCN\
   Mods\aircraft\M-2000C\Cockpit\PCN\PCN_UR.lua
   Mods\aircraft\M-2000C\Cockpit\Resources\
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_GreenBoxRadio_M2KC.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_HUD_big_M2KC.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_HUD_M2KC.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_LCD_M2KC.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_PCA_M2KC.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_RWR_M2KC.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\font_VTB_M2KC.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\headingtape_hud_M2KC.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\headingtape_vtb_AR_M2KC.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\headingtape_vtb_M2KC.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\Indication_hud_M2KC.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\Indication_vtb_M2KC.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Cadr_AR.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Grid_0.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Grid_1.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Grid_2.dds
   Mods\aircraft\M-2000C\Cockpit\Resources\IndicationTextures\M2KC_VTB_Page_2.dds
   Mods\aircraft\M-2000C\Cockpit\RWR\
   Mods\aircraft\M-2000C\Cockpit\RWR\RWR_definitions.lua
   Mods\aircraft\M-2000C\Cockpit\RWR\RWR_page.lua
   Mods\aircraft\M-2000C\Cockpit\VTB\
   Mods\aircraft\M-2000C\Cockpit\VTB\VTB_base.lua
   Mods\aircraft\M-2000C\Cockpit\VTB\VTB_definitions.lua
   Mods\aircraft\M-2000C\Cockpit\VTB\VTB_MDO_Menu.lua
   Mods\aircraft\M-2000C\Cockpit\VTB\VTB_page_0.lua
   Mods\aircraft\M-2000C\Cockpit\VTB\VTB_page_1.lua
   Mods\aircraft\M-2000C\Cockpit\VTB\VTB_page_2.lua
   Mods\aircraft\M-2000C\Cockpit\VTB\VTB_page_3.lua
   Mods\aircraft\M-2000C\Cockpit\VTB\VTB_page_4.lua
   Mods\aircraft\M-2000C\Cockpit\VTH\
   Mods\aircraft\M-2000C\Cockpit\VTH\HUD_base.lua
   Mods\aircraft\M-2000C\Cockpit\VTH\HUD_base_appr.lua
   Mods\aircraft\M-2000C\Cockpit\VTH\HUD_definitions.lua
   Mods\aircraft\M-2000C\Cockpit\VTH\HUD_init.lua
   Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_0.lua
   Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_1.lua
   Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_2.lua
   Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_3.lua
   Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_4.lua
   Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_5.lua
   Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_6.lua
   Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_appr.lua
   Mods\aircraft\M-2000C\Cockpit\VTH\HUD_page_base.lua

Once you made a backup of the original files, you can install the Mod by
extracting the content of the previously indicated folder into the
proper application or game folder, overwriting original files.

For more information about Open Mod Manager and Open Mod Packages, please
visit :

   https://github.com/sedenion/OpenModMan