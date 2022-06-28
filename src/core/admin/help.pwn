YCMD:help(playerid, params[], help)
{
    ShowPlayerDialog(playerid, HELP_DIALOG, DIALOG_STYLE_LIST, "HELP", "Controls\nCommands\nAnimations\nRank\nClass", "Select", "Close");
    return 1;
}


new
    control[MAX_PLAYERS][15][512],
    selectionmessage[MAX_PLAYERS][2000];

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == HELP_ANIMATIONS_S_DIALOG)
    {
        if(response)
        {
            if(listitem == 0)
            {
                animations(playerid, "rotc");
                return 1;
            }
            if(listitem == 1)
            {
                animations(playerid, "military");
                return 1;
            }
            if(listitem == 2)
            {
                animations(playerid, "normal");
                return 1;
            }
        }
    }
    if(dialogid == HELP_DIALOG)
    {
        if(response)
        {
            if(listitem == 0) // CONTROLS
            {
                format(control[playerid][0], sizeof(control), "How to\tDescription\n");
                format(control[playerid][1], sizeof(control), "Walk\tHold LALT (Left Alt) and start clicking W, A, S, D contorls\n");
                format(control[playerid][2], sizeof(control), "Crouch\tClick C.\n");
                format(control[playerid][3], sizeof(control), "Sprint\tClick LSHIFT (Left Shift).\n");
                format(control[playerid][4], sizeof(control), "Jump\tClick SPACE.\n");
                format(control[playerid][5], sizeof(control), "Enter a vehicle as driver\tClick F or ENTER nearby your desired vehicle.\n");
                format(control[playerid][6], sizeof(control), "Enter a vehicle as passenger\tClick G nearby your desired vehicle.\n");
                format(control[playerid][7], sizeof(control), "Start the engine of the vehicle\tClick N while inside the vehicle as a driver.\n");
                format(control[playerid][8], sizeof(control), "Unlock/lock the vehicle\tClick N nearby your desired vehicle.\n");
                format(control[playerid][9], sizeof(control), "Fix a damaged vehicle\tClick H in front of the damaged vehicle. The trunk must be opened.\n");
                format(control[playerid][10], sizeof(control), "Use the fighting style\tHold RMB (Right Mouse Button) while clicking F consecutively.\n");
                format(control[playerid][11], sizeof(control), "Switch your weapon\tScroll your MMB (Middle Mouse Button) or click either Q or E.\n");
                format(control[playerid][12], sizeof(control), "Aim your weapon\tHold RMB (Right Mouse Button) and drag your mouse at your discretion.\n");
                format(control[playerid][13], sizeof(control), "Shoot your weapon\tHold RMB (Right Mouse Button) and click LMB (Left Mouse Button) at your discretion.\n");
                format(control[playerid][14], sizeof(control), "Roll-over\tWhile crouched, aim your weapon and press A to roll to the left or D to the right.\n");


                format(selectionmessage[playerid], sizeof(selectionmessage), "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s", control[playerid][0], control[playerid][1], control[playerid][2], control[playerid][3], control[playerid][4], control[playerid][5], control[playerid][6], control[playerid][7], control[playerid][8], control[playerid][9], control[playerid][10], control[playerid][11], control[playerid][12], control[playerid][13], control[playerid][14]);
                
                ShowPlayerDialog(playerid, HELP_CONTROL_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "HELP > CONTROLS", selectionmessage[playerid], "Close", "");
                return 1;
            }
            if(listitem == 1) // COMMANDS
            {
                format(control[playerid][0], sizeof(control), "Commands\tDescription\n");
                format(control[playerid][1], sizeof(control), "/stats\tThis will show your character's statistics.\n");
                format(control[playerid][2], sizeof(control), "/inventory\tThis will show your character's inventory.\n");
                format(control[playerid][3], sizeof(control), "/dropweapon\tThis allows you to drop your weapon.\n");
                format(control[playerid][4], sizeof(control), "/requesthelp\tThis allows you to request immediate help from the online game admin\n");
                format(control[playerid][5], sizeof(control), "/s(hout)\tThis allows you to deliver your selectionmessage in larger portion in the map that a player can read.\n");
                format(control[playerid][6], sizeof(control), "/l(ow)\tThis allows you to deliver your selectionmessage in smaller portion in the map that a player can read.\n");
                format(control[playerid][7], sizeof(control), "/me\tThis allows you to deliver your character's action in roleplay situation.\n");
                format(control[playerid][8], sizeof(control), "/do\tThis allows you to explain further your character's action in roleplay situation.\n");
                format(control[playerid][9], sizeof(control), "/animations\tThis allows you to see all the animations (ROTC, Military, Normal) in the game.\n");
                format(control[playerid][10], sizeof(control), "/fixvw\tThis allows you to fix your virtual world if you are not seeing any objects.\n");


                format(selectionmessage[playerid], sizeof(selectionmessage), "%s%s%s%s%s%s%s%s%s%s%s", control[playerid][0], control[playerid][1], control[playerid][2], control[playerid][3], control[playerid][4], control[playerid][5], control[playerid][6], control[playerid][7], control[playerid][8], control[playerid][9], control[playerid][10]);
                
                ShowPlayerDialog(playerid, HELP_COMMANDS_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "HELP > COMMANDS", selectionmessage[playerid], "Close", "");
            }
            if(listitem == 2) // ANIMATIONS
            {
                ShowPlayerDialog(playerid, HELP_ANIMATIONS_S_DIALOG, DIALOG_STYLE_LIST, "HELP > ANIMATIONS", "ROTC\nMilitary\nNormal", "Select", "Close");
                return 1;
            }
            // CLASS - giveclass team tr megaphone giveweapon
            
            // RANK - giverank
            if(listitem == 3) // RANK
            {
                if(GetPlayerRank(playerid) < 6)
                {
                    SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not a high ranking cadet to access this feature. (Rank 6+ only)");
                    return 1;
                }

                format(control[playerid][0], sizeof(control), "Commands\tDescription\n");
                format(control[playerid][1], sizeof(control), "/giverank\tThis command allows you to promote someone once.\n");
                format(control[playerid][2], sizeof(control), "/annnounce\tThis allows you to announce a message to all online players.\n");

                format(selectionmessage[playerid], sizeof(selectionmessage), "%s%s%s", control[playerid][0], control[playerid][1], control[playerid][2]);
                
                ShowPlayerDialog(playerid, HELP_RANK_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "HELP > RANK", selectionmessage[playerid], "Close", "");
                return 1;
            }
            if(listitem == 4) // CLASS
            {
                if(GetPlayerRank(playerid) == 0)
                {
                    SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are an element, you can not access this feature.");
                    return 1;
                }

                format(control[playerid][0], sizeof(control), "Commands\tDescription\n");
                format(control[playerid][1], sizeof(control), "/giveclass\tThis command allows you to give someone a class.\n");
                format(control[playerid][2], sizeof(control), "/giveweapon\tThis allows you to give your weapon to someone.\n");
                format(control[playerid][3], sizeof(control), "/team\tThis command allows you to utilize a team management.\n");
                format(control[playerid][4], sizeof(control), "/tr\tThis allows you to communicate your team radio.\n");
                format(control[playerid][5], sizeof(control), "/m(egaphone)\tThis allows you to deliver a message larger portion in your area.\n");
                format(control[playerid][6], sizeof(control), "/revive\t(Medic Only) This allows you to revive an injured player.\n");
                format(control[playerid][7], sizeof(control), "/heal\t(Medic Only) This allows you to heal someone.\n");

                format(selectionmessage[playerid], sizeof(selectionmessage), "%s%s%s%s%s%s%s%s", control[playerid][0], control[playerid][1], control[playerid][2], control[playerid][3], control[playerid][4], control[playerid][5], control[playerid][6], control[playerid][7]);
                
                ShowPlayerDialog(playerid, HELP_CLASS_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "HELP > CLASS", selectionmessage[playerid], "Close", "");
                return 1;
            }
            return 1;
        }
    }
    return 1;
}