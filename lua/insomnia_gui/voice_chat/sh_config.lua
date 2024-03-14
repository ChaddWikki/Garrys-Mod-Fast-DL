InsomniaInterface.VoiceConfig = {} --Do not edit this.
InsomniaInterface.VoiceConfig.Translations = {}

--This configuration can be edited in-game by any user via:
--Chat: !insomnia_voicechat, /insomnia_voicechat
--Console: insomnia_voicechat
--Here you are just setting the default values. If a user has not saved something manually, he will load this config.

--"true" to disable this addon. Default voice bars will be shown again.
InsomniaInterface.VoiceConfig.def_DisableAddon = false

--To resize the bar for users with smaller or bigger screen resolutions than 1920x1080, so it does not look "too" big.
--Users with small screen sizes will not fully see the largest names. This is to avoid scaling texts, which would make them unreadable.
InsomniaInterface.VoiceConfig.def_ScreenScale = true

--If you are using a big HUD, you might want that bars appears higher or lower to resolve problems of overlapping (allowed values are [-115, 310]).
InsomniaInterface.VoiceConfig.def_ScreenOffset = 0

--To show user's playermodels on the bar (false = steam avatar).
InsomniaInterface.VoiceConfig.def_ModelAsAvatar = false

--COLORS: ON TTT TRY TO AVOID RED, BLUE AND YELLOW COLORS (TRAITORS, DETECTIVES AND SPECTATORS USE THOSE COLORS AUTOMATICALLY)
InsomniaInterface.VoiceConfig.def_BackgroundColor = Color(0, 0, 0, 180)
InsomniaInterface.VoiceConfig.def_TextColor = Color(255, 255, 255)
InsomniaInterface.VoiceConfig.def_StaticCircleColor = Color(0, 150, 0)
InsomniaInterface.VoiceConfig.def_DynamicCircleColor = Color(0, 255, 0)

--ULX IS REQUIRED IF YOU WANT TO USE THE FOLLOWING VARIABLES!

--Setting this variable to false disables the text which shows any user rank over the chat bar.
--Users can change it later.
InsomniaInterface.VoiceConfig.def_ShowUserGroups = true

--If you set this to true ONLY the groups you have included into the following list will be shown to players.
--Once set, users can not change it in-game. Useful if you want to hide a rank.
InsomniaInterface.VoiceConfig.RestrictVisibleUserGroups = false

--The list stated before. If "RestrictVisibleUserGroups" is set to "false", then this WILL NOT be used.
--Do you want to fully disable the "rank" feature? Leave the list empty.
--LEFT = The exact name of the user group.
--RIGHT = The name you want to be shown.
InsomniaInterface.VoiceConfig.VisibleUserGroups = {
	superadmin = "SuperAdmin",
	admin = "Admin",
	moderator = "Moderator",
	vip = "Vip"
}

--CONFIG ENDS HERE. DO NOT MAKE CHANGES BELOW THIS LINE.
InsomniaInterface.VoiceConfig.MinOffset = -115
InsomniaInterface.VoiceConfig.MaxOffset = 310

function InsomniaInterface.VoiceConfig:LoadDatabaseVar(name, var_type)
	local check
	local a
	
	check = sql.Query("SELECT * FROM InsomniaInterface_VoiceChat WHERE Name='" .. name .. "'")
	if check == nil or check == false then return end
	
	if var_type == "b" then
		return tobool(check[1]["Value"])
		
	elseif var_type == "n" then
		a = tonumber(check[1]["Value"])
		if a == nil then return end
		return math.Clamp(a, InsomniaInterface.VoiceConfig.MinOffset, InsomniaInterface.VoiceConfig.MaxOffset)
		
	else
		a = string.ToColor(check[1]["Value"])
		if a == nil then return end
		return a
	end
end

