local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then
	killicon.Add(  "m9k_vp90",		"vgui/hud/m9k_vp90", icol  )
	killicon.Add(  "m9k_glock18_extclip",		"vgui/hud/m9k_glock18_extclip", icol  )
	killicon.Add(  "m9k_fnp",		"vgui/hud/m9k_fnp", icol  )
	killicon.Add(  "m9k_guardian",		"vgui/hud/m9k_guardian", icol )
	killicon.Add(  "m9k_ruger",		"vgui/hud/m9k_ruger", icol )
	killicon.Add(  "m9k_usps",		"vgui/hud/m9k_usps", icol )
	killicon.Add(  "m9k_coltscoped",		"vgui/hud/m9k_coltscoped", icol )
	killicon.Add(  "m9k_mr96",		"vgui/hud/m9k_mr96", icol )
	killicon.Add(  "m9k_bren_ten",		"vgui/hud/m9k_bren_ten", icol )
end

//VP70
sound.Add({
	name = 			"vp70.magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/vp70/VP70 Mag Out.wav"
})

sound.Add({
	name = 			"vp70.magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/vp70/VP70 Mag In.wav"
})

sound.Add({
	name = 			"vp70.pull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/vp70/VP70 Pull.wav"
})

sound.Add({
	name = 			"vp70.release",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/vp70/VP70 Release.wav"
})

//glock18ext
sound.Add({
	name = 			"Weapon_M249.magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/glock18extclip/m249_magout.wav"
})

sound.Add({
	name = 			"Weapon_M249.magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/glock18extclip/m249_magin.wav"
})

sound.Add({
	name = 			"Weapon_M249.sliderelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/glock18extclip/m249_sliderelease.wav"
})

sound.Add({
	name = 			"Weapon_M249.slideforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/glock18extclip/m249_slideforward.wav"
})

sound.Add({
	name = 			"Weapon_M249.slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/glock18extclip/m249_slideback.wav"
})


//fnp
sound.Add({
	name = 			"Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/FNP45/Draw.wav"
})

sound.Add({
	name = 			"MagOut",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/FNP45/MagOut.wav"
})

sound.Add({
	name = 			"MagIn",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/FNP45/MagIn.wav"
})

sound.Add({
	name = 			"SlideRelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/FNP45/SlideRelease.wav"
})

//bren
sound.Add({
	name = 			"bren.magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/bren/magout.wav"
})

sound.Add({
	name = 			"bren.magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/bren/magin.wav"
})

sound.Add({
	name = 			"bren.maghit",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/bren/maghit.wav"
})

sound.Add({
	name = 			"bren.SlideBack",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/bren/slideback.wav"
})

sound.Add({
	name = 			"bren.Sliderelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/bren/SlideRelease.wav"
})

sound.Add({
	name = 			"bren.draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/bren/draw.wav"
})

//usp
sound.Add({
	name = 			"USP.Cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Navaro's USP/Cloth.wav"
})

sound.Add({
	name = 			"USP.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Navaro's USP/clipout.wav"
})

sound.Add({
	name = 			"USP.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Navaro's USP/clipin.wav"
})

sound.Add({
	name = 			"USP.SlideBack",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Navaro's USP/Back.wav"
})

sound.Add({
	name = 			"USP.SlideForward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Navaro's USP/Forward.wav"
})

sound.Add({
	name = 			"USP.Foley",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Navaro's USP/Foley.wav"
})

sound.Add({
	name = 			"USP.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Navaro's USP/Deploy.wav"
})

sound.Add({
	name = 			"USP.SilOn",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Navaro's USP/SilOn.wav"
})

sound.Add({
	name = 			"USP.SilOff",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Navaro's USP/SilOff.wav"
})

//VP70
sound.Add({
	name = 			"in",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/1911/in.wav"
})

sound.Add({
	name = 			"out",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/1911/out.wav"
})

