if not InsomniaInterface.Fonts then include("insomnia_gui/shared/cl_fonts.lua") end
if not InsomniaInterface.VGUI then include("insomnia_gui/shared/cl_vgui.lua") end
if not InsomniaInterface.VoiceQueue then include("insomnia_gui/voice_chat/cl_voice_queue.lua") end
if not InsomniaInterface.VoiceConfig then include("insomnia_gui/voice_chat/sh_config.lua") end

--CLASS: VoiceChat
InsomniaInterface.VoiceChat = {}

local menu
local spk_icon = Material("voice/icntlk_pl")

function InsomniaInterface.VoiceChat:Initialize()
	hook.Add("Initialize", "InsomniaInterface_VoiceChat_Initialize", function()
		concommand.Add("insomnia_voicechat", function()
			if menu == nil then
				InsomniaInterface.VoiceChat:BuildConfigMenu()
			end
		end)
		
		hook.Add("OnPlayerChat", "InsomniaInterface_VoiceChat_ChatCommands", function(ply, text)
			if (string.lower(text) == "!insomnia_voicechat") or (string.lower(text) == "/insomnia_voicechat") then
				if ply != LocalPlayer() then return end
				ply:ConCommand("insomnia_voicechat")
				return true
			end
		end)
		
		--This message is not really useful if current gamemode is not DarkRP.
		if GAMEMODE_NAME == "darkrp" then
			if InsomniaInterface.VoiceConfig.DisableAddon == false then
				net.Receive("InsomniaInterface_VoiceChat_HideTalkIcon", function()
					spk_icon:SetInt("$alpha", 0)
				end)
			end
		end
		
		InsomniaInterface.VoiceQueue:CalculatePositions()
		timer.Create("InsomniaInterface_VoiceChat_ScreenWidthScale", 3, 0, function()
			if not (InsomniaInterface.VGUI:ScreenWidthScaleChanged() == true) then return end
			InsomniaInterface.VGUI:UpdateScreenWidthScale()
			InsomniaInterface.VoiceQueue:CalculatePositions()
		end)
		
		hook.Add("PlayerStartVoice", "InsomniaInterface_VoiceChat_StartVoice", function(ply) InsomniaInterface.VoiceChat:StartVoice(ply) end)
		hook.Add("PlayerEndVoice", "InsomniaInterface_VoiceChat_EndVoice", function(ply) InsomniaInterface.VoiceChat:EndVoice(ply) end)
	end)
end

function InsomniaInterface.VoiceChat:StartVoice(ply)
	if not IsValid(ply) then return end
	if InsomniaInterface.VoiceConfig.DisableAddon == true then g_VoicePanelList:SetVisible(true) return end
	local client = LocalPlayer()
	
	--Only current way to hide the default voice chat bars.
	g_VoicePanelList:SetVisible(false)
	
	if GAMEMODE_NAME == "terrortown" then
		if ply:Team() == TEAM_SPEC then
			InsomniaInterface.VoiceQueue:AddBar(ply, "s")
			return
			
		elseif ply:IsActiveDetective() then
			InsomniaInterface.VoiceQueue:AddBar(ply, "d")
			return
			
		elseif client:IsActiveTraitor() then
			if ply == client then
				if (not client:KeyDown(IN_SPEED)) and (not client:KeyDownLast(IN_SPEED)) then
					client.traitor_gvoice = true
				else
					client.traitor_gvoice = false
				end
				
				if not client.traitor_gvoice then
					InsomniaInterface.VoiceQueue:AddBar(ply, "t")
					return
				end
				
			elseif ply:IsActiveTraitor() then
				if not ply.traitor_gvoice then
					InsomniaInterface.VoiceQueue:AddBar(ply, "t")
					return
				end
			end
		end
	end
	
	InsomniaInterface.VoiceQueue:AddBar(ply)
end

function InsomniaInterface.VoiceChat:EndVoice(ply)
	if not IsValid(ply) then return end
	InsomniaInterface.VoiceQueue:RemoveBar(ply)
end

