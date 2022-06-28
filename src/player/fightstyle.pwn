#include <YSI_Coding\y_hooks>

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_YES) 
    {
        // BUS STOP
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 300.4042,2047.2213,17.6406)) 
        {
            ShowPlayerDialog(playerid, FIGHTSTYLE_DIALOG, DIALOG_STYLE_LIST, "Fightstyle Selections", "Normal\nBoxing\nKung Fu\nKneehead\nGrab Kick\nElbow", "Select", "Close");
            return 1;
        }
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == FIGHTSTYLE_DIALOG)
    {
        if(response)
        {
            if(listitem == 0)
            {
                SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[FIGHTSTYLE INFO]: "COL_WHITE"You have changed your fighting style to default!");
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[FIGHTSTYLE GUIDE]: "COL_WHITE"To use your new fightstyle, just hold Right Mouse Button and keep clicking F consecutively!");
                return 1;
            }
            if(listitem == 1)
            {
                SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[FIGHTSTYLE INFO]: "COL_WHITE"You have changed your fighting style to Boxing!");
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[FIGHTSTYLE GUIDE]: "COL_WHITE"To use your new fightstyle, just hold Right Mouse Button and keep clicking F consecutively!");
                return 1;
            }
            if(listitem == 2)
            {
                SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[FIGHTSTYLE INFO]: "COL_WHITE"You have changed your fighting style to Kung Fu!");
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[FIGHTSTYLE GUIDE]: "COL_WHITE"To use your new fightstyle, just hold Right Mouse Button and keep clicking F consecutively!");
                return 1;
            }
            if(listitem == 3)
            {
                SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[FIGHTSTYLE INFO]: "COL_WHITE"You have changed your fighting style to Kneehead!");
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[FIGHTSTYLE GUIDE]: "COL_WHITE"To use your new fightstyle, just hold Right Mouse Button and keep clicking F consecutively!");
                return 1;
            }
            if(listitem == 4)
            {
                SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK);
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[FIGHTSTYLE INFO]: "COL_WHITE"You have changed your fighting style to Grabkick!");
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[FIGHTSTYLE GUIDE]: "COL_WHITE"To use your new fightstyle, just hold Right Mouse Button and keep clicking F consecutively!");
                return 1;
            }
            if(listitem == 5)
            {
                SetPlayerFightingStyle(playerid, FIGHT_STYLE_ELBOW);
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[FIGHTSTYLE INFO]: "COL_WHITE"You have changed your fighting style to Elbow!");
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[FIGHTSTYLE GUIDE]: "COL_WHITE"To use your new fightstyle, just hold Right Mouse Button and keep clicking F consecutively!");
                return 1;
            }
        }
        else
        {
            return 1;
        }
    }
    return 1;
}