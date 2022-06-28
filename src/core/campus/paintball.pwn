#include <YSI_Coding\y_hooks>

#define TEMP_VALUE              10
#define MAX_PAINTBALL_DUELS     20
#define MAX_WEAPONS             46
#define MAX_PB_LOCATIONS        2
#define MAX_PB_LOC_NAME         32

#define PB_LOC_WAREHOUSE        0
#define PB_LOC_RCBATTLEFIELD    1

enum E_Paintball
{
    Float:E_PB_Pos[3],
    E_PB_Type[18],
    E_PB_Text[256],
    E_PB_Pickup,
}

enum E_PB_Duel
{
    E_PB_Duel_Inviter,
    E_PB_Duel_Invited,
    E_PB_Duel_Weap1,
    E_PB_Duel_Weap2,
    E_PB_Duel_Weap3,
    E_PB_Duel_Weap4,
    E_PB_Duel_Ammo1,
    E_PB_Duel_Ammo2,
    E_PB_Duel_Ammo3,
    E_PB_Duel_Ammo4,
    E_PB_Duel_Location,
    E_PB_Duel_Rounds,
    E_PB_Duel_Round,
    E_PB_Duel_Kills1,
    E_PB_Duel_Kills2
}

enum E_PB_Locations
{
    Float:E_PB_Loc_Pos1[3],
    Float:E_PB_Loc_Pos2[3],
    E_PB_Loc_Interior,
    E_PB_Loc_World,
    E_PB_Loc_Name[MAX_PB_LOC_NAME]
}

new
    PaintballData[4][E_Paintball],
    Iterator:PB_Duel<MAX_PAINTBALL_DUELS>,
    PB_DuelData[MAX_PAINTBALL_DUELS][E_PB_Duel],
    pb_duel_idx[MAX_PLAYERS],
    PB_Duel_Invite[MAX_PLAYERS][2],
    bool:IsInPaintball[MAX_PLAYERS],
    PB_LocationData[MAX_PB_LOCATIONS][E_PB_Locations];

ResetPBDuelData(idx)
{
    PB_DuelData[idx][E_PB_Duel_Inviter] = INVALID_PLAYER_ID;
    PB_DuelData[idx][E_PB_Duel_Invited] = INVALID_PLAYER_ID;

    PB_DuelData[idx][E_PB_Duel_Weap1] = 0;
    PB_DuelData[idx][E_PB_Duel_Weap2] = 0;
    PB_DuelData[idx][E_PB_Duel_Weap3] = 0;
    PB_DuelData[idx][E_PB_Duel_Weap4] = 0;

    PB_DuelData[idx][E_PB_Duel_Ammo1] = 0;
    PB_DuelData[idx][E_PB_Duel_Ammo2] = 0;
    PB_DuelData[idx][E_PB_Duel_Ammo3] = 0;
    PB_DuelData[idx][E_PB_Duel_Ammo4] = 0;

    PB_DuelData[idx][E_PB_Duel_Location] = -1;
    PB_DuelData[idx][E_PB_Duel_Rounds] = 0;

    PB_DuelData[idx][E_PB_Duel_Round] = 1;

    Iter_Remove(PB_Duel, idx);
}

hook OnPlayerConnect(playerid)
{
    PB_Duel_Invite[playerid][1] = INVALID_PLAYER_ID;
    PB_Duel_Invite[playerid][0] = false;

    IsInPaintball[playerid] = false;
    return 1;
}

