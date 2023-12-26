---@author QueuedResonance 2022

local Animations = {}

local ZomboLewdAnimationData = ZomboLewdAnimationData

local string = string
local pairs = pairs
local type = type

---@alias ActorData
---| {object: IsoPlayer, role:"Giver"|"Receiver"|nil, criteria:table<string, boolean>[]|nil}[]

--- Returns the first occurrence of this element, if not, returned nil
---@param list any[] array of the list to search the element in
---@param element any the object to search for in the list
function Animations:tableFind(list, element)
	for i = 1, #list do
		local item = list[i]
		if item == element then
			return item
		end
	end
end


---@param actorData ActorData
---@param animationData ZLAnimationData
---@return number[]|nil -- map of actors to positions in animation, return nil if cannot fit
function Animations:FitActorsToAnimation(actorData, animationData)
	--- Cache the available actor positions
	local availablePositions = {} do
		for i, _ in ipairs(animationData.actors) do
			table.insert(availablePositions, i)
		end
	end

	local actorToPosition = {}

	for actor_i, actor in ipairs(actorData) do
		local isFemale = actor.object:isFemale()
		local bestRoleData = {
			i = nil,
			metric = -1,
		}

		-- Ran out of positions to look for
		if #availablePositions == 0 then
			return nil
		end

		--- Check for a valid position in the animation dependent on gender
		for _, i in ipairs(availablePositions) do
			local position = animationData.actors[i]

			-- Flag to use/discard position
			local canUsePosition = true

			-- Check if position is a best fit
			local metric = 0

			--- If its a male animation, prevent them from using this position if female
			if isFemale and position.gender == "Male" then
				canUsePosition = false
			end

			-- Don't use position if role mismatches
			if actor.role and position.role then
				if actor.role == position.role then
					metric = 100
				else
					canUsePosition = false
				end
			end

			if canUsePosition then
				if position.criteria then
					for _, criterion in ipairs(position.criteria) do
						if actor.criteria and actor.criteria[actor_i][criterion] then
							metric = metric + 1
						end
					end
				end

				-- Pick this position if its better
				if metric > bestRoleData.metric then
					bestRoleData.metric = metric
					bestRoleData.i = i
				end
			end
		end
		-- No suitable roles found
		if bestRoleData.i == nil then
			return nil
		end
		-- Select best position for actor
		actorToPosition[actor_i] = bestRoleData.i
		table.remove(availablePositions, bestRoleData.i)
	end

	return actorToPosition
end

--- Returns a list of viable animations to fetch depending on factors listed below
---@param actorData ActorData 
---@param tagsToSearch? string[] an array of tags used to return animations containing them (ie. {"Missionary", "Doggystyle"} will return all animations with these tags)
---@param tagsBlacklist? string[] an array of tags used to ignore animations with these tags (ie. {"Aggressive", "Oral"} will ignore animations with these tags)
---@param allTagsRequired? boolean defaults to true, all tags in tagsToSearch must be valid in the animation to be returned, false will return the animation if one tag is valid
---@return {animation: ZLAnimationData, actorToPosition: number[]}[]
function Animations:getAnimations(actorData, tagsToSearch, tagsBlacklist, allTagsRequired)
	tagsToSearch = tagsToSearch or {}
	tagsBlacklist = tagsBlacklist or {}
	allTagsRequired = allTagsRequired or true

	local viableAnimations = {}

	--- Loop through all the animations
	for i = 1, #ZomboLewdAnimationData do
		local animation = ZomboLewdAnimationData[i]
		local tags = animation.tags
		local tagsFound = 0
		local canAdd = true

		--- See if it contains any blacklisted tags, ignore this animation if it does
		for tagBlacklistIndex = 1, #tagsBlacklist do
			if Animations:tableFind(tags, tagsBlacklist[tagBlacklistIndex]) then
				canAdd = false
				break
			end
		end

		--- Check if this animation contains the tags
		for tagSearchIndex = 1, #tagsToSearch do
			local tagSearch = tagsToSearch[tagSearchIndex]
			if Animations:tableFind(tags, tagSearch) then
				tagsFound = tagsFound + 1
			end
		end

		--- Check if allTagsRequired is true
		if allTagsRequired then
			if tagsFound < #tagsToSearch then
				canAdd = false
			end
		end

		local actorToPosition = self:FitActorsToAnimation(actorData, animation)
		if actorToPosition == nil then
			canAdd = false
		end

		if canAdd then
			table.insert(viableAnimations, {
				animation = animation,
				actorToPosition = actorToPosition,
			})
		end
	end

	return viableAnimations
end

--- Returns a list of viable animations to fetch depending on factors listed below
---@param list unknown the animation list, usually Animations.Client.Animations
---@param isFemale boolean is it le... female?
---@param isConsensual boolean is the act consensual
---@param isZombie boolean can this act be used with zombies
function Animations:getZLAnimations(list, isFemale, isConsensual, isZombie)
	local viableAnimations = {}

	for _, animation in ipairs(list) do
		local data = ZomboLewdAnimationData[animation]

		if data then
			local canAdd = true

			--- Check if the animations are gender compatible
			if isFemale then
				if not data.Animations.Female then
					canAdd = false
				end
			else
				if not data.Animations.Male then
					canAdd = false
				end
			end

			--- Check if the animations can be used with zombie
			if isZombie ~= nil and isZombie ~= data.IsZombieAllowed then
				canAdd = false
			end

			--- Check if the animations are consensual
			if isConsensual ~= nil and isConsensual ~= data.IsConsensual then
				canAdd = false
			end

			if canAdd then
				table.insert(viableAnimations, {Key = animation, Data = data})
			end
		end
	end

	return viableAnimations
end

return Animations