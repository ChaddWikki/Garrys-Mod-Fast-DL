local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then
	killicon.Add(  "m9k_ksg",		"vgui/hud/m9k_ksg", icol  )
	killicon.Add(  "m9k_spas12stock",		"vgui/hud/m9k_spas12stock", icol  )
	killicon.Add(  "m9k_dragonsbreath",		"vgui/hud/m9k_dragonsbreath", icol  )
	killicon.Add(  "m9k_serbushorty",		"vgui/hud/m9k_serbushorty", icol  )
	killicon.Add(  "m9k_fntps",		"vgui/hud/m9k_fntps", icol  )
	killicon.Add(  "m9k_spas12silenced",		"vgui/hud/m9k_spas12silenced", icol  )
	killicon.Add(  "m9k_baikal",		"vgui/hud/m9k_baikal", icol  )
	killicon.Add(  "m9k_m3tactical",		"vgui/hud/m9k_m3tactical", icol  )
end

//ksg
sound.Add({
	name = 			"KSG.Fire",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/ksg/shot1.wav",
			"weapons/ksg/shot2.wav",
			"weapons/ksg/shot3.wav",}	
})

sound.Add({
	name = 			"KSG.Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ksg/draw.wav"
})

sound.Add({
	name = 			"KSG.StartReload",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ksg/reload_start.wav"
})

sound.Add({
	name = 			"KSG.PumpBack",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ksg/pumpback.wav"
})

sound.Add({
	name = 			"KSG.PumpForward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ksg/pumpforward.wav"
})

sound.Add({
	name = 			"KSG.ShellInsert",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = {"weapons/ksg/shellinsert1.wav",
			"weapons/ksg/shellinsert3.wav",
			"weapons/ksg/shellinsert2.wav",}	
})

//spasstock
sound.Add({
	name = 			"SPAS.Stock.Fire",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/spas12/xm1014-1.wav",}	
})

sound.Add({
	name = 			"Weapon_lol.aft_rel",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/spas12/spas12_pump.wav",}	
})

sound.Add({
	name = 			"Weapon_lol.ins_shell",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/spas12/spas12_insertshell.wav",}	
})

sound.Add({
	name = 			"Weapon_lol.draw",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/spas12/spas12_draw.wav",}	
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
	sound = {"weapons/dragonsbreath/insert1.wav",
			"weapons/dragonsbreath/insert2.wav",}	
})

sound.Add({
	name = 			"dragon.draw",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/dragonsbreath/draw.wav",}	
})

//baikal
sound.Add({
	name = 			"BaikalLovesToFire",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/baikal/xm1014-1.wav",}	
})

sound.Add({
	name = 			"MP.Draw",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/baikal/draw.wav",}	
})

sound.Add({
	name = 			"MP.Foley",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/baikal/Foley.wav",}	
})

sound.Add({
	name = 			"MP.Insert",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/baikal/insert.wav",}	
})