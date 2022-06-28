#include <YSI_Coding\y_hooks>

#define ADMIN_PASSWORD          "rotcadminpass123"


new
    Text3D:statusLabel[MAX_PLAYERS];

new newcolorset = 0x8a9a5bFF;

hook OnPlayerConnect(playerid)
{
    //TogglePlayerClock(playerid, 1);
    aduty[playerid] = false;
    IsPlayerForceFreeze[playerid] = false;
    return 1;
}

bool:IsPlayerMod(playerid)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT user_id FROM admins WHERE user_id = %d", GetPlayerUserID(playerid));
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    if(cache_num_rows()) {
        cache_delete(SQL_Cache);
        return true;
    }
    cache_delete(SQL_Cache);
    return false;
}

YCMD:adminhelp(playerid, params[], help)
{
    if(!IsPlayerMod(playerid))
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }
    
    SendClientMessageEx2(playerid, COLOR_YELLOW, "- - - - - - - - - - - - - - - - - - - - - ADMIN COMMANDS - - - - - - - - - - - - - - - - - - - - -");
    SendClientMessageEx2(playerid, COLOR_WHITE, "[ADMIN] /makeadmin /aduty /kick /ban /goto /gethere /gotocoords /tpall /jetpack /set /setskin");
    SendClientMessageEx2(playerid, COLOR_WHITE, "[ADMIN] /sethp /sethpall /change /toggle /getweapon /removeweapons /freeze /freezeall");
    SendClientMessageEx2(playerid, COLOR_WHITE, "[HIERARCHY] /setclass /setclassall /setrank /setrankall");
    return 1;
}

GetPlayerRealName(playerid)
{
    new SQL_Result[64];
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT user_name FROM users WHERE user_id='%d'", GetPlayerUserID(playerid));
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name(0, "user_name", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

stock SetPlayerRealName(playerid, value)
{
    mysql_format( SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_name='%s' WHERE user_id=%d", value, GetPlayerUserID(playerid) );
    mysql_tquery( SQL_Handle, SQL_Buffer );
    return 1;
}

YCMD:aduty(playerid, params[], help)
{
    if(!IsPlayerMod(playerid))
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You are not authorized to use this command!");
        return 1;
    }

    if(aduty[playerid] == false)
    {
        new
            Float:x, Float:y, Float:z;

        GetPlayerPos(playerid, x, y, z);

        aduty[playerid] = true;
        DestroyDynamic3DTextLabel(statusLabel[playerid]);

        SetPlayerHealth(playerid, 99999);
        SendClientMessage(playerid, COLOR_LIMEGREEN, "[ADMIN INFO]: "COL_WHITE"ADMIN ON");
        return 1;
    }
    else
    {
        aduty[playerid] = false;
        statusLabel[playerid] = CreateDynamic3DTextLabel(ShowPlayerLabel(playerid), newcolorset, 0, 0, 0, 3.0, .attachedplayer = playerid);

        SetPlayerHealth(playerid, 100);

        SendClientMessage(playerid, COLOR_LIGHTRED, "[ADMIN INFO]: "COL_WHITE"ADMIN OFF");
        return 1;
    }
}

YCMD:makemeadmin(playerid, params[], help)
{
    if(IsPlayerMod(playerid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are already an admin!");
        return 1;
    }

    new
        password[32];

    if(sscanf(params, "s[32]", password)) {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/makemeadmin [password]");
        return 1;
    }

    if(!strcmp(password, ADMIN_PASSWORD))
    {
        mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "INSERT INTO admins(user_id) VALUES(%d);", GetPlayerUserID(playerid));
        mysql_tquery(SQL_Handle, SQL_Buffer);

        SendClientMessage(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You have set yourself as an admin!");
    }
    else
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You have entered the wrong admin password!");
    }
    return 1;
}

YCMD:change(playerid, params[], help)
{
    if(!IsPlayerMod(playerid))
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new
        option[16],
        option_params[256],
        targetid,
        value[21];
    
    if(sscanf(params, "s[16]S()[256]", option, option_params)) 
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/change [ name / gender / email / studentid ]");
        return 1;
    }

    if( !strcmp(option, "name", true) )
    {
        if(sscanf(option_params, "us[21]", targetid, value))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/change name [Player ID] [New Name]");
            return 1;
        }

        if(!IsPlayerConnected(targetid)) 
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " The target player is not connected!");
            return 1;
        }

        if(!IsPlayerLoggedIn(targetid)) 
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " The target player has not yet logged in!");
            return 1;
        }

        if( !IsValidName( value ) )
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " That is an invalid name!");
            return 1;
        }

        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[NAME INFO]: "COL_WHITE"You changed the name of %s to %s", GetPlayerNameEx(targetid), value );
        SendClientMessageEx2(targetid, COLOR_AQUA, "[NAME INFO]: "COL_WHITE"Your name was changed by an admin to %s", value );

        SetPlayerName(targetid, value);
        return 1;
    }

    return 1;
}

