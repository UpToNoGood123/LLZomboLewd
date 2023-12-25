require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "ZomboLewd_",
	id = "KneeBJ",
	tags = {"Blowjob", "Sex", "MF"},
	actors = {
		{
			criteria = {"bottom"},
			stages = {
				{
					perform = "KneeBJF",
					duration = 1000
				}
			}
		},
		{
			gender = "Male",
			criteria = {"top"},
			stages = {
				{
					perform = "KneeBJM",
					duration = 1000
				}
			}
		}
	}
})