#include <YSI_Coding\y_hooks>

forward OnPlayerFirstJoin(playerid);

forward OnPlayerLogin(playerid);
forward OnPlayerRegister(playerid);

#define MAX_MALE_SKINS              60
#define MAX_FEMALE_SKINS            21

new GenderSkins[2][] = {
    {2, 7, 20, 21, 22, 23, 25, 29, 46, 48, 59, 60, 98, 100, 101, 102, 206, 103, 104, 105, 106, 114, 115, 116, 119, 122, 123, 126, 128, 143, 144, 170, 174, 175, 176, 177, 180, 184, 188, 211, 221, 222, 223, 234, 240, 248, 249, 250, 258, 259, 262, 269, 270, 271, 289, 290, 291, 292, 297, 299},
    {12, 13, 55, 56, 65, 69, 76, 85, 91, 93, 150, 151, 157, 195, 198, 215, 216, 219, 224, 225, 226}
};

static
    bool:PlayerFirstJoin[MAX_PLAYERS];

new
    bool:TempPlayerSession[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    PlayerFirstJoin[playerid] = true;

    if( !IsValidName2(GetPlayerNameEx(playerid)) )
    {
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"You have entered an invalid name, so we kicked from the server!");
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"Please use a first name and last name and put underscore between your names. (Example: Jat_Baudelaire)");
        SetTimerEx("DelayKick", 500, false, "i", playerid);
        return 1;
    }
    
    return 1;
}

hook OnPlayerRequestClass(playerid, classid)
{
    SetSpawnInfo(playerid, NULL_ZERO, GenderSkins[0][0], 312.7469, -166.1403, 999.6010, 180.0, NULL_ZERO, NULL_ZERO, NULL_ZERO, NULL_ZERO, NULL_ZERO, NULL_ZERO);
    
    if(PlayerFirstJoin[playerid])
    {
        TogglePlayerSpectating(playerid, true);

        CallLocalFunction("OnPlayerFirstJoin", "d", playerid);
    }
}

public OnPlayerFirstJoin(playerid) 
{
    PlayerFirstJoin[playerid] = false;

    inline CheckAccount() 
    {
        TogglePlayerSpectating(playerid, false);
        if(cache_num_rows()) 
        {
            SetSpawnInfo(playerid, NULL_ZERO, GenderSkins[0][0], 294.9166, 2982.6262, 9.2347, 99.0, NULL_ZERO, NULL_ZERO, NULL_ZERO, NULL_ZERO, NULL_ZERO, NULL_ZERO);
            CallRemoteFunction("OnPlayerLogin", "d", playerid);
        } 
        else 
        {
            CallRemoteFunction("OnPlayerRegister", "d", playerid);
        }
    }
    MySQL_TQueryInline(SQL_Handle, using inline CheckAccount, "SELECT user_name FROM users WHERE user_name='%e';", GetPlayerNameEx(playerid));
}