YCMD:makeadmin(playerid, params[], help) 
{
    if(!IsPlayerMod(playerid))
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new
        targetid,
        value;
    
    if(sscanf(params, "ui", targetid, value)) 
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/makeadmin [playerid] [1/0]");
        return 1;
    }

    if(!IsPlayerConnected(targetid)) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player is not connected!");
        return 1;
    }

    if(!IsPlayerLoggedIn(targetid)) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player has not yet logged in!");
        return 1;
    }

    if(value == 1) 
    {
        mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "INSERT INTO admins(user_id) VALUES(%d);", GetPlayerUserID(targetid));
        mysql_tquery(SQL_Handle, SQL_Buffer);
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You have given %s admin powers.", GetPlayerNameEx2(targetid));
        SendClientMessage(targetid, COLOR_AQUA, "[INFO]: "COL_WHITE"You have been given admin powers.");
    } 
    else if(value == 0) 
    {
        if(!IsPlayerMod(targetid)) 
        {
            SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"The target player is not even an admin!");
            return 1;
        }
        
        mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "DELETE FROM admins WHERE user_id = %d;", GetPlayerUserID(targetid));
        mysql_tquery(SQL_Handle, SQL_Buffer);
        SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: "COL_WHITE"You have revoked %s's admin powers.", GetPlayerNameEx2(targetid));
        SendClientMessage(targetid, COLOR_ORANGE, "[SERVER]: "COL_WHITE"Your admin powers were revoked.");
    } 
    else 
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/makeadmin [playerid] [1/0]");
    }

    return 1;
}

YCMD:removeweapons(playerid, params[], help)
{
    new targetid;
    if(!IsPlayerMod(playerid)) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    if(sscanf(params, "u", targetid))
	{
	    SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: {FFFFFF}/removeweapons [Player ID]");
		return 1;
	}

    if(!IsPlayerConnected(targetid)) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player is not connected!");
        return 1;
    }

    if(!IsPlayerLoggedIn(targetid)) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player has not yet logged in!");
        return 1;
    }

    SetWeaponOne(targetid, 0);
    SetWeaponTwo(targetid, 0);
    SetWeaponOneAmmo(targetid, 0);
    SetWeaponTwoAmmo(targetid, 0);
    ResetPlayerWeapons(targetid);
    SendClientMessageEx2(targetid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"Your weapons have been removed by an admin.");
    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: "COL_WHITE"You removed all the weapons from %s!", GetPlayerNameEx2(targetid));

    return 1;
}

