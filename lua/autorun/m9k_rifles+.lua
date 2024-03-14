local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then
	killicon.Add(  "m9k_m4a4",		"vgui/hud/m9k_m4a4", icol  )
	killicon.Add(  "m9k_lr300",		"vgui/hud/m9k_lr300", icol  )
	killicon.Add(  "m9k_sturmgewehr44",		"vgui/hud/m9k_sturmgewehr44", icol  )
	killicon.Add(  "m9k_vz58",		"vgui/hud/m9k_vz58", icol  )
	killicon.Add(  "m9k_fnc",		"vgui/hud/m9k_fnc", icol  )
	killicon.Add(  "m9k_xm8",		"vgui/hud/m9k_xm8", icol  )
	killicon.Add(  "m9k_qbz97",		"vgui/hud/m9k_qbz97", icol  )
	killicon.Add(  "m9k_fw",		"vgui/hud/m9k_fw", icol  )
	killicon.Add(  "m9k_asg36",		"vgui/hud/m9k_asg36", icol  )
	killicon.Add(  "m9k_m16a4",		"vgui/hud/m9k_m16a4", icol  )
	killicon.Add(  "m9k_ak74u",		"vgui/hud/m9k_ak74u", icol  )
	killicon.Add(  "m9k_ak47sd",		"vgui/hud/m9k_ak47sd", icol  )
end

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

//stormer
sound.Add({
	name = 			"stg44_cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/stg44/cloth.wav"
})

sound.Add({
	name = 			"stg44_bolt",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/stg44/bolt.wav"
})

sound.Add({
	name = 			"stg44_magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/stg44/magout.wav"
})

sound.Add({
	name = 			"stg44_foley",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/stg44/foley.wav"
})

sound.Add({
	name = 			"stg44_magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/stg44/magin.wav"
})

//m4a4a
sound.Add({
	name = 			"M4.Cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m4a4a/Cloth.wav"
})

sound.Add({
	name = 			"M4.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m4a4a/Deploy.wav"
})

sound.Add({
	name = 			"M4.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m4a4a/Magout.wav"
})

sound.Add({
	name = 			"M4.BoltBack",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m4a4a/BoltBack.wav"
})

sound.Add({
	name = 			"M4.BoltForward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m4a4a/BoltForward.wav"
})

sound.Add({
	name = 			"M4.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m4a4a/Magin.wav"
})

//vz58
sound.Add({
	name = 			"VZ58.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/vz58/ak47_clipin.wav"
})

sound.Add({
	name = 			"VZ58.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/vz58/ak47_clipout.wav"	
})

sound.Add({
	name = 			"VZ58.Boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/vz58/ak47_boltback.wav"	
})

sound.Add({
	name = 			"VZ58.Boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/vz58/ak47_boltforward.wav"	
})

sound.Add({
	name = 			"VZ58.Cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/vz58/ak47_cloth.wav"	
})

sound.Add({
	name = 			"VZ58.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/vz58/ak47_deploy.wav"	
})

//fnc
sound.Add({
	name = 			"FNC.Cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fnc/Cloth.wav" 
})

sound.Add({
	name = 			"FNC.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fnc/Magout.wav" 
})

sound.Add({
	name = 			"FNC.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fnc/Magin.wav" 
})

sound.Add({
	name = 			"FNC.Boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fnc/Boltback.wav" 
})

sound.Add({
	name = 			"FNC.Boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fnc/Boltforward.wav" 
})

sound.Add({
	name = 			"FNC.Foley",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fnc/Foley.wav" 
})

sound.Add({
	name = 			"FNC.Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fnc/Draw.wav" 
})

//qbz
sound.Add({
	name = 			"QBZ97.Clothfast",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/qbz/Draw.wav" 
})

sound.Add({
	name = 			"QBZ97.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"Weapons/qbz/Clipout.wav" 
})

sound.Add({
	name = 			"QBZ97.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/qbz/Clipout.wav" 
})

sound.Add({
	name = 			"QBZ97.Pull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/qbz/Pull.wav" 
})

sound.Add({
	name = 			"QBZ97.Cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/qbz/Cloth.wav" 
})

sound.Add({
	name = 			"QBZ97.Handle",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/qbz/Handle.wav" 
})

sound.Add({
	name = 			"QBZ97.Magtap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/qbz/Magtap.wav" 
})

//fw
sound.Add({
	name = 			"Weapon_future.fireselect",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fw/fireselect.wav" 
})

sound.Add({
	name = 			"Weapon_future.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fw/famas_clipout.wav" 
})

sound.Add({
	name = 			"Weapon_future.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fw/famas_clipin.wav" 
})

sound.Add({
	name = 			"Weapon_future.Forearm",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fw/famas_forearm.wav" 
})

//m16a4
sound.Add({
	name = 			"twink_m16a4.magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/twink_m16a4/magout.wav" 
})

sound.Add({
	name = 			"twink_m16a4.magin1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/twink_m16a4/magin1.wav" 
})

sound.Add({
	name = 			"twink_m16a4.magin2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/twink_m16a4/magin2.wav" 
})

sound.Add({
	name = 			"twink_m16a4.chargeback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/twink_m16a4/chargeback.wav" 
})

sound.Add({
	name = 			"twink_m16a4.chargefor",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/twink_m16a4/chargefor.wav" 
})

//asg36
sound.Add({
	name = 			"Weapon_aug.stockunfold",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/asg36/foldback.wav" 
})

//ak74u
sound.Add({
	name = 			"Weapon_Galil.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak74u/magout.wav" 
})

sound.Add({
	name = 			"Weapon_Galil.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak74u/magin.wav" 
})

sound.Add({
	name = 			"Weapon_Galil.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak74u/boltpull.wav" 
})

sound.Add({
	name = 			"Weapon_Galil.Safety",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak74u/safety.wav" 
})

sound.Add({
	name = 			"Weapon_Galil.Clothdraw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak74u/drawcloth.wav" 
})

sound.Add({
	name = 			"Weapon_Galil.Foley",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak74u/foley.wav" 
})

//ak47sd, Weapon_AK47.Boltback
sound.Add({
	name = 			"Weapon_AK47.Boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak47sd/boltforward.wav" 
})

sound.Add({
	name = 			"Weapon_AK47.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak47sd/boltpull.wav" 
})

sound.Add({
	name = 			"Weapon_AK47.Boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak47sd/boltback.wav" 
})

function PocketM9KWeapons(ply, wep)

	if not IsValid(wep) then return end
	class = wep:GetClass()
	m9knopocket = false
	
	for k, v in pairs(m9knpw) do
		if v == class then
			m9knopocket = true
			break
		end
	end
	
	if m9knopocket then
		return false
	end
	
	--goddammit i hate darkrp
	
end
hook.Add("canPocket", "PocketM9KWeapons", PocketM9KWeapons )

assault_autorun_mounted = true