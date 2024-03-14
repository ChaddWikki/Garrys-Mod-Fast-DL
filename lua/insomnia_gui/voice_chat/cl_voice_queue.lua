if not InsomniaInterface.Fonts then include("insomnia_gui/shared/cl_fonts.lua") end
if not InsomniaInterface.VGUI then include("insomnia_gui/shared/cl_vgui.lua") end
if not InsomniaInterface.VoiceConfig then include("insomnia_gui/voice_chat/sh_config.lua") end

--CLASS: VoiceQueue
InsomniaInterface.VoiceQueue = {}

local max_bars_size = 10
local cur_bars_size = 0
local max_characters = 25
local bar_ranking = {}
local cur_panels = {}

local name_text_size
local job_text_size
local rank_text_size

local sta_geometry = {}
local dyn_geometry = {}

sta_geometry["circles"] = {}
sta_geometry["circles"]["inside"] = {}
sta_geometry["circles"]["outside"] = {}
sta_geometry["parallelogram"] = {}
sta_geometry["avatar"] = {}

for i=1, max_bars_size do
	dyn_geometry[i] = {}
	dyn_geometry[i]["circles"] = {}
	dyn_geometry[i]["circles"]["inside"] = {}
	dyn_geometry[i]["circles"]["outside"] = {}
	dyn_geometry[i]["parallelogram"] = {}
	dyn_geometry[i]["avatar"] = {}
	dyn_geometry[i]["texts"] = {}
	dyn_geometry[i]["texts"]["user"] = {}
	dyn_geometry[i]["texts"]["job"] = {}
	dyn_geometry[i]["texts"]["group"] = {}
end

