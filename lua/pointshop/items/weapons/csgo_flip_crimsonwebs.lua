ITEM.Name = "Flip Knife" .. " | " .. "Crimson Webs"
ITEM.Price = 20000
ITEM.Model = "models/weapons/w_csgo_flip.mdl"
ITEM.Skin = 3
ITEM.WeaponClass = "csgo_flip_crimsonwebs"

function ITEM:OnEquip(ply)
	if not ply:Alive() then return end
	ply:StripWeapon('weapon_zm_improvised')
		ply:Give(self.WeaponClass)
		ply:SelectWeapon(self.WeaponClass)
	
	end
	
	function ITEM:OnHolster(ply)
	if not ply:Alive() then return end
		ply:StripWeapon(self.WeaponClass)
		ply:Give('weapon_zm_improvised')  -- Also don't know why you're giving the player a weapon for holstering it..
		ply:SelectWeapon('weapon_zm_improvised')
	end
	
	function ITEM:PlayerSpawn(ply)
			ply:StripWeapon('weapon_zm_improvised')
			ply:Give(self.WeaponClass)
			ply:SelectWeapon(self.WeaponClass)
	end