-- ///////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--														 //Paladin Holy//
--												  Thank Your For Your My ProFiles
--													  I Hope Your Enjoy Them
--															    MTS


local lib = function()
	
-- ///////////////////-----------------------------------------TOGGLES-----------------------------------//////////////////////////////

	mtsAlert:message("\124cff9482C9*MrTheSoulz - \124cffF58CBAPaladin/Holy \124cff9482C9Loaded*")

-- ///////////////////-----------------------------------------DISPELS-----------------------------------//////////////////////////////
	
-- Made by Tao
local ignoreDebuffs = {
	'Mark of Arrogance',
	'Displaced Energy'
}
	
ProbablyEngine.library.register('dispell', {
Cleanse = function(spell)
local prefix = (IsInRaid() and 'raid') or 'party'
	for i = -1, GetNumGroupMembers() - 1 do
	local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		if IsSpellInRange('cleanse', unit) then
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


end
-- //////////////////////-----------------------------------------END LIB-----------------------------------//////////////////////////////

local Buffs = {

	-- Buffs
		{ "19740", { -- Blessing of Might
			"!player.buff(19740).any",
			"!player.buff(116956).any",
			"!player.buff(93435).any",
			"!player.buff(128997).any",
			"@mts.getConfig('PalaHolyBuffs')",
			"@mts.getSetting('toUsePalaHolyBuff', 'MIGHT')"
		}, nil },
		
		{ "20217", { -- Blessing of Kings
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"@mts.getConfig('PalaHolyBuffs')",
			"@mts.getSetting('toUsePalaHolyBuff', 'KINGS')" 
		}, nil },
	
	-- Seals
		{ "20165", "player.seal != 3" }, -- Seal of Insight

}
-- ////////////////////////-----------------------------------------END BUFFS-----------------------------------//////////////////////////////

local inCombat = {

	-- keybinds
		{ "114158", "modifier.shift", "ground"}, -- Light´s Hammer
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus

	-- Mana Regen
		{ "28730", "player.mana < 90", nil }, -- Arcane torrent
		{ "54428", "player.mana < 85", nil }, -- Divine Plea
		{ "#trinket1", { "@mts.getConfig('usePalaHolyTk1')", "@mts.ConfigUnitMana('PalaHolyTk1', 'player')" }, nil }, -- Trinket 1
		{ "#trinket2", { "@mts.getConfig('usePalaHolyTk1')", "@mts.ConfigUnitMana('PalaHolyTk2', 'player')" }, nil }, -- Trinket 2
	
	-- Interrupts
		{ "96231", "modifier.interrupts", "target" }, -- Rebuke
		
	-- Hands
		{ "6940", { "tank.spell(6940).range", "tank.health < 40" }, "tank" }, -- Hand of Sacrifice
		{ "1044", "player.state.root" }, -- Hand of Freedom

	-- Survival
		{ "#5512", "@mts.ConfigUnitHp('PalaHolyHs', 'player')" }, -- Healthstone       
		{ "498", "player.health <= 90", "player" }, -- Divine Protection
		{ "642", "player.health <= 20", "player" }, -- Divine Shield

	{{-- Cooldowns
		{ "#gloves" }, -- gloves
		{ "31821", "@coreHealing.needsHealing(40, 5)", nil }, -- Devotion Aura	
		{ "31884", "@coreHealing.needsHealing(95, 4)", nil }, -- Avenging Wrath
		{ "86669", "@coreHealing.needsHealing(85, 4)", nil }, -- Guardian of Ancient Kings
		{ "31842", "@coreHealing.needsHealing(90, 4)", nil }, -- Divine Favor
		{ "105809", "talent(13)", nil }, -- Holy Avenger
	}, "modifier.cooldowns" },
	
	-- Dispel
		{ "4987", { "player.buff(Gift of the Titans)", "@coreHealing.needsDispelled('Mark of Arrogance')" }, nil },
		{ "4987", "@coreHealing.needsDispelled('Shadow Word: Bane')", nil },
		{ "4987", "@coreHealing.needsDispelled('Corrosive Blood')", nil },
		{ "4987", "@coreHealing.needsDispelled('Harden Flesh')", nil },
		{ "4987", "@coreHealing.needsDispelled('Torment')", nil },
		{ "4987", "@coreHealing.needsDispelled('Breath of Fire')", nil },
		{ "4987", { "@mts.getConfig('PalaHolyDispells')", "@dispell.Cleanse()" }, nil },
	
	-- Divine Purpose
		{ "85673", { "lowest.health <= 80", "player.buff(86172)" }, "lowest"  }, -- Word of Glory
		{ "114163", { "!lowest.buff(114163)", "lowest.health <= 85", "player.buff(86172)" }, "lowest" }, -- Eternal Flame
	
	{{-- Selfless Healer
		{ "!/target [target=focustarget, harm, nodead]", "!target.exists" }, -- Target focus target
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{{ -- If got buff
			{ "19750", { "lowest.health < 85", "!lowest.health < 65", "!@coreHealing.needsHealing(95, 4)", "!player.moving" }, "lowest" }, -- Flash of light
			{ "82326", { "lowest.health < 65", "!@coreHealing.needsHealing(95, 4)", "!player.moving" }, "lowest" }, -- Divine Light
			{ "82327", { "@coreHealing.needsHealing(95, 4)", "!player.moving" }, "lowest" }, -- Holy Radiance
		}, "player.buff(114250).count = 3" }
	}, "talent(7)" },		

	-- Infusion of Light
		{ "20473", "lowest.health < 100", "lowest" }, -- Holy Shock
		{ "82326", { "lowest.health < 75", "!@coreHealing.needsHealing(90, 4)", "!player.moving", "player.buff(54149)" }, "lowest" }, -- Divine Light
	
	-- AOE
		-- Manual
			{ "85222", { "@mts.getSetting('toUsePalaHolyHr', 'MANUAL')", "player.holypower >= 3", "modifier.multitarget" }, "lowest" }, -- Light of Dawn
			{ "82327", { "@mts.getSetting('toUsePalaHolyHr', 'MANUAL')", "modifier.multitarget" }, "lowest" }, -- Holy Radiance
		-- Party
			{ "85222", { "@mts.getSetting('toUsePalaHolyHr', 'AUTO')", "@coreHealing.needsHealing(90, 3)", "player.holypower >= 3", "modifier.party" }, "lowest" }, -- Light of Dawn
			{ "82327", { "@mts.getSetting('toUsePalaHolyHr', 'AUTO')", "@coreHealing.needsHealing(80, 3)", "!modifier.last", "!player.moving", "modifier.party" }, "lowest" }, -- Holy Radiance - Party
		-- RAID
			{ "85222", { "@mts.getSetting('toUsePalaHolyHr', 'AUTO')", "@coreHealing.needsHealing(90, 5)", "player.holypower >= 3", "modifier.raid", "!modifier.members > 10" }, "lowest" }, -- Light of Dawn
			{ "82327", { "@mts.getSetting('toUsePalaHolyHr', 'AUTO')", "@coreHealing.needsHealing(90, 5)", "!modifier.last", "!player.moving", "modifier.raid", "!modifier.members > 10" }, "lowest" }, -- Holy Radiance - Raid 10
		-- Raid 25
			{ "85222", { "@mts.getSetting('toUsePalaHolyHr', 'AUTO')", "@coreHealing.needsHealing(90, 8)", "player.holypower >= 3", "modifier.members > 10" }, "lowest" }, -- Light of Dawn
			{ "82327", { "@mts.getSetting('toUsePalaHolyHr', 'AUTO')", "@coreHealing.needsHealing(90, 8)", "!modifier.last", "!player.moving", "modifier.members > 10" }, "lowest" }, -- Holy Radiance 10+
	
	
	-- HEAL FAST BITCH
		{ "633", "@mts.ConfigUnitHp('PalaHolyLoh', 'lowest')", "lowest" }, -- Lay on Hands
		{ "85673", { "player.holypower >= 3", "lowest.health <= 80" }, "lowest"  }, -- Word of Glory
		{ "114163", { "player.holypower >= 1", "!lowest.buff(114163)", "@mts.ConfigUnitHp('PalaHolyEf', 'lowest')" }, "lowest" }, -- Eternal Flame
		{ "20925", { "spell.charges(20925) >= 2", "lowest.health < 90", "!lowest.buff(148039)", "lowest.spell(20925).range", "!modifier.last" }, "lowest" }, -- Sacred Shield
		{ "19750", { "lowest.health < 30", "!player.moving" }, "lowest" }, -- Flash of light

	-- Dps
		{ "35395", "target.spell(35395).range", "target" }, -- Crusader Strike
		
	-- Tank
		{ "53563", { "!tank.buff(53563)", "tank.spell(53563).range" }, "tank" }, -- Beacon of light
		{ "114157", "tank.health < 85", "tank" }, -- Execution Sentence
		{ "114163", { "player.holypower >= 3", "!tank.buff(114163)", "tank.health <= 75" }, "tank" }, -- Eternal Flame
		{ "20925", { "spell.charges(20925) >= 1", "tank.health < 95", "!tank.buff(148039)", "tank.spell(20925).range", "!modifier.last" }, "tank" }, -- Sacred Shield
		{ "82326", { "tank.health < 65", "tank.spell(82326).range", "!player.moving" }, "tank" }, -- Divine Light
		
	-- Single target
		{ "114165", { "lowest.health < 85", "!player.moving" }, "lowest"}, -- Holy Prism
		{ "635", { "lowest.health < 97", "!lowest.health < 65", "!player.moving" }, "lowest" }, -- Holy Light
		{ "82326", { "lowest.health < 35", "!player.moving" }, "lowest" }, -- Divine Light
  
} 
-- //----/////////////////-----------------------------------------END IN-COMBAT-----------------------------------//////////////////////////////

local outCombat = {

	-- keybinds
		{ "114158", "modifier.shift", "ground"}, -- Light´s Hammer
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus

	-- Mana Regen
		{ "28730", "player.mana < 90", nil }, -- Arcane torrent
		{ "54428", "player.mana < 85", nil }, -- Divine Plea
		{ "#trinket1", "player.mana < 85", nil }, -- Trinket 1
		{ "#trinket2", "player.mana < 85", nil }, -- Trinket 2

	-- Hands
		{ "1044", "player.state.root" }, -- Hand of Freedom
 
	-- Tank
		{ "53563", { "!tank.buff(53563)", "tank.spell(53563).range" }, "tank" }, -- Beacon of light

	-- Healing
		{ "20473", "lowest.health < 100", "lowest" }, -- Holy Shock	
  
}-- ///////////////////-----------------------------------------END OUT-OF-COMBAT-----------------------------------//////////////////////////////

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end


ProbablyEngine.rotation.register_custom(65, "|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Holy|r]", inCombat, outCombat, lib)