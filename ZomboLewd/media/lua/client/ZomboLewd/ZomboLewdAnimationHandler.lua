--- Animation handler for all lewd things
--- future todo task for me in the far future: have support for 3somes, 4somes, possibly more if we want to be extra steamy
---@author QueuedResonance

require "TimedActions/ISBaseTimedAction"

-- Initialize external tables
local AnimationHandler = {EventMarkerModules = {}, ActionEvents = {Perform = {}, WaitToStart = {}, Start = {}, Stop = {}, Update = {}}}

local ZomboLewdConfig = ZomboLewdConfig
local ZomboLewdAnimationData = ZomboLewdAnimationData
local ISBaseTimedAction = ISBaseTimedAction
local ISTimedActionQueue = ISTimedActionQueue

local luautils = luautils
local ignoredKeyframeNames = {}

local ipairs = ipairs

---@class ZLAnimationAction : ISBaseTimedAction
---@field animation unknown
---@field ignoreHandsWounds boolean
---@field duration integer
---@field ended unknown
---@field currentStage number
---@field originalPosition {x: number, y: number, z: number}
---@field originalActor IsoPlayer
---@field position {x: number, y: number, z: number}
---@field facing IsoDirections
---@field waitingStarted boolean
---@field callbacks {WaitToStart: fun(action: ZLAnimationAction), Update: fun(action: ZLAnimationAction), Perform: fun(action: ZLAnimationAction), Stop: fun(action: ZLAnimationAction), Start: fun(action: ZLAnimationAction)}
---@field otherActions ZLAnimationAction[]
---@field isFinalStage boolean
---@field originalTurnDelta float
ISAnimationAction = ISBaseTimedAction:derive("ISZomboLewdAnimationAction")

--- Plays an animation using the given animation data
---@param worldobjects? unknown[] an array of all nearby objects, usually returned through a contextMenu
---@param actors IsoPlayer[] an array of actors to be played in this scene. Must be IsoPlayer types. First actor will usually be the position where the act takes place
---@param animationData unknown the animation object passed from AnimationUtils:getAnimations()
---@param disableCancel? boolean: prevents cancellation of this action if set to true (for example, non-consensual actions)
---@param disableWalk? boolean: disables the initial walk of the animation (actors will teleport to eachother instantly for the scene)
---@param callbacks? {WaitToStart: fun(action: ZLAnimationAction), Update: fun(action: ZLAnimationAction), Perform: fun(action: ZLAnimationAction), Stop: fun(action: ZLAnimationAction), Start: fun(action: ZLAnimationAction)}
---@param slotCriteria? table<string, boolean>[]
function AnimationHandler.Play(worldobjects, actors, animationData, disableCancel, disableWalk, callbacks, slotCriteria)
	disableWalk = disableWalk or false

	if #actors < 1 then return end
	if not disableWalk then
		for _, actor in ipairs(actors) do
			if actor ~= actors[1] then
				if not luautils.walkAdj(actor, actors[1]:getSquare(), true) then
					return
				end
			end
		end
	end

	disableCancel = disableCancel or false

	--- Get the position of the original character, then get the facing position of the second character
	local x, y, z = actors[1]:getX(), actors[1]:getY(), actors[1]:getZ()
	local facing = actors[1]:getDir()
	local otherActions = {}

	--- Cache the available actor positions
	local availablePositions = {} do
		for _, actor in ipairs(animationData.actors) do
			table.insert(availablePositions, actor)
		end
	end

	for actor_i, actor in ipairs(actors) do
		local isFemale = actor:isFemale()
		local bestRole
		local bestRoleData = {
			i = 0,
			metric = -1,
		}
		
		--- Check for a valid position in the animation dependent on gender
		for i = #availablePositions, 1, -1 do
			local canUsePosition = true

			--- If its a male animation, prevent them from playing this animation if female
			if isFemale and availablePositions[i].gender == "Male" then
				canUsePosition = false
			end

			if canUsePosition then
				-- Check if position is a best fit
				local metric = 0
				for _, criteria in ipairs(availablePositions[i].criteria) do
					if slotCriteria and slotCriteria[actor_i][criteria] then
						metric = metric + 1
					end
				end

				-- Pick this position if its better
				if metric > bestRoleData.metric then
					bestRoleData.metric = metric
					bestRoleData.i = i
				end
			end
		end

		-- Select best position for actor
		bestRole = table.remove(availablePositions, bestRoleData.i)

		for j, stage in ipairs(bestRole.stages) do
			otherActions[j] = otherActions[j] or {}

			--- Create animation data
			local action = ISAnimationAction:new(actor, stage.perform, stage.duration)
			action.currentStage = j
			action.originalPosition = {x = actor:getX(), y = actor:getY(), z = actor:getZ()}
			action.originalActor = actors[1]
			action.position = {x = x, y = y, z = z}
			action.facing = #actors > 1 and facing
			action.waitingStarted = false
			action.callbacks = callbacks
			action.otherActions = #actors > 1 and otherActions[j]
			action.isFinalStage = j == #bestRole.stages -- assumes every actor has the same number of stages
			action.originalTurnDelta = actor:getTurnDelta()

			if disableCancel == true then
				action.stopOnRun = false
				action.stopOnAim = false
			end

			table.insert(otherActions[j], action)
			
			if disableWalk then
				ISTimedActionQueue.clear(action.character)
			end
			
		end
	end
	
	--- Activate the animations simultaneously
	for i, stage in ipairs(otherActions) do
		for j, action in ipairs(stage) do
			ISTimedActionQueue.add(action)
		end
	end

	-- return otherActions
