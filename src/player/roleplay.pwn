
#include <YSI_Coding\y_hooks>

hook OnPlayerText(playerid, text[]){
    SetPlayerChatBubble(playerid, text, 0xFFFFFFFF, 10.0, 5000);
    new
        message[256];

    format(message, 256, " "COL_BEIGE"%s: "COL_WHITE"%s", GetPlayerNameEx2(playerid), text);
    SendFadingMessage(playerid, message);
    return 0;
}

YCMD:l(playerid, params[], help) = low;

YCMD:low(playerid, params[], help){
    new
        message[256],
        fstring[256];

    if(sscanf(params, "s[256]", message)){
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/l [message].");
        return 1;
    }

    format(fstring, 256, " %s (low): %s", GetPlayerNameEx2(playerid), message);
    SendFadingMessage(playerid, fstring, MESSAGE_LOCAL/2);

    return 1;
}

YCMD:s(playerid, params[], help) = shout;

YCMD:shout(playerid, params[], help){
    new
        message[256],
        fstring[256];

    if(sscanf(params, "s[256]", message)){
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/shout [message].");
        return 1;
    }

    format(fstring, 256, " %s (shout): %s", GetPlayerNameEx2(playerid), message);
    SendFadingMessage(playerid, fstring, MESSAGE_LOCAL*1.5);

    return 1;
}

YCMD:b(playerid, params[], help) = ooc;

YCMD:ooc(playerid, params[], help){
    new
        message[256];

    if(sscanf(params, "s[256]", message)){
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/ooc [message].");
        return 1;
    }

    SendClientMessageEx(playerid, COLOR_CADETBLUE, MESSAGE_LOCAL, " (( %s: %s ))", GetPlayerNameEx2(playerid), message);

    return 1;
}

YCMD:global(playerid, params[], help)
{
    if(!IsGlobalToggled && !IsPlayerMod(playerid))
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"The global chat is toggled off by an admin!");
        return 1;
    }
    
    new
        message[256];

    if(sscanf(params, "s[256]", message))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/global [message]");
        return 1;
    }

    foreach(new i : Player)
    {
        if(IsPlayerLoggedIn(i))
        {
            if(strlen(message) > MESSAGE_SPLIT_LENGTH)
            {
                SendClientMessageEx2(i, COLOR_WHITE, "(( "COL_ORANGE"%s: "COL_WHITE"%.*s... "COL_WHITE"))", GetPlayerNameEx2(playerid), MESSAGE_SPLIT_LENGTH, message);
                SendClientMessageEx2(i, COLOR_WHITE, "(( "COL_ORANGE"%s: "COL_WHITE"...%s "COL_WHITE"))", GetPlayerNameEx2(playerid), message[MESSAGE_SPLIT_LENGTH]);
            }
            else
            {
                SendClientMessageEx2(i, COLOR_WHITE, "(( "COL_ORANGE"%s: "COL_WHITE"%s "COL_WHITE"))", GetPlayerNameEx2(playerid), message);
            }
        }
    }
    return 1;
}

YCMD:me(playerid, params[], help) = i;

YCMD:i(playerid, params[], help){
    static
        action[256];

    if(sscanf(params, "s[256]", action)){
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/i [action].");
        return 1;
    }
    
    SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  ** %s %s **", GetPlayerNameEx2(playerid), action);
    
    return 1;
}

YCMD:do(playerid, params[], help){
    static
        description[256];

    if(sscanf(params, "s[256]", description)){
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/do [description].");
        return 1;
    }
    
    SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  ** %s (( %s )) **", description, GetPlayerNameEx2(playerid));

    return 1;
}