#include <YSI_Coding\y_hooks>

#define TIME 250 //Timer for check if player is cycling through weapons or received another weapon (in ms)
#define playercommand //comment this line to disable the /holdingweapon command for players

forward Enable(playerid);
forward Disable(playerid);
forward AttachWeapon(playerid);
forward HoldingWeaponsForAll(boolean);

enum attached_object_data
{
    ao_modelid,
    ao_bone,
    Float:ao_x,
    Float:ao_y,
    Float:ao_z,
    Float:ao_rx,
    Float:ao_ry,
    Float:ao_rz,
    Float:ao_sx,
    Float:ao_sy,
    Float:ao_sz
}
new ao[MAX_PLAYERS][MAX_PLAYER_ATTACHED_OBJECTS][attached_object_data];

new wep[MAX_PLAYERS] = -1, /*counttimer,*/ weps[12], de[MAX_PLAYERS] = 1, d1 = 1, camera[MAX_PLAYERS];
 
hook OnPlayerDisconnect(playerid, reason)
{
    if(IsPlayerConnected(playerid)) if(!IsPlayerNPC(playerid)) for(new a = 0; a < 10; a++) if(IsPlayerAttachedObjectSlotUsed(playerid, a)) RemovePlayerAttachedObject(playerid, a);
    return print("[FS]HoldingWeapons Unloaded!");
}

hook OnPlayerUpdate(playerid)
{
    AttachWeapon(playerid);
    return 1;
}

