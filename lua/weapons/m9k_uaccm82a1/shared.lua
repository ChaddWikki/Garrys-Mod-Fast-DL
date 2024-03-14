-- Variables that are used on both client and server
SWEP.Gun = ("m9k_uaccm82a1") -- must be the name of your swep but NO CAPITALS!
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "bobs_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "M9K Sniper Rifles" --Category where you will find your weapons
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "UACC C.P.B M82A1"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 3				-- Slot in the weapon selection menu
SWEP.SlotPos				= 4			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- Set false if you want no crosshair from hip
SWEP.Weight				= 90			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair					= false		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction				= false		-- Is this a bolt action rifle?
SWEP.HoldType 				= "rpg"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 80
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_uacc_m82.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_uacc_m82.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base 				= "bobs_scoped_base" --the Base this weapon will work on. PLEASE RENAME THE BASE!
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("uaccm82_shot")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 215		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 10		-- Size of a clip
SWEP.Primary.DefaultClip			= 100 	-- Bullets you start with
SWEP.Primary.KickUp			= 0.75				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.7		--Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= 0.68	-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "SniperPenetratedRound"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.SelectiveFire		= true
SWEP.Secondary.ScopeZoom			= 6.5	
SWEP.Secondary.UseACOG			= false -- Choose one scope type
SWEP.Secondary.UseMilDot		= false	-- I mean it, only one	
SWEP.Secondary.UseSVD			= false	-- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic		= true	
SWEP.Secondary.UseElcan			= false
SWEP.Secondary.UseGreenDuplex	= false	

SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 0.6
SWEP.ReticleScale 				= 0.5

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pul
SWEP.Primary.Damage		= 135	--base damage per bullet
SWEP.Primary.Spread		= .0001	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .0001 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector (-2, -1.9, 0.649)
SWEP.IronSightsAng = Vector (0, 0, 0)
SWEP.SightsPos = Vector(-2, -1.9, 0.649)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector (4.89, -5.687, -0.28)
SWEP.RunSightsAng = Vector (-9.092, 51.886, -1.919)

function SWEP:SelectFireMode()

	if self.Primary.Burst then
		self.Primary.Burst = false
		self.NextFireSelect = CurTime() + .5
		if CLIENT then
			self.Owner:PrintMessage(HUD_PRINTTALK, "Normal range selected.")
		end
		self.Weapon:EmitSound("weapons/zoom.wav") --Sound emit here
		self.Primary.NumShots	= 1
		self.Secondary.ScopeZoom			= 6.5		
		self.Primary.Sound	= Sound("uaccm82_shot") --Gun shot sound
		self.Primary.Automatic = false
	else
		self.Primary.Burst = true
		self.NextFireSelect = CurTime() + .5
		if CLIENT then
			self.Owner:PrintMessage(HUD_PRINTTALK, "Long range selected.")
		end
		self.Weapon:EmitSound("weapons/zoom.wav") --Sound emit here
		self.Primary.NumShots	= 1 --Number of bullets per brust
		self.Secondary.ScopeZoom			= 11.5	
		self.Primary.Sound	= Sound("uaccm82_shot") --Gun shot sound
		self.Primary.Automatic = false
	end
end

if GetConVar("M9KDefaultClip") == nil then
	print("M9KDefaultClip is missing! You may have hit the lua limit!")
else
	if GetConVar("M9KDefaultClip"):GetInt() != -1 then
		SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * GetConVar("M9KDefaultClip"):GetInt()
	end
end

if GetConVar("M9KUniqueSlots") != nil then
	if not (GetConVar("M9KUniqueSlots"):GetBool()) then 
		SWEP.SlotPos = 2
	end
end
