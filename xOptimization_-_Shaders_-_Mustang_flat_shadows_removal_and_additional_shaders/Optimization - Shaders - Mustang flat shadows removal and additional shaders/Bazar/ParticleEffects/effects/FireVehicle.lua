local fireLife = 2
local smokeLifeC = 2
local smokeLife = 8*smokeLifeC
local hazeLifeDelta = 20.0
local hazeLife = 90.0
local lifeTime = 120

Duration = {{0, 900}, {1, 1500}}
Emitters = {
 	   {
        Name = "Fire1",
		Texture = "DCSFireTex.png",
        Technique = "AnimatedFire",
		InitPositionBox = {Min = {-1.2,0.8,0.3}, Max = {-1.2,1,1.3}},
		Flags = {"SoftParticles"},
        
        Number = {{0, 4}, {1, 1}},
--		NumberRate  = {{-3, 1}, {0,0.125}},
        Life = {{0.0, 1.8}},
        
		ShaderParams = {{0, {0.8,0,0,0}, {0.8,0,0,0}}},

        Velocity = { {0.,{0, 2, 0}, {0., 2.5, 0}}},
        VelocityOverLife = { {0,0} , {0.16, 0.15}, {0.33,1}, {0.4,1}, {1.0,1.7}},
		
        Size = {{0.0, 2.5}, {1.0, 2.8}},
        SizeOverLife = {{0.6, 1} , {1, 0.1}},
		
		ParentVelocity = { {0, 0.5} },
		Windage = { {0, 0.3} },
				
		RedOverLife =   {{0, 1.0}, {1, 1.0}},
        GreenOverLife = {{0, 0.65}, {1, 0.7}},
        BlueOverLife = {{0, 0.4}, {1, 0.4}},
		
        AlfaOverLife = {{0.0, 0.0}, {0.4, 1.4}, {1, 0}},
    },
	{
        Name = "Fire2",
		Texture = "DCSFireTex.png",
        Technique = "AnimatedFire",
		InitPositionBox = {Min = {1.8,0.5,-0.7}, Max = {2.0,0.6,-0.9}},
		Flags = {"SoftParticles"},
        
        Number = {{0, 3.5}, {1.5, 1}},
 --       NumberRate  = {{-8, 1}, {-5, 0}},
        Life = {{0.0, 1.6}},
        
		ShaderParams = {{0, {1.7,0,0,0}, {1.7,0,0,0}}},

        Velocity = { {0., {0, 0.6, 0}, {0., 1.5, 0}}},
        VelocityOverLife = { {0,0} , {0.16, 0.15}, {0.33,1}, {0.4,1}, {1.0,1.7}},
		
        Size = {{0.0, 1.9}, {1.0, 2.1}},
        SizeOverLife = {{0.6, 1} , {1, 0.1}},
		
		ParentVelocity = { {0, 0.5} },
		Windage = { {0, 0.3} },
				
		RedOverLife =   {{0, 1.0*1.2}, {1, 1.0}},
        GreenOverLife = {{0, 0.65*1.2}, {1, 0.7}},
        BlueOverLife = {{0, 0.4*1.2}, {1, 0.4}},
		
        AlfaOverLife = {{0.0, 0}, {0.4, 1.2}, {1, 0}},
    },
		{
        Name = "Smoke1",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"SoftParticles", "Sort", "LocalSpace"},
		InitPositionBox = {Min = {-0.6,0.8,-0.9}, Max = {0.9,1,1.3}},
		Number = {{0, 4.5}, {2*lifeTime-1, 4.5}, {2*lifeTime+1, 0}, {15*lifeTime, 0}}, 
		Life = {{0.0, 12*smokeLifeC}, {1.0, 25*smokeLifeC}}, 
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},
		Velocity = {{0, {-0.30, 3.0, -0.40}, {0.2, 4.0, 0.50}}},
		VelocityOverLife = {{0, 0}, {0.01, 2.0}, {0.5, 1.2}, {1.0, 1.0}},
		ParentVelocity = {{0, 0.09}, {1, 0.11}},
		Size = {{0, 2.2}, {1, 2.8}},
        SizeOverLife = {{0, 1.60}, {0.02, 2.5}, {0.04, 2.0}, {0.07, 5.0}, {0.10, 4.0}, {0.15, 8.0}, {0.21, 6.0}, {0.35, 10.0}, {1, 30.0}},
        RedOverLife =	{{0, 0.1}, {0.1, 0.1}, {0.2, 0.3}, {0.21, 0.1}, {0.23, 0.2}, {1, 0.4}},
        GreenOverLife =	{{0, 0.1}, {0.1, 0.1}, {0.2, 0.3}, {0.21, 0.1}, {0.23, 0.2}, {1, 0.4}},
        BlueOverLife =	{{0, 0.15}, {0.1, 0.15}, {0.25, 0.35}, {0.26, 0.15}, {0.28, 0.25}, {1, 0.45}},
		AlfaOverLife =	{{0, 0.0}, {0.02, 0.70}, {0.04, 0.45}, {0.07, 0.60}, {0.10, 0.28}, {0.5, 0.11}, {1, 0}},
    },
	{
        Name = "Smoke2",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"SoftParticles", "Sort", "LocalSpace"},
		InitPositionBox = {Min = {-0.6,0.8,-0.9}, Max = {0.9,1,1.3}},
		Number = {{0, 0}, {2*lifeTime, 0}, {2*lifeTime+1, 4.0}, {4*lifeTime, 4.0}, {4*lifeTime+1, 0}, {15*lifeTime, 0}}, 
		Life = {{0.0, 10*smokeLifeC}, {1.0, 20*smokeLifeC}}, 
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},
		Velocity = {{0, {-0.28, 3.0, -0.38}, {0.2, 3.9, 0.48}}},
		VelocityOverLife = {{0, 0}, {0.01, 1.8}, {0.5, 1.2}, {1.0, 1.0}},
		ParentVelocity = {{0, 0.09}, {1, 0.11}},
		Size = {{0, 2.1}, {1, 2.6}},
        SizeOverLife = {{0, 1.55}, {0.02, 2.4}, {0.04, 1.9}, {0.07, 4.8}, {0.10, 3.8}, {0.15, 7.6}, {0.21, 5.8}, {0.35, 9.0}, {1, 27.0}},
        RedOverLife =	{{0, 0.1}, {0.1, 0.1}, {0.2, 0.3}, {0.21, 0.1}, {0.23, 0.2}, {1, 0.4}},
        GreenOverLife =	{{0, 0.1}, {0.1, 0.1}, {0.2, 0.3}, {0.21, 0.1}, {0.23, 0.2}, {1, 0.4}},
        BlueOverLife =	{{0, 0.15}, {0.1, 0.15}, {0.25, 0.35}, {0.26, 0.15}, {0.28, 0.25}, {1, 0.45}},
		AlfaOverLife =	{{0, 0.0}, {0.02, 0.70}, {0.04, 0.45}, {0.07, 0.60}, {0.10, 0.28}, {0.5, 0.11}, {1, 0}},
    },
	{
        Name = "Smoke3",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"SoftParticles", "Sort", "LocalSpace"},
		InitPositionBox = {Min = {-0.6,0.8,-0.9}, Max = {0.9,1,1.3}},
		Number = {{0, 0}, {4*lifeTime, 0}, {4*lifeTime+1, 3.5}, {6*lifeTime, 3.5}, {6*lifeTime+1, 0}, {15*lifeTime, 0}}, 
		Life = {{0.0, 8*smokeLifeC}, {1.0, 15*smokeLifeC}}, 
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},
		Velocity = {{0, {-0.26, 3.0, -0.36}, {0.2, 3.8, 0.46}}},
		VelocityOverLife = {{0, 0}, {0.01, 1.6}, {0.5, 1.2}, {1.0, 1.0}},
		ParentVelocity = {{0, 0.09}, {1, 0.11}},
		Size = {{0, 2.0}, {1, 2.4}},
        SizeOverLife = {{0, 1.50}, {0.02, 2.3}, {0.04, 1.8}, {0.07, 4.5}, {0.10, 3.6}, {0.15, 7.2}, {0.21, 5.6}, {0.35, 8.0}, {1, 24.0}},
        RedOverLife =	{{0, 0.1}, {0.1, 0.1}, {0.2, 0.3}, {0.21, 0.1}, {0.23, 0.2}, {1, 0.4}},
        GreenOverLife =	{{0, 0.1}, {0.1, 0.1}, {0.2, 0.3}, {0.21, 0.1}, {0.23, 0.2}, {1, 0.4}},
        BlueOverLife =	{{0, 0.15}, {0.1, 0.15}, {0.25, 0.35}, {0.26, 0.15}, {0.28, 0.25}, {1, 0.45}},
		AlfaOverLife =	{{0, 0.0}, {0.02, 0.70}, {0.04, 0.45}, {0.07, 0.60}, {0.10, 0.28}, {0.5, 0.11}, {1, 0}},
    },
	{
        Name = "Smoke4",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"SoftParticles", "Sort", "LocalSpace"},
		InitPositionBox = {Min = {-0.6,0.8,-0.9}, Max = {0.9,1,1.3}},
		Number = {{0, 0}, {6*lifeTime, 0}, {6*lifeTime+1, 3.0}, {8*lifeTime, 3.0}, {8*lifeTime+1, 0}, {15*lifeTime, 0}}, 
		Life = {{0.0, 6*smokeLifeC}, {1.0, 10*smokeLifeC}}, 
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},
		Velocity = {{0, {-0.24, 3.0, -0.34}, {0.2, 3.7, 0.45}}},
		VelocityOverLife = {{0, 0}, {0.01, 1.4}, {0.5, 1.2}, {1.0, 1.0}},
		ParentVelocity = {{0, 0.09}, {1, 0.11}},
		Size = {{0, 1.9}, {1, 2.2}},
        SizeOverLife = {{0, 1.45}, {0.02, 2.2}, {0.04, 1.7}, {0.07, 4.2}, {0.10, 3.4}, {0.15, 6.8}, {0.21, 5.4}, {0.35, 7.0}, {1, 21.0}},
        RedOverLife =	{{0, 0.1}, {0.1, 0.1}, {0.2, 0.3}, {0.21, 0.1}, {0.23, 0.2}, {1, 0.4}},
        GreenOverLife =	{{0, 0.1}, {0.1, 0.1}, {0.2, 0.3}, {0.21, 0.1}, {0.23, 0.2}, {1, 0.4}},
        BlueOverLife =	{{0, 0.15}, {0.1, 0.15}, {0.25, 0.35}, {0.26, 0.15}, {0.28, 0.25}, {1, 0.45}},
		AlfaOverLife =	{{0, 0.0}, {0.02, 0.70}, {0.04, 0.45}, {0.07, 0.60}, {0.10, 0.28}, {0.5, 0.11}, {1, 0}},
    },
	{
        Name = "Smoke5",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"SoftParticles", "Sort", "LocalSpace"},
		InitPositionBox = {Min = {-0.6,0.8,-0.9}, Max = {0.9,1,1.3}},
		Number = {{0, 0}, {8*lifeTime, 0}, {8*lifeTime+1, 2.5}, {15*lifeTime, 2.5}}, 
		Life = {{0.0, 4*smokeLifeC}, {1.0, 5*smokeLifeC}}, 
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},
		Velocity = {{0, {-0.22, 3.0, -0.32}, {0.2, 3.6, 0.44}}},
		VelocityOverLife = {{0, 0}, {0.01, 1.2}, {0.5, 1.2}, {1.0, 1.0}},
		ParentVelocity = {{0, 0.09}, {1, 0.11}},
		Size = {{0, 1.8}, {1, 2.0}},
        SizeOverLife = {{0, 1.40}, {0.02, 2.1}, {0.04, 1.6}, {0.07, 3.9}, {0.10, 3.2}, {0.15, 6.4}, {0.21, 5.2}, {0.35, 6.0}, {1, 18.0}},
        RedOverLife =	{{0, 0.1}, {0.1, 0.1}, {0.2, 0.3}, {0.21, 0.1}, {0.23, 0.2}, {1, 0.4}},
        GreenOverLife =	{{0, 0.1}, {0.1, 0.1}, {0.2, 0.3}, {0.21, 0.1}, {0.23, 0.2}, {1, 0.4}},
        BlueOverLife =	{{0, 0.15}, {0.1, 0.15}, {0.25, 0.35}, {0.26, 0.15}, {0.28, 0.25}, {1, 0.45}},
		AlfaOverLife =	{{0, 0.0}, {0.02, 0.70}, {0.04, 0.45}, {0.07, 0.60}, {0.10, 0.28}, {0.5, 0.11}, {1, 0}},
    },
	{
        Name = "SmokeHaze",
		Texture = "DCSSmoke.png",
		Technique = "Translucent",
		Flags = {"SoftParticles", "Sort", "LocalSpace"},
		InitPositionBox = CommonInitPos,
        
        Number = {{0, 0.12}},
        Life = {{0.0, hazeLife - hazeLifeDelta}, {1.0, hazeLife + hazeLifeDelta}},
        
		ShaderParams = {{0, {2, 2, 0, 0}, {2, 2, 0, 0}}},
		--ShaderParams = {{0, {2, 2, 0, 0}, {2, 2, 0, 0}}},

        Velocity = {{0.0, {-1.0, 3.0, -1.0}, {1.0, 4, 1.0}},
					{0.2, {-1.0, 3.0, -1.0}, {1.0, 4, 1.0}},
					{0.2, {-2, 4.0, -2}, {2, 7.0, 2}},
					{1.0, {-2, 4.0, -2}, {2, 7.0, 2}}},
        VelocityOverLife = { {0,1}, {10*fireLife/hazeLife, 1}, {0.8,0.1}},

		Size = {{0.0, 16}, {1.0, 20}},
        SizeOverLife = {{0, 0.0}, {10*fireLife/hazeLife, 1}, {0.7, 13}},

        RedOverLife =   {{0, 0.2}},
        GreenOverLife = {{0, 0.2}},
        BlueOverLife = {{0, 0.2}},
        AlfaOverLife = {{0.0, 0.0}, {smokeLife/hazeLife, 0.6}, {0.4, 0.4}, {1, 0.0}},
    },
}

local lb = 1.2 
Lights =
{
	{
		offset = {0,4.5,0},
		color = {{0, {1*lb, 0.6*lb, 0.2*lb}}, {0.3, {0.8*lb, 0.5*lb, 0.1*lb}}, {0.4, {1*lb, 0.6*lb, 0.2*lb}}},
		distance = {{0, 150}, {1.5, 180}, {3, 140}},
	},
}

Lods = 
{
	[1] = 
	{
		Distance = 100000,
		Emitters = 
		{
			["Fire1"] = 
			{			
				Number = {{0, 2}},
				Flags = {},
			},
			["Fire2"] = 
			{		
				Flags = {'SoftParticles'},
			},
						["Haze"] = 
			{
				Flags = {"SoftParticles"},
			}
		}
	},
}