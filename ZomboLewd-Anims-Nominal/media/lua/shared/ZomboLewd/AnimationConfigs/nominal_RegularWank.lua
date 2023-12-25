require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "Nominal_",
	id = "Regular_Wank",
	tags = {"Masturbation", "Solo"},
	actors = {
		{
			gender = "Male",
			stages = {
				{
					perform = "nominal_RegularWank",
					duration = 750
				}
			}
		},
	}
})