require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "ZomboLewd_",
	id = "Oral",
	tags = {"Oral", "Sex", "MF"},
	actors = {
		{
			criteria = {"Give"},
			stages = {
				{
					perform = "StandingBJF",
					duration = 1000
				}
			}
		},
		{
			gender = "Male",
			criteria = {"Receive"},
			stages = {
				{
					perform = "StandingBJM",
					duration = 1000
				}
			}
		}
	}
})