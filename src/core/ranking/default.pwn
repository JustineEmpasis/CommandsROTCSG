#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid) {
    
    return 1;
}

new RankName[][][] = {
    {"I", "Cadet Private", "(PVT)"},
    {"II", "Cadet First Sergeant", "(1SG)"},
    {"III", "Cadet Second Lieutenant", "(2LT)"},
    {"IV", "Cadet First Lieutenant", "(1LT)"},
    {"V", "Cadet Captain", "(CPT)"},
    {"VI", "Cadet Major", "(MAJ)"},
    {"VII", "Cadet Lieutenant Colonel", "(LTC)"},
    {"VIII", "Cadet Colonel", "(COL)"}
};

YCMD:giveclass(playerid, params[], help)
{
    if( (GetPlayerClass(playerid) != 1) && (GetPlayerRank(playerid) != 8) )
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You are not authorized to use this command!");
        return 1;
    }

    new
        targetid,
        class;

    if(sscanf(params, "ui", targetid, class)) {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/giveclass [playerid] [class]");
        return 1;
    }

    if(!IsPlayerLoggedIn(targetid)) {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"That player has not yet logged in or not connected!");
        return 1;
    }

    if(class == 0)
    {
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You removed the class from %s", GetPlayerNameEx2(targetid));
        SendClientMessageEx2(targetid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"Your class has been removed.");
        mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_class = %d", class);
        mysql_tquery(SQL_Handle, SQL_Buffer);
        return 1;
    }

    if(!IsInBetween(class, 1, 5)) {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"Invalid class!");
        return 1;
    }

    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_class = %d WHERE user_id = %d", class, GetPlayerUserID(targetid));
    mysql_tquery(SQL_Handle, SQL_Buffer);

    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You have made %s a class %d", GetPlayerNameEx2(targetid), class);
    SendClientMessageEx2(targetid, COLOR_AQUA, "[INFO]: "COL_WHITE"You were given class %d. Type [/stats] to update your status bar.", class);
    //new classtext[12];
    //format(classtext, sizeof(classtext), '%d', class);
    //UpdateDynamic3DTextLabelText(STREAMER_TAG_3D_TEXT_LABEL:targetid, COLOR_YELLOW, classtext);
    return 1;
}

YCMD:giverank(playerid, params[], help)
{
    if( GetPlayerRank(playerid) < 6 )
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }
    
    new
        targetid, value;

    if(sscanf(params, "ui", targetid, value))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/giverank [targetid] [rank]");
        return 1;
    }

    if(!IsPlayerLoggedIn(targetid)) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target player has not yet logged in!");
        return 1;
    }

    if(GetPlayerRank(playerid) >= 8) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " The target is at the highest rank already!");
        return 1;
    }

    if(GetPlayerRank(playerid) <= value)
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You cannot give someone a rank that is higher to your own rank.");
        return 1;
    }

    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_rank = %d WHERE user_id = %d", value, GetPlayerUserID(targetid));
    mysql_tquery(SQL_Handle, SQL_Buffer);
    
    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[RANK INFO]: "COL_WHITE"You have given a rank to "COL_AQUA"%s a "COL_ORANGE"%s.", GetPlayerNameEx2(targetid), RankName[GetPlayerRank(playerid)][0], RankName[GetPlayerRank(playerid)][1]);
    if( GetPlayerRank(targetid) > value)
    {
        SendClientMessageEx2(targetid, COLOR_AQUA, "[RANK INFO]: "COL_WHITE"You have been demoted by %s. Type [/stats] to update your status bar.", GetPlayerNameEx2(playerid));
        return 1;
    }
    SendClientMessageEx2(targetid, COLOR_AQUA, "[RANK INFO]: "COL_WHITE"You have been promoted by %s. Type [/stats] to update your status bar.", GetPlayerNameEx2(playerid));
    return 1;
}