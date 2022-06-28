#include <YSI_Coding\y_hooks>

SetWeaponOne(playerid, value) {
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET weapon_1=%d WHERE user_id=%d", value, GetPlayerUserID(playerid));
    mysql_tquery(SQL_Handle, SQL_Buffer);
}

SetWeaponOneAmmo(playerid, value) {
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET weapon_1_ammo=%d WHERE user_id=%d", value, GetPlayerUserID(playerid));
    mysql_tquery(SQL_Handle, SQL_Buffer);
}

SetWeaponTwo(playerid, value) {
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET weapon_2=%d WHERE user_id=%d", value, GetPlayerUserID(playerid));
    mysql_tquery(SQL_Handle, SQL_Buffer);
}

SetWeaponTwoAmmo(playerid, value) {
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET weapon_2_ammo=%d WHERE user_id=%d", value, GetPlayerUserID(playerid));
    mysql_tquery(SQL_Handle, SQL_Buffer);
}

GetWeaponOne(playerid) {
    static SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT weapon_1 FROM users WHERE user_id='%d'", GetPlayerUserID(playerid));
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_int(0, "weapon_1", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

GetWeaponOneAmmo(playerid) {
    static SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT weapon_1_ammo FROM users WHERE user_id='%d'", GetPlayerUserID(playerid));
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_int(0, "weapon_1_ammo", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

GetWeaponTwo(playerid) {
    static SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT weapon_2 FROM users WHERE user_id='%de'", GetPlayerUserID(playerid));
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_int(0, "weapon_2", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

GetWeaponTwoAmmo(playerid) {
    static SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT weapon_2_ammo FROM users WHERE user_id='%d'", GetPlayerUserID(playerid));
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_int(0, "weapon_2_ammo", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

SetAmmo(playerid) 
{
    new max_ammo = 250;
    new max_sprayammo = 1000;
    new wep1 = GetWeaponOne(playerid);
    new wep2 = GetWeaponTwo(playerid);

    ResetPlayerWeapons(playerid);

    GivePlayerWeapon(playerid, wep1, max_ammo);
    if( (wep2 == 41) || (wep2 == 42) )
    {
        GivePlayerWeapon(playerid, wep2, max_sprayammo);
        SetWeaponTwoAmmo(playerid, max_sprayammo);
    }
    else
    {  
        GivePlayerWeapon(playerid, wep2, max_ammo);
        SetWeaponTwoAmmo(playerid, max_ammo);
    }

    SetWeaponOne(playerid, wep1);
    SetWeaponTwo(playerid, wep2);
    SetWeaponOneAmmo(playerid, max_ammo);
    return 1;
}

hook OnGameModeInit() {

    // MSU-IIT

    CreateDynamicPickup(1239, 1, 548.9164, 3319.2717, 2.6412);
    CreateDynamicPickup(1239, 1, 616.0417, 3433.1843, 2.4100);
    CreateDynamicPickup(1239, 1, 580.9420, 3270.1729, 2.5683);
    CreateDynamicPickup(1239, 1, 552.6882, 3153.1882, 3.9049);
    CreateDynamicPickup(1239, 1, 302.4463, 3417.7659, 2.4100);
    CreateDynamicPickup(1239, 1, 445.3949, 3393.4832, 2.4100);

    CreateDynamic3DTextLabel("COET\n"COL_WHITE"Locker", COLOR_LIME, 548.9164, 3319.2717, 2.6412, 10.0);
    CreateDynamic3DTextLabel("CED\n"COL_WHITE"Locker", COLOR_LIME, 616.0417, 3433.1843, 2.4100, 10.0);
    CreateDynamic3DTextLabel("CSM\n"COL_WHITE"Locker", COLOR_LIME, 580.9420, 3270.1729, 2.5683, 10.0);
    CreateDynamic3DTextLabel("CCS\n"COL_WHITE"Locker", COLOR_LIME, 552.6882, 3153.1882, 3.9049, 10.0);
    CreateDynamic3DTextLabel("CASS\n"COL_WHITE"Locker", COLOR_LIME, 302.4463, 3417.7659, 2.4100, 10.0);
    CreateDynamic3DTextLabel("CON\n"COL_WHITE"Locker", COLOR_LIME, 445.3949, 3393.4832, 2.4100, 10.0);

    // TRAINING GROUND

    return 1;
}

public OnPlayerSpawn(playerid)
{
    // This will make the player use single-handed sawn-off shotguns.
    return 1;
}

public OnFilterScriptInit()
{
    return 1;
}

public OnFilterScriptExit()
{
    return 1;
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{

    // LOCKERS
    if((dialogid == UNIFORM_LOCKER_DIALOG))
    {
        if(response)
        {
            if(listitem == 0) // Civilian Skins
            {
                ShowSkinModelMenu(playerid, 4);
                return 1;
            }
            else if (listitem == 1) // Advanced Uniform
            {
                ShowSkinModelMenu(playerid, 1);
                return 1;
            }
        }
        else if(!response)
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has closed the Uniform Locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            return 1;
        }
    }

    if(dialogid == WEAPONS_LOCKER_DIALOG)
    {
        if(response)
        {
            if(listitem == 0) // Weapons
            {
                ShowPlayerDialog(playerid, WEAPONS_WEAPONS_LOCKER_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Weapon Selections > Weapons", "Weapon Names\tRank\tClass\nNitestick\tPVT\t4\n9mm\tPVT\t4\nSilenced Pistol\tPVT\t4\nDesert Eagle\tPVT\t4\nShotgun\tPVT\t4\nUzi\tPVT\t4\nTec-9\tPVT\t4\nMP5\tPVT\t3\nCountry Rifle\tPVT\t3\nAK-47\tPVT\t2\nM4\tPVT\t2\nCombat Shotgun\tPVT\t1\nSniper\tPVT\t1", "Select", "Close");
                return 1;
            }
            else if (listitem == 1) // Vest and Medkit
            {

                new Float:health;
                new Float:armour;
                GetPlayerHealth(playerid, health);
                GetPlayerArmour(playerid, armour);

                if ((health == 100) && (armour == 100))
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have vest and full health.");
                    return 1;
                }    
                SetPlayerHealth(playerid, 100);
                SetPlayerArmour(playerid, 100);
                SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has withdrawn a Medkit and Kelvar Vest from the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                return 1;
            }
            else if(listitem == 2) // S.W.A.T. Gears
            {
                if ( GetPlayerClass(playerid) > 3 )
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You are not authorized to wear this gear.");
                    return 1;
                }

                ResetPlayerWeapons(playerid);
                SetWeaponOne(playerid, 0); // Primary Weapon - M4A4
                SetWeaponTwo(playerid, 0); // Secondary Weapon - MP5
                SetWeaponOneAmmo(playerid, 0);
                SetWeaponTwoAmmo(playerid, 0);

                SetPlayerSkin(playerid, 285);
                SetPlayerHealth(playerid, 100);
                SetPlayerArmour(playerid, 100);
                GivePlayerWeapon(playerid, 29, 250);
                GivePlayerWeapon(playerid, 31, 250);

                SetWeaponOne(playerid, 31); // Primary Weapon - M4A4
                SetWeaponTwo(playerid, 29); // Secondary Weapon - MP5
                SetWeaponOneAmmo(playerid, 250);
                SetWeaponTwoAmmo(playerid, 250);

                SetPlayerSkin(playerid, 285);
                SetPlayerHealth(playerid, 100);
                SetPlayerArmour(playerid, 100);
                SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has withdrawn the S.W.A.T. Gears from the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                return 1;
            }
        }
        else if(!response)
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has closed the Weapon Storages. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            return 1;
        }
    }

    // WEAPON AREA > WEAPON
    if(dialogid == WEAPONS_WEAPONS_LOCKER_DIALOG)
    {
        new wep_1 = GetWeaponOne(playerid);
        new wep_2 = GetWeaponTwo(playerid);

        if(response)
        {
            if(listitem == 0) // Nitestick 4
            {
                if(wep_2 == 0)
                {
                    GivePlayerWeapon(playerid, 3, 1);
                    SetWeaponTwo(playerid, 3);
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You withdrawn a Nitestick from the storage.");
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Secondary weapon.");
                    return 1;
                }
            }
            else if(listitem == 1) // 9mm 4
            {
                if(wep_2 == 0)
                {
                    GivePlayerWeapon(playerid, 22, 17);
                    SetWeaponTwo(playerid, 22);
                    SetWeaponTwoAmmo(playerid, 17);
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Secondary weapon.");
                    return 1;
                }
            }
            else if(listitem == 2) // sdpistol 4
            {
                if(wep_2 == 0)
                {
                    GivePlayerWeapon(playerid, 23, 17);
                    SetWeaponTwo(playerid, 23);
                    SetWeaponTwoAmmo(playerid, 17);
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Secondary weapon.");
                    return 1;
                }
            }
            else if(listitem == 3) // Deagle 4
            {
                if(wep_2 == 0)
                {
                    GivePlayerWeapon(playerid, 24, 7);
                    SetWeaponTwo(playerid, 24);
                    SetWeaponTwoAmmo(playerid, 7);
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Secondary weapon.");
                    return 1;
                }
            }
            else if(listitem == 4) // Shotgun 4
            {
                if(wep_1 == 0)
                {
                    GivePlayerWeapon(playerid, 25, 7);
                    SetWeaponOne(playerid, 25);
                    SetWeaponOneAmmo(playerid, 1);
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Primary weapon.");
                    return 1;
                }
            }
            else if(listitem == 5) // Uzi 4
            {
                if(wep_2 == 0)
                {
                    GivePlayerWeapon(playerid, 28, 30);
                    SetWeaponTwo(playerid, 28);
                    SetWeaponTwoAmmo(playerid, 30);
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Secondary weapon.");
                    return 1;
                }
            }
            else if(listitem == 6) // Tec-9 4
            {
                if(wep_2 == 0)
                {
                    GivePlayerWeapon(playerid, 32, 30);
                    SetWeaponTwo(playerid, 32);
                    SetWeaponTwoAmmo(playerid, 30);
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Secondary weapon.");
                    return 1;
                }
            }
            else if(listitem == 7) // MP5 3
            {
                if ( GetPlayerClass(playerid) > 3 )
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You are not authorized to use this weapon.");
                    return 1;
                }
                if(wep_2 == 0)
                {
                    GivePlayerWeapon(playerid, 29, 30);
                    SetWeaponTwo(playerid, 29);
                    SetWeaponTwoAmmo(playerid, 30);
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Secondary weapon.");
                    return 1;
                }
            }
            else if(listitem == 8) // Country Rifle 3
            {
                if ( GetPlayerClass(playerid) > 3 )
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You are not authorized to use this weapon.");
                    return 1;
                }
                if(wep_1 == 0)
                {
                    GivePlayerWeapon(playerid, 33, 1);
                    SetWeaponOne(playerid, 33);
                    SetWeaponOneAmmo(playerid, 1);
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Primary weapon.");
                    return 1;
                }
            }
            else if(listitem == 9) // AK-47 2
            {
                if ( GetPlayerClass(playerid) > 2 )
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You are not authorized to use this weapon.");
                    return 1;
                }
                if(wep_1 == 0)
                {
                    GivePlayerWeapon(playerid, 30, 30);
                    SetWeaponOne(playerid, 30);
                    SetWeaponOneAmmo(playerid, 30);
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Primary weapon.");
                    return 1;
                }
            }
            else if(listitem == 10) // M4A1 2
            {
                if ( GetPlayerClass(playerid) > 2 )
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You are not authorized to use this weapon.");
                    return 1;
                }
                if(wep_1 == 0)
                {
                    GivePlayerWeapon(playerid, 31, 50);
                    SetWeaponOne(playerid, 31);
                    SetWeaponOneAmmo(playerid, 50);
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Primary weapon.");
                    return 1;
                }
            }
            else if(listitem == 11) // Combat Shotgun 1
            {
                if ( GetPlayerClass(playerid) > 1 )
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You are not authorized to use this weapon.");
                    return 1;
                }
                if(wep_1 == 0)
                {
                    GivePlayerWeapon(playerid, 27, 7);
                    SetWeaponOne(playerid, 27);
                    SetWeaponOneAmmo(playerid, 7);
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Primary weapon.");
                    return 1;
                }
            }
            else if(listitem == 12) // Sniper 1
            {
                if ( GetPlayerClass(playerid) > 1 )
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You are not authorized to use this weapon.");
                    return 1;
                }
                if(wep_1 == 0)
                {
                    GivePlayerWeapon(playerid, 34, 1);
                    SetWeaponOne(playerid, 34);
                    SetWeaponOneAmmo(playerid, 1);
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Primary weapon.");
                    return 1;
                }
            } 
        }
        else
        {
            ShowPlayerDialog(playerid, WEAPONS_LOCKER_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Weapon Selections", "Selection\tRank\tClass\nWeapons\tPVT\t4\nVest and Medkit\tPVT\t4\nS.W.A.T. Gears\tPVT\t3", "Select", "Close");
            return 1;
        }
    }
    return 1;
}
/*
Uniforms(playerid)
{
    if( (IsPlayerInRangeOfPoint(playerid, 3.0, 262.2280, 1857.1425, 8.7578)) && (GetPlayerClass(playerid) != 0) && (GetPlayerClass(playerid) <= 4) )
    {
        SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has opened the Uniform Locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
        ShowPlayerDialog(playerid, UNIFORM_LOCKER_DIALOG, DIALOG_STYLE_LIST, "Uniform Selections", "Civilian Clothes\nAdvanced Uniform", "Select", "Close");
        return 1;
    }
    else if(!IsPlayerInRangeOfPoint(playerid, 3.0, 262.2280, 1857.1425, 8.7578))
    {
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}You are not in the Uniform Area.");
        return 1;
    }
    else
    {
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}You do not have the authority to access this locker.");
        SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has attempted to access the Uniform Locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
        return 1;
    }
}
Weapons(playerid)
{
    if((IsPlayerInRangeOfPoint(playerid, 3.0, 259.9224, 1852.4286, 8.7578)) && (GetPlayerClass(playerid) != 0) && (GetPlayerClass(playerid) <= 4))
    {
        SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has opened the Weapon Storages. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
        ShowPlayerDialog(playerid, WEAPONS_LOCKER_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Weapon Selections", "Selection\tRank\tClass\nWeapons\tPVT\t4\nVest and Medkit\tPVT\t4\nS.W.A.T. Gears\tPVT\t3", "Select", "Close");
        return 1;
    }
    else if(!IsPlayerInRangeOfPoint(playerid, 3.0, 259.9224, 1852.4286, 8.7578))
    {
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}You are not in the Weapon Area.");
        return 1;
    }
    else
    {
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}You do not have the authority to access this storage.");
        SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has attempted to access the Weapon Storages. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
        return 1;
    }
}
Ammos(playerid)
{
    if((IsPlayerInRangeOfPoint(playerid, 3.0, 258.8970, 1866.6219, 8.75781)) && (GetPlayerClass(playerid) != 0) && (GetPlayerClass(playerid) <= 4))
    {
        SetAmmo(playerid);
        return 1;
    }
    else if( !IsPlayerInRangeOfPoint(playerid, 3.0, 258.8970, 1866.6219, 8.75781) )
    {
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}You are not in the Ammunation Area.");
        return 1;
    }
    else
    {
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}You do not have the authority to access this storage.");
        SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has attempted to access the Ammunation. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
        return 1;
    }
}

Locker(playerid)
{
    if( (IsPlayerInRangeOfPoint(playerid, 3.0, 181.0148,-88.7169,979.7635)) && (GetPlayerClass(playerid) == 5) )
    {   
        SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has opened the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
        ShowPlayerDialog(playerid, MEDIC_LOCKER_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Locker Selection", "Selection\tRank\t Class\nWeapons\tPVT\tCombat Medic\nUniforms\tPVT\tCombat Medic\nVest and Medkit\tPVT\tCombat Medic\nFirefighter Gears\tPVT\tCombat Medic\nAmmunation\tPVT\tCombat Medic", "Select", "Close");
        return 1;
    }
    else if( (IsPlayerInRangeOfPoint(playerid, 3.0, 181.0148,-88.7169,979.7635)) && (GetPlayerClass(playerid) != 5) )
    {
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}You are not a Combat Medic.");
        return 1;
    }

    if( IsPlayerInRangeOfPoint(playerid, 2.0, 217.4364,-97.7477,1025.2578) )
    {
        SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has opened the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
        ShowPlayerDialog(playerid, CADET_LOCKER_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Locker Selection", "Selection\tRank\nUniforms\tPVT\n\nAmmunation\tPVT", "Select", "Close");
        return 1;
    }
    return 1;
}*/

// /locker
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new wep_1 = GetWeaponOne(playerid);
    
    new wep_2 = GetWeaponTwo(playerid);
    //new wep_1_ammo = GetWeaponOneAmmo(playerid);
    //new wep_2_ammo = GetWeaponTwoAmmo(playerid);

    if(dialogid == MEDIC_LOCKER_DIALOG)
    {  
        if(response)
        {
            if(listitem == 0) // Weapon
            {
                ShowPlayerDialog(playerid, MEDIC_WEAPON_LOCKER_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Locker Selection > Weapons", "Weapons\tRank\tWeapon Type\nBaseball Bat\tPVT\tSecondary\nSpray Can\tPVT\tSecondary\nFire Extinguisher\tPVT\tSecondary\n9mm\tPVT\tSecondary\nShotgun\tPVT\tPrimary\nChainsaw\tPVT\tPrimary", "Select", "Close");
                return 1;
            }
            else if(listitem == 1) // Uniform
            {
                ShowSkinModelMenu(playerid, 2);
                return 1;
            }
            else if(listitem == 2) // Vest and Medkit
            {
                SetPlayerHealth(playerid, 100);
                SetPlayerArmour(playerid, 50);
                SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has withdrawn Medkit and Vest from the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                return 1;
            }
            else if(listitem == 3) // Firefighter
            {
                new List:skins = list_new();

                AddModelMenuItem(skins, 277);
                AddModelMenuItem(skins, 278);
                AddModelMenuItem(skins, 279);

                ShowModelSelectionMenu(playerid, "Skins", MODEL_SELECTION_SKIN_MENU, skins);
                
                ResetPlayerWeapons(playerid);
                SetWeaponOne(playerid, 0);
                SetWeaponTwo(playerid, 0);
                SetWeaponOneAmmo(playerid, 0);
                SetWeaponTwoAmmo(playerid, 0);

                GivePlayerWeapon(playerid, 42, 1000);
                GivePlayerWeapon(playerid, 9, 250);
                SetWeaponOne(playerid, 9); // Chainsaw
                SetWeaponTwo(playerid, 42); // Fire Extinguisher
                SetWeaponOneAmmo(playerid, 250);
                SetWeaponTwoAmmo(playerid, 1000);

                SetPlayerHealth(playerid, 100);
                SetPlayerArmour(playerid, 50);

                SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has withdrawn the Firefighter Gears from the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                return 1;
            }
            else if(listitem == 4) // AMMO
            {
                SetAmmo(playerid);
                return 1;
            }
        }
        else
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has closed the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            return 1;
        }
    }
    // /locker > weapons
    if(dialogid == MEDIC_WEAPON_LOCKER_DIALOG)
    {  
        if(response)
        {
            if(listitem == 0) // Baseball Bat
            {
                if(wep_2 == 0)
                {
                    GivePlayerWeapon(playerid, 5, 1);
                    SetWeaponTwo(playerid, 5);
                    SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has withdrawn Baseball Bat from the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Secondary weapon.");
                    return 1;
                }
            }
            else if(listitem == 1) // Spray
            {
                if(wep_2 == 0)
                {
                    GivePlayerWeapon(playerid, 41, 1000);
                    SetWeaponTwo(playerid, 41);
                    SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has withdrawn Spraycan from the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Secondary weapon.");
                    return 1;
                }
            }
            else if(listitem == 2) // Fire Extinguisher
            {
                if(wep_2 == 0)
                {
                    GivePlayerWeapon(playerid, 42, 1000);
                    SetWeaponTwo(playerid, 42);
                    SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has withdrawn Fire Extinguisher from the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Secondary weapon.");
                    return 1;
                }
            }
            else if(listitem == 3) // 9mm
            {
                if(wep_2 == 0)
                {
                    GivePlayerWeapon(playerid, 22, 250);
                    SetWeaponTwo(playerid, 22);
                    SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has withdrawn 9mm from the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Secondary weapon.");
                    return 1;
                }
            }
            else if(listitem == 4) // Shotgun
            {
                if(wep_1 == 0)
                {
                    GivePlayerWeapon(playerid, 25, 250);
                    SetWeaponOne(playerid, 25);
                    SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has withdrawn Shotgun from the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Primary weapon.");
                    return 1;
                }
            }
            else if(listitem == 5) // Chainsaw
            {
                if(wep_1 == 0)
                {
                    GivePlayerWeapon(playerid, 9, 1);
                    SetWeaponOne(playerid, 9);
                    SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has withdrawn Chainsaw from the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                    return 1;
                }
                else
                {
                    SendClientMessageEx2(playerid, COLOR_ORANGE, "[SERVER]: {FFFFFF}You already have a Secondary weapon.");
                    return 1;
                }
            }
        }
        else
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has closed the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            return 1;
        }
    }
    if(dialogid == CADET_LOCKER_DIALOG)
    {
        if(response)
        {
            if(listitem == 0) // Uniform
            {
                ShowSkinModelMenu(playerid, 3);
                return 1;
            }
            else if(listitem == 1) // Ammunation
            {
                if( (GetWeaponOne(playerid) == 0) && (GetWeaponTwo(playerid) == 0) )
                {
                    SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}You do not have any weapons in your possession.");
                    return 1;
                }
                SetAmmo(playerid);
                SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has withdrawn ammunations from locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                return 1;
            }
        }
        else
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has closed the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
        }
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_YES)
    {
        if( IsPlayerInRangeOfPoint(playerid, 2.0, 181.0148,-88.7169,979.7635) ) // LOCKER MEDIC
        {   
            if( GetPlayerClass(playerid) == 5 )
            {
                SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has opened the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                ShowPlayerDialog(playerid, MEDIC_LOCKER_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Locker Selection", "Selection\tRank\t Class\nWeapons\tPVT\tCombat Medic\nUniforms\tPVT\tCombat Medic\nVest and Medkit\tPVT\tCombat Medic\nFirefighter Gears\tPVT\tCombat Medic\nAmmunation\tPVT\tCombat Medic", "Select", "Close");
                return 1;
            }
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has attempted to access the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not a Combat Medic.");
            return 1;
        }

        if( IsPlayerInRangeOfPoint(playerid, 2.0, 217.4364,-97.7477,1025.2578) ) // LOCKER CADET
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has opened the locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            ShowPlayerDialog(playerid, CADET_LOCKER_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Locker Selection", "Selection\tRank\nUniforms\tPVT\n\nAmmunation\tPVT", "Select", "Close");
            return 1;
        }

        if( IsPlayerInRangeOfPoint(playerid, 2.0, 258.8970, 1866.6219, 8.75781) ) // AMMOS
        {
            if( GetWeaponOne(playerid) == 0 && GetWeaponTwo(playerid) == 0 )
            {
                SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You do not have any weapons in your possession.");
                return 1;
            }
            if( (GetPlayerClass(playerid) != 0) && (GetPlayerClass(playerid) != 5) )
            {
                SetAmmo(playerid);
                SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has withdrawn bullets from the Ammunation. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                return 1;
            }
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has attempted to access the Ammunation. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not an Advanced Officer.");
            return 1;
        }
        if( IsPlayerInRangeOfPoint(playerid, 2.0, 259.9224, 1852.4286, 8.7578) ) // WEAPONS
        {
            if( (GetPlayerClass(playerid) != 0) && (GetPlayerClass(playerid) != 5) )
            {
                SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has opened the Weapon Storages. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                ShowPlayerDialog(playerid, WEAPONS_LOCKER_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Weapon Selections", "Selection\tRank\tClass\nWeapons\tPVT\t4\nVest and Medkit\tPVT\t4\nS.W.A.T. Gears\tPVT\t3", "Select", "Close");
                return 1;
            }
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has attempted to access the Weapon Storage. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not an Advanced Officer.");
            return 1;
        }
        if( IsPlayerInRangeOfPoint(playerid, 2.0, 262.2280, 1857.1425, 8.7578) ) // UNIFORMS
        {
            if( (GetPlayerClass(playerid) != 0) && (GetPlayerClass(playerid) != 5) )
            {
                SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has opened the Uniform Locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                ShowPlayerDialog(playerid, UNIFORM_LOCKER_DIALOG, DIALOG_STYLE_LIST, "Uniform Selections", "Civilian Clothes\nAdvanced Uniform", "Select", "Close");
                return 1;
            }
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has attempted to access the Uniform Storage. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not an Advanced Officer.");
            return 1;
        }
    }
    return 1;
}