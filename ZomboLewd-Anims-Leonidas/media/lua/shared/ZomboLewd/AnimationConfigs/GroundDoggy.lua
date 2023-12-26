require "ZomboLewd/ZomboLewdConfig" --- Always include this at the top to forceload ZomboLewd prior to this animation file

table.insert(ZomboLewdAnimationData, {
	prefix = "Leonidas_",
	id = "Doggy",
	tags = {"Doggy", "Sex", "MF", "Vaginal", "Anal", "Defeated"},
	actors = {
		{
			role = "Receive",
			stages = {
				{
					perform = "GroundDoggyF",
					duration = 1000
				}
			}
		},
		{
			gender = "Male",
			role = "Give",
			stages = {
				{
					perform = "GroundDoggyM",
					duration = 1000
				}
			}
		}
	}
})