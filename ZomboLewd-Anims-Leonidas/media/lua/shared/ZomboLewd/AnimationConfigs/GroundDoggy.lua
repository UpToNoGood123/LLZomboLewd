require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "Leonidas_",
	id = "Doggy",
	tags = {"Doggy", "Sex", "MF", "Vaginal", "Anal", "Defeated"},
	actors = {
		{
			criteria = {"bottom"},
			stages = {
				{
					perform = "GroundDoggyF",
					duration = 1000
				}
			}
		},
		{
			gender = "Male",
			criteria = {"top"},
			stages = {
				{
					perform = "GroundDoggyM",
					duration = 1000
				}
			}
		}
	}
})