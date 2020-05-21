AddCSLuaFile()

DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

function PLAYER:SetModel(pl)
end

function PLAYER:Loadout(pl)
end

--Double jump script originally created by Willox (unlicensed) modified by me
local plyMeta = FindMetaTable("Player")
AccessorFunc(plyMeta, "gwDoubleJump", "DoubleJumped", FORCE_BOOL)

local function GetMoveVector( mv )

	local ang = mv:GetAngles()

	local max_speed = mv:GetMaxSpeed() * 2

	local forward = math.Clamp( mv:GetForwardSpeed(), - max_speed, max_speed )
	local side = math.Clamp( mv:GetSideSpeed(), - max_speed, max_speed )

	local abs_xy_move = math.abs( forward ) + math.abs( side )

	if abs_xy_move == 0 then

		return Vector( 0, 0, 0 )

	end

	local mul = max_speed / abs_xy_move

	local vec = Vector()

	vec:Add( ang:Forward() * forward )
	vec:Add( ang:Right() * side )

	vec:Mul( mul )

	return vec

end

function PLAYER:StartMove( pl, mv, cmd )
	if GetConVar("gw_double_jump_enabled"):GetBool() then

		if pl:OnGround() then

			pl:SetDoubleJumped( false )

			return

		end

		if not mv:KeyPressed( IN_JUMP ) then

			return

		end

		if pl:GetDoubleJumped() then

			return

		end

		pl:SetDoubleJumped( true )

		local vel = GetMoveVector( mv )

		vel.z = pl:GetJumpPower() * 1.5

		mv:SetVelocity( vel )

		pl:DoCustomAnimEvent( PLAYERANIMEVENT_JUMP, - 1 )
	end
end

--player_manager.RegisterClass( "player_guess_who", PLAYER, "player_default" )
player_class.Register( "player_guess_who", PLAYER )