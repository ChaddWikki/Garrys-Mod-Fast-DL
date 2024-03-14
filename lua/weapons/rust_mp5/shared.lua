SWEP.Base = "tfa_rust_recoilbase"

SWEP.PrintName = "MP5A4"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 60
SWEP.Secondary.IronFOV = 50
SWEP.Category = "TFA Rust Weapons"
SWEP.Type = "SMG"

SWEP.Slot = 2
SWEP.SlotPos = 74

SWEP.ViewModel = "models/weapons/darky_m/rust/c_mp5.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_mp5.mdl"


SWEP.IronSightsPos = Vector(-6.47, 0, 2.9)
SWEP.IronSightsAng = Vector(0.349, -1.38, 0)

SWEP.IronSightsPos_msHolosight = Vector(-6.45, 0, 2.125)
SWEP.IronSightsAng_msHolosight = Vector(-0.18, -1.36, 0)

SWEP.IronSightsPos_Holo = Vector(-6.43, 0, 3)
SWEP.IronSightsAng_Holo = Vector(-1.18, -1.38, 0)

SWEP.IronSightsPos_8xscope = Vector(-6.435, 0, 2.455)
SWEP.IronSightsAng_8xscope = Vector(0.349, -1.38, 0)

SWEP.IronSightsPos_4xscope = Vector(-6.465, 0, 2.63)
SWEP.IronSightsAng_4xscope = Vector(0.349, -1.38, 0)


SWEP.Primary.Sound = "darky_rust.mp5-attack"
SWEP.Primary.SilencedSound= "darky_rust.mp5-attack-silenced" 

SWEP.Primary.Spread = .004365*10
SWEP.Primary.IronAccuracy = .004365

SWEP.Primary.Damage = 35
SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 600

SWEP.Primary.Range = 2048
SWEP.Primary.RangeFalloff = 0.8


SWEP.Attachments = {
	[1] = {atts = {"darky_rust_silencer", "darky_rust_muzzlebrake", "darky_rust_muzzleboost"}},
	[2] = {atts = {"darky_rust_ms_holosight", "darky_rust_holo", "darky_rust_4x", "darky_rust_8x"}},
	[3] = {atts = {"darky_rust_laser", "darky_rust_flash"}},
	[4] = {atts = {"darky_rust_9hv","darky_rust_9inc"}},
}

local rust_holo_material = Material( "models/darky_m/rust_weapons/mods/holosight.reticle.standard.png" )
local rust_ms_material = Material( "models/darky_m/rust_weapons/mods/xhair_highvis.png" )

