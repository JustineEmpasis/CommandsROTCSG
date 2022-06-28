
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    new Float:hp;
    GetPlayerHealth(playerid, hp);
    if( (hp <= 30.0) && (IsPlayerInjured[playerid] == false) && (aduty[playerid] == false) ) 
    {
        ApplyAnimation(playerid, "PED", "KO_SHOT_FRONT", 4.1, 0, 1, 1, 1, 0, 1);
        IsPlayerInjured[playerid] = true;
        DoInjured(playerid);
        return 1;
    }
    return 1;
}

hook OnPlayerConnect(playerid) 
{
    IsPlayerHospitalized[playerid] = false;
    IsPlayerReviving[playerid] = false;
    return 1;
}

forward DoInjured(playerid);
public DoInjured(playerid)
{
    new Float:x, Float:y, Float:z;

    GameTextForPlayer(playerid, "~r~SEVERELY WOUNDED", 5000, 1);
    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You are severely wounded, as a result your body could not move anymore. Wait for a Medic to treat your wounds... ");
    SendClientMessageEx2(playerid, COLOR_WHITE, "...If you want to skip your wounds and spawn at the hospital, type [/hospital] to proceed.");

    SetPlayerHealth(playerid, 50.0);

    GetPlayerPos(playerid, x, y, z);
    InjuredLabel[playerid] = Create3DTextLabel("(( SEVERELY WOUNDED ))", COLOR_ORANGERED, x, y, z, 8.0, GetPlayerVirtualWorld(playerid), 1);
    Attach3DTextLabelToPlayer(InjuredLabel[playerid], playerid, 0.0, 0.0, 0.7);
    return 1;
}

forward DeathMessage(playerid, which);
public DeathMessage(playerid)
{
    SendClientMessageEx2(playerid, COLOR_ORANGE, "[HOSPITAL]: {FFFFFF}You are now wearing a hospital gown. Please wait for 5 seconds to move.");
    return 1;
}

new loopdeath[MAX_PLAYERS] = 0;

hook OnPlayerDeath(playerid, killerid, reason)
{
    IsPlayerHospitalized[playerid] = true;

    Delete3DTextLabel(InjuredLabel[playerid]);

    SetWeaponOne(playerid, 0);
    SetWeaponTwo(playerid, 0);
    SetWeaponOneAmmo(playerid, 0);
    SetWeaponTwoAmmo(playerid, 0);
    ResetPlayerWeapons(playerid);

    if(loopdeath[playerid] == 0)
    {  
        SendClientMessageEx2(playerid, COLOR_ORANGE, "[HOSPITAL]: {FFFFFF}You've been admitted to the hospital. Please wait 30 seconds.");
        SetTimerEx("DeathMessage", 31000, false, "i", playerid);
    }
    loopdeath[playerid]++;

    GameTextForPlayer(playerid, "~r~HOSPITALIZED", 8000, 1);

    SpawnPlayer(playerid);
    SetPlayerPos(playerid, 70.6340, 2108.9006, 17.7899);
    SetPlayerCameraPos(playerid, 100.2352, 2066.3064, 29.4583);
    SetPlayerCameraLookAt(playerid, 99.5277, 2067.0173, 29.2433);

    TogglePlayerControllable(playerid, 0);

    SetTimerEx("OnPlayerSpawnAtHospital", 30000, false, "i", playerid);
    return 1;
}

forward OnPlayerSpawnAtHospital(playerid);
public OnPlayerSpawnAtHospital(playerid)
{   
    loopdeath[playerid] = 0;

    Delete3DTextLabel(InjuredLabel[playerid]);

    IsPlayerHospitalized[playerid] = false;
    IsPlayerInjured[playerid] = false;
    SetPlayerPos(playerid, 173.3931,-68.3511,979.5447);
    FreezePlayer(playerid, true, 5000);
    SetCameraBehindPlayer(playerid);
    SetPlayerHealth(playerid, 100);
    SetPlayerArmour(playerid, 0);

    if(GetGender(playerid) == 0)
    {
        SetPlayerSkin(playerid, 42);
    }
    if(GetGender(playerid) == 1)
    {
        SetPlayerSkin(playerid, 69);     
    }
    return 1;
}

