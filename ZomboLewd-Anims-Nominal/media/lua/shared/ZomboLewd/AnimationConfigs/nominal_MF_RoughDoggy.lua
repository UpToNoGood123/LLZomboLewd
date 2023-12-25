require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "Nominal_",
	id = "Rough_Doggy",
	tags = {"Intercourse", "MF", "Anal", "Doggy", "Rough", "Sex"},
	actors = {
		{
			criteria = {"bottom"},
			stages = {
				{
					perform = "nominal_MF_RoughDoggy_F",
					duration = 1000
				}
			}
		},
		{
			gender = "Male",
			criteria = {"top"},
			stages = {
				{
					perform = "nominal_MF_RoughDoggy_M",
					duration = 1000
				}
			}
		}

	}
})