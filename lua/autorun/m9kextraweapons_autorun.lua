//this part is for making kill icons
local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then

	killicon.Add(  "m9k_m269",		"vgui/hud/m9k_m269", icol  )
	killicon.Add(  "m9k_arcticak47",		"vgui/hud/m9k_arcticak47", icol  )
	killicon.Add(  "m9k_mtp9",		"vgui/hud/m9k_mtp9", icol  )
	killicon.Add(  "m9k_uaccm82a1",		"vgui/hud/m9k_uaccm82a1", icol  )
	killicon.Add(  "m9k_launched_m32",		"vgui/hud/m9k_m32", icol  )
	killicon.Add(  "m9k_akm",		"vgui/hud/m9k_akm", icol  )
	killicon.Add(  "m9k_glock17",		"vgui/hud/m9k_glock17", icol  )
	killicon.Add(  "m9k_uspt",		"vgui/hud/m9k_uspt", icol  )
	killicon.Add(  "m9k_b92fs",		"vgui/hud/m9k_b92fs", icol  )
	killicon.Add(  "m9k_usc",		"vgui/hud/m9k_usc", icol  )
	killicon.Add(  "m9k_highpower",		"vgui/hud/m9k_highpower", icol  )
	killicon.Add(  "m9k_benellim4",		"vgui/hud/m9k_benellim4", icol  )
	killicon.Add(  "m9k_mk20",		"vgui/hud/m9k_mk20", icol  )
	killicon.Add(  "m9k_heraqcr",		"vgui/hud/m9k_heraqcr", icol  )
	--			weapon name			location of weapon's kill icon, I just used the hud icon

end

local M9KIcon = "vgui/menu/m9k_icon"
list.Set( "ContentCategoryIcons", "M9K Assault Rifles", M9KIcon.."_assault.vmt" )
list.Set( "ContentCategoryIcons", "M9K Machine Guns", M9KIcon.."_heavy.vmt" )
list.Set( "ContentCategoryIcons", "M9K Shotguns", M9KIcon.."_heavy.vmt" )
list.Set( "ContentCategoryIcons", "M9K Sniper Rifles", M9KIcon.."_heavy.vmt" )
list.Set( "ContentCategoryIcons", "M9K Pistols", M9KIcon.."_small.vmt" )
list.Set( "ContentCategoryIcons", "M9K Submachine Guns", M9KIcon.."_small.vmt" )
list.Set( "ContentCategoryIcons", "M9K Specialties", M9KIcon.."_spe.vmt" )



//these are some variables we need to keep for stuff to work
//that means don't delete them

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

//I always leave a note reminding me which weapon these sounds are for
//M269
sound.Add({
	name = 			"M269_Shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/m269/m269-1.wav"
})

sound.Add({
	name = 			"Weapon_Binachi.draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m269/draw.wav"
})
sound.Add({
	name = 			"Weapon_Binachi.boxout_1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m269/boxout_1.wav"
})
sound.Add({
	name = 			"Weapon_Binachi.boxout_2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m269/boxout_2.wav"
})
sound.Add({
	name = 			"Weapon_Binachi.box_insert",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m269/box_insert.wav"
})
sound.Add({
	name = 			"Weapon_Binachi.hit",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m269/hit.wav"
})
sound.Add({
	name = 			"Weapon_Binachi.slide_fail",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m269/slide_fail.wav"
})
sound.Add({
	name = 			"Weapon_Binachi.slide_back",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m269/slide_back.wav"
})
sound.Add({
	name = 			"Weapon_Binachi.slide_forward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m269/slide_forward.wav"
})
sound.Add({
	name = 			"Weapon_Binachi.rattle",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m269/rattle.wav"
})
sound.Add({
	name = 			"Weapon_Binachi.cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m269/cloth.wav"
})
//Arctic ak47
sound.Add({
	name = 			"ak47arctic_shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/ak47arctic/ak47-1.wav"
})

sound.Add({
	name = 			"AK47.Bolt",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak47arctic/Bolt.wav"
})