public AttachWeapon(playerid)
{
    if(IsPlayerNPC(playerid)) return 1;
    
    if(IsPlayerInAnyVehicle(playerid))
    {
        for(new a = 0; a < 9; a++) if(IsPlayerAttachedObjectSlotUsed(playerid, a)) RemovePlayerAttachedObject(playerid, a);
        wep[playerid] = -1;
        return 1;
    }
    //if(!de[playerid]) return 1;
    if(camera[playerid]) return 1;
    if(wep[playerid] != GetPlayerWeapon(playerid)) for(new a = 0; a < 12; a++)
    {
        
        GetPlayerWeaponData(playerid, a, weps[a], weps[10]);
        switch(a)
        {
            case 0: // KNUCKLES
            {
                if(IsPlayerAttachedObjectSlotUsed(playerid, 0)) RemovePlayerAttachedObject( playerid, 0);
                //new m = 331;
                if(weps[a] == 1 && GetPlayerWeapon(playerid) != 1) SetPlayerAttachedObject( playerid, 0, 331, Get_bone(331), Get_fOffsetX(331), Get_fOffsetY(331), Get_fOffsetZ(331), Get_fRotX(331), Get_fRotY(331), Get_fRotZ(331), Get_fScaleX(331), Get_fScaleY(331), Get_fScaleZ(331) ); // Knuckles
            }
            case 1: // MELEE
            {
                if(IsPlayerAttachedObjectSlotUsed(playerid, 1)) RemovePlayerAttachedObject(playerid, 1);
                switch(weps[a])
                {
                    case 4: if(GetPlayerWeapon(playerid) != 4) SetPlayerAttachedObject( playerid, 1, 335, Get_bone(335), Get_fOffsetX(335), Get_fOffsetY(335), Get_fOffsetZ(335), Get_fRotX(335), Get_fRotY(335), Get_fRotZ(335), Get_fScaleX(335), Get_fScaleY(335), Get_fScaleZ(335) ); // Knife
                    case 3: if(GetPlayerWeapon(playerid) != 3) SetPlayerAttachedObject( playerid, 1, 334, Get_bone(334), Get_fOffsetX(334), Get_fOffsetY(334), Get_fOffsetZ(334), Get_fRotX(334), Get_fRotY(334), Get_fRotZ(334), Get_fScaleX(334), Get_fScaleY(334), Get_fScaleZ(334) ); // Baton
                    case 9: if(GetPlayerWeapon(playerid) != 9) SetPlayerAttachedObject( playerid, 1, 341, Get_bone(341), Get_fOffsetX(341), Get_fOffsetY(341), Get_fOffsetZ(341), Get_fRotX(341), Get_fRotY(341), Get_fRotZ(341), Get_fScaleX(341), Get_fScaleY(341), Get_fScaleZ(341) ); // CHAINSAW
                }
            }
            case 2: // SECONDARY WEAPON HANDGUN
            {
                if(IsPlayerAttachedObjectSlotUsed(playerid, 2)) RemovePlayerAttachedObject(playerid, 2);
                switch(weps[a])
                {
                    case 22: if(GetPlayerWeapon(playerid) != 22) SetPlayerAttachedObject( playerid, 2, 346, Get_bone(346), Get_fOffsetX(346), Get_fOffsetY(346), Get_fOffsetZ(346), Get_fRotX(346), Get_fRotY(346), Get_fRotZ(346), Get_fScaleX(346), Get_fScaleY(346), Get_fScaleZ(346) ); // 9mm
                    case 23: if(GetPlayerWeapon(playerid) != 23) SetPlayerAttachedObject( playerid, 2, 347, Get_bone(347), Get_fOffsetX(347), Get_fOffsetY(347), Get_fOffsetZ(347), Get_fRotX(347), Get_fRotY(347), Get_fRotZ(347), Get_fScaleX(347), Get_fScaleY(347), Get_fScaleZ(347) ); // sdpistol
                    case 24: if(GetPlayerWeapon(playerid) != 24) SetPlayerAttachedObject( playerid, 2, 348, Get_bone(348), Get_fOffsetX(348), Get_fOffsetY(348), Get_fOffsetZ(348), Get_fRotX(348), Get_fRotY(348), Get_fRotZ(348), Get_fScaleX(348), Get_fScaleY(348), Get_fScaleZ(348) ); // Deagle
                }
            }
            case 3: // PRIMARY WEAPON CLOSE RANGE
            {
                if(IsPlayerAttachedObjectSlotUsed(playerid, 3)) RemovePlayerAttachedObject(playerid, 3);
                switch(weps[a])
                {
                    case 25: if(GetPlayerWeapon(playerid) != 25) SetPlayerAttachedObject( playerid, 3, 349, Get_bone(349), Get_fOffsetX(349), Get_fOffsetY(349), Get_fOffsetZ(349), Get_fRotX(349), Get_fRotY(349), Get_fRotZ(349), Get_fScaleX(349), Get_fScaleY(349), Get_fScaleZ(349) ); // Shotgun
                    case 26: if(GetPlayerWeapon(playerid) != 26) SetPlayerAttachedObject( playerid, 3, 350, Get_bone(350), Get_fOffsetX(350), Get_fOffsetY(350), Get_fOffsetZ(350), Get_fRotX(350), Get_fRotY(350), Get_fRotZ(350), Get_fScaleX(350), Get_fScaleY(350), Get_fScaleZ(350) ); // Sawn off
                    case 27: if(GetPlayerWeapon(playerid) != 27) SetPlayerAttachedObject( playerid, 3, 351, Get_bone(351), Get_fOffsetX(351), Get_fOffsetY(351), Get_fOffsetZ(351), Get_fRotX(351), Get_fRotY(351), Get_fRotZ(351), Get_fScaleX(351), Get_fScaleY(351), Get_fScaleZ(351) ); // Spas
                }
            }
            case 4: // SECONDARY WEAPON SHORT RANGE
            {
                if(IsPlayerAttachedObjectSlotUsed(playerid, 4)) RemovePlayerAttachedObject(playerid, 4);
                switch(weps[a])
                {
                    case 28: if(GetPlayerWeapon(playerid) != 28) SetPlayerAttachedObject( playerid, 4, 352, Get_bone(352), Get_fOffsetX(352), Get_fOffsetY(352), Get_fOffsetZ(352), Get_fRotX(352), Get_fRotY(352), Get_fRotZ(352), Get_fScaleX(352), Get_fScaleY(352), Get_fScaleZ(352) ); // UZI
                    case 29: if(GetPlayerWeapon(playerid) != 29) SetPlayerAttachedObject( playerid, 4, 353, Get_bone(353), Get_fOffsetX(353), Get_fOffsetY(353), Get_fOffsetZ(353), Get_fRotX(353), Get_fRotY(353), Get_fRotZ(353), Get_fScaleX(353), Get_fScaleY(353), Get_fScaleZ(353) ); // MP5
                    case 32: if(GetPlayerWeapon(playerid) != 32) SetPlayerAttachedObject( playerid, 4, 372, Get_bone(372), Get_fOffsetX(372), Get_fOffsetY(372), Get_fOffsetZ(372), Get_fRotX(372), Get_fRotY(372), Get_fRotZ(372), Get_fScaleX(372), Get_fScaleY(372), Get_fScaleZ(372) ); // TEC-9
                }
            }
            case 5: // PRIMARY WEAPON MID RANGE
            {
                if(IsPlayerAttachedObjectSlotUsed(playerid, 5)) RemovePlayerAttachedObject(playerid, 5);
                switch(weps[a])
                {
                    case 30: if(GetPlayerWeapon(playerid) != 30) SetPlayerAttachedObject( playerid, 5, 355, Get_bone(355), Get_fOffsetX(355), Get_fOffsetY(355), Get_fOffsetZ(355), Get_fRotX(355), Get_fRotY(355), Get_fRotZ(355), Get_fScaleX(355), Get_fScaleY(355), Get_fScaleZ(355) ); // AK
                    case 31: if(GetPlayerWeapon(playerid) != 31) SetPlayerAttachedObject( playerid, 5, 356, Get_bone(356), Get_fOffsetX(356), Get_fOffsetY(356), Get_fOffsetZ(356), Get_fRotX(356), Get_fRotY(356), Get_fRotZ(356), Get_fScaleX(356), Get_fScaleY(356), Get_fScaleZ(356) ); // M4
                }
            }
            case 6: // PRIMARY WEAPON LONG RANGE
            {
                if(IsPlayerAttachedObjectSlotUsed(playerid, 6)) RemovePlayerAttachedObject(playerid, 6);
                switch(weps[a])
                {
                    case 34: if(GetPlayerWeapon(playerid) != 34) SetPlayerAttachedObject( playerid, 6, 358, Get_bone(358), Get_fOffsetX(358), Get_fOffsetY(358), Get_fOffsetZ(358), Get_fRotX(358), Get_fRotY(358), Get_fRotZ(358), Get_fScaleX(358), Get_fScaleY(358), Get_fScaleZ(358) ); // SNIPER
                    case 33: if(GetPlayerWeapon(playerid) != 33) SetPlayerAttachedObject( playerid, 6, 357, Get_bone(357), Get_fOffsetX(357), Get_fOffsetY(357), Get_fOffsetZ(357), Get_fRotX(357), Get_fRotY(357), Get_fRotZ(357), Get_fScaleX(357), Get_fScaleY(357), Get_fScaleZ(357) ); // RIFLE
                }
            }
            case 8: // THROWABLE
            {
                if(IsPlayerAttachedObjectSlotUsed(playerid, 8)) RemovePlayerAttachedObject(playerid, 8);
                switch(weps[a])
                {
                    case 16: if(GetPlayerWeapon(playerid) != 16) SetPlayerAttachedObject( playerid, 8, 342, Get_bone(342), Get_fOffsetX(342), Get_fOffsetY(342), Get_fOffsetZ(342), Get_fRotX(342), Get_fRotY(342), Get_fRotZ(342), Get_fScaleX(342), Get_fScaleY(342), Get_fScaleZ(342) ); // Grenade
                    case 17: if(GetPlayerWeapon(playerid) != 17) SetPlayerAttachedObject( playerid, 8, 343, Get_bone(343), Get_fOffsetX(343), Get_fOffsetY(343), Get_fOffsetZ(343), Get_fRotX(343), Get_fRotY(343), Get_fRotZ(343), Get_fScaleX(343), Get_fScaleY(343), Get_fScaleZ(343) ); // Tear Gas
                    case 18: if(GetPlayerWeapon(playerid) != 18) SetPlayerAttachedObject( playerid, 8, 344, Get_bone(344), Get_fOffsetX(344), Get_fOffsetY(344), Get_fOffsetZ(344), Get_fRotX(344), Get_fRotY(344), Get_fRotZ(344), Get_fScaleX(344), Get_fScaleY(344), Get_fScaleZ(344) ); // Molotov
                }
            }
            case 9: // SPRAY
            {
                if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
                switch(weps[a])
                {
                    case 43: if(GetPlayerWeapon(playerid) != 43) SetPlayerAttachedObject( playerid, 9, 367, Get_bone(367), Get_fOffsetX(367), Get_fOffsetY(367), Get_fOffsetZ(367), Get_fRotX(367), Get_fRotY(367), Get_fRotZ(367), Get_fScaleX(367), Get_fScaleY(367), Get_fScaleZ(367) ); // Camera
                    case 41: if(GetPlayerWeapon(playerid) != 41) SetPlayerAttachedObject( playerid, 9, 365, Get_bone(365), Get_fOffsetX(365), Get_fOffsetY(365), Get_fOffsetZ(365), Get_fRotX(365), Get_fRotY(365), Get_fRotZ(365), Get_fScaleX(365), Get_fScaleY(365), Get_fScaleZ(365) ); // Spraycan
                    case 42: if(GetPlayerWeapon(playerid) != 42) SetPlayerAttachedObject( playerid, 9, 366, Get_bone(366), Get_fOffsetX(366), Get_fOffsetY(366), Get_fOffsetZ(366), Get_fRotX(366), Get_fRotY(366), Get_fRotZ(366), Get_fScaleX(366), Get_fScaleY(366), Get_fScaleZ(366) ); // Spraycan
                }
            }
        }
    }
    wep[playerid] = GetPlayerWeapon(playerid);
    return 1;
}
 