hook OnGameModeInit() {
    PaintballData[0][E_PB_Pos][0] = 220.45520;
    PaintballData[0][E_PB_Pos][1] = 1922.5000;
    PaintballData[0][E_PB_Pos][2] = 17.640600;

    PaintballData[1][E_PB_Pos][0] = 211.41790;
    PaintballData[1][E_PB_Pos][1] = 1922.5000;
    PaintballData[1][E_PB_Pos][2] = 17.640600;

    PaintballData[2][E_PB_Pos][0] = 202.48670;
    PaintballData[2][E_PB_Pos][1] = 1922.5000;
    PaintballData[2][E_PB_Pos][2] = 17.640600;

    PaintballData[3][E_PB_Pos][0] = 193.59360;
    PaintballData[3][E_PB_Pos][1] = 1922.5000;
    PaintballData[3][E_PB_Pos][2] = 17.640600;

    format(PaintballData[0][E_PB_Type], 18, "Duel");
    format(PaintballData[1][E_PB_Type], 18, "2 Teams");
    format(PaintballData[2][E_PB_Type], 18, "Capture The Flag");
    format(PaintballData[3][E_PB_Type], 18, "Free For All");

    //format(PaintballData[0][E_PB_Text], 256, "Type: "COL_WHITE"%s\n"COL_WHITE"Press "COL_ORANGE"~k~~CONVERSATION_YES~ "COL_WHITE"to play", PaintballData[0][E_PB_Type]);
    //format(PaintballData[1][E_PB_Text], 256, "Type: "COL_WHITE"%s\n"COL_WHITE"Press "COL_ORANGE"~k~~CONVERSATION_YES~ "COL_WHITE"to play", PaintballData[1][E_PB_Type]);
    //format(PaintballData[2][E_PB_Text], 256, "Type: "COL_WHITE"%s\n"COL_WHITE"Press "COL_ORANGE"~k~~CONVERSATION_YES~ "COL_WHITE"to play", PaintballData[2][E_PB_Type]);
    //format(PaintballData[3][E_PB_Text], 256, "Type: "COL_WHITE"%s\n"COL_WHITE"Press "COL_ORANGE"~k~~CONVERSATION_YES~ "COL_WHITE"to play", PaintballData[3][E_PB_Type]);
    format(PaintballData[0][E_PB_Text], 256, "Type: "COL_WHITE"%s\n"COL_WHITE"COMING SOON", PaintballData[0][E_PB_Type]);
    format(PaintballData[1][E_PB_Text], 256, "Type: "COL_WHITE"%s\n"COL_WHITE"COMING SOON", PaintballData[1][E_PB_Type]);
    format(PaintballData[2][E_PB_Text], 256, "Type: "COL_WHITE"%s\n"COL_WHITE"COMING SOON", PaintballData[2][E_PB_Type]);
    format(PaintballData[3][E_PB_Text], 256, "Type: "COL_WHITE"%s\n"COL_WHITE"COMING SOON", PaintballData[3][E_PB_Type]);
    
    PaintballData[0][E_PB_Pickup] = 1314;
    PaintballData[1][E_PB_Pickup] = 1254;
    PaintballData[2][E_PB_Pickup] = 1313;
    PaintballData[3][E_PB_Pickup] = 954;
    
    for(new i; i < 4; i++) {
        CreateDynamicPickup(PaintballData[i][E_PB_Pickup], 1, PaintballData[i][E_PB_Pos][0], PaintballData[i][E_PB_Pos][1], PaintballData[i][E_PB_Pos][2]);
        CreateDynamic3DTextLabel(PaintballData[i][E_PB_Text], COLOR_YELLOW, PaintballData[i][E_PB_Pos][0], PaintballData[i][E_PB_Pos][1], PaintballData[i][E_PB_Pos][2], 20.0);
    }

    PB_LocationData[PB_LOC_WAREHOUSE][E_PB_Loc_Pos1][0] = 1416.1038;
    PB_LocationData[PB_LOC_WAREHOUSE][E_PB_Loc_Pos1][1] = -22.12900;
    PB_LocationData[PB_LOC_WAREHOUSE][E_PB_Loc_Pos1][2] = 1000.9261;

    PB_LocationData[PB_LOC_WAREHOUSE][E_PB_Loc_Pos2][0] = 1367.1556;
    PB_LocationData[PB_LOC_WAREHOUSE][E_PB_Loc_Pos2][1] = -22.12900;
    PB_LocationData[PB_LOC_WAREHOUSE][E_PB_Loc_Pos2][2] = 1000.9261;

    PB_LocationData[PB_LOC_RCBATTLEFIELD][E_PB_Loc_Pos1][0] = -972.7333;
    PB_LocationData[PB_LOC_RCBATTLEFIELD][E_PB_Loc_Pos1][1] = 1061.2119;
    PB_LocationData[PB_LOC_RCBATTLEFIELD][E_PB_Loc_Pos1][2] = 1345.6687;
    
    PB_LocationData[PB_LOC_RCBATTLEFIELD][E_PB_Loc_Pos2][0] = -1132.190;
    PB_LocationData[PB_LOC_RCBATTLEFIELD][E_PB_Loc_Pos2][1] = 1057.7382;
    PB_LocationData[PB_LOC_RCBATTLEFIELD][E_PB_Loc_Pos2][2] = 1346.4122;

    PB_LocationData[PB_LOC_WAREHOUSE][E_PB_Loc_Interior] = 1;
    PB_LocationData[PB_LOC_RCBATTLEFIELD][E_PB_Loc_Interior] = 10;

    PB_LocationData[PB_LOC_WAREHOUSE][E_PB_Loc_World] = 0;
    PB_LocationData[PB_LOC_RCBATTLEFIELD][E_PB_Loc_World] = 0;

    format(PB_LocationData[PB_LOC_WAREHOUSE][E_PB_Loc_Name], MAX_PB_LOC_NAME, "Warehouse 1");
    format(PB_LocationData[PB_LOC_RCBATTLEFIELD][E_PB_Loc_Name], MAX_PB_LOC_NAME, "RC Battlefield");
    
    return 1;
}

