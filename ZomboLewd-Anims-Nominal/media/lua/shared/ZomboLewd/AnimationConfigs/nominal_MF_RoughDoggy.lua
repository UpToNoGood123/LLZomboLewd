require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "Nominal_",
	id = "Rough_Doggy",
	tags = {"Receive_Vaginal", "Give_Vaginal", "Intercourse", "MF", "Anal", "Doggy", "Rough", "Sex"},
	actors = {
		{
			stages = {
				{
					perform = "nominal_MF_RoughDoggy_F",
					duration = 1000
				},
				{
					perform = "nominal_MF_LegUpMissionary_F",
					duration = 900
				},
				{
					perform = "nominal_MF_DefeatedMissionary_F",
					duration = 1000
				}
			}
		},
		{
			gender = "Male",
			stages = {
				{
					perform = "nominal_MF_RoughDoggy_M",
					duration = 1000
				},
				{
					perform = "nominal_MF_LegUpMissionary_M",
					duration = 900
				},
				{
					perform = "nominal_MF_DefeatedMissionary_M",
					duration = 1000
				}
			}
		}

	}
})