YCMD:freeze(playerid, params[], help)
{
    new targetid;
    if(!IsPlayerMod(playerid)) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    if(sscanf(params, "u", targetid))
	{
	    SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: {FFFFFF}/freeze [Player ID]");
		return 1;
	}

    if( IsPlayerMod(targetid) ) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You can not freeze an admin.");
        return 1;
    }

    if(!IsPlayerConnected(targetid)) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player is not connected!");
        return 1;
    }

    if(!IsPlayerLoggedIn(targetid)) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player has not yet logged in!");
        return 1;
    }

    if( IsPlayerForceFreeze[targetid] == true)
    {
        SendClientMessageEx2(targetid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You are now unfroze!");
        SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: "COL_WHITE"You unfroze %s!", GetPlayerNameEx2(targetid));
        TogglePlayerControllable(targetid, 1);
        IsPlayerForceFreeze[targetid] = false;
        return 1;
    }

    SendClientMessageEx2(targetid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You are forced freeze!");
    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: "COL_WHITE"You froze %s!", GetPlayerNameEx2(targetid) );
    TogglePlayerControllable(targetid, 0);
    IsPlayerForceFreeze[targetid] = true;

    return 1;
}

YCMD:freezeall(playerid, params[], help)
{
    if(!IsPlayerMod(playerid)) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new
        freeze = 0, unfreeze = 0;

    foreach(new i : Player)
    {
        if( IsPlayerLoggedIn(i) )
        {
            if ( IsPlayerMod(i) )
            {
                continue;
            }

            if ( IsPlayerForceFreeze[i] == true ) // unfreeze
            {
                SendClientMessageEx2(i, COLOR_ORANGE, "[SERVER]: "COL_WHITE"You are now unfroze!");
                IsPlayerForceFreeze[i] = false;
                TogglePlayerControllable(i, 1);
                unfreeze++;
            }
            else
            {
                SendClientMessageEx2(i, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You have been forced freeze!");
                IsPlayerForceFreeze[i] = true;
                TogglePlayerControllable(i, 0);
                freeze++;
            }
        }
    }

    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: "COL_WHITE"You have frozen %d player(s)!", freeze);
    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: "COL_WHITE"You have unfrozen %d player(s)!", unfreeze);
    return 1;
}


YCMD:getweapon(playerid, params[], help)
{
    new targetid, weaponID, ammo;
    if(!IsPlayerMod(playerid)) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    if(sscanf(params, "uii", targetid, weaponID, ammo))
	{
	    SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: {FFFFFF}/getweapon [Player ID] [Weapon ID] [Amount of Ammo]");
		return 1;
	}

    if(!IsPlayerConnected(targetid)) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player is not connected!");
        return 1;
    }

    if(!IsPlayerLoggedIn(targetid)) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player has not yet logged in!");
        return 1;
    }

	if(weaponID < 1 || weaponID > 46)
	{
	    return SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You have specified an invalid weapon");
 	}
 	
 	if(ammo < 1 || ammo > 999)
 	{
 	    return SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You have specified an invalid amount of ammo");
 	}

	GivePlayerWeapon(targetid, weaponID, ammo);
    if(targetid == playerid)
    {
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: {FFFFFF}You have given yourself a weapon with %d ammunation.", ammo);
    }
    else
    {
        SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You have given %s a weapon with %d ammunation.", GetPlayerNameEx2(targetid), ammo);
 	    SendClientMessageEx2(targetid, COLOR_LIMEGREEN, "[SERVER]: {FFFFFF}You received a weapon");
    }
	return 1;
}

YCMD:sethpall(playerid, params[], help)
{
    if(!IsPlayerMod(playerid))
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new value;
    if(sscanf(params, "d", value))
	{
	    SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: {FFFFFF}/sethpall [Value]");
		return 1;
	}

    new
        healed;

    foreach(new i : Player)
    {
        if(IsPlayerLoggedIn(i))
        {
            if(IsPlayerInjured[i] == true)
            {
                continue;
            }

            if(IsPlayerHospitalized[i] == true)
            {
                continue;
            }

            SetPlayerHealth(i, value);
            healed++;
        }
    }

    if(!healed)
    {
        return 1;
    }

    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You have healed %d player(s).", healed);
    return 1;
}