// 1416.1038, -22.12900, 1000.9261, 90.00000 // Player 1 Warehouse
// 1367.1556, -22.63590, 1000.9219, 270.0000 // Player 2 Warehouse
// -972.7333, 1061.2119, 1345.6687, 90.00000 // Player 1 RC BattleField
// -1132.190, 1057.7382, 1346.4122, 270.0000 // Player 2 RC BattleField

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    if(newkeys == KEY_YES) {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, PaintballData[0][E_PB_Pos][0], PaintballData[0][E_PB_Pos][1], PaintballData[0][E_PB_Pos][2])) {
            ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_1);
        }
        if(IsPlayerInRangeOfPoint(playerid, 5.0, PaintballData[1][E_PB_Pos][0], PaintballData[1][E_PB_Pos][1], PaintballData[1][E_PB_Pos][2])) {
            
        }
        if(IsPlayerInRangeOfPoint(playerid, 5.0, PaintballData[2][E_PB_Pos][0], PaintballData[2][E_PB_Pos][1], PaintballData[2][E_PB_Pos][2])) {
            
        }
        if(IsPlayerInRangeOfPoint(playerid, 5.0, PaintballData[3][E_PB_Pos][0], PaintballData[3][E_PB_Pos][1], PaintballData[3][E_PB_Pos][2])) {
            
        }
    }
    return 1;
}