sound.Add({
	name = 			"AK47.magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak47arctic/Magout.wav"
})

sound.Add({
	name = 			"AK47.magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak47arctic/magin.wav"
})

sound.Add({
	name = 			"AK47.Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak47arctic/Draw.wav"
})

sound.Add({
	name = 			"AK47.MagTap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ak47arctic/MagTap.wav"
})
//MTP 9
sound.Add({
	name = 			"mtp_shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/mtp-9/mtp-1.wav"
})

sound.Add({
	name = 			"Lynx-47.Boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mtp-9/Boltback.wav"
})

sound.Add({
	name = 			"Lynx-47.Boltrelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mtp-9/Boltrelease.wav"
})

sound.Add({
	name = 			"Lynx-47.Boltrelease2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mtp-9/Boltrelease2.wav"
})

sound.Add({
	name = 			"Lynx-47.Mag_Close",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mtp-9/Mag_Close.wav"
})

sound.Add({
	name = 			"Lynx-47.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mtp-9/Magin.wav"
})

sound.Add({
	name = 			"Lynx-47.Maginsert",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mtp-9/Maginsert.wav"
})

sound.Add({
	name = 			"Lynx-47.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mtp-9/Magout.wav"
})
//m82a1
sound.Add({
	name = 			"uaccm82_shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/uaccm82a1/awp1.wav"
})

sound.Add({
	name = 			"AWP_Magrelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/uaccm82a1/magrelease.wav"
})

sound.Add({
	name = 			"AWP_Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			{"weapons/uaccm82a1/awp_magout.wav",
		                 "weapons/uaccm82a1/awp_magout2.wav"}
})

sound.Add({
	name = 			"AWP_Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/uaccm82a1/awp_magin.wav"
})
//m32
sound.Add({
	name = 			"WeapoM_32.Single",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/M32/m32_shoot.wav"
})

sound.Add({
	name = 			"WeapoM_32.Insertshell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/M32/m32_insert.wav"
})

sound.Add({
	name = 			"Weapon_M32.AfterReload",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/M32/m32_after_reload.wav"
})

sound.Add({
	name = 			"Weapon_M32.StartReload",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/M32/m32_start_reload.wav"
})
//AKM
sound.Add({
	name = 			"akm.shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/akm/akm-1.wav"
})

sound.Add({
	name = 			"Weapon_AKM.Magout",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/akm/magout.wav"
})

sound.Add({
	name = 			"Weapon_AKM.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/akm/magin.wav"
})

sound.Add({
	name = 			"Weapon_AKM.BoltBack",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/akm/boltback.wav"
})

sound.Add({
	name = 			"Weapon_AKM.BoltForward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/akm/boltforward.wav"
})

sound.Add({
	name = 			"Weapon_AKM.ClothFast",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			{"weapons/akm/cloth.wav",
	                     "weapons/akm/cloth_fast.wav",
						 "weapons/akm/draw.wav"}
})

//Glock17
sound.Add({
	name = 			"Glock17_shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			{"weapons/Glock17/fire-1.wav",
	                     "weapons/Glock17/fire-2.wav",
						 "weapons/Glock17/fire-3.wav",
						 "weapons/Glock17/fire-4.wav"}
})

sound.Add({
	name = 			"Glo17.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Glock17/deploy.wav"
})

sound.Add({
	name = 			"Glo17.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Glock17/magout.wav"
})

sound.Add({
	name = 			"Glo17.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Glock17/magin.wav"
})

sound.Add({
	name = 			"Glo17.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Glock17/slideback.wav"
})

sound.Add({
	name = 			"Glo17.Slideforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Glock17/slideforward.wav"
})
//Beretta 92FS
sound.Add({
	name = 			"b92fs_shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/92fs/m9-1.wav"
})

sound.Add({
	name = 			"Weapon_b92f.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/92fs/magout.wav"
})

sound.Add({
	name = 			"Weapon_b92f.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/92fs/magin.wav"
})

sound.Add({
	name = 			"Weapon_b92f.Sliderelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/92fs/sliderelease.wav"
})

