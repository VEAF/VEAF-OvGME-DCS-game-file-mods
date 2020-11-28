local fireLife = 2
local smokeLifeC = 4 -- 2
local smokeLife = 8*smokeLifeC
local lifeTime = 120

Duration = {{0, 900}, {1, 1500}}
Emitters = {
 	{
        Name = "Fire1",
		Texture = "DCSFireTex.png",
        Technique = "AnimatedFire",
		InitPositionBox = {Min = {-1.2,0.8,-1.3}, Max = {-1.2,1,1.3}},
		Flags = {"SoftParticles"},
        
        Number = {{0, 1.5}, {lifeTime, 1.5}, {lifeTime, 0}, {20*lifeTime, 0}},
--		NumberRate  = {{-3, 1}, {0,0.125}},
        Life = {{0.0, 3.6}},
        
		ShaderParams = {{0, {0.8,0,0,0}, {0.8,0,0,0}}},

        Velocity = {{0,{0, 2, 0}, {0, 2.5, 0}}},
        VelocityOverLife = { {0,0} , {0.16, 0.15}, {0.33,1}, {0.4,1}, {1.0,1.7}},
		
        Size = {{0.0, 2.5}, {1.0, 2.8}},
        SizeOverLife = {{0.6, 2} , {1, 0.1}},
		
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
		InitPositionBox = {Min = {1.8,0.5,1.3}, Max = {2.0,0.6,-0.9}},
		Flags = {"SoftParticles"},
        
        Number = {{0, 1.5}, {lifeTime, 1.5}, {lifeTime, 0}, {20*lifeTime, 0}},
--      NumberRate  = {{-8, 1}, {-5, 0}},
        Life = {{0.0, 3.2}},
        
		ShaderParams = {{0, {1.7,0,0,0}, {1.7,0,0,0}}},

        Velocity = {{0, {0, 0.6, 0}, {0, 1.5, 0}}},
        VelocityOverLife = { {0,0} , {0.16, 0.15}, {0.33,1}, {0.4,1}, {1.0,1.7}},
		
        Size = {{0.0, 1.9}, {1.0, 2.1}},
        SizeOverLife = {{0.6, 2} , {1, 0.1}},
		
		ParentVelocity = { {0, 0.5} },
		Windage = { {0, 0.3} },
				
		RedOverLife =   {{0, 1.0*1.2}, {1, 1.0}},
        GreenOverLife = {{0, 0.65*1.2}, {1, 0.7}},
        BlueOverLife = {{0, 0.4*1.2}, {1, 0.4}},
		
        AlfaOverLife = {{0.0, 0}, {0.4, 1.2}, {1, 0}},
    },
	{
        Name = "Blast1",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"SoftParticles"},
		InitPositionBox = {Min = {0,-2,0}, Max = {0,-2,0}},
        Number = {{0, 1200}, {0.06, 1200}, {0.07, 0}, {20*lifeTime, 0}},
        Life = {{0.0, 4}},
        
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

        Velocity = {{0, {14, 0.5, 14}, {-14, 1, -14}}},
        VelocityOverLife = { {0, 25}, {0.03, 0.2}, {1, 0.1}},

		ParentVelocity = { {0, 0.15} },
		Windage = { {0, 0.4}},
		
		Size = {{0, 11}, {1, 12}},
        SizeOverLife = {{0, 0.2}, {0.03, 1}, {1, 3}},

        RedOverLife =   {{0, 0.35}, {0.35, 0.44}},
        GreenOverLife = {{0, 0.31}, {0.35, 0.4}},
        BlueOverLife = {{0, 0.23}, {0.35, 0.32}},
        AlfaOverLife = {{0, 0}, {0.03, 1}, {1, 0}},
    },
	{
        Name = "Smoke1",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"SoftParticles"},
		InitPositionBox = {Min = {-1.8, 0, -0.6}, Max = {1.8, 0.5, 0.6}},
        Number = {{2, 0}, {3, 1.5}, {0.5*lifeTime-4, 1.5}, {0.5*lifeTime+4, 0}, {20*lifeTime, 0}},
--        NumberRate  = {{-2, 1}, {0, 0.33}},
        Life = {{0.0, 6.0*smokeLifeC}, {1.0, 12.0*smokeLifeC}},
        
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

		RadialVelocity = {{0, 1}},
        Velocity = {{0, {1.3, 10, 1.3}, {-1.3, 12, -1.3}}},
        VelocityOverLife = { {0, 0.8}, {0.5, 0.8}, {0.8, 1.2}, {1, 2.5}},
