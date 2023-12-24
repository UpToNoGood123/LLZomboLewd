require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "ZomboLewd_",
	id = "Blowjob",
	tags = {"Blowjob", "Sex", "MF"},
	actors = {
		{
			criteria = {"bottom"},
			stages = {
				{
					perform = "StandingBJF",
					duration = 1000
				}
			}
		},
		{
			gender = "Male",
			criteria = {"top"},
			stages = {
				{
					perform = "StandingBJM",
					duration = 1000
				}
			}
		}
	}
})