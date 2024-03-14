ITEM.Name = "M9 Bayonet Knife"
ITEM.Price = 20000
ITEM.Model = "models/weapons/w_csgo_m9.mdl"
ITEM.Skin = 0
ITEM.WeaponClass = "csgo_m9"

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