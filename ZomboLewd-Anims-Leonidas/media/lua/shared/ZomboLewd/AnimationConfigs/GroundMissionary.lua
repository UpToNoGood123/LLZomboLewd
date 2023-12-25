require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "ZomboLewd_",
	id = "GroundMissionary",
	tags = {"Missionary", "Sex", "MF", "Vaginal", "Anal", "Defeated"},
	actors = {
		{
			criteria = {"bottom"},
			stages = {
				{
					perform = "GroundMissionaryF",
					duration = 1000
				}
			}
		},
		{
			gender = "Male",
			criteria = {"top"},
			stages = {
				{
					perform = "GroundMissionaryM",
					duration = 1000
				}
			}
		}
	}
})