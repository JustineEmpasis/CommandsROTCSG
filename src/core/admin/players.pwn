DropWeapon(playerid)
{
    new weaponid = GetPlayerWeapon(playerid);
    new weaponName[32];
    GetWeaponName(weaponid, weaponName, sizeof(weaponName));

    if(weaponid == 0)
    {
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}You do not have any weapons on your hand.");
        return 1;
    }

    new saveweapon[13], saveammo[13];
    for(new slot = 0; slot < 13; slot++)
        GetPlayerWeaponData(playerid, slot, saveweapon[slot], saveammo[slot]);

    ResetPlayerWeapons(playerid);
    for(new slot; slot < 13; slot++)
    {
        if(saveweapon[slot] == weaponid || saveammo[slot] == 0)
            continue;
        GivePlayerWeapon(playerid, saveweapon[slot], saveammo[slot]);
    }
 
    GivePlayerWeapon(playerid, 0, 1);

    // DATABASE ALGO
    if(weaponid == GetWeaponOne(playerid))
    {
        SetWeaponOne(playerid, 0);
        SetWeaponOneAmmo(playerid, 0);
    }
    else
    {
        SetWeaponTwo(playerid, 0);
        SetWeaponTwoAmmo(playerid, 0);
    }
    return 1;
}

new availWeapon[2][] = { {25, 27, 30, 31, 33, 34, 9}, {3, 41, 42, 22, 23, 24, 28, 32, 29} };

CheckWeapon(playerid, weapontype)
{
    new weapons[13][2];
    
    for (new i = 0; i <= 12; i++)
    {
        GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
    }

    new plen = 7;
    new slen = 9;

    if(weapontype == 0) // Primary
    {
        for ( new i = 0 ; i < 13; i++)
        {
            for ( new o = 0 ; o < plen ; o++)
            {
                if(weapons[i][0] == availWeapon[weapontype][o]) // M4 31 == 
                {
                    return 1;
                }
            }
        }

    }
    if (weapontype == 1) // Secondary
    {
        for ( new i = 0 ; i < 13 ; i++)
        {
            for ( new o = 0 ; o < slen ; o++)
            {
                if(weapons[i][0] == availWeapon[weapontype][o])
                {
                    return 1;
                }
            }
        }
    }
    return 0;
}

CheckWeaponTest(weapontype, weaponID)
{
    if(weapontype == 0) // Primary
    {
        for (new o = 0; o < 7; o++)
        {
            if ( weaponID == availWeapon[0][o] )
            {
                return 1;
            }
        }
    }
    if(weapontype == 1) // Secondary
    {
        for (new o = 0; o < 9; o++)
        {
            if ( weaponID == availWeapon[1][o] )
            {
                return 1;
            }
        }
    }
    return 0;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new wep_1 = GetWeaponOne(playerid);
    new wep_2 = GetWeaponTwo(playerid);
    new wep_1_ammo = GetWeaponOneAmmo(playerid);
    new wep_2_ammo = GetWeaponTwoAmmo(playerid);

    new allweapon[100];
    new wep1Name[32], wep2Name[32];

    GetWeaponName(wep_1, wep1Name, sizeof(wep1Name));
    GetWeaponName(wep_2, wep2Name, sizeof(wep2Name));

    if(dialogid == INV_DIALOG)
    {
        if(response)
        {
            if(listitem == 0)
            {
                format(allweapon, sizeof(allweapon), "Weapon Name: %s\nAmmo: %d", wep1Name, wep_1_ammo);
                ShowPlayerDialog(playerid, INV_PRIMARY_WEAPONS_DIALOG, DIALOG_STYLE_MSGBOX, "Primary Weapon", allweapon, "Drop", "Close");
            }
            else if(listitem == 1)
            {
                format(allweapon, sizeof(allweapon), "Weapon Name: %s\nAmmo: %d", wep2Name, wep_2_ammo);
                ShowPlayerDialog(playerid, INV_SECONDARY_WEAPONS_DIALOG, DIALOG_STYLE_MSGBOX, "Secondary Weapon", allweapon, "Drop", "Close");
            }
        }
    }

    if(dialogid == INV_PRIMARY_WEAPONS_DIALOG)
    {
        if(response)
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has dropped the %s. "COL_ORANGE"**", GetPlayerNameEx2(playerid), wep1Name);
            SetWeaponOne(playerid, 0);
            SetWeaponOneAmmo(playerid, 0);
            if(wep_2 == 0)
            {
                ResetPlayerWeapons(playerid);
                return 1;
            }
            else
            {
                ResetPlayerWeapons(playerid);
                GivePlayerWeapon(playerid, wep_2, wep_2_ammo);
                SetWeaponTwo(playerid, wep_2);
                SetWeaponTwoAmmo(playerid, wep_2_ammo);
                return 1;
            }
        }
        else
        {
            ShowPlayerDialog(playerid, INV_DIALOG, DIALOG_STYLE_LIST, "Inventory", allweapon, "Select", "Close");
        }
    }

    if(dialogid == INV_SECONDARY_WEAPONS_DIALOG)
    {
        if(response)
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has dropped the %s. "COL_ORANGE"**", GetPlayerNameEx2(playerid), wep2Name);
            SetWeaponTwo(playerid, 0);
            SetWeaponTwoAmmo(playerid, 0);
            if(wep_1 == 0)
            {
                ResetPlayerWeapons(playerid);
                return 1;
            }
            else
            {
                ResetPlayerWeapons(playerid);
                GivePlayerWeapon(playerid, wep_1, wep_1_ammo);
                SetWeaponOne(playerid, wep_1);
                SetWeaponOneAmmo(playerid, wep_1_ammo);
                return 1;
            }
        }
        else
        {
            ShowPlayerDialog(playerid, INV_DIALOG, DIALOG_STYLE_LIST, "Inventory", allweapon, "Select", "Close");
        }
    }
    return 1;
}