ShowDialogToPlayer(playerid, dialogid) {
    if(dialogid == DIALOG_PB_DUEL_1) {
        ShowPlayerDialog(playerid, DIALOG_PB_DUEL_1, DIALOG_STYLE_LIST, "Paintball | Duel", "Duel a player", "Select", "Exit");
    }
    
    if(dialogid == DIALOG_PB_DUEL_2) {
        ShowPlayerDialog(playerid, DIALOG_PB_DUEL_2, DIALOG_STYLE_INPUT, "Paintball | Duel - Invite player", "Enter player name or player ID", "Next", "Back");
    }
    
    if(dialogid == DIALOG_PB_DUEL_3) {
        new
            WeaponMenu[2048],
            WeaponName[4][32];
        
        if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap1] == 0) {
            format(WeaponName[0], 32, "None");
        } else {
            GetWeaponName(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap1], WeaponName[0], 32);
        }
        if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap2] == 0) {
            format(WeaponName[1], 32, "None");
        } else {
            GetWeaponName(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap2], WeaponName[1], 32);
        }
        if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap3] == 0) {
            format(WeaponName[2], 32, "None");
        } else {
            GetWeaponName(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap3], WeaponName[2], 32);
        }
        if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap4] == 0) {
            format(WeaponName[3], 32, "None");
        } else {
            GetWeaponName(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap4], WeaponName[3], 32);
        }
        
        format(WeaponMenu, sizeof(WeaponMenu), "Weapon\tAmmo\n%s\t%d\n%s\t%d\n%s\t%d\n%s\t%d\nNext\t->", WeaponName[0], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo1], WeaponName[1], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo2], WeaponName[2], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo3], WeaponName[3], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo4]);
        
        ShowPlayerDialog(playerid, DIALOG_PB_DUEL_3, DIALOG_STYLE_TABLIST_HEADERS, "Paintball | Duel - Choose Weapon", WeaponMenu, "Select", "Back");
    }
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_PB_DUEL_1)
    {
        if(response) {
            if(listitem == 0) {
                ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_2);
            }

            Iter_Alloc(PB_Duel);
            pb_duel_idx[playerid] = Iter_Last(PB_Duel);

            ResetPBDuelData(pb_duel_idx[playerid]);
        } else {
            ResetPBDuelData(pb_duel_idx[playerid]);
        }
    }
    
    if(dialogid == DIALOG_PB_DUEL_2) {
        if(response) {
            if(!IsPlayerLoggedIn(strval(inputtext))) {
                SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"That player has not yet logged in!");
                return 1;
            }

            // if(strval(inputtext) == playerid) {
            //     SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"You can not duel yourself!");
            //     return 1;
            // }

            PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Inviter] = playerid;
            PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited] = strval(inputtext);
            
            ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
        }
    }

    if(dialogid == DIALOG_PB_DUEL_3) {
        if(response) {
            if(listitem == 0) {
                ShowPlayerDialog(playerid, DIALOG_PB_DUEL_4, DIALOG_STYLE_LIST, "Paintball | Duel - Choose Weapon", "Deagle\n9mm\nSilenced Pistol\nNone", "Next", "Back");
            }

            if(listitem == 1) {
                ShowPlayerDialog(playerid, DIALOG_PB_DUEL_5, DIALOG_STYLE_LIST, "Paintball | Duel - Choose Weapon", "M4\nAk47\nSniper Rifle\nCunt Gun\nNone", "Next", "Back");
            }
            
            if(listitem == 2) {
                ShowPlayerDialog(playerid, DIALOG_PB_DUEL_6, DIALOG_STYLE_LIST, "Paintball | Duel - Choose Weapon", "SPAS\nShotgun\nSawn-Off\nNone", "Next", "Back");
            }
            
            if(listitem == 3) {
                ShowPlayerDialog(playerid, DIALOG_PB_DUEL_7, DIALOG_STYLE_LIST, "Paintball | Duel - Choose Weapon", "Tec-9\nMicro SMG\nMP5\nNone", "Next", "Back");
            }

            if(listitem == 4) {
                ShowPlayerDialog(playerid, DIALOG_PB_DUEL_12, DIALOG_STYLE_LIST, "Paintball | Duel - Choose Location", "Warehouse\nRC Battlefield", "Next", "Back");
            }
        } else {
            ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_2);
        }
    }

    if(dialogid == DIALOG_PB_DUEL_4) {
        if(response) {
            if(listitem == 0) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap1] = WEAPON_DEAGLE;
            }

            if(listitem == 1) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap1] = WEAPON_COLT45;
            }

            if(listitem == 2) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap1] = WEAPON_SILENCED;
            }

            if(listitem == 3) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap1] = 0;
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo1] = 0;
            }

            if(listitem != 3) {
                ShowPlayerDialog(playerid, DIALOG_PB_DUEL_8, DIALOG_STYLE_INPUT, "Paintball | Duel - Choose Weapon", "Enter the amount of ammo for this weapon", "Next", "Back");
            } else {
                ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
            }
        } else {
            ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
        }
    }

    if(dialogid == DIALOG_PB_DUEL_5) {
        if(response) {
            if(listitem == 0) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap2] = WEAPON_M4;
            }

            if(listitem == 1) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap2] = WEAPON_AK47;
            }

            if(listitem == 2) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap2] = WEAPON_SNIPER;
            }

            if(listitem == 3) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap2] = WEAPON_RIFLE;
            }

            if(listitem == 4) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap2] = 0;
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo2] = 0;
            }

            if(listitem != 4) {
                ShowPlayerDialog(playerid, DIALOG_PB_DUEL_9, DIALOG_STYLE_INPUT, "Paintball | Duel - Choose Weapon", "Enter the amount of ammo for this weapon", "Next", "Back");
            } else {
                ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
            }
        } else {
            ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
        }
    }

    if(dialogid == DIALOG_PB_DUEL_6) {
        if(response) {
            if(listitem == 0) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap3] = WEAPON_SHOTGSPA;
            }

            if(listitem == 1) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap3] = WEAPON_SHOTGUN;
            }

            if(listitem == 2) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap3] = WEAPON_SAWEDOFF;
            }

            if(listitem == 3) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap3] = 0;
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo3] = 0;
            }

            if(listitem != 3) {
                ShowPlayerDialog(playerid, DIALOG_PB_DUEL_10, DIALOG_STYLE_INPUT, "Paintball | Duel - Choose Weapon", "Enter the amount of ammo for this weapon", "Next", "Back");
            } else {
                ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
            }
        } else {
            ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
        }
    }

    if(dialogid == DIALOG_PB_DUEL_7) {
        if(response) {
            if(listitem == 0) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap4] = WEAPON_TEC9;
            }

            if(listitem == 1) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap4] = WEAPON_UZI;
            }

            if(listitem == 2) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap4] = WEAPON_MP5;
            }

            if(listitem == 3) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap4] = 0;
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo4] = 0;
            }

            if(listitem != 3) {
                ShowPlayerDialog(playerid, DIALOG_PB_DUEL_11, DIALOG_STYLE_INPUT, "Paintball | Duel - Choose Weapon", "Enter the amount of ammo for this weapon", "Next", "Back");
            } else {
                ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
            }
        } else {
            ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
        }
    }

    if(dialogid == DIALOG_PB_DUEL_8) {
        if(response) {
            PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo1] = strval(inputtext);
            ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
        } else {
            ShowPlayerDialog(playerid, DIALOG_PB_DUEL_4, DIALOG_STYLE_LIST, "Paintball | Duel - Choose Weapon", "Deagle\n9mm\nSilenced Pistol\nNone", "Next", "Back");
        }
    }

    if(dialogid == DIALOG_PB_DUEL_9) {
        if(response) {
            PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo2] = strval(inputtext);
            ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
        } else {
            ShowPlayerDialog(playerid, DIALOG_PB_DUEL_5, DIALOG_STYLE_LIST, "Paintball | Duel - Choose Weapon", "M4\nAk47\nSniper Rifle\nCunt Gun\nNone", "Next", "Back");
        }
    }

    if(dialogid == DIALOG_PB_DUEL_10) {
        if(response) {
            PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo3] = strval(inputtext);
            ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
        } else {
            ShowPlayerDialog(playerid, DIALOG_PB_DUEL_6, DIALOG_STYLE_LIST, "Paintball | Duel - Choose Weapon", "SPAS\nShotgun\nSawn-Off\nNone", "Next", "Back");
        }
    }

    if(dialogid == DIALOG_PB_DUEL_11) {
        if(response) {
            PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo4] = strval(inputtext);
            ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
        } else {
            ShowPlayerDialog(playerid, DIALOG_PB_DUEL_7, DIALOG_STYLE_LIST, "Paintball | Duel - Choose Weapon", "Tec-9\nMicro SMG\nMP5\nNone", "Next", "Back");
        }
    }

    if(dialogid == DIALOG_PB_DUEL_12) {
        if(response) {
            PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Location] = listitem;
            
            ShowPlayerDialog(playerid, DIALOG_PB_DUEL_13, DIALOG_STYLE_INPUT, "Paintball | Duel - Rounds", "Enter amount of rounds", "Next", "Back");
        } else {
            ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_2);
        }
    }

    if(dialogid == DIALOG_PB_DUEL_13) {
        if(response) {
            new
                summary[2048],
                PlayersName[2][MAX_PLAYER_NAME],
                WeaponName[4][32],
                WeaponAmmo[4];
            
            GetPlayerName(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Inviter], PlayersName[0], MAX_PLAYER_NAME);
            GetPlayerName(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited], PlayersName[1], MAX_PLAYER_NAME);

            GetWeaponName(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap1], WeaponName[0], 32);
            GetWeaponName(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap2], WeaponName[1], 32);
            GetWeaponName(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap3], WeaponName[2], 32);
            GetWeaponName(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap4], WeaponName[3], 32);

            WeaponAmmo[0] = PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo1];
            WeaponAmmo[1] = PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo2];
            WeaponAmmo[2] = PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo3];
            WeaponAmmo[3] = PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo4];

            PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Rounds] = strval(inputtext);

            format(summary, sizeof(summary), ""COL_LIMEGREEN"You: "COL_WHITE"%s\n"COL_ORANGE"Enemy: "COL_WHITE"%s\n"COL_GREENYELLOW"Weapon 1: "COL_WHITE"%s - "COL_YELLOW"%d\n"COL_GREENYELLOW"Weapon 2: "COL_WHITE"%s - "COL_YELLOW"%d\n"COL_GREENYELLOW"Weapon 3: "COL_WHITE"%s - "COL_YELLOW"%d\n"COL_GREENYELLOW"Weapon 4: "COL_WHITE"%s - "COL_YELLOW"%d\n"COL_BURLYWOOD"Location: "COL_WHITE"%s\n"COL_BURLYWOOD"Number of rounds: "COL_WHITE"%d", PlayersName[0], PlayersName[1], WeaponName[0], WeaponAmmo[0], WeaponName[1], WeaponAmmo[1], WeaponName[2], WeaponAmmo[2], WeaponName[3], WeaponAmmo[3], PB_LocationData[PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Location]][E_PB_Loc_Name], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Rounds]);

            ShowPlayerDialog(playerid, DIALOG_PB_DUEL_14, DIALOG_STYLE_MSGBOX, "Paintball | Duel - Summary", summary, "Invite", "Back");
        } else {
            ShowDialogToPlayer(playerid, DIALOG_PB_DUEL_3);
        }
    }

    if(dialogid == DIALOG_PB_DUEL_14) {
        if(response) {
            print("Test 1");
            if(!IsPlayerLoggedIn(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited])) {
                SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"That player you invited has disconnected.");

                ResetPBDuelData(pb_duel_idx[playerid]);
                return 1;
            }
            print("Test 2");
            
            PB_Duel_Invite[PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited]][0] = true;
            PB_Duel_Invite[PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited]][1] = playerid;
            
            SendClientMessageEx2(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited], COLOR_AQUA, "[PAINTBALL INVITATION]: "COL_WHITE"%s has invited you to a paintball duel, enter the command [/paintball (accept / deny)] to respond.", GetPlayerNameEx(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Inviter]));

            print("Test 3");

            SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SUCCESS]: "COL_WHITE"You have invited %s to a paintball duel, enter the command [/paintball start] to continue.", GetPlayerNameEx(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited]));

            print("Test 4");
        } else {
            ShowPlayerDialog(playerid, DIALOG_PB_DUEL_12, DIALOG_STYLE_LIST, "Paintball | Duel - Choose Location", "Warehouse\nRC Battlefield", "Next", "Back");
        }
    }
    return 1;
}

