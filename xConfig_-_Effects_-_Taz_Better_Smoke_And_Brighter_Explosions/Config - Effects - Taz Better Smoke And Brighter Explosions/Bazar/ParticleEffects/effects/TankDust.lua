local DustRedOverLife = {{0.0, 0}} -- {{0.0, 1}}
local DustGreenOverLife = {{0.0, 1}} -- {{0.0, 1}}
local DustBlueOverLife = {{0.0, 0}} -- {{0.0, 0.85}}
Emitters = {
	[1] = 
	{
        Name = "Dust",
		Texture = "SmokeNormAnim.png",
        Technique = "TranslucentAnim",
		Flags = {"SoftParticles", "LocalSpace"},
		InitPositionBox = {Min = {-3.0, 0, -0.1}, Max = {-3, 0, 0.1}},
		
        Number = {{0, 6}}, -- Density of smoke
        Life = {{0, 5}, {1, 6}}, -- Increasing second numbers (5 and 6) will make particle linger longer
        Spin = {{0, 1}, {1, -1}},
        SpinOverLife = {{0, -2}, {0.7, 1}},
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

		ParentVelocity = {{0, 0.1}},
		RadialVelocity = {{0, 1}},
		Velocity = {{0, {-0.2, 1, -1}, {-0.2, 1.5, 1}}},
        VelocityOverLife = {{0, 0.5}, {0.7, 0.3}},
		
        Size = {{0, 3}, {1, 4}}, -- Increase second numbers in bracket (3 and 4) to increase particle size
        SizeOverLife = {{0, 0.2}, {0.2, 2}, {1, 3}},
		
		Windage = { {0, 0.5} }, -- Increasing second number (0.5) will make dust blow in the wind more.
		
        RedOverLife =   {{0, 0.35}, {0.25, 0.55}},
        GreenOverLife = {{0, 0.34}, {0.25, 0.54}},
        BlueOverLife = {{0, 0.3}, {0.25, 0.5}},
        AlfaOverLife = {{0, 0}, {0.1, 1}, {0.5, 0.1}, {1, 0}},
    },
}

Lods = 
{
	[1] = 
	{
		Distance = 1500,
		Emitters = 
		{
			["Dust"] = 
			{
				Number = {{0,4}},
			},
		}
	},
}