--Requires the previous calculations before using
function InsomniaInterface.VoiceQueue:AddBar(ply, ttt_special_team)
	local user_name = ply:Name()
	local user_steamid = ply:SteamID()
	local user_job
	local user_group
	
	local b_color
	local t_color
	local sc_color
	local dc_color
	
	if cur_panels[user_steamid] != nil then return end
	if cur_bars_size == max_bars_size then return end
	
	--For some reason the gmod camera leads to system malfunction
	local client = LocalPlayer()
	if IsValid(client) then
		local wep = client:GetActiveWeapon()
		if IsValid(wep) then
			wep = wep:GetClass()
			if wep == "gmod_camera" then return end
		end
	end
	
	cur_bars_size = cur_bars_size + 1
	local first_gap
	local cur_avatar_panel
	local cur_res = InsomniaInterface.VGUI:GetScreenWidthScale()
	
	for k=1, max_bars_size do
		if bar_ranking[k] == nil then
			bar_ranking[k] = true
			first_gap = k
			break
		end
	end
	
	sc_color = InsomniaInterface.VoiceConfig.StaticCircleColor
	dc_color = InsomniaInterface.VoiceConfig.DynamicCircleColor
	
	if GAMEMODE_NAME == "terrortown" then
		if ttt_special_team then
			if ttt_special_team == "s" then
				b_color = Color(255, 255, 0, 180)
				t_color = color_black
				
			elseif ttt_special_team == "t" then
				b_color = Color(255, 0, 0, 180)
				t_color = color_white
				
			else
				b_color = Color(0, 0, 255, 180)
				t_color = color_white
			end
		else
			b_color = InsomniaInterface.VoiceConfig.BackgroundColor
			t_color = InsomniaInterface.VoiceConfig.TextColor
		end
	else
		b_color = InsomniaInterface.VoiceConfig.BackgroundColor
		t_color = InsomniaInterface.VoiceConfig.TextColor
		
		if GAMEMODE_NAME == "darkrp" then
			--If this fails an empty string is returned
			user_job = team.GetName(ply:Team())
		end
	end
	
	if ulx then
		user_group = ply:GetUserGroup()
	end
	
	local first_vertex = math.random(1, sta_geometry["circles"]["s"])
	local cur_polygon_part = InsomniaInterface.VGUI:CalculatePolygonPart(dyn_geometry[first_gap]["circles"]["outside"]["vertexes"], sta_geometry["circles"]["s"],
	{x=dyn_geometry[first_gap]["circles"]["x"], y=dyn_geometry[first_gap]["circles"]["y"]}, first_vertex, sta_geometry["circles"]["outside"]["part_size"])
	
	hook.Add("HUDPaint", "InsomniaInterface_VoiceChat_Users_" .. user_steamid, function()
		if cur_panels[user_steamid] == nil then
			if InsomniaInterface.VoiceConfig.ModelAsAvatar == true then
				cur_panels[user_steamid] = vgui.Create("DPanel")
				cur_avatar_panel = cur_panels[user_steamid]
				cur_avatar_panel.rank = first_gap
				local modelpanel = vgui.Create("DModelPanel", cur_panels[user_steamid])
				InsomniaInterface.VGUI:SetupPlayerAvatar(cur_panels[user_steamid], dyn_geometry[first_gap]["avatar"]["x"], dyn_geometry[first_gap]["avatar"]["y"], sta_geometry["avatar"]["size"], ply, true)
			else
				cur_panels[user_steamid] = vgui.Create("AvatarImage")
				cur_avatar_panel = cur_panels[user_steamid]
				cur_avatar_panel.rank = first_gap
				InsomniaInterface.VGUI:SetupPlayerAvatar(cur_panels[user_steamid], dyn_geometry[first_gap]["avatar"]["x"], dyn_geometry[first_gap]["avatar"]["y"], sta_geometry["avatar"]["size"], ply, false)
				
				timer.Create("InsomniaInterface_VoiceChat_Users2_" .. user_steamid, 3, 0, function()
					if not IsValid(ply) then return end
					local checked_scale = InsomniaInterface.VGUI:GetScreenWidthScale()
					
					if checked_scale == cur_res then return end
					InsomniaInterface.VGUI:SetupPlayerAvatar(cur_panels[user_steamid], dyn_geometry[first_gap]["avatar"]["x"], dyn_geometry[first_gap]["avatar"]["y"], sta_geometry["avatar"]["size"], ply, false)
					cur_res = checked_scale
				end)
			end
		end
		
		draw.RoundedBox(8, dyn_geometry[first_gap]["parallelogram"]["x"], dyn_geometry[first_gap]["parallelogram"]["y"], sta_geometry["parallelogram"]["w"], sta_geometry["parallelogram"]["h"], b_color)
		InsomniaInterface.VGUI:DrawPolygon(dyn_geometry[first_gap]["circles"]["outside"]["vertexes"], sc_color)
		InsomniaInterface.VGUI:DrawPolygon(cur_polygon_part, dc_color)
		InsomniaInterface.VGUI:DrawPanelOnPolygon(dyn_geometry[first_gap]["circles"]["inside"]["vertexes"], cur_panels[user_steamid])
		
		InsomniaInterface.VGUI:DrawText(user_name, "Montreal" .. name_text_size, dyn_geometry[first_gap]["texts"]["user"]["x"], dyn_geometry[first_gap]["texts"]["user"]["y"], t_color,
		TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, max_characters)
		
		if GAMEMODE_NAME == "darkrp" then
			InsomniaInterface.VGUI:DrawText(user_job, "Montreal" .. job_text_size, dyn_geometry[first_gap]["texts"]["job"]["x"], dyn_geometry[first_gap]["texts"]["job"]["y"], t_color,
			TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, max_characters)
		end
		
		if ulx then
			if InsomniaInterface.VoiceConfig.RestrictVisibleUserGroups == false and InsomniaInterface.VoiceConfig.ShowUserGroups == true and user_group != "user" then
				InsomniaInterface.VGUI:DrawTextOutlined(user_group, "Montreal" .. rank_text_size, dyn_geometry[first_gap]["texts"]["group"]["x"], dyn_geometry[first_gap]["texts"]["group"]["y"], color_white,
				TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black, max_characters)
			elseif InsomniaInterface.VoiceConfig.RestrictVisibleUserGroups == true and InsomniaInterface.VoiceConfig.ShowUserGroups == true then
				if InsomniaInterface.VoiceConfig.VisibleUserGroups[user_group] != nil then
					InsomniaInterface.VGUI:DrawTextOutlined(InsomniaInterface.VoiceConfig.VisibleUserGroups[user_group], "Montreal" .. rank_text_size, dyn_geometry[first_gap]["texts"]["group"]["x"], dyn_geometry[first_gap]["texts"]["group"]["y"],
					color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black, max_characters)
				end
			end
		end
	end)
	
	--Moving dynamic circle
	timer.Create("InsomniaInterface_VoiceChat_Users1_" .. user_steamid, 0.06, 0, function()
		if not IsValid(ply) then InsomniaInterface.VoiceQueue:RemoveBar(user_steamid, true) end --security
		
		first_vertex = first_vertex + 1
		cur_polygon_part = InsomniaInterface.VGUI:CalculatePolygonPart(dyn_geometry[first_gap]["circles"]["outside"]["vertexes"], sta_geometry["circles"]["s"],
		{x=dyn_geometry[first_gap]["circles"]["x"], y=dyn_geometry[first_gap]["circles"]["y"]}, first_vertex, sta_geometry["circles"]["outside"]["part_size"])
	end)
