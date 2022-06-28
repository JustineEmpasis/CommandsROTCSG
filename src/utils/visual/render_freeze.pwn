#include <YSI_Coding\y_hooks>

new
    bool:TogglePlayerFreeze[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    TogglePlayerFreeze[playerid] = false;
    return 1;
}

FreezePlayer(playerid, bool:temp=false, timer=1000)
{
    if(temp)
    {
        TogglePlayerControllable(playerid, false);
        SetTimerEx("EndFreeze", timer, false, "i", playerid);
    }
    else
    {
        if(TogglePlayerFreeze[playerid])
        {
            TogglePlayerControllable(playerid, true);
            TogglePlayerFreeze[playerid] = false;
        }
        else
        {
            TogglePlayerControllable(playerid, false);
            TogglePlayerFreeze[playerid] = true;
        }
    }
}

forward EndFreeze(playerid);
public EndFreeze(playerid)
{
    TogglePlayerControllable(playerid, true);
}

YCMD:freezeme(playerid, params[], help) {
    FreezePlayer(playerid);
    return 1;
}