YCMD:paintball(playerid, params[], help) {
    new
        option[16];

    if(sscanf(params, "s[*]", 16, option)) {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/paintball [leave / stats]");
        return 1;
    }

    if(!strcmp(option, "leave", true)) {
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerPos(playerid, PaintballData[0][E_PB_Pos][0], PaintballData[0][E_PB_Pos][1], PaintballData[0][E_PB_Pos][2]);

        IsInPaintball[playerid] = false;
    }

    if(!strcmp(option, "accept", true)) {
        if(!PB_Duel_Invite[playerid][0]) {
            SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"You are not invited on a paintball match!");
            return 1;
        }

        SendClientMessageEx2(PB_Duel_Invite[playerid][1], COLOR_AQUA, "[PAINTBALL INVITATION]: "COL_WHITE"%s accepted your paintball invitation.", GetPlayerNameEx(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited])); // TEST
        
        if(!IsPlayerInRangeOfPoint(playerid, 5.0, 220.45520, 1922.5000, 17.640600)) {                   
            SetPlayerCheckpoint(playerid, 220.45520, 1922.5000, 17.640600, 5.0);
            SendClientMessage(playerid, COLOR_AQUA, "[PAINTBALL INVITATION]: "COL_WHITE"Proceed to the checkpoint so the inviter can begin the game.");
        }

        pb_duel_idx[playerid] = pb_duel_idx[PB_Duel_Invite[playerid][1]];

        PB_Duel_Invite[playerid][0] = false;
    }

    if(!strcmp(option, "deny", true)) {
        if(!PB_Duel_Invite[playerid][0]) {
            SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"You are not invited on a paintball match!");
            return 1;
        }

        SendClientMessageEx2(PB_Duel_Invite[playerid][1], COLOR_AQUA, "[PAINTBALL INVITATION]: "COL_WHITE"%s denied your paintball invitation.", GetPlayerNameEx(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited])); // TEST
        ResetPBDuelData(pb_duel_idx[PB_Duel_Invite[playerid][1]]);

        PB_Duel_Invite[playerid][0] = false;
    }

    if(!strcmp(option, "start", true)) {
        if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Inviter] != playerid) {
            SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"Only an inviter can start the game.");
            return 1;
        }

        if(!IsPlayerInRangeOfPoint(playerid, 5.0, 220.45520, 1922.5000, 17.640600)) {
            SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"You must be near at the entrance of the paintball to start.");
            return 1;
        }

        if(!IsPlayerInRangeOfPoint(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited], 5.0, 220.45520, 1922.5000, 17.640600)) {
            SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"The player you have invited must be near the entrance to start.");
            return 1;
        }

        PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Round] = 1;
        
        StartPBDuel(playerid);

        IsInPaintball[playerid] = true;
        IsInPaintball[PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited]] = true;
    }

    return 1;
}