sound.Add({
	name = 			"Weapon_b92f.Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/92fs/draw.wav"
})
//USP Tactical
sound.Add({
	name = 			"uspt_shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/usp tactical/shoot.wav"
})

sound.Add({
	name = 			"uspt_sishot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/usp tactical/supressed.wav"
})

sound.Add({
	name = 			"USP Tactical.magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usp tactical/magout.wav"
})

sound.Add({
	name = 			"USP Tactical.magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usp tactical/magin.wav"
})

sound.Add({
	name = 			"USP Tactical.slide",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usp tactical/slide.wav"
})

sound.Add({
	name = 			"USP Tactical.Cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usp tactical/cloth.wav"
})

sound.Add({
	name = 			"USP Tactical.Clothfast",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usp tactical/clothfast.wav"
})

sound.Add({
	name = 			"USP Tactical.sliderelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usp tactical/sliderelease.wav"
})

sound.Add({
	name = 			"USP Tactical.Sil_on",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usp tactical/sil_on.wav"
})

sound.Add({
	name = 			"USP Tactical.Sil_off",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usp tactical/sil_off.wav"
})

sound.Add({
	name = 			"USP Tactical.shoulder",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usp tactical/shoulder.wav"
}) 
//High Power
sound.Add({
	name = 			"high.shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/highpower/deagle-1.wav"
})

sound.Add({
	name = 			"Weapon_highle.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/highpower/de_clipout.wav"
})

sound.Add({
    name = 			"Weapon_highle.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/highpower/de_clipin.wav"
})

sound.Add({
	name = 			"Weapon_highle.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/highpower/de_slideback.wav"
})

sound.Add({
	name = 			"Weapon_highle.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/highpower/de_deploy.wav"
})
//Benelli M4
sound.Add({
	name = 			"M4.shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/M1014/Fire.wav"
})

sound.Add({
	name = 			"M1014.cloth1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/M1014/cloth1.wav"
})

sound.Add({
    name = 			"M1014.cloth2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/M1014/cloth2.wav"
})

sound.Add({
	name = 			"M1014.shell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/M1014/shell.wav"
})

sound.Add({
	name = 			"M1014.bolt",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/M1014/bolt.wav"
})
//Mk20
sound.Add({
	name = 			"Mk20.shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/Mk20/shoot.wav"
})

sound.Add({
	name = 			"SCAR.BoltPull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Mk20/BoltPull.wav"
})

sound.Add({
    name = 			"SCAR.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Mk20/Magout.wav"
})

sound.Add({
	name = 			"SCAR.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Mk20/Magin.wav"
})


sound.Add({
	name = 			"SCAR.Foley",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Mk20/Foley.wav"
})

sound.Add({
	name = 			"SCAR.MagTap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Mk20/MagTap.wav"
})

sound.Add({
	name = 			"SCAR.MagInsert",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Mk20/MagInsert.wav"
})

sound.Add({
	name = 			"SCAR.MagInTap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Mk20/MagInTap.wav"
})

sound.Add({
	name = 			"SCAR.Shoulder",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Mk20/Shoulder.wav"
})

sound.Add({
	name = 			"SCAR.Safety",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Mk20/Safety.wav"
})
//Hera Arms CQR
sound.Add({
	name = 			"hera.shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/cqr/fire_1.wav"
})

sound.Add({
	name = 			"CQR.WpnUp",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/cqr/wpnup.wav"
})

sound.Add({
    name = 			"CQR.WpnDwn",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/cqr/wpndwn.wav"
})

sound.Add({
	name = 			"CQR.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/cqr/clipout.wav"
})


sound.Add({
	name = 			"CQR.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/cqr/clipin.wav"
})

sound.Add({
	name = 			"CQR.Clipin1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/cqr/clipin.wav"
})

sound.Add({
	name = 			"CQR.SlideBack",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/cqr/cockbk.wav"
})

sound.Add({
	name = 			"CQR.SlideForward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/cqr/cockfwd.wav"
})
//asg36
sound.Add({
	name = 			"Weapon_aug.boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/asg36/m24_boltback.wav" 
})

