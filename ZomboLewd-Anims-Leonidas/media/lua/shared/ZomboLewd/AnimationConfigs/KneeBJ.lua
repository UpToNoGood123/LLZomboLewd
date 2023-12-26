require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "ZomboLewd_",
	id = "KneeBJ",
	tags = {"Oral", "Sex", "MF", "Blowjob"},
	actors = {
		{
			role = "Give",
			stages = {
				{
					perform = "KneeBJF",
					duration = 1000
				}
			}
		},
		{
			gender = "Male",
			role = "Receive",
			stages = {
				{
					perform = "KneeBJM",
					duration = 1000
				}
			}
		}
	}
})