hook OnPlayerDeath(playerid, killerid, reason) {
    if(IsInPaintball[playerid]) {
        if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Round] >= 10) {
            new PlayerName[2][MAX_PLAYER_NAME],
                PlayerKills[2],
                Winner,
                Loser;

            PlayerKills[0] = PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Kills1];
            PlayerKills[1] = PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Kills2];
            
            if(PlayerKills[0] == PlayerKills[1]) {
                SendClientMessage(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Inviter], COLOR_AQUA, "[PAINTBALL INFO]: "COL_WHITE"The game has ended and it was a draw!");
                SendClientMessage(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited], COLOR_AQUA, "[PAINTBALL INFO]: "COL_WHITE"The game has ended and it was a draw!");
                return 1;
            }

            Winner = PlayerKills[0] > PlayerKills[1] ? PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Inviter] : PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited];
            Loser = PlayerKills[0] < PlayerKills[1] ? PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Inviter] : PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited];

            GetPlayerName(Winner, PlayerName[0]);
            GetPlayerName(Loser, PlayerName[1]);

            SendClientMessageEx2(Winner, COLOR_AQUA, "[PAINTBALL INFO]: "COL_WHITE"%s has won against %s with the score %d out of %d rounds.", PlayerName[0], PlayerName[1], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Kills1], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Rounds]);
            SendClientMessageEx2(Loser, COLOR_AQUA, "[PAINTBALL INFO]: "COL_WHITE"%s has won against %s with the score %d out of %d rounds.", PlayerName[0], PlayerName[1], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Kills1], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Rounds]);
        }

        if(playerid == PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Inviter] || playerid == PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited]) {
            if(playerid == PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Inviter]) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Kills1]++;
            }

            if(playerid == PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited]) {
                PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Kills2]++;
            }

            StartPBDuel(playerid);
        }

    }
    return 1;
}

