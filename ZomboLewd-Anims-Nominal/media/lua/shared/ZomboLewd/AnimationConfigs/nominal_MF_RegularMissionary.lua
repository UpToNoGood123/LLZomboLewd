require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "Nominal_",
	id = "Regular_Missionary",
	tags = {"Intercourse", "MF", "Vaginal", "Missionary", "Regular", "Sex"},
	actors = {
		{
			gender = "Female",
			stages = {
				{
					perform = "nominal_MF_RegularMissionary_F",
					duration = 900
				}
			}
		},
		{
			gender = "Male",
			stages = {
				{
					perform = "nominal_MF_RegularMissionary_M",
					duration = 900
				}
			}
		}

	}
})