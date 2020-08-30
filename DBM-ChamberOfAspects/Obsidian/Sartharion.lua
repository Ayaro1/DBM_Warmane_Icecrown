local mod	= DBM:NewMod("Sartharion", "DBM-ChamberOfAspects", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4911 $"):sub(12, -3))
mod:SetCreatureID(28860)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnShadowFissure	    = mod:NewSpellAnnounce(59127)
local warnTenebron          = mod:NewAnnounce("WarningTenebron", 2, 61248, false)
local warnShadron           = mod:NewAnnounce("WarningShadron", 2, 58105, false)
local warnVesperon          = mod:NewAnnounce("WarningVesperon", 2, 61251, false)

local warnFireWall			= mod:NewSpecialWarning("WarningFireWall", nil, nil, true)
local warnVesperonPortal	= mod:NewSpecialWarning("WarningVesperonPortal", false)
local warnTenebronPortal	= mod:NewSpecialWarning("WarningTenebronPortal", false)
local warnShadronPortal		= mod:NewSpecialWarning("WarningShadronPortal", false)

mod:AddBoolOption("AnnounceFails", true, "announce")

local timerShadowFissure    = mod:NewCastTimer(5, 59128)--Cast timer until Void Blast. it's what happens when shadow fissure explodes.
local timerWall             = mod:NewCDTimer(30, 43113)
local timerTenebron         = mod:NewTimer(26, "TimerTenebron", 61248)
local timerShadron          = mod:NewTimer(80, "TimerShadron", 58105)
local timerVesperon         = mod:NewTimer(120, "TimerVesperon", 61251)

local timerTenebronWhelps   = mod:NewTimer(10, "Tenebron Whelps", 1022)
local timerShadronPortal    = mod:NewTimer(10, "Shadron Portal", 11420)
local timerVesperonPortal   = mod:NewTimer(10, "Vesperon Portal", 57988)
local timerVesperonPortal2  = mod:NewTimer(10, "Vesperon Portal 2", 57988)

local warnTenebronWhelps    = mod:NewAnnounce("Whelps Soon", 1, 1022, false)
local warnShadronPortal     = mod:NewAnnounce("Portal Soon", 1, 11420, false)
local warnVesperonPortal    = mod:NewAnnounce("Reflect Soon", 1, 57988, false)

mod:AddBoolOption("PlaySoundOnFireWall")

local lastvoids = {}
local lastfire = {}

local function isunitdebuffed(spellID)
	local name = GetSpellInfo(spellID)
	if not name then return false end

	for i=1, 40, 1 do
		local debuffname = UnitDebuff("player", i, "HARMFUL")
		if debuffname == name then
			return true
		end
	end
	return false
end

function mod:OnSync(event)
	if event == "FireWall" then
		timerWall:Start()
		warnFireWall:Show()

		if self.Options.PlaySoundOnFireWall then
--			PlaySoundFile("Sound\\Spells\\PVPFlagTaken.wav")
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end

	elseif event == "VesperonPortal" then
		warnVesperonPortal:Show()

	elseif event == "TenebronPortal" then
		warnTenebronPortal:Show()

	elseif event == "ShadronPortal" then
		warnShadronPortal:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
    if args:IsSpellID(57579, 59127) and self:IsInCombat() then
        warnShadowFissure:Show()
        timerShadowFissure:Start()
    end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, mob)
	if not self:IsInCombat() then return end
	if msg == L.Wall or msg:find(L.Wall) then
		self:SendSync("FireWall")
	elseif msg == L.Portal or msg:find(L.Portal) then
		if mob == L.NameVesperon then
			self:SendSync("VesperonPortal")
		elseif mob == L.NameTenebron then
			self:SendSync("TenebronPortal")
		elseif mob == L.NameShadron then
			self:SendSync("ShadronPortal")
		end
	end
end

mod.CHAT_MSG_MONSTER_EMOTE = mod.CHAT_MSG_RAID_BOSS_EMOTE

function mod:CheckDrakes(delay)
	if self.Options.HealthFrame then
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(28860, "Sartharion")
	end
	if isunitdebuffed(61248) then	-- Power of Tenebron
		timerTenebron:Start(26 - delay)
		warnTenebron:Schedule(21 - delay)
		timerTenebronWhelps:Start(60 - delay)
		warnTenebronWhelps:Schedule(55 - delay)
		if self.Options.HealthFrame then
			DBM.BossHealth:AddBoss(30452, "Tenebron")
		end
	end
	if isunitdebuffed(58105) then	-- Power of Shadron
		timerShadron:Start(74 - delay)
		warnShadron:Schedule(69 - delay)
		timerShadronPortal:Start(94 - delay)
		warnShadronPortal:Schedule(89 - delay)
		if self.Options.HealthFrame then
			DBM.BossHealth:AddBoss(30451, "Shadron")
		end
	end
	if isunitdebuffed(61251) then	-- Power of Vesperon
		timerVesperon:Start(119 - delay)
		warnVesperon:Schedule(114 - delay)
		timerVesperonPortal:Start(139 - delay)
		timerVesperonPortal2:Start(199 - delay)
		warnVesperonPortal:Schedule(134 - delay)
		warnVesperonPortal:Schedule(194 - delay)
		if self.Options.HealthFrame then
			DBM.BossHealth:AddBoss(30449, "Vesperon")
		end
	end
end

function mod:OnCombatStart(delay)
	self:ScheduleMethod(5, "CheckDrakes", delay)
	timerWall:Start(-delay)

	table.wipe(lastvoids)
	table.wipe(lastfire)
end


local sortedFails = {}
local function sortFails1(e1, e2)
	return (lastvoids[e1] or 0) > (lastvoids[e2] or 0)
end
local function sortFails2(e1, e2)
	return (lastfire[e1] or 0) > (lastfire[e2] or 0)
end

function mod:OnCombatEnd(wipe)
	if not self.Options.AnnounceFails then return end
	if DBM:GetRaidRank() < 1 or not self.Options.Announce then return end

	local voids = ""
	for k, v in pairs(lastvoids) do
		table.insert(sortedFails, k)
	end
	table.sort(sortedFails, sortFails1)
	for i, v in ipairs(sortedFails) do
		voids = voids.." "..v.."("..(lastvoids[v] or "")..")"
	end
	SendChatMessage(L.VoidZones:format(voids), "RAID")
	table.wipe(sortedFails)

	local fire = ""
	for k, v in pairs(lastfire) do
		table.insert(sortedFails, k)
	end
	table.sort(sortedFails, sortFails2)
	for i, v in ipairs(sortedFails) do
		fire = fire.." "..v.."("..(lastfire[v] or "")..")"
	end
	SendChatMessage(L.FireWalls:format(fire), "RAID")
	table.wipe(sortedFails)
end

function mod:SPELL_AURA_APPLIED(args)
	if self.Options.AnnounceFails and self.Options.Announce and args:IsSpellID(57491) and DBM:GetRaidRank() >= 1 and DBM:GetRaidUnitId(args.destName) ~= "none" and args.destName then
		lastfire[args.destName] = (lastfire[args.destName] or 0) + 1
		SendChatMessage(L.FireWallOn:format(args.destName), "RAID")
	end
end

function mod:SPELL_DAMAGE(args)
	if self.Options.AnnounceFails and self.Options.Announce and args:IsSpellID(59128) and DBM:GetRaidRank() >= 1 and DBM:GetRaidUnitId(args.destName) ~= "none" and args.destName then
		lastvoids[args.destName] = (lastvoids[args.destName] or 0) + 1
		SendChatMessage(L.VoidZoneOn:format(args.destName), "RAID")
	end
end
