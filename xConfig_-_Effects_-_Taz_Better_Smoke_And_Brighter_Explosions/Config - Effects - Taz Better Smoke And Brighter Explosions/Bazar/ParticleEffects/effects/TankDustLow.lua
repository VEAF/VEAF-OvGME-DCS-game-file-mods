local DustRedOverLife = {{0.0, 1}} -- {{0.0, 1}}
local DustGreenOverLife = {{0.0, 1}} -- {{0.0, 1}}
local DustBlueOverLife = {{0.0, 0.85}} -- {{0.0, 0.85}}
Emitters = {
	[1] = 
	{
        Name = "TracksDirtFront",
		Texture = "DustDirt.png",
        Technique = "Translucent",
		Flags = {"LocalSpace"},
		InitPositionBox = {Min = {1.2, 1, 0.5}, Max = {1.2, 1, -0.5}}, -- F/R, U/D, L/R
		
        Number = {{0, 20}}, -- {{0, 10}},
        Life = {{0.0, 1.25}, {1.0, 1.4}},
        Spin = {{0, -2}, {1, 2}},
		ShaderParams = {{0, {1,1,0,0}, {1,1,0,0}}}, -- {sprite u, sprite v, uk, uk}

		ParentVelocity = {{0, 0.1}},
		Velocity = {{0, {1, -1, 0.2}, {1, -1, -0.2}}},
		Acceleration = {{0, {-0.1, -0.05, 0.1}, {-0.1, -0.05, -0.1}}},
		
        Size = {{0.0, 1}, {1.0, 1.4}},
        SizeOverLife = {{0.0, 0.4}, {0.6, 1.0}},
		
		Windage = { {0, 0.0} },
				
		RedOverLife = {{0.0, 0.5}}, -- {{0.0, 0.204}},
		GreenOverLife = {{0.0, 0.5}}, -- {{0.0, 0.15}},
		BlueOverLife = {{0.0, 0.45}}, -- {{0.0, 0.055}},
        AlfaOverLife = {{0.0, 0}, {0.2, 1}, {0.8, 0.8}, {1.0, 0}},
    },
	[2] =
	{
        Name = "TracksDirtRear",
		Texture = "DustDirt.png",
        Technique = "Translucent",
		Flags = {"LocalSpace"},
		InitPositionBox = {Min = {-6.5, 0, 0.5}, Max = {-6.5, 0, -0.5}}, -- F/R, U/D, L/R
		
        Number = {{0, 20}}, -- {{0, 20}},
        Life = {{0.0, 1.25}, {1.0, 1.4}},
        Spin = {{0, 5}, {1, -5}},
		ShaderParams = {{0, {1,1,0,0}, {1,1,0,0}}}, -- {sprite u, sprite v, uk, uk}

		ParentVelocity = {{0, 0.1}},
		Velocity = {{0, {-2, 3, 0.2}, {-2, 3, -0.2}}},
		Acceleration = {{0, {0, -7, 0.1}, {0, -7, -0.1}}},
		
        Size = {{0.0, 1}, {1.0, 1.4}},
        SizeOverLife = {{0.0, 0.4}, {0.6, 1.0}},
		
		Windage = { {0, 0.0} },
				
		RedOverLife = {{0.0, 0.61}}, -- {{0.0, 0.204}},
		GreenOverLife = {{0.0, 0.60}}, -- {{0.0, 0.15}},
		BlueOverLife = {{0.0, 0.56}}, -- {{0.0, 0.055}},
        AlfaOverLife = {{0.0, 0}, {0.2, 1}, {0.8, 0.8}, {1.0, 0}},
    },
	[3] = 
	{
        Name = "TracksDust",
		Texture = "SmokeNormAnim.png",
        Technique = "TranslucentAnim",
		Flags = {"SoftParticles", "LocalSpace", "Sort"},
		InitPositionBox = {Min = {-3, 0, -0.1}, Max = {-3, 0, 0.1}},
		
        Number = {{0, 6}}, -- {{0, 15}}, -- Density of dust
        Life = {{0, 6}, {1, 8}}, -- Increasing second numbers (6 and 8) will make particle linger longer
        Spin = {{0, 1}, {1, -1}},
		SpinOverLife = {{0, 2}, {0.7, -1}},
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

		ParentVelocity = {{0, 0.1}},
		RadialVelocity = {{0, 1}},
		Velocity = {{0, {-0.8, 0.5, 0.1}, {-0.8, 0.5, -0.1}}},
        VelocityOverLife = {{0, 1}, {0.3, 0.4}, {1, 0}},
		
        Size = {{0, 2}, {1, 3}}, -- Increase second numbers in bracket (2 and 3) to increase particle size
        SizeOverLife = {{0, 0.2}, {0.1, 1}, {0.5, 2}, {1, 4}},
		
		Windage = { {0, 0.1} }, -- Increasing second number (0.1) will make dust blow in the wind more.
				
        RedOverLife =   {{0, 0.35}, {0.25, 0.6}},
        GreenOverLife = {{0, 0.34}, {0.25, 0.58}},
        BlueOverLife = {{0, 0.3}, {0.25, 0.55}},
		AlfaOverLife = {{0.0, 0}, {0.1, 0.8}, {0.35, 0.1}, {1, 0}},
    },
}

Lods = 
{
	[1] = 
	{
		Distance = 1000,
		Emitters = 
		{
			["TracksDirt"] = 
			{			
				Flags = {'Disable'},
			},
		}
	},
	[2] = 
	{
		Distance = 5000,
		Emitters = 
		{
			["TracksDirt"] = 
			{			
				Flags = {'Disable'},
			},
			["TracksDust"] = 
			{			
				Flags = {'Disable'},
			},
		}
	},
}