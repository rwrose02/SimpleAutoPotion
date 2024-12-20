---@class ham
local ham = select(2,...)
---@class Player
---@field localizedClass string
---@field englishClass string
---@field classIndex number
---@field healingItems table<number>
---@field healingSpells table<number>
---@field getHealingItems function
---@field fetchHealingSpells function
---@field getHealingSpells function
ham.Player = {}

function ham.Player:new()
	local obj = setmetatable({}, { __index = ham.Player })
  obj.localizedClass, obj.englishClass, obj.classIndex = UnitClass("player");
	obj.healingItems = {}
	obj.healingSpells = {}
	return obj
end
function ham.Player:getHealingItems()
	return self.healingItems
end

function ham.Player:fetchHealingSpells()
	for i, spell in ipairs(HAMDB.activatedSpells) do
		if IsSpellKnown(spell) or IsSpellKnown(spell, true) then
			self.healingSpells[spell] = true
		end
	end
end

function ham.Player:getHealingSpells()
	return self.healingSpells
end