SWEP.VElements = {
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_ms_holosight.mdl", bone = "main", rel = "", pos = Vector(0, -1.9-2.3, -0.65+5), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["ms_holosight_xhair"] = { type = "Quad", bone = "main", rel = "ms_holosight", pos = Vector(0.519, 0, 0), angle = Angle(-90, 0, 90), size = 0.01, active = false, draw_func = function()   surface.SetDrawColor(255,255,255,255) surface.SetMaterial( rust_ms_material ) surface.DrawTexturedRect(-70, -70, 140, 140) end },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_holo.mdl", bone = "main", rel = "", pos = Vector(-0.09, -1.5-2.3, -0.8+5), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight_lens"] = { type = "Quad", bone = "main", rel = "holosight", pos = Vector(0.47, -0.123, 0.3), angle = Angle(0, -90, 0), size = 0.01, active = false, draw_func = function()     surface.SetDrawColor(255,0,0,255) surface.SetMaterial( rust_holo_material ) surface.DrawTexturedRect(-40, -40, 80, 80) end },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_8xScope.mdl", bone = "main", rel = "", pos = Vector(0.03, -0.4-2.3, 1.9+5), angle = Angle(180, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_reddot.mdl", bone = "main", rel = "", pos = Vector(0.25, -2.3-2.3, -1+5), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_silencer.mdl", bone = "main", rel = "", pos = Vector(0, -1.4, 21), angle = Angle(0, 0, 180), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzlebrake.mdl", bone = "main", rel = "", pos = Vector(0, -1.35, 18), angle = Angle(0, 90, -90), size = Vector(1.65, 2.1, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzleboost.mdl", bone = "main", rel = "", pos = Vector(0, -1.35, 18), angle = Angle(0, 90, -90), size = Vector(1.8, 2.2, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_laser.mdl", bone = "main", rel = "", pos = Vector(0, -0.4, 7.18+5.5), angle = Angle(0, -90, 180), size = Vector(1.0, 1.0, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_flash.mdl", bone = "main", rel = "", pos = Vector(-0.1, 0.2, 8.1+5), angle = Angle(0, -90, 180), size = Vector(1.0, 1.0, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "main", rel = "lasersight", pos = Vector(0.5,0,0), angle = Angle(-90, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 32), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
}

SWEP.WElements = {
	["w_offset"] = { type = "Quad", bone = "main", rel = "", pos = Vector(5, 0.7, -3.5), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_ms_holosight.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.9-2.3, -0.65+5), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_holo.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.09, -1.5-2.3, -0.8+5), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_8xScope.mdl", bone = "main", rel = "w_offset", pos = Vector(0.03, -0.4-2.3, 1.9+5), angle = Angle(180, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, mmaterial = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_reddot.mdl", bone = "main", rel = "w_offset", pos = Vector(0.25, -2.3-2.3, -1+5), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_silencer.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.4, 21), angle = Angle(0, 0, 180), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzlebrake.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.35, 18), angle = Angle(0, 90, -90), size = Vector(1.65, 2.1, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzleboost.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.35, 18), angle = Angle(0, 90, -90), size = Vector(1.8, 2.2, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_laser.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -0.4, 7.18+5.5), angle = Angle(0, -90, 180), size = Vector(1.0, 1.0, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_flash.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.1, 0.2, 8.1+5), angle = Angle(0, -90, 180), size = Vector(1.0, 1.0, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_dot"] = { type = "Sprite", sprite = "effects/tfalaserdot", bone = "main", rel = "lasersight", pos = Vector(0.4, 0, -2), size = { x = 4, y = 4 }, color = Color(255, 0, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false},
	["flash_sprite"] = { type = "Sprite", sprite = "effects/blueflare1", bone = "main", rel = "flashlight", pos = Vector(0.3, 0, -4), size = { x = 15, y = 15 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false}
}

SWEP.MuzzleFlashEffect = "tfa_muzzleflash_pistol"

SWEP.LuaShellModel = "models/tfa/pistolshell.mdl"
SWEP.LuaShellEject = true
SWEP.LuaShellEjectDelay = 0
SWEP.LuaShellEffect = "PistolShellEject"

SWEP.IronAnimation = {
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_PRIMARYATTACK_1,
	}
}

SWEP.EventTable = {}

SWEP.Primary.Recoil = 1.4
SWEP.RecoilTable = {
	Angle(-2.5531914893617, 3, 0),
	Angle(-2.5531914893617, 1.25, 0),
	Angle(-3.6170212765957, -1.75, 0),
	Angle(-2.9787234042553, -0, 0),
	Angle(-2.5531914893617, 2, 0),
	Angle(-1.7021276595745, 2.75, 0),
	Angle(-0.63829787234043, 2.75, 0),
	Angle(-2.1276595744681, 1.75, 0),
	Angle(-1.7021276595745, -1, 0),
	Angle(-0.21276595744681, -2, 0),
	Angle(-0.42553191489362, -2, 0),
	Angle(-0.42553191489362, -2, 0),
	Angle(-0.85106382978723, -1.25, 0),
	Angle(-1.2765957446809, 0.75, 0),
	Angle(-0.85106382978723, 2.25, 0),
	Angle(-0.21276595744681, 1.75, 0),
	Angle(-0.42553191489362, 1.5, 0),
	Angle(-0.21276595744681, 1.75, 0),
	Angle(-1.2765957446809, 0.75, 0),
	Angle(-0.85106382978723, -1.5, 0),
	Angle(-0.42553191489362, -1.75, 0),
	Angle(-0.21276595744681, -1.5, 0),
	Angle(-0.42553191489362, -1.5, 0),
	Angle(-0.21276595744681, -1.5, 0),
	Angle(-0.85106382978723, 0.25, 0),
	Angle(-0.21276595744681, 1.75, 0),
	Angle(1.063829787234, 1.25, 0),
	Angle(-1.063829787234, 1.5, 0),
	Angle(0, -2.5, 0),
	Angle(0.21276595744681, -1.75, 0),
	Angle(0.42553191489362, 1.75, 0),
}