YCMD:displayweapons(playerid, params[], help)
{
    if(!strcmp(params, "/displayweapons", true))
    {
        #if defined playercommand
            if(d1)
            {
                if(de[playerid])
                {
                    SendClientMessage(playerid, COLOR_ORANGE, "[WEAPONS INFO] {FFFFFF}Disabled.");
                    Disable(playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_ORANGE, "[WEAPONS INFO] {FFFFFF}Enabled.");
                    Enable(playerid);
                }
            }
            else SendClientMessage(playerid, 0x0000FFAA, "[HWEAPONS] {FFFFFF}This function is disabled.");
            return 1;

        #else
            return SendClientMessage(playerid, 0x0000FFAA, "[HWEAPONS] {FFFFFF}This function is disabled.");
        #endif
    }
    return 0;
}

enum bone_replacement
{
    mod_id,
    bone_id
}

new
    TempRecord[MAX_PLAYERS][bone_replacement];

YCMD:editweapon(playerid, params[], help)
{
    if(!IsPlayerMod(playerid))
    {
        SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    new selection[16];
    new selection_params[256];
    new m_id;
    new bone;
    if( sscanf(params, "s[16]S()[255]", selection, selection_params ) )
    {
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/edit [ placement / bone ]");
        return 1;
    }

    if( !strcmp(selection, "placement", true) )
    {
        if(sscanf(selection_params, "i", m_id))
        {
            SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/edit placement [ID]");
            SendClientMessageEx2(playerid, COLOR_YELLOW, "[GUIDE]: "COL_WHITE"[0] Knuckles, [1] Melee, [2] Handgun, [3] Shotguns, [4] SubmachineGuns, [5] Rifle, [6] Snipers, [8] Throwable, [9] Spray");
            return 1;
        }

        EditAttachedObject(playerid, m_id);
        SendClientMessageEx2(playerid, 0xFFFFFFFF, "SERVER: You now edit your attached object on index slot %d!", m_id);
        return 1;
    }
    if( !strcmp(selection, "bone", true) )
    {
        new m[512];
        format(m, sizeof(m), "MODEL ID\tWEAPON NAME\n[331]\tKnuckles\n[334]\tNitestick\n[335]\tKnife\n[341]\tChainsaw\n[342]\tGrenade\n[343]\tTeargas\n[344]\tMolotov\n[346]\t9mm\n[347]\tSilenced Pistol\n[348]\tDeagle\n[349]\tShotgun\n[350]\tSawn\n[351]\tSpaz\n[352]\tUzi\n[372]\tTec-9\n[353]\tMP5\n[355]\tAK47\n[356]\tM4\n[357]\tRifle\n[358]\tSniper\n[365]\tSpraycan\n[366]\tExtinguisher");


        ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", m, "Select", "Close");

        Set_bone(m_id, bone);
        return 1;
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == WEAPONHOLSTER_BONE_DIALOG)
    {
        new s[512];
        format(s, sizeof(s), "BONE ID\tBONE NAME\n[1]\tSpine\n[2]\tHead\n[3]\tLeft Upper Arm\n[4]\tRight Upper Arm\n[5]\tLeft Hand\n[6]\tRight Hand\n[7]\tLeft Thigh\n[8]\tRight Thigh\n[9]\tLeft Foot\n[10]\tRight Foot\n[11]\tRight Calf\n[12]\tLeft Calf\n[13]\tLeft Forearm\n[14]\tRight Forearm\n[15]\tLeft Clavicle\n[16]\tRight Clavicle");
        if(response)
        {
            if(listitem == 0) // [331] Knuckles
            {
                TempRecord[playerid][mod_id] = 331;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 1) // [334] Nitestick
            {
                TempRecord[playerid][mod_id] = 334;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 2) // [335] Knife
            {
                TempRecord[playerid][mod_id] = 335;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 3) // [341] Chainsaw
            {
                TempRecord[playerid][mod_id] = 341;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 4) // [342] Grenade
            {
                TempRecord[playerid][mod_id] = 342;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 5) // [343] Teargas
            {
                TempRecord[playerid][mod_id] = 343;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 6) // [344] Molotov
            {
                TempRecord[playerid][mod_id] = 344;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 7) // [346] 9mm
            {
                TempRecord[playerid][mod_id] = 346;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 8) // [347] Silenced Pistol
            {
                TempRecord[playerid][mod_id] = 347;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 9) // [348] Deagle
            {
                TempRecord[playerid][mod_id] = 348;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 10) // [349] Shotgun
            {
                TempRecord[playerid][mod_id] = 349;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 11) // [350] Sawn
            {
                TempRecord[playerid][mod_id] = 350;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 12) // [351]Spaz
            {
                TempRecord[playerid][mod_id] = 351;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 13) // [352] Uzi
            {
                TempRecord[playerid][mod_id] = 352;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 14) // [372] Tec-9
            {
                TempRecord[playerid][mod_id] = 372;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 15) // [353]MP5
            {
                TempRecord[playerid][mod_id] = 353;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 16) // [355]AK47
            {
                TempRecord[playerid][mod_id] = 355;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 17) // [356] M4
            {
                TempRecord[playerid][mod_id] = 356;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 18) // [357] Rifle
            {
                TempRecord[playerid][mod_id] = 357;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 19) // [358] Sniper
            {
                TempRecord[playerid][mod_id] = 358;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 20) // [365] Spraycan
            {
                TempRecord[playerid][mod_id] = 365;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            if(listitem == 21) // [366] Extinguisher
            {
                TempRecord[playerid][mod_id] = 366;
                ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_S_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", s, "Select", "Close");
                return 1;
            }
            return 1;
        }
    }
    if(dialogid == WEAPONHOLSTER_BONE_S_DIALOG)
    {
        if(response)
        {
            if(listitem == 0) // [1] Spine
            {
                TempRecord[playerid][bone_id] = 1;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 1) // [2] Head
            {
                TempRecord[playerid][bone_id] = 2;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 2) // [3] Left Upper Arm
            {
                TempRecord[playerid][bone_id] = 3;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 3) // [4]Right Upper Arm
            {
                TempRecord[playerid][bone_id] = 4;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 4) // [5] Left Hand
            {
                TempRecord[playerid][bone_id] = 5;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 5) // [6] Right Hand
            {
                TempRecord[playerid][bone_id] = 6;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 6) // [7] Left Thigh
            {
                TempRecord[playerid][bone_id] = 7;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 7) // [8] Right Thigh
            {
                TempRecord[playerid][bone_id] = 8;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 8) // [9] Left Foot
            {
                TempRecord[playerid][bone_id] = 9;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 9) // [10] Right Foot
            {
                TempRecord[playerid][bone_id] = 10;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 10) // [11] Right Calf
            {
                TempRecord[playerid][bone_id] = 11;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 11) // [12] Left Calf
            {
                TempRecord[playerid][bone_id] = 12;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 12) // [13] Left Forearm
            {
                TempRecord[playerid][bone_id] = 13;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 13) // [14] Right Forearm
            {
                TempRecord[playerid][bone_id] = 14;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 14) // 15] Left Clavicle
            {
                TempRecord[playerid][bone_id] = 15;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            if(listitem == 15) // [16] Right Clavicle
            {
                TempRecord[playerid][bone_id] = 16;

                Set_bone(TempRecord[playerid][mod_id], TempRecord[playerid][bone_id]);
                return 1;
            }
            return 1;
        }
    }
    return 1;
}


public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    if (response)
    {
        SendClientMessageEx2(playerid, COLOR_GREEN, "Attached object edition saved.");
        SendClientMessageEx2(playerid, COLOR_GREEN, "index: %i", index);
        SendClientMessageEx2(playerid, COLOR_GREEN, "modelid: %i", modelid);
        SendClientMessageEx2(playerid, COLOR_GREEN, "boneid: %i", boneid);
        ao[playerid][index][ao_modelid] = modelid;
        ao[playerid][index][ao_bone] = boneid;
        ao[playerid][index][ao_x] = fOffsetX;
        ao[playerid][index][ao_y] = fOffsetY;
        ao[playerid][index][ao_z] = fOffsetZ;
        ao[playerid][index][ao_rx] = fRotX;
        ao[playerid][index][ao_ry] = fRotY;
        ao[playerid][index][ao_rz] = fRotZ;
        ao[playerid][index][ao_sx] = fScaleX;
        ao[playerid][index][ao_sy] = fScaleY;
        ao[playerid][index][ao_sz] = fScaleZ;

        Set_bone(modelid, boneid);
        Set_fOffsetX(modelid, fOffsetX);
        Set_fOffsetY(modelid, fOffsetY);
        Set_fOffsetZ(modelid, fOffsetZ);
        Set_fRotX(modelid, fRotX);
        Set_fRotY(modelid, fRotY);
        Set_fRotZ(modelid, fRotZ);
        Set_fScaleX(modelid, fScaleX);
        Set_fScaleY(modelid, fScaleY);
        Set_fScaleZ(modelid, fScaleZ);
        return 1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_RED, "Attached object edition not saved.");
        new i = index;
        SetPlayerAttachedObject(playerid, index, modelid, boneid, ao[playerid][i][ao_x], ao[playerid][i][ao_y], ao[playerid][i][ao_z], ao[playerid][i][ao_rx], ao[playerid][i][ao_ry], ao[playerid][i][ao_rz], ao[playerid][i][ao_sx], ao[playerid][i][ao_sy], ao[playerid][i][ao_sz]);
    }
    return 1;
}

public Disable(playerid)
{
    de[playerid] = 0;
    wep[playerid] = -1;
    for(new a = 0; a < 9; a++) if(IsPlayerAttachedObjectSlotUsed(playerid, a)) RemovePlayerAttachedObject(playerid, a);
    return 1;
}
 
public Enable(playerid)
{
    de[playerid] = 1;
    return 1;
}
/*
public HoldingWeaponsForAll(boolean)
{
    if(boolean == 0)
    {
        if(!d1) return 1;
        for(new i = 0; i < MAX_PLAYERS+1; i++) for(new a = 0; a < 9; a++) if(IsPlayerAttachedObjectSlotUsed(i, a)) RemovePlayerAttachedObject(i, a);
        KillTimer(counttimer);
        d1 = 0;
        return 1;
    }
    if(boolean == 1)
    {
        if(d1) return 1;
        counttimer = SetTimer("AttachWeapon", TIME, 1);
        d1 = 1;
        return 1;
    }
    return 0;
}*/
 
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == 128 && oldkeys != 128 && GetPlayerWeapon(playerid) == 43)
    {
        camera[playerid] = 1;
        for(new a = 0; a < 9; a++) if( IsPlayerAttachedObjectSlotUsed(playerid, a) ) RemovePlayerAttachedObject(playerid, a);
    }

    if(newkeys != 128 && oldkeys == 128 && GetPlayerWeapon(playerid) == 43) camera[playerid] = 0;
    return 1;
}