YCMD:giveweapon(playerid, params[], help)
{
    new targetid;

    if( (GetPlayerClass(playerid) == 0) )
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"You are not authorized to use this command.");
        return 1;
    }

    if(sscanf(params, "u", targetid))
	{
	    SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: {FFFFFF}/giveweapon [Player ID]");
		return 1;
	}

    if(!IsPlayerConnected(targetid)) 
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"The target player is not connected.");
        return 1;
    }
    if(!IsPlayerLoggedIn(targetid)) 
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"The target player has not yet logged in.");
        return 1;
    }
    if(playerid == targetid) {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"You can not give it to yourself!");
        return 1;
    }

    new Float:a;
    new Float:b;
    new Float:c;
    GetPlayerPos(targetid, a, b, c);
    if(!IsPlayerInRangeOfPoint(playerid, 5, a, b, c))
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"The player is not nearby.");
        return 1;
    }

    // Sender
    new s_wep_1 = GetWeaponOne(playerid);
    new s_wep_2 = GetWeaponTwo(playerid);

    // Receiver
    new r_wep_1 = GetWeaponOne(targetid);
    new r_wep_2 = GetWeaponTwo(targetid);

    new s_wep1Name[32], s_wep2Name[32];
    new r_wep1Name[32], r_wep2Name[32];

    GetWeaponName(s_wep_1, s_wep1Name, sizeof(s_wep1Name));
    GetWeaponName(s_wep_2, s_wep2Name, sizeof(s_wep2Name));
    GetWeaponName(r_wep_1, r_wep1Name, sizeof(r_wep1Name));
    GetWeaponName(r_wep_2, r_wep2Name, sizeof(r_wep2Name));

    new current_wep = GetPlayerWeapon(playerid);
    new current_ammo = GetPlayerAmmo(playerid);

    if( current_wep == 0 )
    {
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}You do not have any weapons on your hands.");
        return 1;
    }
    if ( (CheckWeapon(targetid, 0) == 1) && (CheckWeaponTest( 0, current_wep ) == 1) ) // P | S
    {
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}The receiver already have a Primary weapon.");
        return 1;
    }
    if ( (CheckWeapon(targetid, 1) == 1) && (CheckWeaponTest( 1, current_wep ) == 1) ) // P | S
    {
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}The receiver already have a Secondary weapon.");
        return 1;
    }
    if ( CheckWeaponTest( 0, current_wep ) == 1 )
    {
        GiveWepOne(playerid, targetid, current_wep, current_ammo);
        return 1;
    }
    if ( CheckWeaponTest( 1, current_wep ) == 1 )
    {
        GiveWepTwo(playerid, targetid, current_wep, current_ammo);
        return 1;
    }

    return 1;
}

GiveWepOne(playerid, targetid, current_wep, current_ammo)
{
    new s_wep1Name[32];
    GetWeaponName(current_wep, s_wep1Name, sizeof(s_wep1Name));

    GivePlayerWeapon(targetid, current_wep, current_ammo);
    SetWeaponOne(targetid, current_wep);
    SetWeaponOneAmmo(targetid, current_ammo);

    // Sender
    SetWeaponOne(playerid, 0);
    SetWeaponOneAmmo(playerid, 0);
    DropWeapon(playerid);

    SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s gave the %s to %s. "COL_ORANGE"**", GetPlayerNameEx2(playerid), s_wep1Name, GetPlayerNameEx2(targetid));
    return 1;
}

