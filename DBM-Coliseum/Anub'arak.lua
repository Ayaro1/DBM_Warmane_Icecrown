﻿local mod	= DBM:NewMod("Anub'arak_Coliseum", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4435 $"):sub(12, -3))
mod:SetCreatureID(34564)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

mod:SetUsedIcons(3, 4, 5, 6, 7, 8)


mod:AddBoolOption("RemoveHealthBuffsInP3", not mod:IsTank())

-- Adds
local warnAdds					= mod:NewAnnounce("warnAdds", 3, 45419)
local timerAdds					= mod:NewTimer(45, "timerAdds", 45419)
local Burrowed					= false

-- Pursue
local warnPursue				= mod:NewTargetAnnounce(67574, 4)
local specWarnPursue			= mod:NewSpecialWarning("SpecWarnPursue")
local warnHoP					= mod:NewTargetAnnounce(10278, 2, nil, false)	--Heroic strat revolves around kiting pursue and using Hand of Protection.
local timerHoP					= mod:NewBuffActiveTimer(10, 10278, nil, false)	--So we will track bops to make this easier.
mod:AddBoolOption("PlaySoundOnPursue")
mod:AddBoolOption("PursueIcon")

-- Emerge
local warnEmerge				= mod:NewAnnounce("WarnEmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnEmergeSoon			= mod:NewAnnounce("WarnEmergeSoon", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerEmerge				= mod:NewTimer(65, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

-- Submerge
local warnSubmerge				= mod:NewAnnounce("WarnSubmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnSubmergeSoon			= mod:NewAnnounce("WarnSubmergeSoon", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local specWarnSubmergeSoon		= mod:NewSpecialWarning("specWarnSubmergeSoon", mod:IsTank())
local timerSubmerge				= mod:NewTimer(75, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")

-- Submerge 2
local warnSubmergeTwo			= mod:NewAnnounce("WarnSubmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnSubmergeTwoSoon		= mod:NewAnnounce("WarnSubmergeSoon", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local specWarnSubmergeTwoSoon	= mod:NewSpecialWarning("specWarnSubmergeSoon", mod:IsTank())
local timerSubmergeTwo			= mod:NewTimer(145, "2nd Submerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")

-- Extra Emerge timers
local timerEmergeOne			= mod:NewTimer(65, "1st Emerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerEmergeTwo			= mod:NewTimer(65, "2nd Emerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

-- Phases
local warnPhase3				= mod:NewPhaseAnnounce(3)
local enrageTimer				= mod:NewBerserkTimer(570)	-- 9:30 ? hmpf (no enrage while submerged... this sucks)

-- Penetrating Cold
local specWarnPCold				= mod:NewSpecialWarningYou(68510, false)
local timerPCold				= mod:NewBuffActiveTimer(15, 68509)

mod:AddBoolOption("SetIconsOnPCold", true)
mod:AddBoolOption("AnnouncePColdIcons", false)
mod:AddBoolOption("AnnouncePColdIconsRemoved", false)

-- Freezing Slash
local warnFreezingSlash			= mod:NewTargetAnnounce(66012, 2, nil, mod:IsHealer() or mod:IsTank())
local timerFreezingSlash		= mod:NewCDTimer(20, 66012, nil, mod:IsHealer() or mod:IsTank())

-- Shadow Strike
local timerShadowStrike			= mod:NewNextTimer(30.5, 66134)
local preWarnShadowStrike		= mod:NewSoonAnnounce(66134, 3)
local warnShadowStrike			= mod:NewSpellAnnounce(66134, 4)
local specWarnShadowStrike		= mod:NewSpecialWarning("SpecWarnShadowStrike", mod:IsTank())

-- Shadow Strike Scheduled Timers
local timerShadowStrikeOne		= mod:NewTimer(30, "1st Shadowstrike", not mod:IsHealer())
local timerShadowStrikeTwo		= mod:NewTimer(30, "2nd Shadowstrike", not mod:IsHealer())
local timerShadowStrikeThree	= mod:NewTimer(30, "3rd Shadowstrike", not mod:IsHealer())
local timerShadowStrikeFour		= mod:NewTimer(30, "4th Shadowstrike", not mod:IsHealer())
local timerShadowStrikeFive		= mod:NewTimer(30, "5th Shadowstrike", not mod:IsHealer())
local timerShadowStrikeSix		= mod:NewTimer(30, "6th Shadowstrike", not mod:IsHealer())
local timerShadowStrikeSeven	= mod:NewTimer(30, "7th Shadowstrike", not mod:IsHealer())
local timerShadowStrikeEight	= mod:NewTimer(30, "8th Shadowstrike", not mod:IsHealer())
local timerShadowStrikeNine		= mod:NewTimer(30, "9th Shadowstrike", not mod:IsHealer())
local timerShadowStrikeTen		= mod:NewTimer(30, "10th Shadowstrike", not mod:IsHealer())
local timerShadowStrikeEleven	= mod:NewTimer(30, "11th Shadowstrike", not mod:IsHealer())

--[[
-- local TTSstun = mod:NewSoundFile("Interface\\AddOns\\DBM-Core\\sounds\\stunIn3.mp3", "TTS stun countdown", true)
local stunTTSOffset = 4.87
mod:AddBoolOption("BroadcastStunTimer", true)
-- Shadow Strik stuns
local stunTimer = mod:NewTimer(30, "Stun Adds!")
local stunCount = 0
local stunTimerValues = {30, 30, 115}
]]--

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	-- stunCount = 0
	Burrowed = false
	timerAdds:Start(10-delay)
	warnAdds:Schedule(10-delay)
	self:ScheduleMethod(10-delay, "Adds")
	warnSubmergeSoon:Schedule(70-delay)
	specWarnSubmergeSoon:Schedule(70-delay)
	timerSubmerge:Start(80-delay)
	timerEmergeOne:Schedule(80)
	enrageTimer:Start(-delay)
	timerFreezingSlash:Start(-delay)
	warnSubmergeTwoSoon:Schedule(215)
	specWarnSubmergeTwoSoon:Schedule(215)
	timerSubmergeTwo:Schedule(80)
	timerEmergeTwo:Schedule(225)
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		timerShadowStrikeOne:Start(-delay)
		timerShadowStrikeTwo:Schedule(30)
		timerShadowStrikeThree:Schedule(145)
		timerShadowStrikeFour:Schedule(175)
		timerShadowStrikeFive:Schedule(205)
		timerShadowStrikeSix:Schedule(320)
		timerShadowStrikeSeven:Schedule(350)
		timerShadowStrikeEight:Schedule(380)
		timerShadowStrikeNine:Schedule(410)
		timerShadowStrikeTen:Schedule(440)
		timerShadowStrikeEleven:Schedule(470)
		timerShadowStrike:Start()
		preWarnShadowStrike:Schedule(25.5-delay)
		self:ScheduleMethod(30.5-delay, "ShadowStrike")
		-- self:nextStunTimer()
	end
end

function mod:OnCombatEnd()
	timerShadowStrikeTwo:Cancel()
	timerShadowStrikeThree:Cancel()
	timerShadowStrikeFour:Cancel()
	timerShadowStrikeFive:Cancel()
	timerShadowStrikeSix:Cancel()
	timerShadowStrikeSeven:Cancel()
	timerShadowStrikeEight:Cancel()
	timerShadowStrikeNine:Cancel()
	timerShadowStrikeTen:Cancel()
	timerShadowStrikeEleven:Cancel()
	timerEmergeOne:Cancel()
	timerSubmergeTwo:Cancel()
	timerEmergeTwo:Cancel()
end

--[[
function mod:nextStunTimer()
	self:UnscheduleMethod("nextStunTimer")
	local duration = stunTimerValues[1+(stunCount % #stunTimerValues)]
	if stunCount == 0 then -- weird 2 sec offset from warmane
		duration = 28
	end
	if self.Options.BroadcastStunTimer then
		DBM:CreatePizzaTimer(duration, "Stun Adds!", true)
	end
	stunTimer:Start(duration)
	--TTSstun:Schedule(duration-stunTTSOffset)
	self:ScheduleMethod(duration, "nextStunTimer")
	stunCount = stunCount + 1
end

function mod:OnCombatEnd()
	stunCount = 0
	self:UnscheduleMethod("nextStunTimer")
	stunTimer:Stop()
	--TTSstun:Cancel()
end
]]--

function mod:Adds()
	if self:IsInCombat() then
		if not Burrowed then
			timerAdds:Start()
			warnAdds:Schedule(45)
			self:ScheduleMethod(45, "Adds")
		end
	end
end

function mod:ShadowStrike()
	if self:IsInCombat() then
		timerShadowStrike:Start()
		preWarnShadowStrike:Cancel()
		preWarnShadowStrike:Schedule(25.5)
		self:UnscheduleMethod("ShadowStrike")
		self:ScheduleMethod(30.5, "ShadowStrike")
	end
end

local PColdTargets = {}
do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(UnitName(v1)) < DBM:GetRaidSubgroup(UnitName(v2))
	end
	function mod:SetPcoldIcons()
		if DBM:GetRaidRank() > 0 then
			table.sort(PColdTargets, sort_by_group)
			local PColdIcon = 7
			for i, v in ipairs(PColdTargets) do
				if self.Options.AnnouncePColdIcons then
					SendChatMessage(L.PcoldIconSet:format(PColdIcon, UnitName(v)), "RAID")
				end
				self:SetIcon(UnitName(v), PColdIcon)
				PColdIcon = PColdIcon - 1
			end
			table.wipe(PColdTargets)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(67574) then			-- Pursue
		if args:IsPlayer() then
			specWarnPursue:Show()
			if self.Options.PlaySoundOnPursue then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
		if self.Options.PursueIcon then
			self:SetIcon(args.destName, 8, 15)
		end
		warnPursue:Show(args.destName)
	elseif args:IsSpellID(66013, 67700, 68509, 68510) then		-- Penetrating Cold
		if args:IsPlayer() then
			specWarnPCold:Show()
		end
		if self.Options.SetIconsOnPCold then
			table.insert(PColdTargets, DBM:GetRaidUnitId(args.destName))
			if ((mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25")) and #PColdTargets >= 5) or ((mod:IsDifficulty("normal10") or mod:IsDifficulty("heroic10")) and #PColdTargets >= 2) then
				self:SetPcoldIcons()	--Sort and fire as early as possible once we have all targets.
			end
		end
		timerPCold:Show()
	elseif args:IsSpellID(66012) then							-- Freezing Slash
		warnFreezingSlash:Show(args.destName)
		timerFreezingSlash:Start()
	elseif args:IsSpellID(10278) and self:IsInCombat() then		-- Hand of Protection
		warnHoP:Show(args.destName)
		timerHoP:Start(args.destName)
	end
end

mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(66013, 67700, 68509, 68510) then			-- Penetrating Cold
		mod:SetIcon(args.destName, 0)
		if (self.Options.AnnouncePColdIcons and self.Options.AnnouncePColdIconsRemoved) and DBM:GetRaidRank() >= 1 then
			SendChatMessage(L.PcoldIconRemoved:format(args.destName), "RAID")
		end
	elseif args:IsSpellID(10278) and self:IsInCombat() then		-- Hand of Protection
		timerHoP:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66118, 67630, 68646, 68647) then		-- Swarm (start p3)
		self.vb.phase = 2
		warnPhase3:Show()
		warnEmergeSoon:Cancel()
		warnSubmergeSoon:Cancel()
		specWarnSubmergeSoon:Cancel()
		timerEmerge:Stop()
		timerSubmerge:Stop()
		timerSubmergeTwo:Stop()
		timerEmergeTwo:Stop()
		if self.Options.RemoveHealthBuffsInP3 then
			mod:ScheduleMethod(0.1, "RemoveBuffs")
		end
		if mod:IsDifficulty("normal10") or mod:IsDifficulty("normal25") then
			timerAdds:Cancel()
			warnAdds:Cancel()
			self:UnscheduleMethod("Adds")
		end
	elseif args:IsSpellID(66134) then		-- Shadow Strike
		self:ShadowStrike()
		specWarnShadowStrike:Show()
		warnShadowStrike:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg and msg:find(L.Burrow) then
		Burrowed = true
		timerAdds:Cancel()
		warnAdds:Cancel()
		warnSubmerge:Show()
		warnEmergeSoon:Schedule(55)
		timerEmerge:Start()
		timerFreezingSlash:Stop()
	-- Disabled since Warmane is not sending out the Boss Emote for this trigger
	--[[elseif msg and msg:find(L.Emerge) then
		Burrowed = false
		timerAdds:Start(5)
		warnAdds:Schedule(5)
		self:ScheduleMethod(5, "Adds")
		warnEmerge:Show()
		warnSubmergeSoon:Schedule(65)
		specWarnSubmergeSoon:Schedule(65)
		timerSubmerge:Start()
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerShadowStrike:Stop()
			preWarnShadowStrike:Cancel()
			self:UnscheduleMethod("ShadowStrike")
			self:ScheduleMethod(5.5, "ShadowStrike")  -- 35-36sec after Emerge next ShadowStrike
		end]]--
	end
end

function mod:RemoveBuffs()
	CancelUnitBuff("player", (GetSpellInfo(47440)))		-- Commanding Shout (Rank 3)
	CancelUnitBuff("player", (GetSpellInfo(47439)))		-- Commanding Shout (Rank 2)
	CancelUnitBuff("player", (GetSpellInfo(45517)))		-- Commanding Shout (Rank 1)
	CancelUnitBuff("player", (GetSpellInfo(469)))		-- Commanding Shout (Rank 1)
	CancelUnitBuff("player", (GetSpellInfo(48161)))		-- Power Word: Fortitude (Rank 8)
	CancelUnitBuff("player", (GetSpellInfo(25389)))		-- Power Word: Fortitude (Rank 7)
	CancelUnitBuff("player", (GetSpellInfo(10938)))		-- Power Word: Fortitude (Rank 6)
	CancelUnitBuff("player", (GetSpellInfo(10937)))		-- Power Word: Fortitude (Rank 5)
	CancelUnitBuff("player", (GetSpellInfo(2791)))		-- Power Word: Fortitude (Rank 4)
	CancelUnitBuff("player", (GetSpellInfo(1245)))		-- Power Word: Fortitude (Rank 3)
	CancelUnitBuff("player", (GetSpellInfo(1244)))		-- Power Word: Fortitude (Rank 2)
	CancelUnitBuff("player", (GetSpellInfo(1243)))		-- Power Word: Fortitude (Rank 1)
	CancelUnitBuff("player", (GetSpellInfo(48162)))		-- Prayer of Fortitude (Rank 4)
	CancelUnitBuff("player", (GetSpellInfo(25392)))		-- Prayer of Fortitude (Rank 3)
	CancelUnitBuff("player", (GetSpellInfo(21564)))		-- Prayer of Fortitude (Rank 2)
	CancelUnitBuff("player", (GetSpellInfo(21562)))		-- Prayer of Fortitude (Rank 1)
	CancelUnitBuff("player", (GetSpellInfo(72590)))		-- Runescroll of Fortitude
end
