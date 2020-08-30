local mod	= DBM:NewMod("Thorim", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4177 $"):sub(12, -3))
mod:SetCreatureID(32865)
mod:SetUsedIcons(8)

mod:RegisterCombat("yell", L.YellPhase1)
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_CAST_START"
)

local warnPhase2				= mod:NewPhaseAnnounce(2, 1)
local warnStormhammer			= mod:NewTargetAnnounce(62470, 2)
local warnLightningCharge		= mod:NewSpellAnnounce(62466, 2)
local warnUnbalancingStrike		= mod:NewTargetAnnounce(62130, 4)	-- nice blizzard, very new stuff, hmm or not? ^^ aq40 4tw :)
local warningBomb				= mod:NewTargetAnnounce(62526, 4)

local specWarnOrb				= mod:NewSpecialWarningMove(62017)

mod:AddBoolOption("AnnounceFails", false, "announce")

local enrageTimer				= mod:NewBerserkTimer(369)
local timerStormhammerCD		= mod:NewCDTimer(16, 62042)
local timerLightningCharge	 	= mod:NewCDTimer(16, 62466)
local timerUnbalancingStrike	= mod:NewCastTimer(26, 62130)
local TimerHardmodeThorim		= mod:NewTimer(150, "TimerHardmodeThorim", 62042)
local timerFrostNova			= mod:NewNextTimer(20, 62605)
local timerFrostNovaCast		= mod:NewCastTimer(2.5, 62605)
local timerChainLightning		= mod:NewNextTimer(15, 64390)
local timerFBVolley				= mod:NewCDTimer(13, 62604)

mod:AddBoolOption("RangeFrame", true)

local lastcharge				= {}

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	enrageTimer:Start()
	TimerHardmodeThorim:Start()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	table.wipe(lastcharge)
end

local sortedFailsC = {}
local function sortFails1C(e1, e2)
	return (lastcharge[e1] or 0) > (lastcharge[e2] or 0)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.AnnounceFails and DBM:GetRaidRank() >= 1 then
		local lcharge = ""
		for k, v in pairs(lastcharge) do
			table.insert(sortedFailsC, k)
		end
		table.sort(sortedFailsC, sortFails1C)
		for i, v in ipairs(sortedFailsC) do
			lcharge = lcharge.." "..v.."("..(lastcharge[v] or "")..")"
		end
		SendChatMessage(L.Charge:format(lcharge), "RAID")
		table.wipe(sortedFailsC)
	end
end


function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62042) then 					-- Storm Hammer
		warnStormhammer:Show(args.destName)
		timerStormhammerCD:Start()
	elseif args:IsSpellID(62507) then				-- Touch of Dominion
		TimerHardmodeThorim:Start()
	elseif args:IsSpellID(62130) then				-- Unbalancing Strike
		warnUnbalancingStrike:Show(args.destName)
	elseif args:IsSpellID(62526, 62527) then		-- Runic Detonation
		self:SetIcon(args.destName, 8, 5)
		warningBomb:Show(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(62042) then 		-- Storm Hammer
		timerStormhammerCD:Start()
	elseif args:IsSpellID(62130) then	-- Unbalancing Strike
		timerUnbalancingStrike:Start()
	elseif args:IsSpellID(62604) then	-- Frostbolt Volley by Sif
		timerFBVolley:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then		-- Bossfight (tank and spank)
		warnPhase2:Show()
		enrageTimer:Stop()
		if (timerHardmodeThorim ~= nil) then
			timerHardmodeThorim:Stop()
		end
		self.vb.phase = 2
		enrageTimer:Start(300)
	elseif msg == L.YellKill or msg:find(L.YellKill) then
		enrageTimer:Stop()
	end
end

local spam = 0
function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(62017) then -- Lightning Shock
		if bit.band(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0
		and bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
		and GetTime() - spam > 5 then
			spam = GetTime()
			specWarnOrb:Show()
		end
	elseif self.Options.AnnounceFails and args:IsSpellID(62466) and DBM:GetRaidRank() >= 1 and DBM:GetRaidUnitId(args.destName) ~= "none" and args.destName then
		lastcharge[args.destName] = (lastcharge[args.destName] or 0) + 1
		SendChatMessage(L.ChargeOn:format(args.destName), "RAID")
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62605) then --Frost Nova by Sif
		timerFrostNovaCast:Start()
		timerFrostNova:Start()
	elseif args:IsSpellID(64390) then --Chain Lightning by Thorim
		timerChainLightning:Start()
	end
end