GiveWepTwo(playerid, targetid, current_wep, current_ammo)
{
    new s_wep2Name[32];
    GetWeaponName(current_wep, s_wep2Name, sizeof(s_wep2Name));

    GivePlayerWeapon(targetid, current_wep, current_ammo);
    SetWeaponTwo(targetid, current_wep);
    SetWeaponTwoAmmo(targetid, current_ammo);

    // Sender
    SetWeaponTwo(playerid, 0);
    SetWeaponTwoAmmo(playerid, 0);
    DropWeapon(playerid);

    SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s gave the %s to %s. "COL_ORANGE"**", GetPlayerNameEx2(playerid), s_wep2Name, GetPlayerNameEx2(targetid));
    return 1;
}

YCMD:dropweapon(playerid, paramns[], help)
{
    new curwep = GetPlayerWeapon(playerid);
    new wepname[32];
    GetWeaponName(curwep, wepname, sizeof(wepname));

    if(curwep != 0)
    {
        DropWeapon(playerid);
        SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has dropped the %s. "COL_ORANGE"**", GetPlayerNameEx2(playerid), wepname);
    }
    return 1;
}

YCMD:inventory(playerid, params[], help)
{
    new wep_1 = GetWeaponOne(playerid);
    new wep_2 = GetWeaponTwo(playerid);
    new wep_1_ammo = GetWeaponOneAmmo(playerid);
    new wep_2_ammo = GetWeaponTwoAmmo(playerid);

    new weapons[13][2];

    for (new i = 0; i <= 12; i++)
    {
        GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
        if ( weapons[i][0] == wep_1 )
        {
            SetWeaponOneAmmo(playerid, weapons[i][1]);
        }
        if ( weapons[i][0] == wep_2 )
        {
            SetWeaponTwoAmmo(playerid, weapons[i][1]);
        }
    }

    new allweapon[100];
    new wep1Name[32], wep2Name[32];

    GetWeaponName(wep_1, wep1Name, sizeof(wep1Name));
    GetWeaponName(wep_2, wep2Name, sizeof(wep2Name));

    if( (wep_1_ammo == 0) && (wep_2_ammo == 0) )
    {
        ShowPlayerDialog(playerid, INV_DIALOG, DIALOG_STYLE_MSGBOX, "Inventory", "You do not have any weapons inside your inventory", "Close", "");
        return 1;
    }

    if((wep_1 == 0) && (wep_2 == 0))
    {
        format(allweapon, sizeof(allweapon), "Weapon Name\tWeapon Type\n[1] None\t\tPrimary Weapon\n[2] None\t\tSecondary Weapon");
    }
    else if((wep_1 == 0) && (wep_2 > 0))
    {
        format(allweapon, sizeof(allweapon), "Weapon Name\tWeapon Type\n[1] None\t\tPrimary Weapon\n[2] %s\t\tSecondary Weapon", wep2Name);
    }
    else if((wep_2 > 0) && (wep_2 == 0))
    {
        format(allweapon, sizeof(allweapon), "Weapon Name\tWeapon Type\n[1] %s\t\tPrimary Weapon\n[2] None\t\tSecondary Weapon", wep1Name);
    }
    else
    {
        format(allweapon, sizeof(allweapon), "Weapon Name\tWeapon Type\n[1] %s\t\tPrimary Weapon\n[2] %s\t\tSecondary Weapon", wep1Name, wep2Name);
    }

    ShowPlayerDialog(playerid, INV_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Inventory", allweapon, "Select", "Close");
    return 1;
}

YCMD:requesthelp(playerid, params[], help) {
    new
        bool:admins;

    foreach(new i : Player) {
        if(IsPlayerMod(i)) {
            admins = true;
        }
    }

    if(!admins) {
        SendClientMessage(playerid, COLOR_ORANGE, "[WARNING]: "COL_WHITE"There are no admins online to accept your help request.");
        return 1;
    }

    new
        message[256];
    
    if(sscanf(params, "s[256]", message)) {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/requesthelp [message]");
        return 1;
    }

    foreach(new i : Player) {
        if(IsPlayerMod(i)) {
            SendClientMessageEx2(i, COLOR_WHITE, ""COL_PEACHPUFF"[Assistance Request From: %s]: "COL_WHITE"%s", GetPlayerNameEx2(playerid), message);
        }
    }

    SendClientMessage(playerid, COLOR_LIMEGREEN, "[SUCCESS]: "COL_WHITE"You have sent your help request to the online admins.");
    return 1;
}

YCMD:fixvw(playerid, params[], help)
{
    if(GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
    {
        SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are already in the right virtual world.");
        return 1;
    }

    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
    SendClientMessageEx2(playerid, COLOR_AQUA, "[GAME]: "COL_WHITE"Welcome back! You are now in a right virtual world.");
    return 1;
}