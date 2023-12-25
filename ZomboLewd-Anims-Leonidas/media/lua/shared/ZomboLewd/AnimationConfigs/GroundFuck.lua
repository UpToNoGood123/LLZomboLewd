require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "ZomboLewd_",
	id = "GroundFuck",
	tags = {"GroundFuck", "Sex", "MF", "Vaginal", "Anal", "Defeated"},
	actors = {
		{
			criteria = {"bottom"},
			stages = {
				{
					perform = "GroundFuckF",
					duration = 1000
				}
			}
		},
		{
			gender = "Male",
			criteria = {"top"},
			stages = {
				{
					perform = "GroundFuckM",
					duration = 1000
				}
			}
		}
	}
})