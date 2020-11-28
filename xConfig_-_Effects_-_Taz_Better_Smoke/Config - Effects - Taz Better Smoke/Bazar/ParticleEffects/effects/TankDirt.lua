local DirtRedOverLife = {{0.0, 1}} -- {{0.0, 150/255}}
local DirtGreenOverLife = {{0.0, 0}} -- {{0.0, 110/255}}
local DirtBlueOverLife = {{0.0, 0}} -- {{0.0, 60/255}}
local birthBoxSize = 0.1

Emitters = {
	[1] = 
	{
        Name = "TracksDirt",
		Texture = "Dirt.png",
        Technique = "Translucent",
		Flags = {"LocalSpace"},
		InitPositionBox = {Min = {-birthBoxSize, -birthBoxSize, -birthBoxSize}, Max = {birthBoxSize,birthBoxSize, birthBoxSize}},
		
        Number = {{0, 0}}, -- {{0, 20}},
        Life = {{0.0, 0.6}, {1.0, 1.1}},
        Spin = {{0, -10.0}, {1, 10.0}},
		ShaderParams = {{0, {1,1,0,0}, {1,1,0,0}}},

		ParentVelocity = {{0, 0.2}},
		Velocity = {{0.0, {-0.05, -0.4, -0.1}, {-0.07, 2.0, 0.1}}},
		Acceleration = {{0.0, {0.0, -9.8, 0.0}, {0.0, -9.8, 0.0}}},
		
        Size = {{0.0, 0.07}, {1.0, 0.2}},
		
		Windage = { {0, 0.0} },
				
		RedOverLife = DirtRedOverLife,
		GreenOverLife = DirtGreenOverLife,
		BlueOverLife = DirtBlueOverLife,
        AlfaOverLife = {{0.0, 1.0}},
    },
}

Lods = 
{
	[1] = 
	{
		Distance = 100,
		Emitters = 
		{
			["TracksDirt"] = 
			{			
				Flags = {'Disable'},
			},
		}
	},
}