﻿if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "Opciones"
})

L:SetTimerLocalization({
	TimerInvite = "%s"
})

L:SetOptionLocalization({
	ColorByClass	= "Mostrar colores de clases en la Tabla de Estadísticas.",
	ShowInviteTimer	= "Mostrar tiempo restante para entrar en batalla.",
	AutoSpirit	= "Liberar espíritu automaticamente"
})

L:SetMiscLocalization({
	ArenaInvite	= "Mostrar tiempo para la Arena"
})


--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "Arena"
})

L:SetTimerLocalization({
	TimerStart	= "¡La arena va a Comenzar!",
	TimerShadow	= "Visión de las Sombras"
})

L:SetOptionLocalization({
	TimerStart	= "Mostrar tiempo para que la Arena empieze.",
	TimerShadow 	= "Mostrar tiempo para que salga Visión de las Sombras."
})

L:SetMiscLocalization({
    Start60     = "¡Un minuto hasta que comience la batalla en la arena!",
	Start30		= "¡Treinta segundos hasta que comience la batalla en arena!",
	Start15		= "¡Quince segundos hasta que comience la batalla en arena!"
})

---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "Valle de Alterac"
})

L:SetTimerLocalization({
	TimerStart		= "La batalla comezara en", 
	TimerTower		= "%s",
	TimerGY			= "%s",
})

L:SetMiscLocalization({
	BgStart60		= "1 minuto para que dé comienzo la batalla por el Valle de Alterac.",
	BgStart30		= "30 segundos para que dé comienzo la batalla por el Valle de Alterac.",
	ZoneName		= "Valle de Alterac"
})

L:SetOptionLocalization({
	TimerStart		= "Mostrar tiempo para que comienze la Batalla.",
	TimerTower		= "Mostrar tiempo para conquistar las Torres.",
	TimerGY			= "Mostrar tiempo para conquistar los Cementerios.",
	AutoTurnIn		= "Completar automaticamente las misiones de entregar piezas."
})

---------------
--  Arathi  --
---------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "Cuenca de Arathi"
})

L:SetMiscLocalization({
	BgStart60		= "La batalla por la Cuenca de Arathi comenzará en 1 minuto.",
	BgStart30		= "La Batalla por la Cuenca de Arathi comenzará en 30 segundos.",
	ZoneName 		= "Cuenca de Arathi",
	ScoreExpr 		= "(%d+)/1600",
	Alliance 		= "La Alianza",
	Horde 			= "La Horda",
	WinBarText 		= "%s ganara en",
	BasesToWin 		= "Bases necesarias para ganar: %d",
	Flag 			= "Bandera"
})

L:SetTimerLocalization({
	TimerStart 		= "¡La batalla va Comenzar!", 
	TimerCap 		= "%s",
})

L:SetOptionLocalization({
	TimerStart  		= "Mostrar tiempo para que comienze la Batalla.",
	TimerWin 		= "Mostrar tiempo para que una faccion Gane la Batalla.",
	TimerCap 		= "Mostrar tiempo que tarda en conquistar Banderas.",
	ShowAbEstimatedPoints	= "Mostrar recursos estimados a ganar.",
	ShowAbBasesToWin	= "Mostrar bases para ganar."
})

-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name = "Ojo de la Tormenta"
})

L:SetMiscLocalization({
	BgStart60		= "¡La batalla comienza en un minuto!",
	BgStart30		= "¡La batalla comienza en treinta segundos!",
	ZoneName		= "Ojo de la Tormenta",
	ScoreExpr		= "(%d+)/1600",
	Alliance 		= "Alianza",
	Horde 			= "Horda",
	WinBarText 		= "%s ganara en",
	FlagReset 		= "La bandera se ha restablecido.",
	FlagTaken 		= "¡ (.+) ha tomado la bandera!",
	FlagCaptured 		= "¡La .+ ha%w+ ha capturado la bandera!",
	FlagDropped 		= "¡Ha caído la bandera!",

})

L:SetTimerLocalization({
	TimerStart 		= "¡La batalla va a Comenzar!", 
	TimerFlag 		= "Bandera Restablecida",
})

