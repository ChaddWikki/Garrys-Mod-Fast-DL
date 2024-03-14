-- Variables that are used on both client and server
SWEP.Gun = ("m9k_highpower") -- must be the name of your swep but NO CAPITALS!
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "bobs_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "M9K Pistols" --Category where you will find your weapons
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "High-Power Eagle"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 20			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false		-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight					= 30		-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "pistol"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg makes for good sniper rifles

SWEP.ViewModelFOV			= 75
SWEP.ViewModelFlip			= false 
SWEP.ViewModel				= "models/weapons/v_high_deagle.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_high_deagle.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base				= "bobs_gun_base" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = true

SWEP.Primary.Sound			= Sound("high.shot")		-- Script that calls the primary fire sound
SWEP.Primary.SilencedSound 	= Sound("")		-- Sound if the weapon is silenced
SWEP.Primary.RPM			= 225		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 7		-- Size of a clip
SWEP.Primary.DefaultClip		= 21		-- Bullets you start with
SWEP.Primary.KickUp				= 0.85		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.75		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.65		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "357"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. 
--Use AirboatGun for a light metal peircing shotgun pellets
SWEP.SelectiveFire		= true
SWEP.CanBeSilenced		= false

SWEP.Secondary.IronFOV			= 60		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pul
SWEP.Primary.Damage		= 43.5	-- Base damage per bullet
SWEP.Primary.Spread		= .012	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .008 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-3.054, 0, 1.07)	--Iron Sight positions and angles. Use the Iron sights utility in 
SWEP.IronSightsAng = Vector(0,0,0)	--Clavus's Swep Construction Kit to get these vectors
SWEP.SightsPos = Vector (-3.054, 0, 1.07)
SWEP.SightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector(2.725, -11.25, -6.2)	--These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(70, 0, 0)	--Again, use the Swep Construction Kit

function SWEP:SelectFireMode()

	if self.Primary.Burst then
		self.Primary.Burst = false
		self.NextFireSelect = CurTime() + .5
		if CLIENT then
			self.Owner:PrintMessage(HUD_PRINTTALK, "50AE selected.")
		end
		self.Weapon:EmitSound("weapons/highpower/de_slideback.wav") --Sound emit here
		self.Primary.NumShots	= 1
		self.Primary.Damage		= 43.5	
		self.Primary.Sound	= Sound("high.shot") --Gun shot sound
		self.Primary.KickUp				= 0.85
        self.Primary.KickDown			= 0.75
        self.Primary.KickHorizontal		= 0.65
		self.Primary.Ammo			= "357"
		self.Primary.Automatic = false
	else
		self.Primary.Burst = true
		self.NextFireSelect = CurTime() + .5
		if CLIENT then
			self.Owner:PrintMessage(HUD_PRINTTALK, "FMJ selected.")
		end
		self.Weapon:EmitSound("weapons/highpower/de_slideback.wav") --Sound emit here
		self.Primary.NumShots	= 1 --Number of bullets per brust
		self.Primary.Sound	= Sound("high.shot") --Gun shot sound
		self.Primary.Damage		= 75
		self.Primary.KickUp				= 1	
        self.Primary.KickDown			= 0.95
        self.Primary.KickHorizontal		= 0.85
		self.Primary.Ammo			= "SniperPenetratedRound"
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