function InsomniaInterface.VoiceChat:BuildConfigMenu()
	local check
	local c
	
	menu = vgui.Create("DFrame")
	menu:SetSize(575, 705)
	menu:Center()
	menu:SetTitle("Insomnia Interface: Voice Chat Config")
	menu:SetDraggable(true)
	menu:MakePopup()
	
	function menu:OnClose()
		menu = nil
	end
	
	local disableaddon = vgui.Create("DCheckBoxLabel", menu)
	disableaddon:SetText("Disable voice bars (Default bars will show up again).")
	disableaddon:SetPos(25, 50)
	
	if InsomniaInterface.VoiceConfig.DisableAddon == true then
		disableaddon:SetChecked(true)
	else
		disableaddon:SetChecked(false)
	end
	
	function disableaddon:OnChange(bVal)
		InsomniaInterface.VoiceConfig.DisableAddon = bVal
		
		if GAMEMODE_NAME == "darkrp" then
			if bVal == true then
				spk_icon:SetInt("$alpha", 1)
			else
				spk_icon:SetInt("$alpha", 0)
			end
		end
		
		if bVal == true then
			check = sql.Query("INSERT INTO InsomniaInterface_VoiceChat(Name, Value) VALUES('DisableAddon', '1')")
			if check == false then
				sql.Query("UPDATE InsomniaInterface_VoiceChat SET Value='1' WHERE Name='DisableAddon'")
			end
		else
			check = sql.Query("INSERT INTO InsomniaInterface_VoiceChat(Name, Value) VALUES('DisableAddon', '0')")
			if check == false then
				sql.Query("UPDATE InsomniaInterface_VoiceChat SET Value='0' WHERE Name='DisableAddon'")
			end
		end
	end
	
	local screenscale = vgui.Create("DCheckBoxLabel", menu)
	screenscale:SetText("Resize the bars if your resolution is not 1080p to fit your screen.")
	screenscale:SetPos(25, 75)
	
	if InsomniaInterface.VoiceConfig.ScreenScale == true then
		screenscale:SetChecked(true)
	else
		screenscale:SetChecked(false)
	end
	
	function screenscale:OnChange(bVal)
		InsomniaInterface.VoiceConfig.ScreenScale = bVal
		
		if InsomniaInterface.VGUI:GetScreenWidthScale() != 1 then
			InsomniaInterface.VoiceQueue:CalculatePositions()
		end
		
		if bVal == true then
			check = sql.Query("INSERT INTO InsomniaInterface_VoiceChat(Name, Value) VALUES('ScreenScale', '1')")
			if check == false then
				sql.Query("UPDATE InsomniaInterface_VoiceChat SET Value='1' WHERE Name='ScreenScale'")
			end
		else
			check = sql.Query("INSERT INTO InsomniaInterface_VoiceChat(Name, Value) VALUES('ScreenScale', '0')")
			if check == false then
				sql.Query("UPDATE InsomniaInterface_VoiceChat SET Value='0' WHERE Name='ScreenScale'")
			end
		end
	end
	
	local modelasavatar = vgui.Create("DCheckBoxLabel", menu)
	modelasavatar:SetText("Use playermodels as avatars.")
	modelasavatar:SetPos(25, 100)
	
	if InsomniaInterface.VoiceConfig.ModelAsAvatar == true then
		modelasavatar:SetChecked(true)
	else
		modelasavatar:SetChecked(false)
	end
	
	function modelasavatar:OnChange(bVal)
		InsomniaInterface.VoiceConfig.ModelAsAvatar = bVal
		
		if bVal == true then
			check = sql.Query("INSERT INTO InsomniaInterface_VoiceChat(Name, Value) VALUES('ModelAsAvatar', '1')")
			if check == false then
				sql.Query("UPDATE InsomniaInterface_VoiceChat SET Value='1' WHERE Name='ModelAsAvatar'")
			end
		else
			check = sql.Query("INSERT INTO InsomniaInterface_VoiceChat(Name, Value) VALUES('ModelAsAvatar', '0')")
			if check == false then
				sql.Query("UPDATE InsomniaInterface_VoiceChat SET Value='0' WHERE Name='ModelAsAvatar'")
			end
		end
	end
	
	local showusergroups = vgui.Create("DCheckBoxLabel", menu)
	showusergroups:SetText("Show user groups over the bars (ULX is required on the server).")
	showusergroups:SetPos(25, 125)
	
	if InsomniaInterface.VoiceConfig.ShowUserGroups == true then
		showusergroups:SetChecked(true)
	else
		showusergroups:SetChecked(false)
	end
	
	function showusergroups:OnChange(bVal)
		InsomniaInterface.VoiceConfig.ShowUserGroups = bVal
		
		if bVal == true then
			check = sql.Query("INSERT INTO InsomniaInterface_VoiceChat(Name, Value) VALUES('ShowUserGroups', '1')")
			if check == false then
				sql.Query("UPDATE InsomniaInterface_VoiceChat SET Value='1' WHERE Name='ShowUserGroups'")
			end
		else
			check = sql.Query("INSERT INTO InsomniaInterface_VoiceChat(Name, Value) VALUES('ShowUserGroups', '0')")
			if check == false then
				sql.Query("UPDATE InsomniaInterface_VoiceChat SET Value='0' WHERE Name='ShowUserGroups'")
			end
		end
	end
	
	local screenoffset = vgui.Create("DNumSlider", menu)
	screenoffset:SetText("First bar origin (offset)")
	screenoffset:SetSize(400, 20)
	screenoffset:SetPos(25, 150)
	screenoffset:SetDecimals(0)
	screenoffset:SetMin(InsomniaInterface.VoiceConfig.MinOffset)
	screenoffset:SetMax(InsomniaInterface.VoiceConfig.MaxOffset)
	screenoffset:SetValue(InsomniaInterface.VoiceConfig.ScreenOffset)
	
	function screenoffset:OnValueChanged(value)
		value = math.Round(value)
		InsomniaInterface.VoiceConfig.ScreenOffset = value
		
		InsomniaInterface.VoiceQueue:CalculatePositions()
		value = tostring(value)
		
		check = sql.Query("INSERT INTO InsomniaInterface_VoiceChat(Name, Value) VALUES('ScreenOffset', '" .. value .. "')")
		if check == false then
			sql.Query("UPDATE InsomniaInterface_VoiceChat SET Value='" .. value .. "' WHERE Name='ScreenOffset'")
		end
	end
	
	local backgroundcolor_f = vgui.Create("DFrame", menu)
	backgroundcolor_f:SetSize(250, 200)
	backgroundcolor_f:SetPos(25, 200)
	backgroundcolor_f:ShowCloseButton(false)
	backgroundcolor_f:SetTitle("Background color")
	backgroundcolor_f:SetDraggable(false)
	
	local backgroundcolor = vgui.Create("DColorMixer", backgroundcolor_f)
	backgroundcolor:Dock(FILL)
	backgroundcolor:SetPalette(true)
	backgroundcolor:SetAlphaBar(true)
	backgroundcolor:SetWangs(true)
	backgroundcolor:SetColor(Color(InsomniaInterface.VGUI:ColorToComponents(InsomniaInterface.VoiceConfig.BackgroundColor)))
	
	function backgroundcolor:ValueChanged(col)
		InsomniaInterface.VoiceConfig.BackgroundColor = Color(InsomniaInterface.VGUI:ColorToComponents(col))
		c = string.FromColor(col)
		
		check = sql.Query("INSERT INTO InsomniaInterface_VoiceChat(Name, Value) VALUES('BackgroundColor', '" .. c .. "')")
		if check == false then
			sql.Query("UPDATE InsomniaInterface_VoiceChat SET Value='" .. c .. "' WHERE Name='BackgroundColor'")
		end
	end
	
	local textcolor_f = vgui.Create("DFrame", menu)
	textcolor_f:SetSize(250, 200)
	textcolor_f:SetPos(300, 200)
	textcolor_f:ShowCloseButton(false)
	textcolor_f:SetTitle("Text Color")
	textcolor_f:SetDraggable(false)
	
	local textcolor = vgui.Create("DColorMixer", textcolor_f)
	textcolor:Dock(FILL)
	textcolor:SetPalette(true)
	textcolor:SetAlphaBar(false)
	textcolor:SetWangs(true)
	textcolor:SetColor(Color(InsomniaInterface.VGUI:ColorToComponents(InsomniaInterface.VoiceConfig.TextColor)))
	
	function textcolor:ValueChanged(col)
		InsomniaInterface.VoiceConfig.TextColor = Color(InsomniaInterface.VGUI:ColorToComponents(col))
		c = string.FromColor(col)
		
		check = sql.Query("INSERT INTO InsomniaInterface_VoiceChat(Name, Value) VALUES('TextColor', '" .. c .. "')")
		if check == false then
			sql.Query("UPDATE InsomniaInterface_VoiceChat SET Value='" .. c .. "' WHERE Name='TextColor'")
		end
	end
	
	local sta_circle_f = vgui.Create("DFrame", menu)
	sta_circle_f:SetSize(250, 200)
	sta_circle_f:SetPos(25, 425)
	sta_circle_f:ShowCloseButton(false)
	sta_circle_f:SetTitle("Static circle color")
	sta_circle_f:SetDraggable(false)
	
	local sta_circle = vgui.Create("DColorMixer", sta_circle_f)
	sta_circle:Dock(FILL)
	sta_circle:SetPalette(true)
	sta_circle:SetAlphaBar(false)
	sta_circle:SetWangs(true)
	sta_circle:SetColor(Color(InsomniaInterface.VGUI:ColorToComponents(InsomniaInterface.VoiceConfig.StaticCircleColor)))
	
	function sta_circle:ValueChanged(col)
		InsomniaInterface.VoiceConfig.StaticCircleColor = Color(InsomniaInterface.VGUI:ColorToComponents(col))
		c = string.FromColor(col)
		
		check = sql.Query("INSERT INTO InsomniaInterface_VoiceChat(Name, Value) VALUES('StaticCircleColor', '" .. c .. "')")
		if check == false then
			sql.Query("UPDATE InsomniaInterface_VoiceChat SET Value='" .. c .. "' WHERE Name='StaticCircleColor'")
		end
	end
	
	local dyn_circle_f = vgui.Create("DFrame", menu)
	dyn_circle_f:SetSize(250, 200)
	dyn_circle_f:SetPos(300, 425)
	dyn_circle_f:ShowCloseButton(false)
	dyn_circle_f:SetTitle("Dynamic circle color")
	dyn_circle_f:SetDraggable(false)
	
	local dyn_circle = vgui.Create("DColorMixer", dyn_circle_f)
	dyn_circle:Dock(FILL)
	dyn_circle:SetPalette(true)
	dyn_circle:SetAlphaBar(false)
	dyn_circle:SetWangs(true)
	dyn_circle:SetColor(Color(InsomniaInterface.VGUI:ColorToComponents(InsomniaInterface.VoiceConfig.DynamicCircleColor)))
	
	function dyn_circle:ValueChanged(col)
		InsomniaInterface.VoiceConfig.DynamicCircleColor = Color(InsomniaInterface.VGUI:ColorToComponents(col))
		c = string.FromColor(col)
		
		check = sql.Query("INSERT INTO InsomniaInterface_VoiceChat(Name, Value) VALUES('DynamicCircleColor', '" .. c .. "')")
		if check == false then
			sql.Query("UPDATE InsomniaInterface_VoiceChat SET Value='" .. c .. "' WHERE Name='DynamicCircleColor'")
		end
	end
	
	local resetbutton = vgui.Create("DButton", menu)
	resetbutton:SetText("Reset all settings")
	resetbutton:SetSize(100, 30)
	resetbutton:SetPos(25, 650)
	
	function resetbutton:DoClick()
		disableaddon:SetChecked(InsomniaInterface.VoiceConfig.def_DisableAddon)
		screenscale:SetChecked(InsomniaInterface.VoiceConfig.def_ScreenScale)
		screenoffset:SetValue(math.Clamp(InsomniaInterface.VoiceConfig.def_ScreenOffset, InsomniaInterface.VoiceConfig.MinOffset, InsomniaInterface.VoiceConfig.MaxOffset))
		modelasavatar:SetChecked(InsomniaInterface.VoiceConfig.def_ModelAsAvatar)
		backgroundcolor:SetColor(Color(InsomniaInterface.VGUI:ColorToComponents(InsomniaInterface.VoiceConfig.def_BackgroundColor)))
		textcolor:SetColor(Color(InsomniaInterface.VGUI:ColorToComponents(InsomniaInterface.VoiceConfig.def_TextColor)))
		sta_circle:SetColor(Color(InsomniaInterface.VGUI:ColorToComponents(InsomniaInterface.VoiceConfig.def_StaticCircleColor)))
		dyn_circle:SetColor(Color(InsomniaInterface.VGUI:ColorToComponents(InsomniaInterface.VoiceConfig.def_DynamicCircleColor)))
		showusergroups:SetChecked(InsomniaInterface.VoiceConfig.def_ShowUserGroups)
		
		InsomniaInterface.VoiceConfig:CopyDefaultValues()
		InsomniaInterface.VoiceQueue:CalculatePositions()
		sql.Query("DELETE FROM InsomniaInterface_VoiceChat")
		
		if GAMEMODE_NAME == "darkrp" then
			if InsomniaInterface.VoiceConfig.DisableAddon == false then
				spk_icon:SetInt("$alpha", 0)
			end
		end
	end
end