--		Acceleration = {{0.0, {0.0, -0.1, 0.0}, {0.0, 0.1, 0.0}}},

		ParentVelocity = { {0, 0.15} },
		Windage = { {0, 0.4} },
		
		Size = {{0.0, 35}, {1.0, 40}},
        SizeOverLife = {{0, 0.6}, {0.6, 3}, {0.8, 6}, {1, 10}},
--		Weight = { {0, 10} },
--		WeightOverLife = {{0, 0}, {0.5, 10}, {1, 0}},
		Spin = {{0, 1}},
		SpinOverLife = {{0, 1}, {1, -0.6}},

        RedOverLife =   {{0, 0.32}, {0.3, 0.36}, {0.7, 0.46}},
        GreenOverLife = {{0, 0.34}, {0.3, 0.38}, {0.7, 0.48}},
        BlueOverLife = {{0, 0.38}, {0.3, 0.42}, {0.7, 0.52}},
        AlfaOverLife = {{0, 0}, {0.005, 1}, {0.5, 0.8}, {0.92, 0.06}, {1, 0}},
    },
	{
        Name = "Smoke2",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"SoftParticles"},
		InitPositionBox = {Min = {-1.8, 6, -0.6}, Max = {1.8, 7, 0.6}},
        Number = {{0, 0}, {0.5*lifeTime-4, 0}, {0.5*lifeTime+4, 1.5}, {lifeTime-4, 1.5}, {lifeTime+4, 0}, {20*lifeTime, 0}},
--        NumberRate  = {{-2, 1}, {0, 0.33}},
        Life = {{0.0, 5.5*smokeLifeC}, {1.0, 12.5*smokeLifeC}},
        
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

		RadialVelocity = {{0, 1}},
        Velocity = {{0, {1.3, 9.8, 1.3}, {-1.3, 11.8, -1.3}}},
        VelocityOverLife = { {0, 0.8}, {0.5, 0.8}, {0.8, 1.2}, {1, 2.5}},

		ParentVelocity = { {0, 0.15} },
		Windage = { {0, 0.6} },
		
		Size = {{0.0, 32}, {1.0, 40}},
        SizeOverLife = {{0, 0.6}, {0.6, 3}, {0.8, 6}, {1, 10}},
		Spin = {{0, 1}},
		SpinOverLife = {{0, 0.8}, {1, -0.5}},

        RedOverLife =   {{0, 0.33}, {0.25, 0.47}},
        GreenOverLife = {{0, 0.35}, {0.25, 0.49}},
        BlueOverLife = {{0, 0.39}, {0.25, 0.53}},
        AlfaOverLife = {{0, 0}, {0.01, 0.8}, {0.5, 0.6}, {0.8, 0.05}, {1, 0}},
    },
	{
        Name = "Smoke3",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"SoftParticles"},
		InitPositionBox = {Min = {-1.8, 0.2, -0.6}, Max = {1.8, 0.4, 0.6}},
        Number = {{0, 0}, {lifeTime-4, 0}, {lifeTime+4, 1.4}, {2*lifeTime-4, 1.4}, {2*lifeTime+4, 0}, {20*lifeTime, 0}},
--        NumberRate  = {{-2, 1}, {0, 0.33}},
        Life = {{0.0, 5.0*smokeLifeC}, {1.0, 13.0*smokeLifeC}},
        
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

		RadialVelocity = {{0, 1}},
        Velocity = {{0, {1.3, 9.6, 1.3}, {-1.3, 11.6, -1.3}}},
        VelocityOverLife = { {0, 0.7}, {0.5, 0.8}, {0.8, 1.2}, {1, 2.5}},

		ParentVelocity = { {0, 0.15} },
		Windage = { {0, 0.8} },
		
		Size = {{0.0, 30}, {1.0, 40}},
        SizeOverLife = {{0, 0.5}, {0.7, 3.0}, {0.8, 6}, {1, 10}},
		Spin = {{0, 1}},
		SpinOverLife = {{0, 0.6}, {1, -0.4}},

        RedOverLife =   {{0, 0.34}, {0.25, 0.48}},
        GreenOverLife = {{0, 0.36}, {0.25, 0.5}},
        BlueOverLife = {{0, 0.4}, {0.25, 0.54}},
        AlfaOverLife = {{0, 0}, {0.01, 0.8}, {0.8, 0.05}, {1, 0}},
    },
	{
        Name = "Smoke4",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"SoftParticles"},
		InitPositionBox = {Min = {-1.8, 0, -0.6}, Max = {1.8, 0.2, 0.6}},
        Number = {{0, 0}, {2*lifeTime-4, 0}, {2*lifeTime+4, 1.2}, {4*lifeTime-4, 1.2}, {4*lifeTime+4, 0}, {20*lifeTime, 0}},
