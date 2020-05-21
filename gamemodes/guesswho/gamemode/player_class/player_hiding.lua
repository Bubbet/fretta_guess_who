AddCSLuaFile()

DEFINE_BASECLASS( "player_guess_who" )

local PLAYER = {}

PLAYER.WalkSpeed = GetConVar("gw_hiding_walk_speed"):GetFloat()
PLAYER.RunSpeed = GetConVar("gw_hiding_run_speed"):GetFloat()
PLAYER.JumpPower = 200
PLAYER.CanUseFlashlight = false

function PLAYER:Loadout(pl)
    if GetConVar( "gw_abilities_enabled" ):GetBool() then
        if pl:GetDiedInPrep() then
            pl:Give(pl:GetPrepAbility())
        else
            pl:Give( GAMEMODE.GWConfig.ActiveAbilities[ math.random( 1, #GAMEMODE.GWConfig.ActiveAbilities ) ] )
        end
    else
        pl:Give( "weapon_gw_default" )
    end
end

function PLAYER:ShouldDrawLocal() return true end

function PLAYER:OnSpawn(pl)
    local clr = GAMEMODE.GWConfig.WalkerColors[math.random(1, #GAMEMODE.GWConfig.WalkerColors)]
    pl:SetPlayerColor(Vector(clr.r / 255, clr.g / 255, clr.b / 255))
    pl:SetCustomCollisionCheck(true)
    pl:SetAvoidPlayers(false)
    pl:SetCollisionGroup(11)
end

--player_manager.RegisterClass( "player_hiding", PLAYER, "player_guess_who" )
player_class.Register( "player_hiding", PLAYER )