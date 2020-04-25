// optimisations: change 1 to 0 to disable
#define ENABLE_HMD_MASK       1 // Enable hidden area masking for HMD (adjust MASKSIZE to fit your headset)
#define ENABLE_SIMPLE_SHADOWS 1 // Use less samples in shadow mapping
#define ENABLE_SIMPLE_GRASS   1 // Simplified grass
#define ENABLE_SIMPLE_CANOPY  1 // Simplified canopy glass
#define ENABLE_SIMPLE_HG      1 // Simplified histogram calculation
#define ENABLE_NO_BLOOM       1 // Disable bloom & color grading

// improvements
#define ENABLE_DITHERING          1 // Use dithering in HDR tonemap to reduce banding, may cause moire artifacts at edges of lenses
#define ENABLE_DIFFUSE_SS         2 // Albedo texture supersampling. 0=off, 1=2x, 2=4x, 3=6x, 4=8x
#define NVG_GAIN_ADJUSTS_POSITION 0 // with this enabled the NVG gain control instead adjusts the vertical position allowing in-game adjustment with fixed gain (NVG_VERTICAL_OFFSET is ignored)

// other settings
#define MASKSIZE                  0.525   // change this to adjust the size of the mask, 0.525 seems to be ok for the Vive, 0.600 should be ok for the rift cv1
#define MSAA_MASKSIZE             0.2     // Mask size used for MSAA - area outside this circle will not have MSAA applied on it
#define NVG_SIZE                  4.0     // size of the NVG scope (larger value = smaller scope)
#define NVG_VERTICAL_OFFSET       0.07    // vertical position of the NVG scope, for allowing to "look under" the goggles at instruments
#define NVG_NOISE_STR             0.075   // NVG noise strength
#define NVG_HOTPIXEL_THRESHOLD    0.99982 // NVG noise threshold for "hot" pixels
