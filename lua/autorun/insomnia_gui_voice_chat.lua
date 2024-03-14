--PACKAGE: InsomniaInterface
InsomniaInterface = InsomniaInterface or {}

if SERVER then
	AddCSLuaFile("insomnia_gui/shared/cl_fonts.lua")
	AddCSLuaFile("insomnia_gui/shared/cl_vgui.lua")
	AddCSLuaFile("insomnia_gui/voice_chat/cl_voice_chat.lua")
	AddCSLuaFile("insomnia_gui/voice_chat/cl_voice_queue.lua")
	AddCSLuaFile("insomnia_gui/voice_chat/sh_config.lua")
	
	util.AddNetworkString("InsomniaInterface_VoiceChat_HideTalkIcon")
	hook.Add("PlayerInitialSpawn", "InsomniaInterface_VoiceChat_HideTalkIcon", function(ply)
		net.Start("InsomniaInterface_VoiceChat_HideTalkIcon")
		net.Send(ply)
	end)
else
	include("insomnia_gui/voice_chat/cl_voice_chat.lua")
	InsomniaInterface.VoiceChat:Initialize()
end