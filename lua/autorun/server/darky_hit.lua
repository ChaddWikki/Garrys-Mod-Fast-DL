util.AddNetworkString("HITMARKER")
util.AddNetworkString("KILLMARKER")

local lastheadshot, lastheadshottime

local function ScaleDamage(ent, group, dmginfo)
	if IsValid(ent) and IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() then
		net.Start("HITMARKER")
		net.WriteUInt(dmginfo:GetDamage(), 10)
		net.WriteBool(group == HITGROUP_HEAD)
		net.WriteBool(false)
		net.Send(dmginfo:GetAttacker())
		lastheadshot = (group == HITGROUP_HEAD)
		lastheadshottime = CurTime()
	end
end

local function DeathNPC(ent, attacker, inflictor) -- mfs from facepunch changed order for attacker and inflictor in playerdeath and onnpckilled hooks and have no lasthitgroup for npcs 
	if IsValid(ent) and IsValid(attacker) and attacker:IsPlayer() then
		net.Start("HITMARKER")
		net.WriteUInt(0, 10)
		net.WriteBool(lastheadshot and lastheadshottime == CurTime())
		net.WriteBool(true)
		net.Send(attacker)
	end
end

local function DeathPlayer(ent, inflictor, attacker)
	if IsValid(ent) and IsValid(attacker) and inflictor:IsPlayer() then
		net.Start("HITMARKER")
		net.WriteUInt(0, 10)
		net.WriteBool(ent:LastHitGroup() == HITGROUP_HEAD)
		net.WriteBool(true)
		net.Send(attacker)
	end
end

hook.Add("ScaleNPCDamage", "darky_hitmarkers_npc", ScaleDamage)
hook.Add("ScalePlayerDamage", "darky_hitmarkers_players", ScaleDamage)

hook.Add("PlayerDeath", "darky_hitmarkers_killplayers", DeathPlayer)
hook.Add("OnNPCKilled", "darky_hitmarkers_killnpc", DeathNPC)

