﻿if GetLocale() ~= "koKR" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "오닉시아"
}

L:SetWarningLocalization{
	WarnWhelpsSoon		= "곧 새끼용 등장",
	WarnPhase2Soon		= "곧 2 페이즈",	
	WarnPhase3Soon		= "곧 3 페이즈"	
}

L:SetTimerLocalization{
	TimerWhelps 		= "새끼용"
}

L:SetOptionLocalization{
	TimerWhelps				= "새끼용 등장 타이머 보기",
	WarnWhelpsSoon			= "새끼용 등장의 사전 경고 보기",
	SoundWTF				= "독특한 레이드를 즐기기위한 웃긴 소리 재생.(가급적 안하시길 권장)",
	WarnPhase2Soon			= "2 페이즈 사전 경고 보기(67% 이하가 될 경우)",	
	WarnPhase3Soon			= "3 페이즈 사전 경고 보기(41% 이하가 될 경우)"	
}

L:SetMiscLocalization{ 
	YellP2 		= "쓸데없이 힘을 쓰는 것도 지루하군. 네 녀석들 머리 위에서 모조리 불살라 주마!",
	YellP3 		= "혼이 더 나야 정신을 차리겠구나!"
}
