#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
    CreateDynamic3DTextLabel("Bus Stop\nDestination: "COL_WHITE"Training Grounds\n"COL_WHITE"Press {FFFF00}Y "COL_WHITE"to travel", COLOR_YELLOW, 381.7274, 3076.2734, 2.4159, 10.0);
    CreateDynamic3DTextLabel("Bus Stop\nDestination: "COL_WHITE"MSU-IIT\n"COL_WHITE"Press {FFFF00}Y "COL_WHITE"to travel", COLOR_YELLOW, -51.6477, 2067.8733, 17.4453, 10.0);

    CreateDynamicPickup(1239, 1, 381.7274, 3076.2734, 2.4159);
    CreateDynamicPickup(1239, 1, -51.6477, 2067.8733, 17.4453);

    // BARRACKS
    CreateDynamic3DTextLabel("Uniform Area\n"COL_WHITE"Click {32CD32}Y{FFFFFF} to access", COLOR_LIMEGREEN, 262.2280, 1857.1425, 8.7578, 3.0);
    CreateDynamic3DTextLabel("Weapon Area\n"COL_WHITE"Click {32CD32}Y{FFFFFF} to access", COLOR_LIMEGREEN, 259.9224, 1852.4286, 8.7578, 3.0);
    CreateDynamic3DTextLabel("Ammunation Area\n"COL_WHITE"Click {32CD32}Y{FFFFFF} to access", COLOR_LIMEGREEN, 258.8970, 1866.6219, 8.7578, 3.0);

    // CADET BUILDING
    CreateDynamic3DTextLabel("Ax Cadet Building\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to enter", COLOR_YELLOW, 317.5399,1927.7338,17.6406, 10.0);
    CreateDynamicPickup(1318, 1, 317.5399,1927.7338,17.6406);

    // AX LOBBY
    CreateDynamic3DTextLabel("Sleeping Room\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to enter", COLOR_YELLOW, 238.8854,182.6869,1203.0300, 3.0);// DONE
    CreateDynamic3DTextLabel("Cafeteria\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to enter", COLOR_YELLOW, 228.8093,151.2396,1203.0234, 3.0);// DONE
    CreateDynamic3DTextLabel("Meeting Room\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to enter", COLOR_YELLOW, 228.7924,161.2749,1203.0234, 3.0);// DONE
    CreateDynamic3DTextLabel("Training Ground\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to exit", COLOR_YELLOW, 238.6489,138.6741,1203.0234, 3.0);// DONE

    // AX SLEEPING ROOM
    CreateDynamic3DTextLabel("Lobby\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to enter", COLOR_YELLOW, 296.6336,188.6885,1027.1719, 3.0); // DONE

    // AX CADET ROOM
    CreateDynamic3DTextLabel("Lobby\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to enter", COLOR_YELLOW, 207.6883,-111.2324,1025.1328, 3.0); // DONE
    CreateDynamic3DTextLabel("Office\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to enter", COLOR_YELLOW, 212.4481,-96.6825,1025.2578, 3.0);// DONE

    // AX CADET OFFICE
    CreateDynamic3DTextLabel("Meeting Room\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to enter", COLOR_YELLOW, 366.5168,197.0463,1028.3828, 3.0); // DONE

    // AX CAFETERIA
    CreateDynamic3DTextLabel("Lobby\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to enter", COLOR_YELLOW, 460.5459,-88.7052,1049.5547, 3.0); // DONE

    // AX LOCKER
    CreateDynamic3DTextLabel("Cadet Locker\n"COL_WHITE"Click {32CD32}Y{FFFFFF} to access", COLOR_LIMEGREEN, 217.4364,-97.7477,1025.2578, 3.0);

    // HOSPITAL
    CreateDynamic3DTextLabel("Medic Locker\n"COL_WHITE"Type {32CD32}Y{FFFFFF} to access", COLOR_LIMEGREEN, 181.0148,-88.7169,979.7635, 3.0); // LOCKER
    CreateDynamic3DTextLabel("All-Saint General Hospital\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to enter", COLOR_YELLOW, 73.0285,2096.7178,19.6465, 10.0);
    CreateDynamic3DTextLabel("Training Ground\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to exit", COLOR_YELLOW, 161.4321,-93.4414,979.5447, 5.0);
    CreateDynamic3DTextLabel("Meeting Office\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to enter", COLOR_YELLOW, 181.4259,-83.7146,979.7635, 5.0);
    CreateDynamic3DTextLabel("All-Saint General Hospital\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to exit", COLOR_YELLOW, 364.6743,187.8716,1039.9844, 3.0);

    CreateDynamicPickup(1318, 1, 73.0285,2096.7178,19.6465); // AS HOSPITAL

    // CHANGE FIGHT STYLE LOCATION
    CreateDynamic3DTextLabel("Fightstyle\n"COL_WHITE"Click {FFFF00}Y{FFFFFF} to train", COLOR_YELLOW, 300.4042,2047.2213,17.6406, 5.0);

    // /camera
    CreateDynamic3DTextLabel("Surveillance Camera\n"COL_WHITE"Click {32CD32}Y{FFFFFF} to access", COLOR_LIMEGREEN, 248.6850, 1859.5487, 14.0840, 3.0);
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    new time = 3000;
    if(newkeys == KEY_YES) 
    {
        // BUS STOP
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 381.7274, 3076.2734, 2.4159)) 
        {
            SetPlayerPos(playerid, -52.0175, 2062.1865, 17.4453);
            SetPlayerFacingAngle(playerid, 270.0);
            FreezePlayer(playerid, true, 3000);
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 5.0, -51.6477, 2067.8733, 17.4453)) 
        {
            SetPlayerPos(playerid, 381.7274, 3076.2734, 2.4159);
            FreezePlayer(playerid, true, time);
            return 1;
        }

        // TRAINING GROUND HOSPITAL
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 73.0285,2096.7178,19.6465)) 
        {
            SetPlayerPos(playerid, 161.4321,-93.4414,979.5447);
            FreezePlayer(playerid, true, time);
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 161.4321,-93.4414,979.5447)) 
        {
            SetPlayerPos(playerid, 73.0285,2096.7178,19.6465);
            FreezePlayer(playerid, true, time);
            return 1;
        }

        // TRAINING GROUND HOSPITAL
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 73.0285,2096.7178,19.6465)) 
        {
            SetPlayerPos(playerid, 161.4321,-93.4414,979.5447);
            FreezePlayer(playerid, true, time);
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 161.4321,-93.4414,979.5447)) 
        {
            SetPlayerPos(playerid, 73.0285,2096.7178,19.6465);
            FreezePlayer(playerid, true, time);
            return 1;
        }
        
        // FROM HOSPITAL TO OFFICE
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 181.4259,-83.7146,979.7635)) 
        {
            SetPlayerPos(playerid, 364.6743,187.8716,1039.9844);
            FreezePlayer(playerid, true, time);
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 364.6743,187.8716,1039.9844)) 
        {
            SetPlayerPos(playerid, 181.4259,-83.7146,979.7635);
            FreezePlayer(playerid, true, time);
            return 1;
        }
        
        // FROM TRAINIG GROUND TO LOBBY
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 317.0016, 1927.7322, 17.6406))
        {
            SetPlayerPos(playerid, 238.6489,138.6741,1203.0234);
            FreezePlayer(playerid, true, time);
            return 1;
        }

        if(IsPlayerInRangeOfPoint(playerid, 1.0, 238.6489,138.6741,1203.0234))
        {
            SetPlayerPos(playerid, 317.0016, 1927.7322, 17.6406);
            FreezePlayer(playerid, true, time);
            return 1;
        }

        // FROM LOBBY TO CAFETERIA
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 228.8093,151.2396,1203.0234))
        {
            SetPlayerPos(playerid, 460.5459,-88.7052,1049.5547);
            FreezePlayer(playerid, true, time);
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 460.5459,-88.7052,1049.5547))
        {
            SetPlayerPos(playerid, 228.8093,151.2396,1203.0234);
            FreezePlayer(playerid, true, time);
            return 1;
        }

        // FROM LOBBY TO MEETING ROOM
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 228.7924,161.2749,1203.0234))
        {
            SetPlayerPos(playerid, 207.6883,-111.2324,1025.1328);
            FreezePlayer(playerid, true, time);
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 207.6883,-111.2324,1025.1328))
        {
            SetPlayerPos(playerid, 228.7924,161.2749,1203.0234);
            FreezePlayer(playerid, true, time);
            return 1;
        }

        // FROM MEETING ROOM TO OFFICE
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 212.4481,-96.6825,1025.2578))
        {
            SetPlayerPos(playerid, 366.5168,197.0463,1028.3828);
            FreezePlayer(playerid, true, time);
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 366.5168,197.0463,1028.3828))
        {
            SetPlayerPos(playerid, 212.4481,-96.6825,1025.2578);
            FreezePlayer(playerid, true, time);
            return 1;
        }

        // FROM LOBBY TO SLEEPING ROOM
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 238.8854,182.6869,1203.0300))
        {
            SetPlayerPos(playerid, 296.6336,188.6885,1027.1719);
            FreezePlayer(playerid, true, time);
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 296.6336,188.6885,1027.1719))
        {
            SetPlayerPos(playerid, 238.8854,182.6869,1203.0300);
            FreezePlayer(playerid, true, time);
            return 1;
        }

    }
    return 1;
}