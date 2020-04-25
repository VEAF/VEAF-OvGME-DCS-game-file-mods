------------------------------------------------------------------
         DCS World shaders performance mod (for VR use)
      by Keijo "Kegetys" Ruotsalainen, http://www.kegetys.fi
------------------------------------------------------------------
  
For DCS World version 2.5.6.47224 (19.4.2020). Using with other
versions may or may not work.

Various shader changes for improved performance in VR, without sacrificing
too much on visual quality. Also other improvements (see list below)

Install:
- Backup your Bazar/shaders directory (but keep the files in place)
- Extract files from this zip, overwriting the existing files
- Remove terrain metacaches. For example:
   Mods\terrains\Caucasus\misc\metacache\dcs
   Mods\terrains\Nevada\misc\metacache\dcs
   Mods\terrains\???\misc\metacache\dcs
  rename those directories to dcs.old or similar. This ensures
  the metashaders will be recompiled correctly.
- Run DCS World. The shaders will be compiled as they are used
  for the first time, so first startup and loading of mission will
  take a while (can be 10 minutes or more). While playing you can
  also see some stutters when new shaders are compiling for the 
  first time.
- Performance should be better, especially in VR.

Uninstall:
- Restore Bazar/shaders backup
- Restore terrain metacaches
- Delete files from C:\Users\<user>\Saved Games\DCS\fxo and metashaders2
  directories.

Changes done:
- Simplified canopy glass shader*
- "Emulation" for the OpenVR hidden area mesh**
- MSAA is applied only on the middle area of view***
- Simplified histogram calculation
- Disabled bloom
- Disabled blur compute shaders
- Removed some refractions shader (not sure what it did)
- Simplified grass rendering
- Disabled atmosphere for things close to camera
- Removed one GBuffer entirely for bandwidth savings
- Slight mip bias adjustment for text rendering (sharper text)
- Reduced shadow PCF maximum sample count from 16 to 10
- Disabled color grading
- Improved night vision goggles, useable in VR now with smaller, properly 
  positioned scope, working gain control and new noise effect
- Added simple dithering to HDR tonemap to smooth out banding, visible especially at the sky
- The 3D mouse cursor is less bright at night time
- Albedo texture supersampling, for sharpening object textures.
  Visible especially with cockpit text labels.

* This optimization does not work with planes which do not use the glass 
  shader for the canopy glass.

** If you see an area around your peripheral vision rendered incorrectly
   open Bazar\shaders\deferred\_HMD.hlsl and increase the MASKSIZE value.
   The default is optimized for HTC Vive.

*** You can also adjust MSAA_MASKSIZE value from above file, which is the
    size of the area onto which MSAA is applied when it is enabled.

From Bazar\shaders\deferred\_HMD.hlsl file you can also adjust other settings,
for example the size and position of the NVG scope. There is also setting
NVG_GAIN_ADJUSTS_POSITION which when set to 1 allows using the in-game NVG gain
adjustment to move the NVG scope up/down (and closer/further away).
    
------------------------------------------------------------------
 Vesion history
------------------------------------------------------------------
2.5.6.47224:
 - Compatibility with DCS World version 2.5.6.47224 (19.4.2020)
 - Fixed some potential issues with GBuffer decoding
 - Fixed simple glass albedo color
 - Added ENABLE_NO_BLOOM setting to keep bloom enabled (appears to perform better nowdays)
 - Changed HMD mask outside area to write black rather than discard to be compatible with bloom
 - Added albedo texture supersampling (ENABLE_DIFFUSE_SS setting)
2.5.6.45915:
 - Compatibility with DCS World version 2.5.6.45915 (3.4.2020)
2.5.6.43503:
 - Compatibility with DCS World version 2.5.6.43503 (16.2.2020)
 - Restored original sun flare
 - Added simplified version of histogram calculation (previously it was removed completely)
 - Above can be turned off with ENABLE_SIMPLE_HG setting
 - Removed the sRGB fix as the game seems to have some other workaround for it now
 - ENABLE_SIMPLE_SHADOWS now limits the sample count to 10 instead of 16
v2.5.5.41371:
 - Compatibility with DCS World version 2.5.5.41371 (4.1.2020)
v2.5.5.34644:
 - Compatibility with DCS World version 2.5.5.34644 (14.8.2019)
v2.5.4.28615:
 - Restored resolveDepth as it was causing problems with haze and NVG depth effect
 - Fixed fog not being visible near the camera
 - NVG effect improved for VR goggles (smaller scope, correct positioning, new noise)
 - NVG gain now does something proper rather than just brightens up the sky
 - NVG parameters configurable from _HMD.hlsl
 - Included the sRGB gamma fix in the mod (fix elevated black levels, visible esp. at night)
 - Added simple dithering to HDR tonemap to smooth out banding, visible especially at the sky
 - Made the 3D mouse cursor less bright at night time
 - Some optimizations can now be turned off from _HMD.hlsl (simple shadows, grass, canopy)
v2.5.4.25729:
 - Compatibility with DCS World version 2.5.4.25729 (20.12.2018)
v2.5.3.21107:
 - Compatibility with DCS World version 2.5.3.21107 (31.8.2018)
 - Fixed moonlight illuminating cockpit glass too much
v2.5.2.19273.411(b):
 - Fixed compile error with DIFFUSE_UV
v2.5.2.19273.411:
 - Fist version

