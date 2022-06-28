// 2930, 226.42210, 1872.35889, 15.40000 RIGHT CLOSE
// 2930, 226.42210, 1871.2789, 15.40000 RIGHT OPEN

// 2930, 226.42210, 1874.08008, 15.40000 LEFT CLOSE
// 2930, 226.42210, 1875.1601, 15.40000 LEFT OPEN


#include <YSI_Coding\y_hooks>

new
    gate[10],
    bool:gateMove[10];

public OnGameModeInit()
{
    // MEDIC BIOMETRICS
    CreateDynamicObject(19273, 168.4658, -85.2679, 979.9879, 0.0000, 0.0000, 180.0000);
    CreateDynamicObject(19273, 170.6971, -85.3371, 979.9879, 0.0000, 0.0000, 0.0000);
    CreateDynamicObject(19273, 167.9713, -77.9128, 979.9879, 0.0000, 0.0000, 90.0000);
    CreateDynamicObject(19273, 167.8816, -75.9470, 979.9879, 0.0000, 0.0000, -90.0000);

    // ADVANCED OFFICER BIOMETRICS
    CreateDynamicObject(19273, 228.43890, 1870.90369, 14.21640,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(19273, 225.33380, 1873.79834, 14.21640,   0.00000, 0.00000, 0.00000);

    CreateDynamic3DTextLabel("Barracks\n"COL_WHITE"click {FFFF00}Y{FFFFFF} to open", COLOR_YELLOW, 225.3481,1873.2865,13.7344, 1.0);
    CreateDynamic3DTextLabel(""COL_WHITE"click {FFFF00}Y{FFFFFF} to open", COLOR_YELLOW, 228.5076,1871.3811,13.7344, 1.0);

    CreateDynamic3DTextLabel("Medic Room\n"COL_WHITE"click {FFFF00}Y{FFFFFF} to open", COLOR_YELLOW, 170.6896, -85.7445, 979.5447, 0.5);
    CreateDynamic3DTextLabel("Exit Gate\n"COL_WHITE"click {FFFF00}Y{FFFFFF} to open", COLOR_YELLOW, 168.4495, -84.8717, 979.5447, 0.5);
    CreateDynamic3DTextLabel("Medic Room\n"COL_WHITE"click {FFFF00}Y{FFFFFF} to open", COLOR_YELLOW, 167.5024, -75.9550,979.5447, 0.5);
    CreateDynamic3DTextLabel("Exit Gate\n"COL_WHITE"click {FFFF00}Y{FFFFFF} to open", COLOR_YELLOW, 168.3749, -77.8933, 979.5520, 0.5);

    gate[0] = CreateDynamicObject(2930, 226.42210, 1872.35889, 15.40000, 0, 0, 0); // RIGHT
    gate[1] = CreateDynamicObject(2930, 226.42210, 1874.08008, 15.40000, 0, 0, 0); // LEFT

    gate[2] = CreateDynamicObject(1569, 168.8450, -85.3277, 978.5043, 0, 0, 0); // RIGHT
    gate[3] = CreateDynamicObject(1569, 167.9385, -77.7000, 978.5201, 0, 0, 90.0000); // LEFT

    gateMove[0] = false;
    gateMove[1] = false;
    gateMove[2] = false;
    gateMove[3] = false;
    return 1;
}

forward ReturnObjectAO(objectone, objecttwo);
public ReturnObjectAO(objectone, objecttwo)
{
    MoveDynamicObject(objectone, 226.42210, 1872.35889, 15.40000, 2.00);
    MoveDynamicObject(objecttwo, 226.42210, 1874.08008, 15.40000, 2.00);
    gateMove[0] = false;
    gateMove[1] = false;
    return 1;
}

forward ReturnObjectMedic(gateID, door);
public ReturnObjectMedic(gateID, door)
{
    if(door == 2)
    {
        MoveDynamicObject(gateID, 168.8450, -85.3277, 978.5043, 2.00);
        gateMove[2] = false;
        return 1;
    }
    if(door == 3)
    {
        MoveDynamicObject(gateID, 167.9385, -77.7000, 978.5201, 2.00);
        gateMove[3] = false;
        return 1;
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_YES) 
    {
        if( IsPlayerInRangeOfPoint(playerid, 0.5, 225.3167,1873.4076,13.7344) || IsPlayerInRangeOfPoint(playerid, 0.5, 228.5076,1871.3811,13.7344) ) // AO ENTRANCE AND EXIT
        {
            if( (gateMove[0] == true && gateMove[0] == true) )
            {
                SendClientMessage(playerid, COLOR_DARKERGREY, " The door is already open.");
                return 1;
            }

            if ( IsPlayerInRangeOfPoint(playerid, 0.5, 225.3167,1873.4076,13.7344) )
            {
                SetPlayerFacingAngle(playerid, 358.2725);
            }
            if ( IsPlayerInRangeOfPoint(playerid, 0.5, 228.5076,1871.3811,13.7344) )
            {
                SetPlayerFacingAngle(playerid, 180.7451);
            }

            ApplyAnimation(playerid, "HEIST9", "USE_SWIPECARD", 4.1, 0, 0, 0, 0, 0, 1);

            if( (GetPlayerClass(playerid) == 0) || (GetPlayerClass(playerid) == 5))
            {
                SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this biometric.");
                return 1;
            }

            MoveDynamicObject(gate[0], 226.42210, 1871.2789, 15.40000, 2.00);
            MoveDynamicObject(gate[1], 226.42210, 1875.1601, 15.40000, 2.00);
            gateMove[0] = true;
            gateMove[1] = true;

            SetTimerEx("ReturnObjectAO", 3000, false, "ii", gate[0], gate[1]);

            return 1;
        }
        if( IsPlayerInRangeOfPoint(playerid, 0.5, 170.6896, -85.7445, 979.5447) || IsPlayerInRangeOfPoint(playerid, 0.5, 168.4495, -84.8717, 979.5447) ) // MEDIC DOOR 1 & 2
        {
            if( (gateMove[2] == true) )
            {
                SendClientMessage(playerid, COLOR_DARKERGREY, " The door is already open.");
                return 1;
            }

            if ( IsPlayerInRangeOfPoint(playerid, 0.5, 170.6896, -85.7445, 979.5447) )
            {
                SetPlayerFacingAngle(playerid, 360);
            }
            if ( IsPlayerInRangeOfPoint(playerid, 0.5, 168.4495, -84.8717, 979.5447) )
            {
                SetPlayerFacingAngle(playerid, 180);
            }

            ApplyAnimation(playerid, "HEIST9", "USE_SWIPECARD", 4.1, 0, 0, 0, 0, 0, 1);

            if( (GetPlayerClass(playerid) == 0) || (GetPlayerClass(playerid) < 5))
            {
                SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this biometric.");
                return 1;
            }

            MoveDynamicObject(gate[2], 167.8490, -85.3277, 978.5043, 2.00);
            gateMove[2] = true;

            SetTimerEx("ReturnObjectMedic", 3000, false, "ii", gate[2], 2);
            return 1;
        }
        if( IsPlayerInRangeOfPoint(playerid, 0.5, 167.5024, -75.9550, 979.5447) || IsPlayerInRangeOfPoint(playerid, 0.5, 168.3749, -77.8933, 979.5520) ) // MEDIC DOOR 1 & 2
        {
            if( (gateMove[3] == true) )
            {
                SendClientMessage(playerid, COLOR_DARKERGREY, " The door is already open.");
                return 1;
            }

            if ( IsPlayerInRangeOfPoint(playerid, 0.5, 167.5024, -75.9550, 979.5447) )
            {
                SetPlayerFacingAngle(playerid, 270);
            }
            if ( IsPlayerInRangeOfPoint(playerid, 0.5, 168.3749, -77.8933, 979.5520) )
            {
                SetPlayerFacingAngle(playerid, 90);
            }

            ApplyAnimation(playerid, "HEIST9", "USE_SWIPECARD", 4.1, 0, 0, 0, 0, 0, 1);

            if( (GetPlayerClass(playerid) == 0) || (GetPlayerClass(playerid) < 5))
            {
                SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this biometric.");
                return 1;
            }

            MoveDynamicObject(gate[3], 167.9385, -78.7600, 978.52013, 2.00);
            gateMove[3] = true;

            SetTimerEx("ReturnObjectMedic", 3000, false, "ii", gate[3], 3);
            return 1;
        }
    }
    
    return 1;
}