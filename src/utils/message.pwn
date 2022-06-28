#define MESSAGE_SPLIT_LENGTH                135
#define MESSAGE_CLIENT                      -1
#define MESSAGE_LOCAL                       25.0

native SendClientMessageStr(playerid, color, AmxString:message) = SendClientMessage;

enum{
    MESSAGE_HELP,
    MESSAGE_USAGE,
    MESSAGE_SAMPLE,
    MESSAGE_INFO,
    MESSAGE_WARNING,
    MESSAGE_ERROR,
};

ClearChat(playerid, repeat = 20){
    for(new i = 0; i < repeat; i++) {
        SendClientMessage(playerid, -1, "");
    }
}

stock SendSplitMessage(playerid, const message[], color)
{
     static fstring[MAX_STRING];
    
     if(strlen(message) > MESSAGE_SPLIT_LENGTH)
     {
         format(fstring, MAX_STRING, "%.*s...", MESSAGE_SPLIT_LENGTH, message);
         SendClientMessage(playerid, color, fstring);
         format(fstring, MAX_STRING, "    ...%s", message[MESSAGE_SPLIT_LENGTH]);
         SendClientMessage(playerid, color, fstring);
     }
     else
     {
         SendClientMessage(playerid, color, message);
     }
     return 1;
}

SendClientMessageEx(playerid, color, Float:range, const fmat[], va_args<>){
    static message[MAX_STRING];
    va_format(message, MAX_STRING, fmat, va_start<4>);

    if(range != MESSAGE_CLIENT){
        foreach(new i : Player){
            if(GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(i))
            {
                return 1;
            }
            if(IsPlayerInRangeOfPoint(i, MESSAGE_LOCAL, GetPlayerPosition(playerid, DIMENSION_X), GetPlayerPosition(playerid, DIMENSION_Y), GetPlayerPosition(playerid, DIMENSION_Z))){
                SendClientMessage(i, color, message);
            }
        }
    }
    else{
        SendClientMessage(playerid, color, message);
    }
    return 1;
}

SendClientMessageEx2(playerid, color, const text[], {Float,_}:...)
{
    static
        args,
        str[192];

    if((args = numargs()) <= 3)
    {
        SendClientMessage(playerid, color, text);
    }
    else
    {
        while(--args >= 3)
        {
            #emit LCTRL 	5
            #emit LOAD.alt 	args
            #emit SHL.C.alt 2
            #emit ADD.C 	12
            #emit ADD
            #emit LOAD.I
            #emit PUSH.pri
        }
        #emit PUSH.S 	text
        #emit PUSH.C 	192
        #emit PUSH.C 	str
        #emit PUSH.S	8
        #emit SYSREQ.C 	format
        #emit LCTRL 	5
        #emit SCTRL 	4

        SendClientMessage(playerid, color, str);

        #emit RETN
    }
    return 1;
}
/*
SendCustomMessage(playerid, type, const fmat[], va_args<>){
    static message[MAX_STRING];
    va_format(message, MAX_STRING, fmat, va_start<3>);
    
    if(type == MESSAGE_HELP){
        return SendClientMessageStr(playerid, COLOR_PINK, str_format("HELP: "COL_WHITE"%s", message));
    }
    else if(type == MESSAGE_USAGE){
        return SendClientMessageStr(playerid, COLOR_YELLOW, str_format("USAGE: "COL_WHITE"%s", message));
    }
    else if(type == MESSAGE_SAMPLE){
        return SendClientMessageStr(playerid, COLOR_DARKCYAN, str_format("Example: "COL_WHITE"%s", message));
    }
    else if(type == MESSAGE_INFO){
        return SendClientMessageStr(playerid, COLOR_AQUA, str_format("INFO: "COL_WHITE"%s", message));
    }
    else if(type == MESSAGE_WARNING){
        return SendClientMessageStr(playerid, COLOR_ORANGE, str_format("WARNING: "COL_WHITE"%s", message));
    }
    else if(type == MESSAGE_ERROR){
        return SendClientMessageStr(playerid, COLOR_ORANGERED, str_format("ERROR: "COL_WHITE"%s", message));
    }
    return SendClientMessage(playerid, -1, message);
}

*/

SendFadingMessage(playerid, const message[], Float:range=MESSAGE_LOCAL, fade1=COLOR_WHITE, fade2=COLOR_LIGHTGREY, fade3=COLOR_DARKGREY, fade4=COLOR_GREY, fade5=COLOR_DIMGREY){
    if(range != MESSAGE_CLIENT){
        foreach(new i : Player){
            if(IsPlayerInRangeOfPoint(i, range/5, GetPlayerPosition(playerid, DIMENSION_X), GetPlayerPosition(playerid, DIMENSION_Y), GetPlayerPosition(playerid, DIMENSION_Z))){
                SendClientMessage(i, fade1, message);
            }
            else if(IsPlayerInRangeOfPoint(i, range/4, GetPlayerPosition(playerid, DIMENSION_X), GetPlayerPosition(playerid, DIMENSION_Y), GetPlayerPosition(playerid, DIMENSION_Z))){
                SendClientMessage(i, fade2, message);
            }
            else if(IsPlayerInRangeOfPoint(i, range/3, GetPlayerPosition(playerid, DIMENSION_X), GetPlayerPosition(playerid, DIMENSION_Y), GetPlayerPosition(playerid, DIMENSION_Z))){
                SendClientMessage(i, fade3, message);
            }
            else if(IsPlayerInRangeOfPoint(i, range/2, GetPlayerPosition(playerid, DIMENSION_X), GetPlayerPosition(playerid, DIMENSION_Y), GetPlayerPosition(playerid, DIMENSION_Z))){
                SendClientMessage(i, fade4, message);
            }
            else if(IsPlayerInRangeOfPoint(i, range, GetPlayerPosition(playerid, DIMENSION_X), GetPlayerPosition(playerid, DIMENSION_Y), GetPlayerPosition(playerid, DIMENSION_Z))){
                SendClientMessage(i, fade5, message);
            }
        }
    }
    return 1;
}
