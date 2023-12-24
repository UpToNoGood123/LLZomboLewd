require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "Nominal_",
	id = "Sitting_Regular_Wank",
	tags = {"Masturbation", "Solo", "Relaxed", "Sitting"},
	actors = {
		{
			gender = "Male",
			stages = {
				{
					perform = "nominal_SittingRegularWank",
					duration = 750
				}
			}
		},
	}
})