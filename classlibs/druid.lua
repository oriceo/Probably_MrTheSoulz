--[[ //////////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
// Druid's Lib //
Thank Your For Your My ProFiles
I Hope Your Enjoy Them
MTS
]]

-- Made By Tao
local ignoreDebuffs = {
  'Mark of Arrogance',
  'Displaced Energy'
}

ProbablyEngine.library.register('dispell', {
druid = function(spell)
local prefix = (IsInRaid() and 'raid') or 'party'
	for i = -1, GetNumGroupMembers() - 1 do
	local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		if IsSpellInRange("Nature's Cure", unit) then
			for j = 1, 40 do
			local debuffName, _, _, _, dispelType, duration, expires, _, _, _, spellID, _, isBossDebuff, _, _, _ = UnitDebuff(unit, j)
				if dispelType and dispelType == 'Magic' or dispelType == 'Poison' or dispelType == 'Disease' then
				local ignore = false
				for k = 1, #ignoreDebuffs do
					if debuffName == ignoreDebuffs[k] then
						ignore = true
						break
					end
				end
					if not ignore then
						ProbablyEngine.dsl.parsedTarget = unit
						return true
					end
				end
				if not debuffName then
					break
				end
			end
		end
	end
		return false
end})