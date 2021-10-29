if GetLocale() ~= "deDE" then return end

local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Shadron"
})

----------------
--  Tenebron  --
----------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Tenebron"
})

----------------
--  Vesperon  --
----------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vesperon"
})

------------------
--  Sartharion  --
------------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
	WarningTenebron			= "Tenebron kommt",
	WarningShadron			= "Shadron kommt",
	WarningVesperon			= "Vesperon kommt",
	WarningFireWall			= "Feuerwand",
	WarningVesperonPortal	= "Vesperons Portal",
	WarningTenebronPortal	= "Tenebrons Portal",
	WarningShadronPortal	= "Shadrons Portal"
})

L:SetTimerLocalization({
	TimerTenebron	= "Tenebron kommt",
	TimerShadron	= "Shadron kommt",
	TimerVesperon	= "Vesperon kommt"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall		= "Spiele Sound bei Feuerwand",
	AnnounceFails			= "Verkünde Spieler, die bei Feuerwand und Zone der Leere scheitern, im Raidchat (benötigt aktivierte Ankündigungen und (L)- oder (A)-Status)",
	TimerTenebron			= "Zeige Timer für Tenebrons Ankunft",
	TimerShadron			= "Zeige Timer für Shadrons Ankunft",
	TimerVesperon			= "Zeige Timer für Vesperons Ankunft",
	WarningFireWall			= "Zeige Spezialwarnung für Feuerwand",
	WarningTenebron			= "Verkünde Ankunft von Tenebron",
	WarningShadron			= "Verkünde Ankunft von Shadron",
	WarningVesperon			= "Verkünde Ankunft von Vesperon",
	WarningTenebronPortal	= "Zeige Spezialwarnung für Tenebrons Portale",
	WarningShadronPortal	= "Zeige Spezialwarnung für Shadrons Portale",
	WarningVesperonPortal	= "Zeige Spezialwarnung für Vesperons Portale"
})

L:SetMiscLocalization({
	Wall			= "Die Lava um %s brodelt!",
	Portal			= "%s beginnt, ein Portal des Zwielichts zu öffnen!",
	NameTenebron	= "Tenebron",
	NameShadron		= "Shadron",
	NameVesperon	= "Vesperon",
	FireWallOn		= "Feuerwand: %s",
	VoidZoneOn		= "Zone der Leere: %s",
	VoidZones		= "Fehler bei Zone der Leere (dieser Versuch): %s",
	FireWalls		= "Fehler bei Feuerwand (dieser Versuch): %s"
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "Baltharus der Kriegsjünger"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Aufspaltung bald"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Zeige Vorwarnun für Aufspaltung",
	RangeFrame			= "Zeige Abstandsfenster (12 m)",
	SetIconOnBrand		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74505)
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "Saviana Flammenschlund"
})

L:SetWarningLocalization({
	SpecialWarningTranq		= "Wutanfall - Einlullen/Beruhigen"
})

L:SetOptionLocalization({
	RangeFrame				= "Zeige Abstandsfenster (10 m)",
	BeaconIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74453)
})

L:SetMiscLocalization{
}

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "General Zarithrian"
})

L:SetWarningLocalization({
	WarnAdds	= "Neue Adds",
	warnCleaveArmor	= "%s auf >%s< (%s)"		-- Cleave Armor on >args.destName< (args.amount)
})

L:SetTimerLocalization({
	TimerAdds	= "Neue Adds"
})

L:SetOptionLocalization({
	WarnAdds		= "Verkünde neue Adds",
	TimerAdds		= "Zeige Timer für neue Adds",
	AddsArrive		= "Show timer for adds arrival", --Needs Translating
	warnCleaveArmor	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(74367)
})

L:SetMiscLocalization({
	SummonMinions	= "Äschert sie ein, Lakaien!"
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "Halion der Zwielichtzerstörer"
})

L:SetWarningLocalization({
	TwilightCutterCast	= "Casting Twilight Cutter: 5 sec"
})

L:SetOptionLocalization({
	TwilightCutterCast		= "Show warning when $spell:74769 is being cast", --Needs Translating
	AnnounceAlternatePhase	= "Show warnings/timers for phase you aren't in as well",--Needs Translating
	SetIconOnConsumption	= "Setze Zeichen auf Ziele von Einäschern"--So we can use single functions for both versions of spell."--So we can use single functions for both versions of spell.
})

L:SetMiscLocalization({
	Halion					= "Halion",
	MeteorCast				= "Die Himmel brennen!",
	Phase2					= "Ihr werdet im Reich des Zwielichts nur Leid finden! Tretet ein, wenn ihr es wagt!",
	Phase3					= "Ich bin das Licht und die Dunkelheit! Zittert, Sterbliche, vor dem Herold Todesschwinges!",
	twilightcutter			= "Die kreisenden Sphären pulsieren vor dunkler Energie!",
	Kill					= "Genießt euren Sieg, Sterbliche, denn es war euer letzter. Bei der Rückkehr des Meisters wird diese Welt brennen!"
})
