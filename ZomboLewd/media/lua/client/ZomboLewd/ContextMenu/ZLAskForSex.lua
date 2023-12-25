--- Handles asking for sex with players and NPCs
---@author QueuedResonance 2022


local ISWorldObjectContextMenu = ISWorldObjectContextMenu
local ISContextMenu = ISContextMenu
local ISToolTip = ISToolTip

local getText = getText
local string = string

local roles = {
	"Give",
	"Receive"
}

local positions = {
	"Blowjob",
	"Vaginal",
	"Anal",
}

--- Activates when the player clicks ask for seks on the chosen target
---@param worldobjects table of world objects nearby the player
---@param contextMenu any injected from ZomboLewdContextMenu, can access ZomboLewd functionalities with this
---@param requestor IsoPlayer of the player
---@param target IsoPlayer of the asked target
---@param playerRole "Give"|"Receive"
local function onAskForSex(worldobjects, contextMenu, requestor, target, tags, playerRole)
	local isMainHeroFemale = requestor:isFemale()
	local isTargetFemale = target:isFemale()
	local maleCount, femaleCount = 0, 0

	if isMainHeroFemale and isTargetFemale then
		--- Lesbian
		maleCount = 0
		femaleCount = 2
	elseif isMainHeroFemale == false and isTargetFemale == false then
		--- Gay
		maleCount = 2
		femaleCount = 0
	else
		--- Straight
		maleCount = 1
		femaleCount = 1
	end

	table.insert(tags, "Sex")

	local tagBlacklist = {"Defeated"}

	local criteria = {
		[1] = {}, -- requestor (i.e., player)
		[2] = {} -- target
	}
	local targetRole = (playerRole == "Give") and "Receive" or "Give"
	criteria[1][playerRole] = true
	criteria[2][targetRole] = true

	--- Choose random animation as a test
	local animationList = contextMenu.Client.AnimationUtils:getAnimations(2, maleCount, femaleCount, tags, tagBlacklist, true)
	if #animationList == 0 then
		print(string.format("ZomboLewd - Could not find animations"))
		return
	end

	local index = ZombRand(1, #animationList + 1)
	local chosenAnimation = animationList[index]


	contextMenu.Client.AnimationHandler.Play(worldobjects, {requestor, target}, chosenAnimation, nil, nil, nil, criteria)
end

--- Creates a ask for seks context menu
---@param ContextMenu unknown injected from ZomboLewdContextMenu, can access ZomboLewd functionalities with this
---@param playerObj IsoPlayer
---@param context unknown menu object to be filled for
---@param worldobjects table of world objects nearby the player
return function(ContextMenu, playerObj, context, worldobjects)
	if not ZomboLewdConfig.ModOptions.options.box1 then return end

	local player = playerObj:getPlayerNum()

	--- Activate native fetch function to determine if our mouse selected a square containing an IsoPlayer
	ISWorldObjectContextMenu.clearFetch()
	for _, v in ipairs(worldobjects) do
		ISWorldObjectContextMenu.fetch(v, player, true)
	end

	--- Check if we have moused over a IsoPlayer
	if not clickedPlayer then return end

	--- Create "Ask for Sex" option
	local optionAskForSex = context:addOption(getText("ContextMenu_Ask_For_Sex"), worldobjects)

	-- Nest Role options within "Ask for Sex"
	local menuRole = ISContextMenu:getNew(context)
	context:addSubMenu(optionAskForSex, menuRole)

	-- Add role options
	for _, role in ipairs(roles) do
		local optionRole = menuRole:addOption(getText("ContextMenu_" .. role), worldobjects)
		local menuPosition = ISContextMenu:getNew(context)
		context:addSubMenu(optionRole, menuPosition)

		-- For each role, nest Position options
		for _, position in ipairs(positions) do
			local optionPosition = menuPosition:addOption(getText("ContextMenu_" .. position), worldobjects, onAskForSex, ContextMenu, playerObj, clickedPlayer, {position}, role)

			-- Block vaginal option if both characters are male
			-- or if receiver is male
			-- or if giver is female
			-- Better to build a table of options dependent on the genders rather than account for it after
			if position == "Vaginal" then
				if not playerObj:isFemale() and not clickedPlayer:isFemale() or
				   role == "Receive" and not playerObj:isFemale() or
				   role == "Give" and playerObj:isFemale()
				then
					optionPosition.notAvailable = true
				end
			end
		end
	end
end