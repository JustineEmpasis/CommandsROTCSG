#include <YSI_Coding\y_hooks>

forward OnPlayerLoginAttempt(playerid, bool:success);
forward OnPlayerLoginPassword(playerid, dialogid, response, listitem, string:inputtext[]);

new PlayerText:player_rank_label[MAX_PLAYERS];
new PlayerText:player_rank[MAX_PLAYERS];
new PlayerText:player_class_label[MAX_PLAYERS];
new PlayerText:player_class[MAX_PLAYERS];
new PlayerText:player_team_label[MAX_PLAYERS];
new PlayerText:player_team[MAX_PLAYERS];


GetUserBan(playerid) {
    static SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT user_banned FROM users WHERE user_id='%d'", GetPlayerUserID(playerid));
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_int(0, "user_banned", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

public OnPlayerLogin(playerid) {
    SpawnPlayer(playerid);
    SetPlayerPos(playerid, 294.9166, 2982.6262, 9.2347);
    SetPlayerCameraPos(playerid, 251.9090, 2975.0730, 40.9966);
    SetPlayerCameraLookAt(playerid, 320.1534, 3112.3411, 9.7107, CAMERA_CUT);

    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Account Login", "Enter your password to login.", "Login", "Exit");
    StartMusic(playerid);
    return 1;
}

hook OnGameModeInit()
{
    return 1;
}

hook OnPlayerConnect(playerid)
{
    new Float:width = 0.15;
    new Float:height = 1;
    new Float:x = 552.937011;
    new colorset = 0x8a9a5bFF;

    new playerrank[256];
    format(playerrank, sizeof(playerrank), "%s", RankName[GetPlayerRank(playerid)-1][1]);

    new playerclass[256];
    format(playerclass, sizeof(playerclass), "%d", GetPlayerClass(playerid));

    new playerteam[256];
    format(playerteam, sizeof(playerteam), "%s", GetPlayerClassTeamName(playerid));
    
    // player_rank_label
    player_rank_label[playerid] = CreatePlayerTextDraw(playerid, x, 108.267074, "RANK");
    PlayerTextDrawLetterSize(playerid, player_rank_label[playerid], width, height);
    PlayerTextDrawTextSize(playerid, player_rank_label[playerid], 36.500000, 36.711112);
    PlayerTextDrawAlignment(playerid, player_rank_label[playerid], 2);
    PlayerTextDrawColor(playerid, player_rank_label[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, player_rank_label[playerid], 1);
    PlayerTextDrawSetOutline(playerid, player_rank_label[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, player_rank_label[playerid], 51);
    PlayerTextDrawFont(playerid, player_rank_label[playerid], 2);
    PlayerTextDrawSetProportional(playerid, player_rank_label[playerid], 1);

    // player_rank
    player_rank[playerid] = CreatePlayerTextDraw(playerid, x, 118, playerrank);
    PlayerTextDrawLetterSize(playerid, player_rank[playerid], width, height);
    PlayerTextDrawAlignment(playerid, player_rank[playerid], 2);
    PlayerTextDrawColor(playerid, player_rank[playerid], -1);
    PlayerTextDrawSetShadow(playerid, player_rank[playerid], 1);
    PlayerTextDrawSetOutline(playerid, player_rank[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, player_rank[playerid], 51);
    PlayerTextDrawFont(playerid, player_rank[playerid], 2);
    PlayerTextDrawSetProportional(playerid, player_rank[playerid], 1);

    // player_class_label
    player_class_label[playerid] = CreatePlayerTextDraw(playerid, x, 132.466674, "Class");
    PlayerTextDrawLetterSize(playerid, player_class_label[playerid], width, height);
    PlayerTextDrawAlignment(playerid, player_class_label[playerid], 2);
    PlayerTextDrawColor(playerid, player_class_label[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, player_class_label[playerid], 1);
    PlayerTextDrawSetOutline(playerid, player_class_label[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, player_class_label[playerid], 51);
    PlayerTextDrawFont(playerid, player_class_label[playerid], 2);
    PlayerTextDrawSetProportional(playerid, player_class_label[playerid], 1);

    // player_class
    player_class[playerid] = CreatePlayerTextDraw(playerid, x, 142, playerclass);
    PlayerTextDrawLetterSize(playerid, player_class[playerid], width, height);
    PlayerTextDrawAlignment(playerid, player_class[playerid], 2);
    PlayerTextDrawColor(playerid, player_class[playerid], -1);
    PlayerTextDrawSetShadow(playerid, player_class[playerid], 1);
    PlayerTextDrawSetOutline(playerid, player_class[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, player_class[playerid], 51);
    PlayerTextDrawFont(playerid, player_class[playerid], 2);
    PlayerTextDrawSetProportional(playerid, player_class[playerid], 1);

    // player_team_label
    player_team_label[playerid] = CreatePlayerTextDraw(playerid, x, 156, "Team");
    PlayerTextDrawLetterSize(playerid, player_team_label[playerid], width, height);
    PlayerTextDrawAlignment(playerid, player_team_label[playerid], 2);
    PlayerTextDrawColor(playerid, player_team_label[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, player_team_label[playerid], 1);
    PlayerTextDrawSetOutline(playerid, player_team_label[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, player_team_label[playerid], 51);
    PlayerTextDrawFont(playerid, player_team_label[playerid], 2);
    PlayerTextDrawSetProportional(playerid, player_team_label[playerid], 1);

    // player_team
    player_team[playerid] = CreatePlayerTextDraw(playerid, x, 166, playerteam);
    PlayerTextDrawLetterSize(playerid, player_team[playerid], width, height);
    PlayerTextDrawAlignment(playerid, player_team[playerid], 2);
    PlayerTextDrawColor(playerid, player_team[playerid], -1);
    PlayerTextDrawSetShadow(playerid, player_team[playerid], 1);
    PlayerTextDrawSetOutline(playerid, player_team[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, player_team[playerid], 51);
    PlayerTextDrawFont(playerid, player_team[playerid], 2);
    PlayerTextDrawSetProportional(playerid, player_team[playerid], 1);

    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_LOGIN)
    {
        if(response)
        {
            new innerInput[128];
            strcopy(innerInput, inputtext);
            inline GetPassword()
            {
                new password[BCRYPT_HASH_LENGTH+1];
                cache_get_value_name(0, "user_password", password);
                
                bcrypt_verify(playerid, "OnPlayerLoginAttempt", innerInput, password);
                format(password, BCRYPT_HASH_LENGTH+1, "");
            }
            MySQL_TQueryInline(SQL_Handle, using inline GetPassword, "SELECT user_password FROM users WHERE user_name='%e'", GetPlayerNameEx(playerid));
        }
    }
    return 1;
}

public OnPlayerLoginAttempt(playerid, bool:success)
{
    if(success)
    {
        if(GetUserBan(playerid) == 1)
        {
            SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You are banned from this server.");
            SetTimerEx("DelayKick", 2000, false, "i", playerid);
        }

        TempPlayerSession[playerid] = true;
        
        SetCameraBehindPlayer(playerid);

        mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT user_pos_x, user_pos_y, user_pos_z, user_pos_a, user_pos_world, user_pos_interior, user_skin, weapon_1, weapon_1_ammo, weapon_2, weapon_2_ammo, health, armor, fightstyle FROM users WHERE user_id=%d", GetPlayerUserID(playerid));
        mysql_tquery(SQL_Handle, SQL_Buffer, "OnPlayerLoadPosition", "i", playerid);
        
    }
    else
    {
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Account Login", "Enter your password to login.", "Login", "Exit");
    }
    return 1;
}

forward DelayKick(playerid);
public DelayKick(playerid)
{
    Kick(playerid);
    return 1;
}

forward EndAntiSpawnKill(playerid, health, armor);
public EndAntiSpawnKill(playerid, health, armor)
{
    // 5 seconds has passed, so let's set their health back to 100
    SetPlayerHealth(playerid, health);
    SetPlayerArmour(playerid, armor);

    // Let's notify them also
    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[GAME]: "COL_WHITE"Environment loaded.");
    return 1;
}

forward OnPlayerLoadPosition(playerid);
public OnPlayerLoadPosition(playerid)
{
    new Float:TempPlayerPosition[4];
    new TempPlayerGlobalPosition[2];
    new TempPlayerSkin;
    new TempWeaponOne;
    new TempWeaponOneAmmo;
    new TempWeaponTwo;
    new TempWeaponTwoAmmo;
    new TempHealth;
    new TempArmor;
    new TempFightstyle;
    
    cache_get_value_index_float(0, 0, TempPlayerPosition[0]);
    cache_get_value_index_float(0, 1, TempPlayerPosition[1]);
    cache_get_value_index_float(0, 2, TempPlayerPosition[2]);
    cache_get_value_index_float(0, 3, TempPlayerPosition[3]);
    cache_get_value_index_int(0, 4, TempPlayerGlobalPosition[0]);
    cache_get_value_index_int(0, 5, TempPlayerGlobalPosition[1]);
    cache_get_value_index_int(0, 6, TempPlayerSkin);

    cache_get_value_index_int(0, 7, TempWeaponOne);
    cache_get_value_index_int(0, 8, TempWeaponOneAmmo);
    cache_get_value_index_int(0, 9, TempWeaponTwo);
    cache_get_value_index_int(0, 10, TempWeaponTwoAmmo);
    cache_get_value_index_int(0, 11, TempHealth);
    cache_get_value_index_int(0, 12, TempArmor);
    cache_get_value_index_int(0, 13, TempFightstyle);

    SetPlayerPos(playerid, TempPlayerPosition[0], TempPlayerPosition[1], TempPlayerPosition[2]);
    SetPlayerFacingAngle(playerid, TempPlayerPosition[3]);
    SetPlayerVirtualWorld(playerid, TempPlayerGlobalPosition[0]);
    SetPlayerInterior(playerid, TempPlayerGlobalPosition[1]);
    SetPlayerSkin(playerid, TempPlayerSkin);
    GivePlayerWeapon(playerid, TempWeaponOne, TempWeaponOneAmmo);
    GivePlayerWeapon(playerid, TempWeaponTwo, TempWeaponTwoAmmo);

    PlayerTextDrawShow(playerid, player_rank_label[playerid]);
    PlayerTextDrawShow(playerid, player_class_label[playerid]);
    PlayerTextDrawShow(playerid, player_team_label[playerid]);
    PlayerTextDrawShow(playerid, player_rank[playerid]);
    PlayerTextDrawShow(playerid, player_class[playerid]);
    PlayerTextDrawShow(playerid, player_team[playerid]);

    SetPlayerScore(playerid, GetPlayerRank(playerid));
    SetPlayerFightingStyle(playerid, TempFightstyle);
    ShowPlayerDialog(playerid, PLATFORM_DIALOG, DIALOG_STYLE_MSGBOX, "Platform", "Which device are you currently using right now?", "Mobile", "Desktop");
    
    StopAudioStreamForPlayer(playerid);
    UpdatePlayerTD(playerid);

    // Notify them
    SendClientMessageEx2(playerid, COLOR_ORANGE, "[GAME]: "COL_WHITE"Loading environment for 5 seconds.");

    // Start a 5 second timer to end the anti-spawnkill
    SetPlayerHealth(playerid, 9999999);
    FreezePlayer(playerid, true, 5000);
    SetTimerEx("EndAntiSpawnKill", 5000, false, "iii", playerid, TempHealth, TempArmor);
}

UpdatePlayerTD(playerid)
{
    new playerrank[256];
    format(playerrank, sizeof(playerrank), "%s", RankName[GetPlayerRank(playerid)-1][1]);

    new playerclass[256];
    if (GetPlayerClass(playerid) == 0)
    {
        format(playerclass, sizeof(playerclass), "Element");
    }
    else if(GetPlayerClass(playerid) == 1)
    {
        format(playerclass, sizeof(playerclass), "%dst", GetPlayerClass(playerid));
    }
    else if(GetPlayerClass(playerid) == 2)
    {
        format(playerclass, sizeof(playerclass), "%dnd", GetPlayerClass(playerid));
    }
    else if(GetPlayerClass(playerid) == 3)
    {
        format(playerclass, sizeof(playerclass), "%drd", GetPlayerClass(playerid));
    }
    else if(GetPlayerClass(playerid) == 4)
    {
        format(playerclass, sizeof(playerclass), "%dth", GetPlayerClass(playerid));
    }
    else
    {
        format(playerclass, sizeof(playerclass), "Combat Medic");
    }

    new playerteam[256];
    if (GetPlayerClassTeam(playerid) == 0)
    {
        format(playerteam, sizeof(playerteam), "None");
    }
    else
    {
        format(playerteam, sizeof(playerteam), "%s", GetPlayerClassTeamName(playerid));
    }

    PlayerTextDrawSetString(playerid, player_rank[playerid], playerrank);
    PlayerTextDrawSetString(playerid, player_class[playerid], playerclass);
    PlayerTextDrawSetString(playerid, player_team[playerid], playerteam);
    return 1;
}