YCMD:revive(playerid, params[], help)
{
    new targetid;
    new Float:a;
    new Float:b;
    new Float:c;

    if( (GetPlayerClass(playerid) != 5) )
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You are not authorized to use this command.");
        return 1;
    }
    if( IsPlayerReviving[playerid] == true )
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You are currently reviving someone.");
        return 1;
    }
    if( IsPlayerInjured[playerid] == true )
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You are wounded, you cannot revive someone in your current state.");
        return 1;
    }
    if(sscanf(params, "u", targetid))
	{
	    SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: {FFFFFF}/revive [Player ID]");
		return 1;
	}
    if(!IsPlayerConnected(targetid)) 
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"The target player is not connected.");
        return 1;
    }
    if(!IsPlayerLoggedIn(targetid)) 
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"The target player has not yet logged in.");
        return 1;
    }
    if(playerid == targetid) {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You can not revive yourself!");
        return 1;
    }

    GetPlayerPos(targetid, a, b, c);
    if(!IsPlayerInRangeOfPoint(playerid, 1, a, b, c))
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"The player is not nearby.");
        return 1;
    }

    if(IsPlayerInjured[targetid] != true)
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"The target player is not wounded.");
        return 1;
    }
    

    ApplyAnimation(playerid, "MEDIC", "CPR", 4.1, 0, 0, 0, 0, 0, 1);
    ApplyAnimation(targetid, "CRACK", "CRCKIDLE1", 4.1, 0, 1, 1, 1, 0, 1);

    IsPlayerReviving[playerid] = true;
    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You are now reviving %s. Please wait for 10 seconds.", GetPlayerNameEx2(targetid));
    SendClientMessageEx2(targetid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You are being revive by %s. Please wait for 10 seconds.", GetPlayerNameEx2(playerid));
    SetTimerEx("OnRevive", 10000, false, "ii", playerid, targetid);
    return 1;
    
}

forward OnRevive(playerid, targetid);
public OnRevive(playerid, targetid)
{
    IsPlayerInjured[targetid] = false;
    IsPlayerReviving[playerid] = false;
    Delete3DTextLabel(InjuredLabel[targetid]);
    ClearAnimations(playerid);
    ClearAnimations(targetid);
    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: {FFFFFF}You successfully revived %s.", GetPlayerNameEx2(targetid));
    SendClientMessageEx2(targetid, COLOR_LIMEGREEN, "[SERVER]: {FFFFFF}You have been revived by %s.", GetPlayerNameEx2(playerid));
    SetPlayerHealth(targetid, 50.0);
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    return 1;
}

YCMD:hospital(playerid, params[], help)
{
    if( IsPlayerInjured[playerid] != true )
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You are not injured.");
        return 1;
    }

    SetPlayerHealth(playerid, 0);
    return 1;
}

YCMD:heal(playerid, params[], help)
{
    new targetid;
    new Float:a;
    new Float:b;
    new Float:c;

    if( (GetPlayerClass(playerid) != 5) )
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You are not authorized to use this command.");
        return 1;
    }
    if(sscanf(params, "u", targetid))
	{
	    SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: {FFFFFF}/heal [Player ID]");
		return 1;
	}
    if(!IsPlayerConnected(targetid)) 
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"The target player is not connected.");
        return 1;
    }
    if(!IsPlayerLoggedIn(targetid)) 
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"The target player has not yet logged in.");
        return 1;
    }
    if(playerid == targetid) {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You can not heal yourself!");
        return 1;
    }
    new Float:hp;
    GetPlayerHealth(targetid, hp);
    if(100 == hp)
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"The target already have full health!");
        return 1;
    }
    
    GetPlayerPos(targetid, a, b, c);
    if(!IsPlayerInRangeOfPoint(playerid, 5, a, b, c))
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"The player is not nearby.");
        return 1;
    }

    if(IsPlayerInjured[targetid] == true)
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"The target player is currently injured, it must be revived first.");
        return 1;
    }
    if( IsPlayerInjured[playerid] == true )
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You are wounded, you cannot heal someone in your current state.");
        return 1;
    }

    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: {FFFFFF}You healed %s.", GetPlayerNameEx2(targetid));
    SendClientMessageEx2(targetid, COLOR_LIMEGREEN, "[SERVER]: {FFFFFF}You have been healed by %s.", GetPlayerNameEx2(playerid));
    SetPlayerHealth(targetid, 100);
    return 1;
}