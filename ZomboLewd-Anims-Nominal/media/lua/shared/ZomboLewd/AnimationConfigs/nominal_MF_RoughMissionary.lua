require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "Nominal_",
	id = "Rough_Missionary",
	tags = {"Intercourse", "MF", "Vaginal", "Missionary", "Rough", "Sex"},
	actors = {
		{
			gender = "Female",
			role = "Receive",
			stages = {
				{
					perform = "nominal_MF_RoughMissionary_F",
					duration = 1000
				}
			}
		},
		{
			gender = "Male",
			role = "Give",
			stages = {
				{
					perform = "nominal_MF_RoughMissionary_M",
					duration = 1000
				}
			}
		}

	}
})