L:SetOptionLocalization({
	TimerStart  		= "Mostrar tiempo para que comienze la Batalla.",
	TimerWin 		= "Mostrar tiempo para que una faccion Gane la Batalla.",
	TimerFlag 		= "Mostrar tiempo que tarda en restablecer la Bandera.",
	ShowPointFrame 		= "Ver puntos que dara la bandera.",
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "Garganta Grito de Guerra"
})

L:SetMiscLocalization({
	BgStart60 			= "La batalla por la Garganta Grito de Guerra comenzará en 1 minuto.",
	BgStart30 			= "La batalla por la Garganta Grito de Guerra comenzará en 30 segundos. ¡Preparaos!",
	ZoneName 			= "Garganta Grito de Guerra",
	Alliance 			= "Alianza",
	Horde 				= "Horda",	
	InfoErrorText 			= "The flag carrier targeting function will be restored when you are out of combat.",
	ExprFlagPickUp 			= "¡(.+) ha cogido la bandera de la (%w+)!",
	ExprFlagCaptured 		= "¡(.+) ha capturado la bandera de la (%w+)!",
	ExprFlagReturn 			= "¡(.+) ha devuelto la bandera de la (%w+) a su base!",
	FlagAlliance 			= "Banderas capturadas por la Alianza: ",
	FlagHorde			= "Banderas capturadas por la Horda: ",
	FlagBase			= "Base",
})

L:SetTimerLocalization({
	TimerStart 			= "La batalla va comenzar", 
	TimerFlag 			= "La bandera se resetea en",
})

L:SetOptionLocalization({
	TimerStart  			= "Mostrar tiempo para que comienze la Batalla.",
	TimerFlag			= "Mostrar tiempo que tarda en restablecer la Bandera.",
	ShowFlagCarrier			= "Mostrar por donde va la bandera",
	ShowFlagCarrierErrorNote 	= "Mostrar error de por donde va la bandera",
})

------------------------
--  Isle of Conquest  --
------------------------

L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "Isla de la Conquista"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "Máquina de asedio Lista!",
	WarnSiegeEngineSoon	= "Máquina de asedio en ~10 seg"
})

L:SetTimerLocalization({
	TimerStart		= "¡La batalla va comenzar!", 
	TimerPOI		= "%s",
	TimerSiegeEngine	= "Máquina de asedio Lista"
})

L:SetOptionLocalization({
	TimerStart		= "Mostrar tiempo para que comienze la Batalla.", 
	TimerPOI		= "Mostrar tiempo para las Capturas",
	TimerSiegeEngine	= "Mostrar tiempo para la construcción de Máquina de asedio",
	WarnSiegeEngine		= "Mostrar aviso cuando Máquina de asedio esté lista",
	WarnSiegeEngineSoon	= "Mostrar aviso cuando Máquina de asedio esté casi lista"
})

L:SetMiscLocalization({
	ZoneName		= "Isla de la Conquista",
	BgStart60		= "La batalla comenzará en 60 segundos.",
	BgStart30		= "La batalla comenzará en 30 segundos.",
	BgStart15		= "La batalla comenzará en 15 segundos.",
	SiegeEngine				= "Máquina de asedio",
	GoblinStartAlliance		= "¿Ves esas bombas de seforio? Úsalas en las puertas mientras reparo la máquina de asedio.",
	GoblinStartHorde		= "Trabajaré en la máquina de asedio, solo cúbreme las espaldas. ¡Usa esas bombas de seforio en las puertas si las necesitas!",
	GoblinHalfwayAlliance	= "¡Estoy a medias! Mantén a la Horda alejada de aquí. ¡En la escuela de ingeniería no enseñan a luchar!",
	GoblinHalfwayHorde		= "¡Ya casi estoy! Mantén a la Alianza alejada... ¡Luchar no entra en mi contrato!",
	GoblinFinishedAlliance	= "¡Mi mejor obra! ¡Esta máquina de asedio está lista para la acción!",
	GoblinFinishedHorde		= "¡La máquina de asedio está lista para la acción!",
	GoblinBrokenAlliance	= "¿Ya está rota? No pasa nada. No es nada que no pueda arreglar.",
	GoblinBrokenHorde		= "¿Está estropeada otra vez? La arreglaré... pero no esperes que la garantía cubra esto."
})