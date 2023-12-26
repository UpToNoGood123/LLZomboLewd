ZomboLewdConfig = {
	CommandName = "ZomboLewd",
	IconImageExtension = ".png",
	DefaultSexDuration = 300,
	Modules = {},
}

---@alias ZLAnimationData
---| {prefix: string, id: string, tags: string[], actors: {gender: "Male"|"Female"|nil, role: "Giver"|"Receiver"|nil, criteria: string[],stages:{perform: string, duration:number}[]}[]}

---@type ZLAnimationData[]
ZomboLewdAnimationData = {}