end

function ISAnimationAction:isValid()
	--- Make sure to keep the TimedAction running
	return true
end

function ISAnimationAction:waitToStart()
	--- false = starts the timedaction
	--- true = delay the timedaction

	local continueWaiting = self.character:shouldBeTurning()
	-- self.character:setTurnDelta(1000)
	
	--- Check if other characters are still turning towards the original actor
	if self.otherActions then
		local otherActionLength = #self.otherActions
		
		if otherActionLength > 1 then
			for i = 1, otherActionLength do
				local otherAction = self.otherActions[i]
				
				--- Wait till the other actors has finished their turning
				if otherAction.character ~= self.character then
					-- self.character:faceThisObject(otherAction.character)
					self.character:setDir(self.facing)
				
					if(otherAction.waitingStarted == false or otherAction.character:shouldBeTurning() == true) then
						continueWaiting = true
					end
				end
			end
		end
	end

	if self.callbacks then
		if self.callbacks.WaitToStart then
			self.callbacks.WaitToStart(self)
		end
	end

	--- Activate ActionEvents
	for i = 1, #AnimationHandler.ActionEvents.WaitToStart do
		AnimationHandler.ActionEvents.WaitToStart[i](self)
	end

	self.waitingStarted = true

	return continueWaiting
end

function ISAnimationAction:update()
	--- Runs every frame during the animations
	if self.facing then
		self.character:setDir(self.facing)
	end

	if self.position then
		self.character:setX(self.position.x)
		self.character:setY(self.position.y)
		self.character:setZ(self.position.z)
	end

	if self.callbacks then
		if self.callbacks.Update then
			self.callbacks.Update(self)
		end
	end

	--- Activate ActionEvents
	for i = 1, #AnimationHandler.ActionEvents.Update do
		AnimationHandler.ActionEvents.Update[i](self)
	end

	--- Check if the other actor somehow got a bugged action
	if self.otherActions then
		for i = 1, #self.otherActions do
			local otherAction = self.otherActions[i]
			if otherAction.character ~= self.character and not ISTimedActionQueue.hasAction(otherAction) then
				self:forceStop()
			end
		end
	end

	if not self.character:getCharacterActions():contains(self.action) then
		self:forceStop()
	end
end

function ISAnimationAction:perform()
	--- What happens once the timedaction completes?
	if self.otherActions then
		for i = 1, #self.otherActions do
			if self.otherActions[i].character ~= self.character then
				self.otherActions[i]:forceComplete()
			end
		end
	end

	if self.originalPosition then
		self.character:setX(self.originalPosition.x)
		self.character:setY(self.originalPosition.y)
		self.character:setZ(self.originalPosition.z)
	end

	self.character:getModData().zomboLewdSexScene = nil

	if self.callbacks then
		if self.callbacks.Perform then
			self.callbacks.Perform(self)
		end
	end

	--- Activate ActionEvents
	for i = 1, #AnimationHandler.ActionEvents.Perform do
		AnimationHandler.ActionEvents.Perform[i](self)
	end

	ISBaseTimedAction.perform(self)
end

function ISAnimationAction:stop()
	--- What happens if the actor cancels this action?
	if self.otherActions then
		for i = 1, #self.otherActions do
			if self.otherActions[i].character ~= self.character then
				self.otherActions[i]:forceStop()
			end
		end
	end

	self.character:getModData().zomboLewdSexScene = nil

	if self.callbacks then
		if self.callbacks.Stop then
			self.callbacks.Stop(self)
		end
	end

	--- Activate ActionEvents
	for i = 1, #AnimationHandler.ActionEvents.Stop do
		AnimationHandler.ActionEvents.Stop[i](self)
	end

	ISBaseTimedAction.stop(self)
end

function ISAnimationAction:start()
	--- What happens when the animation starts?
	if self.callbacks then
		if self.callbacks.Start then
			self.callbacks.Start(self)
		end
	end

	self.maxTime = self.duration
	self.action:setTime(self.maxTime)
	self:setActionAnim(self.animation)
	self:setOverrideHandModels(nil, nil)

	self.character:getModData().zomboLewdSexScene = true
end

--- Determine animation events when played. Useful for sounds, saucy effects, or misc things
---@param event string value determining the type of animation
---@param parameter string that is the value given from the xml file
function ISAnimationAction:animEvent(event, parameter)
	if not AnimationHandler.EventMarkerModules[event] and not ignoredKeyframeNames[event] then
		--- See if we can lazy load it (Another mod might have added more event markers)
		AnimationHandler.EventMarkerModules[event] = require(string.format("ZomboLewd/AnimationEvents/%s", event))
	end

	if AnimationHandler.EventMarkerModules[event] then
		AnimationHandler.EventMarkerModules[event](self, parameter)
	elseif not ignoredKeyframeNames[event] then
		--- There probably isn't a file named this keyframe anywhere, lets ignore it from now on
		ignoredKeyframeNames[event] = true
		print(string.format("ZomboLewd - Ignoring %s events from now on", event))
	end
end

--- Creates a new animation object with inheritance from ISBaseTimedAction
---@param character IsoPlayer
---@param animation string
---@param duration number seconds in how long the act should be
function ISAnimationAction:new(character, animation, duration)
	local object = {
		character = character,
		animation = animation,
		stopOnWalk = false,
		stopOnRun = true,
		ignoreHandsWounds = true,
		maxTime = -1, --- Gets set in start()
		duration = duration or ZomboLewdConfig.DefaultSexDuration,
		ended = false,
	}
	setmetatable(object, self)
	self.__index = self
	return object
end

return AnimationHandler