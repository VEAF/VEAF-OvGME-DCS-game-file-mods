local smokeLifeC = 2
local smokeLife = 8*smokeLifeC
local VelocityRandom = {Min = {-6}, Max = {10}}

Duration = {{0, 900}, {1, 1500}}
Emitters = { 	   
	{
        Name = "SmokeL",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentMarkerSmoke", -- "TranslucentMarkerSmoke",
		Flags = {"SmokeMarker"},
		InitPositionBox = {Min = {0, 0.0, 0}, Max = {0, 0.01, 0}},
        
        Number = {{0, 6}},
        Life = {{0, 6*smokeLifeC}, {1, 14*smokeLifeC}},
        
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},
		
		RadialVelocity = {{0, 1}},
        Velocity = {{0, {1, 1.8, 0.6}, {-1, 2, -0.6}}},
        VelocityOverLife = {{0, 0.02}, {0.15, 0.4}, {1, 0.6}},
		
--		Acceleration = {{0.0, {0.0, -9.8, 0.0}, {0.0, -9.8, 0.0}}},

		ParentVelocity = { {0, 0.1} },
		Windage = { {0, 0.15} },
		
		Size = {{0, 8}, {1, 10}},
        SizeOverLife = {{0, 0}, {0.08, 0.26}, {0.2, 0.32}, {0.5, 2}, {1, 5}},

		Spin = {{0, 1}},
		SpinOverLife = {{0, 1}, {1, -0.6}},

        RedOverLife =   {{0, 1}},
        GreenOverLife = {{0, 1}},
        BlueOverLife = {{0, 1}},
		AlfaOverLife = {{0, 0}, {0.002, 0.6}, {0.32, 0.01}, {1, 0}},
    },
}

Lights = {}

Lods = 
{
	[1] = 
	{
		Distance = 800,
		Emitters = 
		{
			["SmokeL"] = 
			{
				Number = {{0, 8}},
				Flags = {},
			},
		}
	},
	[2] = 
	{
		Distance = 2000,
		Emitters = 
		{
			["SmokeL"] = 
			{
				Number = {{0, 8}},
				Flags = {},
			},
		}
	},
}