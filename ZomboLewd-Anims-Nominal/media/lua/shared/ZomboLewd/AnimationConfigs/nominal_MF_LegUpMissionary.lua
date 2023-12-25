require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "Nominal_",
	id = "Leg_Up_Missionary",
	tags = {"Intercourse", "MF", "Vaginal", "Missionary", "LegUp", "Sex"},
	actors = {
		{
			gender = "Female",
			stages = {
				{
					perform = "nominal_MF_LegUpMissionary_F",
					duration = 900
				}
			}
		},
		{
			gender = "Male",
			stages = {
				{
					perform = "nominal_MF_LegUpMissionary_M",
					duration = 900
				}
			}
		}

	}
})