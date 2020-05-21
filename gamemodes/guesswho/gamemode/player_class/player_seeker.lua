AddCSLuaFile()

DEFINE_BASECLASS( "player_guess_who" )

local PLAYER = {}

PLAYER.WalkSpeed = GetConVar("gw_seeker_walk_speed"):GetFloat()
PLAYER.RunSpeed = GetConVar("gw_seeker_run_speed"):GetFloat()
PLAYER.JumpPower = 250
PLAYER.CanUseFlashlight = true

function PLAYER:Loadout(pl)
    pl:Give( "weapon_gw_seeker_crowbar" )
    pl:Give( "weapon_smg1" )
    pl:GiveAmmo( 200, "smg1", true )
    pl:GiveAmmo( 1, "smg1_grenade", true )
end

function PLAYER:OnSpawn(pl)
    pl:SetAvoidPlayers(false)
    pl:SetCollisionGroup(11)
end

--player_manager.RegisterClass( "player_seeker", PLAYER, "player_guess_who" )
player_class.Register( "player_seeker", PLAYER )