YCMD:sethp(playerid, params[], help)
{
    new targetid, hpAmount;
    if(!IsPlayerMod(playerid)) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

	if(sscanf(params, "ui", targetid, hpAmount))
	{
	    SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: {FFFFFF}/sethp [Player ID] [Amount]");
		return 1;
	}

    if( !IsPlayerLoggedIn(targetid) )
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " That player has not yet logged in or not connected!");
        return 1;
    }

    if(IsPlayerHospitalized[targetid] == true)
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player is currently hospitalized!");
        return 1;
    }

    if(IsPlayerInjured[targetid] == true)
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player is currently injured!");
        return 1;
    }

    new Float:health;
    new Float:total;
    GetPlayerHealth(targetid, health);

    if(targetid == playerid)
    {
        if (hpAmount == 0)
        {
            SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You {FF6347}killed {FFFFFF}yourself.", hpAmount);
        }
        else if(health > hpAmount) // IF THE GIVEN AMOUNT IS LESS THAN THE CURRENT HP OF THE TARGET ID
        {   
            SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You {FF6347}decreased {FFFFFF}your health to %d.", hpAmount);
        }
        else if (health < hpAmount) // IF THE GIVEN AMOUNT IS GREATER THAN THE CURRENT HP OF THE TARGET ID
        {
            SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You {32CD32}increased {FFFFFF}your health to %d.", hpAmount);
        }
        else if ((hpAmount == 100) && (health == 100))
        {
            SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have full health.", hpAmount);
            return 1;
        }
        else if (health == hpAmount)
        {
            SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have that amount of health.", hpAmount);
            return 1;
        }
    }
    else
    {
        if (hpAmount == 0)
        {
            SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You {FF6347}killed {FFFFFF}'%s'.", GetPlayerNameEx2(targetid));
            SendClientMessageEx2(targetid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You have been {FF6347}killed{FFFFFF}.", hpAmount);
        }
        else if(health > hpAmount) // IF THE GIVEN AMOUNT IS LESS THAN THE CURRENT HP OF THE TARGET ID
        {   
            total = health - hpAmount;
            SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You {FF6347}decreased {FFFFFF}the health of %s to %.0f", GetPlayerNameEx2(targetid), total);
 	        SendClientMessageEx2(targetid, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}You lost %.0f health.", total);
        }
        else if (health < hpAmount) // IF THE GIVEN AMOUNT IS GREATER THAN THE CURRENT HP OF THE TARGET ID
        {
            total = hpAmount - health;
            SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You {32CD32}increased {FFFFFF}the health of %s to %.0f", GetPlayerNameEx2(targetid), total);
 	        SendClientMessageEx2(targetid, COLOR_LIMEGREEN, "[SERVER]: {FFFFFF}You gained %.0f health.", total);
        }
        else if ((hpAmount == 100) && (health == 100))
        {
            SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}%s already have full health.", GetPlayerNameEx2(targetid));
            return 1;
        }
        else if (health == hpAmount)
        {
            SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}%s already have that amount of health.", GetPlayerNameEx2(targetid));
            return 1;
        }

    }
    SetPlayerHealth(targetid, hpAmount);
    return 1;
}

