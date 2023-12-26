require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "ZomboLewd_",
	id = "Blowjob",
	tags = {"Oral", "Sex", "MF", "Blowjob"},
	actors = {
		{
			role = "Give",
			stages = {
				{
					perform = "StandingBJF",
					duration = 1000
				}
			}
		},
		{
			gender = "Male",
			role = "Receive",
			stages = {
				{
					perform = "StandingBJM",
					duration = 1000
				}
			}
		}
	}
})