StartPBDuel(playerid) {
    SpawnPlayer(playerid);
    
    SetPlayerPos(playerid, PB_LocationData[PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Location]][E_PB_Loc_Pos1][0], PB_LocationData[PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Location]][E_PB_Loc_Pos1][1], PB_LocationData[PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Location]][E_PB_Loc_Pos1][2]);
    SetPlayerInterior(playerid, PB_LocationData[PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Location]][E_PB_Loc_Interior]);
    SetPlayerVirtualWorld(playerid, GetPlayerBuffer(playerid));
    
    SetPlayerPos(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited], PB_LocationData[PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Location]][E_PB_Loc_Pos2][0], PB_LocationData[PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Location]][E_PB_Loc_Pos2][1], PB_LocationData[PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Location]][E_PB_Loc_Pos2][2]);
    SetPlayerInterior(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited], PB_LocationData[PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Location]][E_PB_Loc_Interior]);
    SetPlayerVirtualWorld(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited], GetPlayerBuffer(playerid));

    ResetPlayerWeapons(playerid);

    if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap1] != 0) {
        GivePlayerWeapon(playerid, PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap1], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo1]);
    }
    if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap2] != 0) {
        GivePlayerWeapon(playerid, PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap2], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo2]);
    }
    if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap3] != 0) {
        GivePlayerWeapon(playerid, PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap3], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo3]);
    }
    if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap4] != 0) {
        GivePlayerWeapon(playerid, PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap4], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo4]);
    }

    if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap1] != 0) {
        GivePlayerWeapon(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap1], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo1]);
    }
    if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap2] != 0) {
        GivePlayerWeapon(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap2], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo2]);
    }
    if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap3] != 0) {
        GivePlayerWeapon(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap3], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo3]);
    }
    if(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap4] != 0) {
        GivePlayerWeapon(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Weap4], PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Ammo4]);
    }

    new string[64];

    format(string, 64, "~r~Round %d", PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Round]);
    PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Round]++;
    
    GameTextForPlayer(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Inviter], string, 5000, 3);
    FreezePlayer(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Inviter], true, 5000);
    GameTextForPlayer(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited], string, 5000, 3);
    FreezePlayer(PB_DuelData[pb_duel_idx[playerid]][E_PB_Duel_Invited], true, 5000);
}