YCMD:jetpack(playerid, params[], help)
{
    if(!IsPlayerMod(playerid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    SendClientMessage(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You have spawned a jetpack!");
    return 1;
}

YCMD:announce(playerid, params[], help) {
    if( GetPlayerRank(playerid) < 6 )
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }
    
    new
        message[256];

    if(sscanf(params, "s[256]", message)) {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/announce [message]");
        return 1;
    }

    foreach(new i : Player) {
        if(IsPlayerLoggedIn(i)) {
            if(strlen(message) > MESSAGE_SPLIT_LENGTH) {
                SendClientMessageEx2(i, COLOR_WHITE, ""COL_ORANGE"Announcement: "COL_WHITE"%.*s...", MESSAGE_SPLIT_LENGTH, message);
                SendClientMessageEx2(i, COLOR_WHITE, ""COL_ORANGE"Announcement: "COL_WHITE"...%s", message[MESSAGE_SPLIT_LENGTH]);
            } else {
                SendClientMessageEx2(i, COLOR_WHITE, ""COL_ORANGE"Announcement: "COL_WHITE"%s", message);
            }
        }
    }
    return 1;
}

YCMD:goto(playerid, params[], help)
{
    if(!IsPlayerMod(playerid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new
        targetid;
    
    if(sscanf(params, "u", targetid)) {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/goto [playerid]");
        return 1;
    }

    if(!IsPlayerConnected(targetid)) {
        SendClientMessage(playerid, COLOR_LIGHTRED, " The target player is not connected!");
        return 1;
    }
    if(IsPlayerOnTraining[playerid] == true)
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, " The target player is not connected!");
        return 1;
    }

    if(!IsPlayerLoggedIn(targetid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player has not yet logged in!");
        return 1;
    }

    if(playerid == targetid) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You can not teleport to yourself!");
        return 1;
    }

    SetPlayerPos(playerid, GetPlayerPosition(targetid, DIMENSION_X), GetPlayerPosition(targetid, DIMENSION_Y), GetPlayerPosition(targetid, DIMENSION_Z));
    FreezePlayer(playerid, true, 3000);

    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You have teleported to %s", GetPlayerNameEx2(targetid));
    return 1;
}

YCMD:gethere(playerid, params[], help) {
    if(!IsPlayerMod(playerid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new
        targetid;
    
    if(sscanf(params, "u", targetid)) {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/gethere [playerid]");
        return 1;
    }

    if(!IsPlayerConnected(targetid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player is not connected!");
        return 1;
    }

    if(!IsPlayerLoggedIn(targetid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player has not yet logged in!");
        return 1;
    }

    if(IsPlayerHospitalized[targetid] == true)
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player is currently hospitalized!");
        return 1;
    }

    if(IsPlayerInjured[targetid] == true)
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player is currently injured!");
        return 1;
    }
    
    if(playerid == targetid) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You can not teleport yourself!");
        return 1;
    }

    SetPlayerPos(targetid, GetPlayerPosition(playerid, DIMENSION_X), GetPlayerPosition(playerid, DIMENSION_Y), GetPlayerPosition(playerid, DIMENSION_Z));
    FreezePlayer(targetid, true, 3000);

    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You have teleported %s to your location", GetPlayerNameEx2(targetid));
    return 1;
}

YCMD:tpall(playerid, params[], help)
{
    if(!IsPlayerMod(playerid))
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }
    new
        teleported;

    foreach(new i : Player)
    {
        if(IsPlayerLoggedIn(i) && i != playerid)
        {
            if(IsPlayerInjured[i] == true)
            {
                continue;
            }

            if(IsPlayerHospitalized[i] == true)
            {
                continue;
            }

            SetPlayerPos(i, GetPlayerPosition(playerid, DIMENSION_X), GetPlayerPosition(playerid, DIMENSION_Y), GetPlayerPosition(playerid, DIMENSION_Z));
            FreezePlayer(i, true, 3000);

            teleported++;
        }
    }

    if(!teleported)
    {
        return 1;
    }

    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You have teleported %d player%s to your location", teleported, teleported == 1 ? "" : "s");
    return 1;
}

new
    bool:IsGlobalToggled;

hook OnGameModeInit()
{
    IsGlobalToggled = false;
    return 1;
}

YCMD:toggle(playerid, params[], help) {
    if(!IsPlayerMod(playerid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, "  You are not authorized to use this command!");
        return 1;
    }
    
    new
        option[16];
    
    if(sscanf(params, "s[16]", option)) {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/toggle [global]");
        return 1;
    }

    if(!strcmp(option, "global", true)) {
        IsGlobalToggled = IsGlobalToggled ? false : true;
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You have toggled global chat [%s%s"COL_WHITE"].", IsGlobalToggled ? ""COL_LIMEGREEN"ON" : ""COL_ORANGE"OFF");
    }
    return 1;
}

YCMD:setskin(playerid, params[], help)
{
    if(!IsPlayerMod(playerid))
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new
        targetid,
        skinid;
    
    if(sscanf(params, "ui", targetid, skinid))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/setskin [Player ID] [Skin ID]");
        return 1;
    }

    if(!IsPlayerConnected(targetid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player is not connected!");
        return 1;
    }

    if(!IsPlayerLoggedIn(targetid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player has not yet logged in!");
        return 1;
    }

    SendClientMessageEx2(targetid, COLOR_AQUA, "[SERVER]: "COL_WHITE"Your skin was changed by an admin.");
    SetPlayerSkin(targetid, skinid);
    return 1;
}

YCMD:gotocoords(playerid, params[], help) {
    if(!IsPlayerMod(playerid)) {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"You are not authorized to use this command!");
        return 1;
    }

    new
        Float:Position[3],
        GlobalPosition[2];

    if(sscanf(params, "fffI(0)I(0)", Position[0], Position[1], Position[2], GlobalPosition[0], GlobalPosition[1])) {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/gotocoords [x] [y] [z] [interior (optional)] [world (optional)]");
        return 1;
    }

    SetPlayerPos(playerid, Position[0], Position[1], Position[2]);
    SetPlayerInterior(playerid, GlobalPosition[0]);
    SetPlayerVirtualWorld(playerid, GlobalPosition[1]);

    SendClientMessage(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You have teleported to the desired position.");
    
    return 1;
}

forward _KickPlayerDelayed(playerid);
public _KickPlayerDelayed(playerid)
{
    Kick(playerid);
    return 1;
}

DelayedKick(playerid, time = 500)
{
    SetTimerEx("_KickPlayerDelayed", time, false, "d", playerid);
    return 1;
}

YCMD:kick(playerid, params[], help) {
    if(!IsPlayerMod(playerid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new targetid, reason[256];

    if(sscanf(params, "us[144]", targetid, reason)) {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/kick [Player ID] [Reason].");
        return 1;
    }
    
    if(!IsPlayerLoggedIn(targetid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player has not yet logged in!");
        return 1;
    }

    ClearChat(targetid);
    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You kicked %s (Reason: %s)", GetPlayerNameEx2(targetid), reason);
    SendClientMessageEx2(targetid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You have been KICKED (Reason: %s)", reason);
    DelayedKick(targetid);
    return 1;
}

YCMD:ban(playerid, params[], help) {
    if(!IsPlayerMod(playerid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new targetid, reason[256];

    if(sscanf(params, "us[144]", targetid, reason)) {
        return 1;
    }

    if(!IsPlayerLoggedIn(targetid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player has not yet logged in!");
        return 1;
    }

    if(IsPlayerMod(playerid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You can not ban an admin!");
        return 1;
    }

    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[USAGE]: "COL_WHITE"You banned %s. Reason: %s.", GetPlayerNameEx2(targetid), reason);
    SendClientMessageEx2(targetid, COLOR_LIGHTRED, "[USAGE]: "COL_WHITE"You have BANNED from the game. (Reason: %s)", GetPlayerNameEx2(targetid), reason);

    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_banned = 1 WHERE user_id = %d", GetPlayerUserID(playerid));
    mysql_tquery(SQL_Handle, SQL_Buffer);

    DelayedKick(targetid);
    return 1;
}

YCMD:set(playerid, params[], help)
{
    if(!IsPlayerMod(playerid))
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new selection[64];
    new selection_params[64];
    new value;

    if( sscanf(params, "s[16]S()[255]", selection, selection_params ) )
    {
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/set [ weather / time ]");
        return 1;
    }

    if( !strcmp(selection, "weather", true))
    {
        if( sscanf(selection_params, "i", value ) )
        {
            SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/set weather [Weather ID]");
            return 1;
        }

        SetWeather(value);
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[WEATHER INFO]: "COL_WHITE"You set the weather to %i", value);
        return 1;
    }
    if( !strcmp(selection, "time", true))
    {
        if( sscanf(selection_params, "i", value ) )
        {
            SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/set time [Time]");
            return 1;
        }

        SetWorldTime(value);
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[TIME INFO]: "COL_WHITE"You set the time to %i", value);
        return 1;
    }
    return 1;
}

// HIERARCHY

YCMD:setrankall(playerid, params[], help)
{
    if(!IsPlayerMod(playerid))
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new rank;

    if(sscanf(params, "i", rank))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/setrankall [rank]");
        return 1;
    }

    foreach(new i : Player)
    {
        if( IsPlayerLoggedIn(i) )
        {
            if ( IsPlayerMod(i) )
            {
                continue;
            }

            SendClientMessageEx2(i, COLOR_AQUA, "[CLASS INFO]: "COL_WHITE"You were given class %d. Type [/stats] to update your status bar.", rank);
            mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_rank = %d WHERE user_id = %d", rank, GetPlayerUserID(i));
            mysql_tquery(SQL_Handle, SQL_Buffer);
        }
    }

    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[CLASS INFO]: "COL_WHITE"You have made all rank %d", rank);
    return 1;
}

YCMD:setrank(playerid, params[], help)
{
    if(!IsPlayerMod(playerid))
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new
        targetid,
        rank;

    if(sscanf(params, "ui", targetid, rank)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, "[USAGE]: "COL_WHITE"/setrank [targetid] [rank]");
        return 1;
    }

    if(!IsPlayerLoggedIn(targetid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player has not yet logged in!");
        return 1;
    }

    if(!IsInBetween(rank, 0, 9)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " Invalid rank!");
        return 1;
    }

    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_rank = %d WHERE user_id = %d", rank, GetPlayerUserID(targetid));
    mysql_tquery(SQL_Handle, SQL_Buffer);
    
    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[RANK INFO]: "COL_WHITE"You have set "COL_AQUA"%s"COL_WHITE"'s rank to "COL_ORANGE"%s", GetPlayerNameEx2(targetid), GetPlayerRank(targetid));
    SendClientMessageEx2(targetid, COLOR_AQUA, "[RANK INFO]: "COL_WHITE"You were given rank %d. Type [/stats] to update your status bar.", rank);
    return 1;
}

YCMD:setclass(playerid, params[], help)
{
    if(!IsPlayerMod(playerid))
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new
        targetid,
        class;

    if(sscanf(params, "ui", targetid, class))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/setclass [playerid] [class]");
        return 1;
    }

    if( !IsPlayerLoggedIn(targetid) )
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " That player has not yet logged in or not connected!");
        return 1;
    }

    if(class == 0)
    {
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[CLASS INFO]: "COL_WHITE"You removed the class from %s", GetPlayerNameEx2(targetid));
        SendClientMessageEx2(targetid, COLOR_LIGHTRED, "[CLASS INFO]: "COL_WHITE"Your class has been removed.");
        mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_class = %d", class);
        mysql_tquery(SQL_Handle, SQL_Buffer);
        return 1;
    }

    if(!IsInBetween(class, 1, 5)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You inputted an invalid class!");
        return 1;
    }

    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_class = %d WHERE user_id = %d", class, GetPlayerUserID(targetid));
    mysql_tquery(SQL_Handle, SQL_Buffer);

    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[CLASS INFO]: "COL_WHITE"You have made %s a class %d", GetPlayerNameEx2(targetid), class);
    SendClientMessageEx2(targetid, COLOR_AQUA, "[CLASS INFO]: "COL_WHITE"You were given class %d. Type [/stats] to update your status bar.", class);
    return 1;
}

YCMD:setclassall(playerid, params[], help)
{
    if(!IsPlayerMod(playerid))
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }
    
    new class;
    if(sscanf(params, "i", class))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/setclassall [class]");
        return 1;
    }

    foreach(new i : Player)
    {
        if( IsPlayerLoggedIn(i) )
        {
            if ( IsPlayerMod(i) )
            {
                continue;
            }

            SendClientMessageEx2(i, COLOR_AQUA, "[CLASS INFO]: "COL_WHITE"You were given class %d. Type [/stats] to update your status bar.", class);
            mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_class = %d WHERE user_id = %d", class, GetPlayerUserID(i));
            mysql_tquery(SQL_Handle, SQL_Buffer);
        }
    }

    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[CLASS INFO]: "COL_WHITE"You have made all class %d", class);
    return 1;
}