end

function InsomniaInterface.VoiceQueue:RemoveBar(ply, is_steamid)
	local user_steamid
	
	if not is_steamid then
		user_steamid = ply:SteamID()
	else
		user_steamid = ply
	end
	
	if cur_panels[user_steamid] == nil then return end
	
	timer.Remove("InsomniaInterface_VoiceChat_Users1_" .. user_steamid)
	timer.Remove("InsomniaInterface_VoiceChat_Users2_" .. user_steamid)
	hook.Remove("HUDPaint", "InsomniaInterface_VoiceChat_Users_" .. user_steamid)
	
	local cur_avatar_panel = cur_panels[user_steamid]
	bar_ranking[cur_avatar_panel.rank] = nil
	
	if cur_panels[user_steamid]:GetClassName() == "DPanel" then
		cur_panels[user_steamid]:GetChild(0):Remove()
	end
	
	cur_panels[user_steamid]:Remove()
	cur_panels[user_steamid] = nil
	cur_bars_size = cur_bars_size - 1
end

--avoiding intensive calculations in HUDPaint
function InsomniaInterface.VoiceQueue:CalculatePositions()
	local scale_factor
	local cur_scale_w = ScrW()/1920
	
	if InsomniaInterface.VoiceConfig.ScreenScale == true then
		scale_factor = InsomniaInterface.VGUI:GetScreenWidthScale()
		if scale_factor < 1 then scale_factor = scale_factor + (1 - scale_factor)/3 end
	else
		scale_factor = 1
	end
	
	name_text_size = math.floor(math.Clamp(17*scale_factor, 7, 21))
	job_text_size = math.floor(math.Clamp(17*scale_factor, 7, 21))
	rank_text_size = math.floor(math.Clamp(15*scale_factor, 7, 21))
	
	sta_geometry["circles"]["s"] = math.floor(30*scale_factor)
	sta_geometry["circles"]["inside"]["r"] = 27*scale_factor
	sta_geometry["circles"]["outside"]["r"] = 30*scale_factor
	sta_geometry["circles"]["outside"]["part_size"] = 0.4*(sta_geometry["circles"]["s"])
	sta_geometry["avatar"]["size"] = 2*(sta_geometry["circles"]["inside"]["r"])
	
	sta_geometry["parallelogram"]["w"] = 8*(sta_geometry["circles"]["inside"]["r"]) + 25*scale_factor
	
	if GAMEMODE_NAME == "darkrp" then
		sta_geometry["parallelogram"]["h"] = (8/5)*(sta_geometry["circles"]["inside"]["r"])
	else
		sta_geometry["parallelogram"]["h"] = (6/5)*(sta_geometry["circles"]["inside"]["r"])
	end
	
	if GAMEMODE_NAME == "terrortown" then
		for i=1, max_bars_size do
			dyn_geometry[i]["circles"]["x"] = 55*scale_factor
			dyn_geometry[i]["circles"]["y"] = 60*scale_factor + (i-1)*(2*(sta_geometry["circles"]["outside"]["r"]) + 5*scale_factor) + (InsomniaInterface.VoiceConfig.ScreenOffset)*cur_scale_w
		end
	else
		for i=1, max_bars_size do
			dyn_geometry[i]["circles"]["x"] = 1920*cur_scale_w - (sta_geometry["parallelogram"]["w"] + 20*scale_factor)
			dyn_geometry[i]["circles"]["y"] = 920*cur_scale_w - (i-1)*(2*(sta_geometry["circles"]["outside"]["r"]) + 5*scale_factor) - (InsomniaInterface.VoiceConfig.ScreenOffset)*cur_scale_w
		end
	end
	
	for i=1, max_bars_size do
		dyn_geometry[i]["parallelogram"]["x"] = dyn_geometry[i]["circles"]["x"]
		dyn_geometry[i]["parallelogram"]["y"] = dyn_geometry[i]["circles"]["y"] - (sta_geometry["parallelogram"]["h"])/2
		
		dyn_geometry[i]["avatar"]["x"] = dyn_geometry[i]["circles"]["x"] - sta_geometry["circles"]["inside"]["r"]
		dyn_geometry[i]["avatar"]["y"] = dyn_geometry[i]["circles"]["y"] - sta_geometry["circles"]["inside"]["r"]
		
		dyn_geometry[i]["circles"]["inside"]["vertexes"] = InsomniaInterface.VGUI:CalculateRegularPolygon(dyn_geometry[i]["circles"]["x"], dyn_geometry[i]["circles"]["y"], sta_geometry["circles"]["inside"]["r"], sta_geometry["circles"]["s"])
		dyn_geometry[i]["circles"]["outside"]["vertexes"] = InsomniaInterface.VGUI:CalculateRegularPolygon(dyn_geometry[i]["circles"]["x"], dyn_geometry[i]["circles"]["y"], sta_geometry["circles"]["outside"]["r"], sta_geometry["circles"]["s"])
		
		dyn_geometry[i]["texts"]["group"]["x"] = dyn_geometry[i]["circles"]["x"] + sta_geometry["parallelogram"]["w"]
		dyn_geometry[i]["texts"]["group"]["y"] = dyn_geometry[i]["circles"]["y"] - (sta_geometry["parallelogram"]["h"])/2
		
		dyn_geometry[i]["texts"]["user"]["x"] = dyn_geometry[i]["circles"]["x"] + sta_geometry["circles"]["outside"]["r"] + 10*scale_factor
	end
	
	if GAMEMODE_NAME == "darkrp" then
		for i=1, max_bars_size do
			dyn_geometry[i]["texts"]["user"]["y"] = dyn_geometry[i]["circles"]["y"] - (sta_geometry["parallelogram"]["h"])/5
			dyn_geometry[i]["texts"]["job"]["x"] = dyn_geometry[i]["texts"]["user"]["x"]
			dyn_geometry[i]["texts"]["job"]["y"] = dyn_geometry[i]["circles"]["y"] + (sta_geometry["parallelogram"]["h"])/5
		end
	else
		for i=1, max_bars_size do
			dyn_geometry[i]["texts"]["user"]["y"] = dyn_geometry[i]["circles"]["y"]
		end
	end
end