---@class ham
local ham = select(2,...)
local isRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)

local defaultSpells = {
	[185311]="crimsonVialSpell",
	[108238]="renewal",
	[109304]="exhilaration",
	[388035]="fortitudeOfTheBear",
	[12975]="lastStand",
	[383762]="bitterImmunity",
	[19236]="desperatePrayer",
	[322101]="expelHarm",
	[122281]="healingElixir",
	[108416]="darkPact",
	[55233]="vampiricBlood",
	[59545]="giftOfTheNaaruDK",
	[59543]="giftOfTheNaaruHunter",
	[59548]="giftOfTheNaaruMage",
	[416250]="giftOfTheNaaruWarlock",
	[121093]="giftOfTheNaaruMonk",
	[59542]="giftOfTheNaaruPaladin",
	[59544]="giftOfTheNaaruPriest",
	[370626]="giftOfTheNaaruRogue",
	[59547]="giftOfTheNaaruShaman",
	[28880]="giftOfTheNaaruWarrior"
}

-- table.insert(ham.supportedSpells, ham.Spell:new(ham.crimsonVialSpell, "Crimson Vial"))
-- table.insert(ham.supportedSpells, ham.renewal)
-- table.insert(ham.supportedSpells, ham.exhilaration)
-- table.insert(ham.supportedSpells, ham.fortitudeOfTheBear)
-- table.insert(ham.supportedSpells, ham.lastStand)
-- table.insert(ham.supportedSpells, ham.bitterImmunity)
-- table.insert(ham.supportedSpells, ham.desperatePrayer)
-- table.insert(ham.supportedSpells, ham.expelHarm)
-- table.insert(ham.supportedSpells, ham.healingElixir)
-- table.insert(ham.supportedSpells, ham.darkPact)
-- table.insert(ham.supportedSpells, ham.vampiricBlood)
-- table.insert(ham.supportedSpells, ham.giftOfTheNaaruDK)
-- table.insert(ham.supportedSpells, ham.giftOfTheNaaruHunter)
-- table.insert(ham.supportedSpells, ham.giftOfTheNaaruMage)
-- table.insert(ham.supportedSpells, ham.giftOfTheNaaruMageWarlock)
-- table.insert(ham.supportedSpells, ham.giftOfTheNaaruMonk)
-- table.insert(ham.supportedSpells, ham.giftOfTheNaaruPaladin)
-- table.insert(ham.supportedSpells, ham.giftOfTheNaaruPriest)
-- table.insert(ham.supportedSpells, ham.giftOfTheNaaruRogue)
-- table.insert(ham.supportedSpells, ham.giftOfTheNaaruShaman)
-- table.insert(ham.supportedSpells, ham.giftOfTheNaaruWarrior)

---@class Spell
---@field id number
---@field name string
---@field cd number
ham.Spell = {}
local spellcd = {}
spellcd.__index = spellcd
-- Constructor
function ham.Spell:new(id, name)
    local obj = {}
		setmetatable(obj, { __index = ham.Spell })
    obj.id = id
    obj.name = name
    return obj
end


---@return number id Unique identifier for the spell
function ham.Spell:getId()
	return self.id
end

---@return string name Name of the spell
function ham.Spell:getName()
	return self.name
end

---@return number cd Cooldown duration of the spell
function ham.Spell:getCd()
	if isRetail then
			local spellCooldownInfo = C_Spell.GetSpellCooldown(self.id)
			if spellCooldownInfo.duration == 0 then
				return 0
			end
			if spellCooldownInfo.duration == nil then
				return -1
			end
			return spellCooldownInfo.duration
	end
	return -1
end
---spell ids for the spells that are supported by the addon
---@type table<string, Spell>
ham.supportedSpells = {}
for spellId,spellName in pairs(defaultSpells) do
	print(spellId,spellName)
	ham.supportedSpells[spellId] = ham.Spell:new(spellId, spellName)
	DevTool:AddData(ham.supportedSpells[spellId],spellName)
end
function AddNS()
	DevTool:AddData(ham,"hamadded")
	for spellId,spellobj in pairs(ham.supportedSpells) do
		DevTool:AddData(ham.supportedSpells[spellId]:getCd(),spellobj:getName())
	end
end
test_frame = CreateFrame("Frame")
test_frame:RegisterEvent("PLAYER_ENTERING_WORLD")
test_frame:SetScript("OnEvent", function(self, event, ...)
	for spellId,spellName in pairs(defaultSpells) do
		ham.supportedSpells[spellId]:getCd()
	end
end)
