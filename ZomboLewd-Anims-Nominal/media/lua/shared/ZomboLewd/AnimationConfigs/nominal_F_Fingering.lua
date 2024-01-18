require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "Nominal_",
	id = "Fingering",
	tags = {"Masturbation", "Solo", "Standing"},
	actors = {
		{
			gender = "Female",
			stages = {
				{
					perform = "nominal_F_RegularFingering",
					duration = 150
				},
                {
					perform = "nominal_F_RelaxedFingering",
					duration = 900
				},
                {
					perform = "nominal_F_QuickFingering",
					duration = 300
				}
			}
		},
	}
})