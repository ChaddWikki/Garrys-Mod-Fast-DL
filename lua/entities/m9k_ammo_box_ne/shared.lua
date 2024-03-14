ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Ammo Box (No explosion)"
ENT.Category		= "M9K Ammunition"

ENT.Spawnable		= true
ENT.AdminSpawnable		= true
ENT.AdminOnly = false
ENT.DoNotDuplicate = true //It use to stop player from making cheap nuke 

if SERVER then

AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("m9k_ammo_box_ne")
	
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	ent.Planted = false
	
	return ent
end


/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	local model = ("models/Items/BoxMRounds.mdl")
	
	self.Entity:SetModel(model)
	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Entity:SetUseType(SIMPLE_USE)
end


/*---------------------------------------------------------
   Name: PhysicsCollide
---------------------------------------------------------*/
function ENT:PhysicsCollide(data, physobj)
	
	// Play sound on bounce
	if (data.Speed > 80 and data.DeltaTime > 0.2) then
		self.Entity:EmitSound("Default.ImpactSoft")
	end
end

/*---------------------------------------------------------
   Name: OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage(dmginfo)
	self.Entity:TakePhysicsDamage(dmginfo)	
	end
end


/*---------------------------------------------------------
   Name: Use
---------------------------------------------------------*/
function ENT:Use(activator,caller,useType,value)

	
	if (activator:IsPlayer()) and not self.Planted then
		// Give the collecting player some free health
		activator:GiveAmmo(10000, "357", true)
		activator:GiveAmmo(10000, "Buckshot", true)
		activator:GiveAmmo(10000, "Ar2", true)
		activator:GiveAmmo(10000, "Pistol", true)
		activator:GiveAmmo(10000, "SMG1", true)
		activator:GiveAmmo(10000, "SniperPenetratedRound", true)
		activator:GiveAmmo(10000, "AirboatGun", true)
		activator:GiveAmmo(10000, "XBowBolt", true)
		activator:GiveAmmo(10000, "RPG_Round", true)
		activator:GiveAmmo(10000, "40mmGrenade", true)
		activator:GiveAmmo(10000, "Improvised_Explosive", true)
		activator:GiveAmmo(10000, "ProxMine", true)
		activator:GiveAmmo(10000, "Grenade", true)
		activator:GiveAmmo(10000, "AR2AltFire", true)
		activator:GiveAmmo(10000, "SMG1_Grenade", true)
		activator:GiveAmmo(10000, "StickyGrenade", true)
		activator:GiveAmmo(10000, "Harpoon", true)
		activator:GiveAmmo(10000, "C4Explosive", true)
		activator:PrintMessage(HUD_PRINTTALK, "All Ammo Given.")
		activator:EmitSound("items/ammo_pickup.wav")
		
	end
end

if CLIENT then

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
end

/*---------------------------------------------------------
   Name: DrawPre
---------------------------------------------------------*/
function ENT:Draw()
	
	self.Entity:DrawModel()
	
	local ledcolor = Color(230, 45, 45, 255)

  	local TargetPos = self.Entity:GetPos() + (self.Entity:GetUp() * 13.3) + (self.Entity:GetRight() * 2) + (self.Entity:GetForward() * 1.5)

	local FixAngles = self.Entity:GetAngles()
	local FixRotation = Vector(90, 90, 90)
	
	FixAngles:RotateAroundAxis(FixAngles:Right(), FixRotation.x)
	FixAngles:RotateAroundAxis(FixAngles:Up(), FixRotation.y)
	FixAngles:RotateAroundAxis(FixAngles:Forward(), FixRotation.z)

	self.Text = "Ammo Box"
	
	cam.Start3D2D(TargetPos, FixAngles, .07)
		draw.SimpleText(self.Text, "DermaLarge", 31, -22, ledcolor, 1, 1)
	cam.End3D2D()
end

end