--       NumberRate  = {{-2, 1}, {0, 0.33}},
        Life = {{0.0, 4.5*smokeLifeC}, {1.0, 13.5*smokeLifeC}},
        
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

		RadialVelocity = {{0, 1}},
        Velocity = {{0, {1.3, 9.4, 1.3}, {-1.3, 11.4, -1.3}}},
        VelocityOverLife = { {0, 0.6}, {0.5, 0.7}, {0.8, 1.2}, {1, 2.5}},

		ParentVelocity = { {0, 0.15} },
		Windage = { {0, 1.0} },
		
		Size = {{0.0, 30}, {1.0, 40}},
        SizeOverLife = {{0, 0.5}, {0.65, 3.0}, {0.8, 6}, {1, 10}},
		Spin = {{0, 1}},
		SpinOverLife = {{0, 0.6}, {1, -0.4}},

        RedOverLife =   {{0, 0.35}, {0.25, 0.49}},
        GreenOverLife = {{0, 0.37}, {0.25, 0.51}},
        BlueOverLife = {{0, 0.41}, {0.25, 0.55}},
        AlfaOverLife = {{0, 0}, {0.01, 0.7}, {0.8, 0.04}, {1, 0}},
    },
	{
        Name = "Smoke5",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"SoftParticles"},
		InitPositionBox = {Min = {-1.8, 0, -0.6}, Max = {1.8, 0, 0.6}},
        Number = {{0, 0}, {4*lifeTime-4, 0}, {4*lifeTime+4, 1}, {10*lifeTime-4, 1}, {10*lifeTime+4, 0}, {20*lifeTime, 0}},
--        NumberRate  = {{-2, 1}, {0, 0.33}},
        Life = {{0.0, 4.0*smokeLifeC}, {1.0, 14.0*smokeLifeC}},
        
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

		RadialVelocity = {{0, 1}},
        Velocity = {{0, {1.3, 9.2, 1.3}, {-1.3, 11.2, -1.3}}},
        VelocityOverLife = { {0, 0.6}, {0.5, 0.7}, {0.8, 1.2}, {1, 2.5}},

		ParentVelocity = { {0, 0.15} },
		Windage = { {0, 1.2} },
		
		Size = {{0.0, 28}, {1.0, 38}},
        SizeOverLife = {{0, 0.45}, {0.6, 3.0}, {0.8, 6}, {1, 10}},
		Spin = {{0, 1}},
		SpinOverLife = {{0, 0.6}, {1, -0.4}},

        RedOverLife =   {{0, 0.36}, {0.25, 0.50}},
        GreenOverLife = {{0, 0.38}, {0.25, 0.52}},
        BlueOverLife = {{0, 0.42}, {0.25, 0.56}},
        AlfaOverLife = {{0, 0}, {0.01, 0.6}, {0.8, 0.04}, {1, 0}},
    },
}

local lb = 1.2
local df = 0.5 -- dist factor
Lights =
{
	{
		--offset = {0,4.5,0},
		--color = {{0, {1*lb, 0.6*lb, 0.2*lb}}, {0.3, {0.8*lb, 0.5*lb, 0.1*lb}}, {0.4, {1*lb, 0.6*lb, 0.2*lb}}},
		--distance = {{0, 120*df}, {1.5, 155*df}, {3, 110*df}},
	},
}

Lods = 
{
	[1] = 
	{
		Distance = 3000,
		Emitters = 
		{
			["Fire1"] = 
			{			
				Flags = {'Disable'},
			},
			["Fire2"] = 
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
			["Fire1"] = 
			{			
				Flags = {'Disable'},
			},
			["Fire2"] = 
			{		
				Flags = {'Disable'},
			},
		}
	},
}