sound.Add({
	name = 			"Weapon_aug.boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/asg36/m24_boltforward.wav" 
})
//dragon
sound.Add({
	name = 			"DragonFire",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/dragonsbreath/fire.wav",}	
})

sound.Add({
	name = 			"dragon.Pump",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/dragonsbreath/pump.wav",}	
})

sound.Add({
	name = 			"dragon.Insert",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/dragonsbreath/insert1.wav"}	
})

sound.Add({
	name = 			"dragon.draw",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/dragonsbreath/draw.wav",}	
})













//this stuff is important, too. It's to prevent DarkRP players from using an exploit to get infinite ammo.
//just leave it be, its fine here as it is.
m9knpw = {}
table.insert(m9knpw, "m9k_davy_crockett_explo")
table.insert(m9knpw, "m9k_gdcwa_matador_90mm")
table.insert(m9knpw, "m9k_gdcwa_rpg_heat")
table.insert(m9knpw, "m9k_improvised_explosive")
table.insert(m9knpw, "m9k_launched_davycrockett")
table.insert(m9knpw, "m9k_launched_ex41")
table.insert(m9knpw, "m9k_launched_m79")
table.insert(m9knpw, "m9k_m202_rocket")
table.insert(m9knpw, "m9k_mad_c4")
table.insert(m9knpw, "m9k_milkor_nade")
table.insert(m9knpw, "m9k_nervegasnade")
table.insert(m9knpw, "m9k_nitro_vapor")
table.insert(m9knpw, "m9k_oribital_cannon")
table.insert(m9knpw, "m9k_poison_parent")
table.insert(m9knpw, "m9k_proxy")
table.insert(m9knpw, "m9k_released_poison")
table.insert(m9knpw, "m9k_sent_nuke_radiation")
table.insert(m9knpw, "m9k_thrown_harpoon")
table.insert(m9knpw, "m9k_thrown_knife")
table.insert(m9knpw, "m9k_thrown_m61")
table.insert(m9knpw, "m9k_thrown_nitrox")
table.insert(m9knpw, "m9k_thrown_spec_knife")
table.insert(m9knpw, "m9k_thrown_sticky_grenade")
table.insert(m9knpw, "bb_dod_bazooka_rocket")
table.insert(m9knpw, "bb_dod_panzershreck_rocket")
table.insert(m9knpw, "bb_garand_riflenade")
table.insert(m9knpw, "bb_k98_riflenade")
table.insert(m9knpw, "bb_planted_dod_tnt")
table.insert(m9knpw, "bb_thrownalliedfrag")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_thrownsmoke_axis")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_planted_alt_c4")
table.insert(m9knpw, "bb_planted_css_c4")
table.insert(m9knpw, "bb_throwncssfrag")
table.insert(m9knpw, "bb_throwncsssmoke")
table.insert(m9knpw, "m9k_ammo_40mm")
table.insert(m9knpw, "m9k_ammo_40mm_single")
table.insert(m9knpw, "m9k_ammo_357")
table.insert(m9knpw, "m9k_ammo_ar2")
table.insert(m9knpw, "m9k_ammo_buckshot")
table.insert(m9knpw, "m9k_ammo_c4")
table.insert(m9knpw, "m9k_ammo_frags")
table.insert(m9knpw, "m9k_ammo_ieds")
table.insert(m9knpw, "m9k_ammo_nervegas")
table.insert(m9knpw, "m9k_ammo_nuke")
table.insert(m9knpw, "m9k_ammo_pistol")
table.insert(m9knpw, "m9k_ammo_proxmines")
table.insert(m9knpw, "m9k_ammo_rockets")
table.insert(m9knpw, "m9k_ammo_smg")
table.insert(m9knpw, "m9k_ammo_sniper_rounds")
table.insert(m9knpw, "m9k_ammo_stickynades")
table.insert(m9knpw, "m9k_ammo_winchester")

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

extra_autorun_mounted = true
