require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "ZomboLewd_",
	id = "GroundMissionary",
	tags = {"Missionary", "Sex", "MF", "Vaginal", "Anal", "Defeated"},
	actors = {
		{
			role = "Receive",
			stages = {
				{
					perform = "GroundMissionaryF",
					duration = 1000
				}
			}
		},
		{
			gender = "Male",
			role = "Give",
			stages = {
				{
					perform = "GroundMissionaryM",
					duration = 1000
				}
			}
		}
	}
})