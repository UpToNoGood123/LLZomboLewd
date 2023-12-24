require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "Nominal_",
	id = "Defeated_Missionary",
	tags = {"Intercourse", "MF", "Vaginal", "Missionary", "Defeated", "Sex"},
	actors = {
		{
			gender = "Female",
			stages = {
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
					perform = "nominal_MF_DefeatedMissionary_M",
					duration = 1000
				}
			}
		}

	}
})