function InsomniaInterface.VoiceConfig:LoadSavedSettings()
	if not sql.TableExists("InsomniaInterface_VoiceChat") then
		sql.Query("CREATE TABLE InsomniaInterface_VoiceChat(Name VARCHAR(25) PRIMARY KEY, Value VARCHAR(15) NOT NULL)")
	end
	
	InsomniaInterface.VoiceConfig.DisableAddon = InsomniaInterface.VoiceConfig:LoadDatabaseVar("DisableAddon", "b")
	if InsomniaInterface.VoiceConfig.DisableAddon == nil then InsomniaInterface.VoiceConfig.DisableAddon = InsomniaInterface.VoiceConfig.def_DisableAddon end
	
	InsomniaInterface.VoiceConfig.ScreenScale = InsomniaInterface.VoiceConfig:LoadDatabaseVar("ScreenScale", "b")
	if InsomniaInterface.VoiceConfig.ScreenScale == nil then InsomniaInterface.VoiceConfig.ScreenScale = InsomniaInterface.VoiceConfig.def_ScreenScale end
	
	InsomniaInterface.VoiceConfig.ScreenOffset = InsomniaInterface.VoiceConfig:LoadDatabaseVar("ScreenOffset", "n")
	if InsomniaInterface.VoiceConfig.ScreenOffset == nil then InsomniaInterface.VoiceConfig.ScreenOffset = InsomniaInterface.VoiceConfig.def_ScreenOffset end
	
	InsomniaInterface.VoiceConfig.ModelAsAvatar = InsomniaInterface.VoiceConfig:LoadDatabaseVar("ModelAsAvatar", "b")
	if InsomniaInterface.VoiceConfig.ModelAsAvatar == nil then InsomniaInterface.VoiceConfig.ModelAsAvatar = InsomniaInterface.VoiceConfig.def_ModelAsAvatar end
	
	InsomniaInterface.VoiceConfig.BackgroundColor = InsomniaInterface.VoiceConfig:LoadDatabaseVar("BackgroundColor", "c")
	if InsomniaInterface.VoiceConfig.BackgroundColor == nil then InsomniaInterface.VoiceConfig.BackgroundColor = InsomniaInterface.VoiceConfig.def_BackgroundColor end
	
	InsomniaInterface.VoiceConfig.TextColor = InsomniaInterface.VoiceConfig:LoadDatabaseVar("TextColor", "c")
	if InsomniaInterface.VoiceConfig.TextColor == nil then InsomniaInterface.VoiceConfig.TextColor = InsomniaInterface.VoiceConfig.def_TextColor end
	
	InsomniaInterface.VoiceConfig.StaticCircleColor = InsomniaInterface.VoiceConfig:LoadDatabaseVar("StaticCircleColor", "c")
	if InsomniaInterface.VoiceConfig.StaticCircleColor == nil then InsomniaInterface.VoiceConfig.StaticCircleColor = InsomniaInterface.VoiceConfig.def_StaticCircleColor end
	
	InsomniaInterface.VoiceConfig.DynamicCircleColor = InsomniaInterface.VoiceConfig:LoadDatabaseVar("DynamicCircleColor", "c")
	if InsomniaInterface.VoiceConfig.DynamicCircleColor == nil then InsomniaInterface.VoiceConfig.DynamicCircleColor = InsomniaInterface.VoiceConfig.def_DynamicCircleColor end
	
	InsomniaInterface.VoiceConfig.ShowUserGroups = InsomniaInterface.VoiceConfig:LoadDatabaseVar("ShowUserGroups", "b")
	if InsomniaInterface.VoiceConfig.ShowUserGroups == nil then InsomniaInterface.VoiceConfig.ShowUserGroups = InsomniaInterface.VoiceConfig.def_ShowUserGroups end
end
InsomniaInterface.VoiceConfig:LoadSavedSettings()

function InsomniaInterface.VoiceConfig:CopyDefaultValues()
	InsomniaInterface.VoiceConfig.DisableAddon = InsomniaInterface.VoiceConfig.def_DisableAddon
	InsomniaInterface.VoiceConfig.ScreenScale = InsomniaInterface.VoiceConfig.def_ScreenScale
	InsomniaInterface.VoiceConfig.ScreenOffset = math.Clamp(InsomniaInterface.VoiceConfig.def_ScreenOffset, InsomniaInterface.VoiceConfig.MinOffset, InsomniaInterface.VoiceConfig.MaxOffset)
	InsomniaInterface.VoiceConfig.ModelAsAvatar = InsomniaInterface.VoiceConfig.def_ModelAsAvatar
	InsomniaInterface.VoiceConfig.BackgroundColor = Color((InsomniaInterface.VoiceConfig.def_BackgroundColor).r, (InsomniaInterface.VoiceConfig.def_BackgroundColor).g, (InsomniaInterface.VoiceConfig.def_BackgroundColor).b, (InsomniaInterface.VoiceConfig.def_BackgroundColor).a)
	InsomniaInterface.VoiceConfig.TextColor = Color((InsomniaInterface.VoiceConfig.def_TextColor).r, (InsomniaInterface.VoiceConfig.def_TextColor).g, (InsomniaInterface.VoiceConfig.def_TextColor).b)
	InsomniaInterface.VoiceConfig.StaticCircleColor = Color((InsomniaInterface.VoiceConfig.def_StaticCircleColor).r, (InsomniaInterface.VoiceConfig.def_StaticCircleColor).g, (InsomniaInterface.VoiceConfig.def_StaticCircleColor).b)
	InsomniaInterface.VoiceConfig.DynamicCircleColor = Color((InsomniaInterface.VoiceConfig.def_DynamicCircleColor).r, (InsomniaInterface.VoiceConfig.def_DynamicCircleColor).g, (InsomniaInterface.VoiceConfig.def_DynamicCircleColor).b)
	InsomniaInterface.VoiceConfig.ShowUserGroups = InsomniaInterface.VoiceConfig.def_ShowUserGroups
end