sound.Add({
	name = 			"for",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/1911/for.wav"
})

sound.Add({
	name = 			"back",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/1911/back.wav"
})

sound.Add({
	name = 			"cloth1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/1911/cloth1.wav"
})

//Magpul PDR
sound.Add({
	name = 			"MAG_PDR.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			{"weapons/pdr/pdr-1.wav",
						"weapons/pdr/pdr-2.wav",
						"weapons/pdr/pdr-3.wav"}
})

if GetConVar("DebugM9K") == nil then
	CreateConVar("DebugM9K", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Debugging for some m9k stuff, turning it on won't change much.")
end

if GetConVar("M9KWeaponStrip") == nil then
	CreateConVar("M9KWeaponStrip", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow empty weapon stripping? 1 for true, 0 for false")
	print("Weapon Strip con var created")
end
	
if GetConVar("M9KDisablePenetration") == nil then
	CreateConVar("M9KDisablePenetration", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable Penetration and Ricochets? 1 for true, 0 for false")
	print("Penetration/ricochet con var created")
end
	
if GetConVar("M9KDynamicRecoil") == nil then
	CreateConVar("M9KDynamicRecoil", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use Aim-modifying recoil? 1 for true, 0 for false")
	print("Recoil con var created")
end
	
if GetConVar("M9KAmmoDetonation") == nil then
	CreateConVar("M9KAmmoDetonation", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Enable detonatable M9K Ammo crates? 1 for true, 0 for false.")
	print("Ammo crate detonation con var created")
end

if GetConVar("M9KDamageMultiplier") == nil then
	CreateConVar("M9KDamageMultiplier", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Multiplier for M9K bullet damage.")
	print("Damage Multiplier con var created")
end

if GetConVar("M9KDefaultClip") == nil then
	CreateConVar("M9KDefaultClip", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "How many clips will a weapon spawn with? Negative reverts to default values.")
	print("Default Clip con var created")
end
	
if GetConVar("M9KUniqueSlots") == nil then
	CreateConVar("M9KUniqueSlots", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Give M9K Weapons unique slots? 1 for true, 2 for false. A map change may be required.")
	print("Unique Slots con var created")
end
	
if !game.SinglePlayer() then

	if GetConVar("M9KClientGasDisable") == nil then
		CreateConVar("M9KClientGasDisable", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Turn off gas effect for all clients? 1 for yes, 0 for no. ")
	end
	
	if SERVER then
	
		function ClientSideGasDisabler()
			timer.Create("ClientGasBroadcastTimer", 15, 0, 
				function() BroadcastLua("RunConsoleCommand(\"M9KGasEffect\", \"0\")") end )
		end
	
		if GetConVar("M9KClientGasDisable"):GetBool() then
			ClientSideGasDisabler()
		end

		function M9K_Svr_Gas_Change_Callback(cvar, previous, new)
			if tobool(new) == true then
				ClientSideGasDisabler()
				BroadcastLua("print(\"Gas effects disabled on this server!\")")
			elseif tobool(new) == false then
				BroadcastLua("print(\"Gas effects re-enabled on this server.\")")
				BroadcastLua("print(\"You may turn on M9KGasEffect if you wish.\")")
				if timer.Exists("ClientGasBroadcastTimer") then
					timer.Destroy("ClientGasBroadcastTimer")
				end
			end				
		end
		cvars.AddChangeCallback("M9KClientGasDisable", M9K_Svr_Gas_Change_Callback)
	
	end
	
	if CLIENT then
		if GetConVar("M9KGasEffect") == nil then
			CreateClientConVar("M9KGasEffect", "1", true, true)
			print("Client-side Gas Effect Con Var created")
		end		
	end

else
	if GetConVar("M9KGasEffect") == nil then
		CreateConVar("M9KGasEffect", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use gas effect when shooting? 1 for true, 0 for false")
		print("Gas effect con var created")
	end
end