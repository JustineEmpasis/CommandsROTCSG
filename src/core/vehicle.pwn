#include <YSI_Coding\y_hooks>
#define MAX_VEHICLE 100


hook OnGameModeInit()
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(Bus[0], engine, lights, alarm, doors, bonnet, boot, objective);

    new time = 120000;
    Admin_Veh_Num = 0;

    // BUS
    Bus[0] = AddStaticVehicleEx(437, 365.1963, 3060.8320, 2.6748, 269.8214, 79, 7, time); // bus 1
    Bus[1] = AddStaticVehicleEx(437, 398.1462, 3060.4614, 2.6728, 268.3152, 87, 7, time); // bus 2
    Bus[2] = AddStaticVehicleEx(437, -89.7180, 2057.6089, 17.4505, 271.9573, 87, 7, time); // bus 3
    SetVehicleParamsEx(Bus[0], VEHICLE_PARAMS_OFF, lights, alarm, VEHICLE_PARAMS_ON, bonnet, boot, objective);
    SetVehicleParamsEx(Bus[1], VEHICLE_PARAMS_OFF, lights, alarm, VEHICLE_PARAMS_ON, bonnet, boot, objective);
    SetVehicleParamsEx(Bus[2], VEHICLE_PARAMS_OFF, lights, alarm, VEHICLE_PARAMS_ON, bonnet, boot, objective);

    // COMBAT MEDIC //
    
    // AMBULANCE
    Medic_Veh[0] = AddStaticVehicleEx(416, 12, 2026.7299, 17.6604, 90, 1, 3, time);
    Medic_Veh[1] = AddStaticVehicleEx(416, 12, 2021.7299, 17.6604, 90, 1, 3, time);
    Medic_Veh[2] = AddStaticVehicleEx(416, 12, 2016.7299, 17.6604, 90, 1, 3, time);
    Medic_Veh[3] = AddStaticVehicleEx(416, 12, 2011.7299, 17.6604, 90, 1, 3, time);
    Medic_Veh[4] = AddStaticVehicleEx(416, 12, 2006.7299, 17.6604, 90, 1, 3, time);
    Medic_Veh[5] = AddStaticVehicleEx(416, 12, 2001.7299, 17.6604, 90, 1, 3, time);
    
    // FIRE HYDRANT
    Medic_Veh[6] = AddStaticVehicleEx(407, 12, 1976.7299, 17.6604, 90, 3, 1, time);
    Medic_Veh[7] = AddStaticVehicleEx(407, 12, 1971.7299, 17.6604, 90, 3, 1, time);
    Medic_Veh[8] = AddStaticVehicleEx(407, 12, 1966.7299, 17.6604, 90, 3, 1, time);
    Medic_Veh[9] = AddStaticVehicleEx(407, 12, 1961.7299, 17.6604, 90, 3, 1, time);
    Medic_Veh[10] = AddStaticVehicleEx(407, 12, 1956.7299, 17.6604, 90, 3, 1, time);
    
    // RANCHER
    Medic_Veh[11] = AddStaticVehicleEx(554, 12, 1996.7299, 17.6604, 90, 3, 1, time);
    Medic_Veh[12] = AddStaticVehicleEx(554, 12, 1981.7299, 17.6604, 90, 3, 1, time);

    // FIRE LADDER
    Medic_Veh[13] = AddStaticVehicleEx(544, 12, 1951.7299, 17.6604, 90, 3, 1, time);

    // ADVANCED OFFICER //

    // Tank
    Officer_Veh[0] = AddStaticVehicleEx(432, 213.8300, 1857.8763, 13.0745, 0.0000, 3, 1, time);//1
    Officer_Veh[1] = AddStaticVehicleEx(432, 222.4544, 1857.8762, 13.0745, 0.0000, 3, 1, time);//2

    // Water Tank
    Officer_Veh[2] = AddStaticVehicleEx(601, 24.5140, 2023.9640, 17.4113, -90.0000, 3, 1, time);//1
    Officer_Veh[3] = AddStaticVehicleEx(601, 24.5140, 2017.9307, 17.4113, -90.0000, 3, 1, time);//2
    Officer_Veh[4] = AddStaticVehicleEx(601, 24.5140, 2011.4801, 17.4113, -90.0000, 3, 1, time);//3
    Officer_Veh[5] = AddStaticVehicleEx(601, 24.5140, 2004.7686, 17.4113, -90.0000, 3, 1, time);//4
    Officer_Veh[6] = AddStaticVehicleEx(601, 24.5140, 1997.6368, 17.4113, -90.0000, 3, 1, time);//5

    // Barracks
    Officer_Veh[7] = AddStaticVehicleEx(433, 25.2117, 1977.1456, 18.0669, -90.0000, 3, 1, time);//1
    Officer_Veh[8] = AddStaticVehicleEx(433, 25.2117, 1969.5127, 18.0669, -90.0000, 3, 1, time);//2
    Officer_Veh[9] = AddStaticVehicleEx(433, 25.2117, 1962.5509, 18.0669, -90.0000, 3, 1, time);//3
    Officer_Veh[10] = AddStaticVehicleEx(433, 25.2117, 1955.0668, 18.0669, -90.0000, 3, 1, time);//4
    Officer_Veh[11] = AddStaticVehicleEx(433, 25.2117, 1947.5829, 18.0669, -90.0000, 3, 1, time);//5

    // PATRIOT
    Officer_Veh[12] = AddStaticVehicleEx(470, 54.8241, 2027.8086, 17.4041, 90.0000, 3, 1, time);//1
    Officer_Veh[13] = AddStaticVehicleEx(470, 54.8241, 2020.8815, 17.4041, 90.0000, 3, 1, time);//2
    Officer_Veh[14] = AddStaticVehicleEx(470, 54.8241, 2013.6835, 17.4041, 90.0000, 3, 1, time);//3
    Officer_Veh[15] = AddStaticVehicleEx(470, 54.8241, 2006.5192, 17.4041, 90.0000, 3, 1, time);//4
    Officer_Veh[16] = AddStaticVehicleEx(470, 54.8241, 1999.0133, 17.4041, 90.0000, 3, 1, time);//5
    Officer_Veh[17] = AddStaticVehicleEx(470, 54.8241, 1980.4926, 17.4041, 90.0000, 3, 1, time);//6
    Officer_Veh[18] = AddStaticVehicleEx(470, 54.8241, 1973.0322, 17.4041, 90.0000, 3, 1, time);//7
    Officer_Veh[19] = AddStaticVehicleEx(470, 54.8241, 1965.0642, 17.4041, 90.0000, 3, 1, time);//8
    Officer_Veh[20] = AddStaticVehicleEx(470, 54.8241, 1957.4812, 17.4041, 90.0000, 3, 1, time);//9
    Officer_Veh[21] = AddStaticVehicleEx(470, 54.8241, 1950.0942, 17.4041, 90.0000, 3, 1, time);//10
    // CADET VEHICLES //

    // QUAD
    Cadet_Veh[0] = AddStaticVehicleEx(471, 64.0331, 2030.5259, 17.0339, -90.0000, 110, 110, time);
    Cadet_Veh[1] = AddStaticVehicleEx(471, 64.0331, 2027.6858, 17.0339, -90.0000, 110, 110, time);
    Cadet_Veh[2] = AddStaticVehicleEx(471, 64.0331, 2024.5317, 17.0339, -90.0000, 110, 110, time);
    Cadet_Veh[3] = AddStaticVehicleEx(471, 64.0331, 2020.9200, 17.0339, -90.0000, 110, 110, time);
    Cadet_Veh[4] = AddStaticVehicleEx(471, 64.0331, 2017.3849, 17.0339, -90.0000, 110, 110, time);
    Cadet_Veh[5] = AddStaticVehicleEx(471, 64.0331, 2013.7603, 17.0339, -90.0000, 110, 110, time);
    Cadet_Veh[6] = AddStaticVehicleEx(471, 64.0331, 2010.6027, 17.0339, -90.0000, 110, 110, time);
    Cadet_Veh[7] = AddStaticVehicleEx(471, 64.0331, 2006.6381, 17.0339, -90.0000, 110, 110, time);
    Cadet_Veh[8] = AddStaticVehicleEx(471, 64.0331, 1999.1112, 17.0339, -90.0000, 110, 110, time);
    Cadet_Veh[9] = AddStaticVehicleEx(471, 64.0331, 2002.9454, 17.0339, -90.0000, 110, 110, time);

    // SANCHEZ
    Cadet_Veh[10] = AddStaticVehicleEx(468, 64.1393, 1984.0304, 17.2359, -90.0000, 110, 110, time);
    Cadet_Veh[11] = AddStaticVehicleEx(468, 64.1393, 1980.5662, 17.2359, -90.0000, 110, 110, time);
    Cadet_Veh[12] = AddStaticVehicleEx(468, 64.1393, 1976.8118, 17.2359, -90.0000, 110, 110, time);
    Cadet_Veh[13] = AddStaticVehicleEx(468, 64.1393, 1972.9969, 17.2359, -90.0000, 110, 110, time);
    Cadet_Veh[14] = AddStaticVehicleEx(468, 64.1393, 1969.1759, 17.2359, -90.0000, 110, 110, time);
    Cadet_Veh[15] = AddStaticVehicleEx(468, 64.1393, 1965.2000, 17.2359, -90.0000, 110, 110, time);
    Cadet_Veh[16] = AddStaticVehicleEx(468, 64.1393, 1961.4418, 17.2359, -90.0000, 110, 110, time);
    Cadet_Veh[17] = AddStaticVehicleEx(468, 64.1393, 1957.5745, 17.2359, -90.0000, 110, 110, time);
    Cadet_Veh[18] = AddStaticVehicleEx(468, 64.1393, 1954.0062, 17.2359, -90.0000, 110, 110, time);
    Cadet_Veh[19] = AddStaticVehicleEx(468, 64.1393, 1950.2654, 17.2359, -90.0000, 110, 110, time);

    for (new i = 0; i < sizeof(Medic_Veh); i++)
    {
        SetVehicleParamsEx(Medic_Veh[i], VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, alarm, VEHICLE_PARAMS_ON, bonnet, boot, objective);
    }

    for (new i = 0; i < sizeof(Officer_Veh); i++)
    {
        SetVehicleParamsEx(Officer_Veh[i], VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, alarm, VEHICLE_PARAMS_ON, bonnet, boot, objective);
    }

    for (new i = 0; i < sizeof(Cadet_Veh); i++)
    {
        SetVehicleParamsEx(Cadet_Veh[i], VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, alarm, VEHICLE_PARAMS_OFF, bonnet, boot, objective);
    }
    
    return 1;
}

stock isVehicleOccupied(vehicleid)
{
	for(new i;i < GetMaxPlayers();++i)
	{
		if(IsPlayerConnected(i) && GetPlayerVehicleID(i) == vehicleid && GetPlayerVehicleSeat(i) == 0)
			return true;
	}
	return false;
}

PlayerNearVehicle(playerid, class)
{
    new
        Float:vehX, Float:vehY, Float:vehZ;
    
    // 0 = ELEMENT, 1-4 = OFFICER, 5 = MEDIC

    if(class == 5)
    {
        for ( new i = 0 ; i < sizeof(Medic_Veh) ; i++)
        {
            GetVehiclePos(Medic_Veh[i], vehX, vehY, vehZ);
            if( IsPlayerInRangeOfPoint(playerid, 3.0, vehX, vehY, vehZ) )
            {
                return Medic_Veh[i];
            }
        }
    }
    if(class < 5 && class != 0)
    {
        for ( new i = 0 ; i < sizeof(Officer_Veh) ; i++)
        {
            GetVehiclePos(Officer_Veh[i], vehX, vehY, vehZ);
            if( IsPlayerInRangeOfPoint(playerid, 3.0, vehX, vehY, vehZ) )
            {
                return Officer_Veh[i];
            }
            if( IsPlayerInRangeOfPoint(playerid, 3.0, vehX, vehY, vehZ) )
            {
                return Cadet_Veh[i];
            }
        }
    }

    return -1;
}

PlayerNearAnyVehicle(playerid)
{
    new
        Float:vehX, Float:vehY, Float:vehZ;

    for ( new i = 0 ; i < MAX_VEHICLE; i++)
    {
        GetVehiclePos(i, vehX, vehY, vehZ);
        if( IsPlayerInRangeOfPoint(playerid, 4.0, vehX, vehY, vehZ) )
        {
            return i;
        }

    }
    return -1;
}

bool:IsPlayerOnDesignatedVehicle(playerid)
{
    if(GetPlayerClass(playerid) == 0)
    {
        for ( new i = 0 ; i < sizeof(Cadet_Veh) ; i++)
        {
            if( GetPlayerVehicleID(playerid) == Cadet_Veh[i] )
            {
                return true;
            }
        }
    }
    if(GetPlayerClass(playerid) == 5)
    {
        for ( new i = 0 ; i < sizeof(Medic_Veh) ; i++)
        {
            if( GetPlayerVehicleID(playerid) == Medic_Veh[i] )
            {
                return true;
            }
        }
    }
    if( (GetPlayerClass(playerid) != 0) && (GetPlayerClass(playerid) < 5) )
    {
        for ( new i = 0 ; i < sizeof(Officer_Veh) ; i++)
        {
            if( GetPlayerVehicleID(playerid) == Officer_Veh[i] )
            {
                return true;
            }
        }
    }
    return false;
}

//ShowPlayerDialog(playerid, WEAPONHOLSTER_BONE_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON BONE REPLACEMENT", m, "Select", "Close");
// /car engine / lights / alarm / lock / hood / trunk / repair

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    new playerState = GetPlayerState(playerid); // Get the state

    if( (newkeys == KEY_NO) && (playerState == PLAYER_STATE_DRIVER) && ( IsPlayerOnTraining[playerid] == false ) )
    {
        new selection[512];
        // CADET
        if (GetPlayerClass(playerid) == 0)
        {
            format( selection, sizeof( selection ), "Selection\tAvailability\nEngine\t"COL_LIMEGREEN"Accessible\nLights\t"COL_LIMEGREEN"Accessible\nHood\t"COL_LIMEGREEN"Accessible\nTrunk\t"COL_LIMEGREEN"Accessible\nAlarm\t"COL_RED"Inaccessible\nLock\t"COL_RED"Inaccessible");
            ShowPlayerDialog(playerid, VEHICLE_SELECTION_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Options", selection, "Select", "Close");
        }

        // MEDIC
        if ( GetPlayerClass(playerid) == 5 && (!IsPlayerOnDesignatedVehicle(playerid)) )
        {
            format( selection, sizeof( selection ), "Selection\tAvailability\nEngine\t"COL_LIMEGREEN"Accessible\nLights\t"COL_LIMEGREEN"Accessible\nHood\t"COL_LIMEGREEN"Accessible\nTrunk\t"COL_LIMEGREEN"Accessible\nAlarm\t"COL_RED"Inaccessible\nLock\t"COL_RED"Inaccessible");
            ShowPlayerDialog(playerid, VEHICLE_SELECTION_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Options", selection, "Select", "Close");
        }
        if ( GetPlayerClass(playerid) == 5 && (IsPlayerOnDesignatedVehicle(playerid)))
        {
            format( selection, sizeof( selection ), "Selection\tAvailability\nEngine\t"COL_LIMEGREEN"Accessible\nLights\t"COL_LIMEGREEN"Accessible\nHood\t"COL_LIMEGREEN"Accessible\nTrunk\t"COL_LIMEGREEN"Accessible\nAlarm\t"COL_LIMEGREEN"Accessible\nLock\t"COL_LIMEGREEN"Accessible");
            ShowPlayerDialog(playerid, VEHICLE_SELECTION_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Options", selection, "Select", "Close");
        }

        // OFFICER
        if ( (GetPlayerClass(playerid) != 0) && (GetPlayerClass(playerid) < 5) && (!IsPlayerOnDesignatedVehicle(playerid)) )
        {
            format( selection, sizeof( selection ), "Selection\tAvailability\nEngine\t"COL_LIMEGREEN"Accessible\nLights\t"COL_LIMEGREEN"Accessible\nHood\t"COL_LIMEGREEN"Accessible\nTrunk\t"COL_LIMEGREEN"Accessible\nAlarm\t"COL_RED"Inaccessible\nLock\t"COL_RED"Inaccessible");
            ShowPlayerDialog(playerid, VEHICLE_SELECTION_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Options", selection, "Select", "Close");
        }
        if ( (GetPlayerClass(playerid) != 0) && (GetPlayerClass(playerid) < 5) && (IsPlayerOnDesignatedVehicle(playerid)) )
        {
            format( selection, sizeof( selection ), "Selection\tAvailability\nEngine\t"COL_LIMEGREEN"Accessible\nLights\t"COL_LIMEGREEN"Accessible\nHood\t"COL_LIMEGREEN"Accessible\nTrunk\t"COL_LIMEGREEN"Accessible\nAlarm\t"COL_LIMEGREEN"Accessible\nLock\t"COL_LIMEGREEN"Accessible");
            ShowPlayerDialog(playerid, VEHICLE_SELECTION_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Options", selection, "Select", "Close");
        }
        return 1;
    }
    
    if ( (newkeys == KEY_NO) && (playerState == PLAYER_STATE_ONFOOT) )
    {
        car(playerid, "lock");
        return 1;
    }

    if ( (newkeys == KEY_CTRL_BACK) && (playerState == PLAYER_STATE_ONFOOT) && PlayerNearAnyVehicle(playerid) )
    {
        car(playerid, "repair");
        return 1;
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if( dialogid == VEHICLE_SELECTION_DIALOG )
    {
        if(response)
        {
            if(listitem == 0) // Engine
            {
                car(playerid, "engine");
            }
            if(listitem == 1) // Lights
            {
                car(playerid, "lights");
            }
            if(listitem == 2) // Hood
            {
                car(playerid, "hood");
            }
            if(listitem == 3) // Trunk
            {
                car(playerid, "trunk");
            }
            if(listitem == 4) // Alarm
            {
                car(playerid, "alarm");
            }
            if(listitem == 5) // Lock
            {
                car(playerid, "lock");
            }
        }
    }
    return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    new
        engine, lights, alarm, doors, bonnet, boot, objective, vehID;

    vehID = GetPlayerVehicleID(playerid);

    GetVehicleParamsEx(vehID, engine, lights, alarm, doors, bonnet, boot, objective);

    if ( (oldstate == PLAYER_STATE_ONFOOT) && (newstate == PLAYER_STATE_DRIVER) && (GetPlayerClass(playerid) == 0) && (!IsPlayerOnDesignatedVehicle(playerid)) && ( IsPlayerOnTraining[playerid] == false ) )
    {
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[VEHICLE GUIDE]: "COL_WHITE"You are now inside the vehicle as a driver, you can utilize the vehicle by clicking "COL_YELLOW"N.");
        SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has triggered the alarm of the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
        SetVehicleParamsEx(vehID, engine, lights, 1, doors, bonnet, boot, objective);
        SetTimerEx("TurnOffAlarm", 10000, false, "iiiiiiiii", playerid, vehID, engine, lights, 0, doors, bonnet, boot, objective);
        return 1;
    }

    if ( oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER && ( IsPlayerOnTraining[playerid] == false ) )
    {
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[VEHICLE GUIDE]: "COL_WHITE"You are now inside the vehicle as a driver, you can utilize the vehicle by clicking "COL_YELLOW"N.");
        return 1;
    }
    return 1;
}

forward TurnOffAlarm(playerid, vehID, engine, lights, alarm, doors, bonnet, boot, objective);
public TurnOffAlarm(playerid, vehID, engine, lights, alarm, doors, bonnet, boot, objective)
{
    SendClientMessageEx2(playerid, COLOR_AQUA, "[VEHICLE INFO]: "COL_WHITE"The vehicle alarm has stopped.");
    SetVehicleParamsEx(vehID, engine, lights, alarm, doors, bonnet, boot, objective);
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    new
        engine, lights, alarm, doors, bonnet, boot, objective;

    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    if( IsPlayerInjured[playerid] == true )
    {
        SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[GAME]: "COL_WHITE"You died as a result of attempting to enter a vehicle while injured.");
        SetPlayerHealth(playerid, 0);
        return 1;
    }
    if( doors == 1 )
    {
        SendClientMessageEx2(playerid, COLOR_DARKERGREY, " The vehicle is locked.");
        ClearAnimations(playerid);
        return 1;
    }
    return 1;
}

// ADMIN COMMANDS

YCMD:veh(playerid, params[], help) 
{
    new
        selection[16], selection_params[256];
    new
        modelid, color1, color2;

    if( !IsPlayerMod(playerid) ) 
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
        return 1;
    }

    if( sscanf(params, "s[16]S()[256]", selection, selection_params) )
    {
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/veh [ create / destroy / respawn / repairall / respawnall ] ");
        return 1;
    }
    
    if( !strcmp(selection, "create", true) )
    {
        if(sscanf(selection_params, "iI(-1)I(-1)", modelid, color1, color2)) 
        {
            SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/veh create [modelid] [color] [color]");
            return 1;
        }

        if( modelid < 400 || modelid > 611)
        {
            SendClientMessageEx2(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You inputted wrong ID. Do not go below 400 or over 611.");
            return 1;
        }

        if( Admin_Veh_Num >= MAX_VEHICLES )
        {
            SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: "COL_WHITE"You cannot spawn a vehicle anymore.");
            return 1;
        }

        Admin_Veh[Admin_Veh_Num] = CreateVehicle(modelid, GetPlayerPosition(playerid, DIMENSION_X), GetPlayerPosition(playerid, DIMENSION_Y), GetPlayerPosition(playerid, DIMENSION_Z), GetPlayerPosition(playerid, DIMENSION_A), color1, color2, -1);
        SetVehicleParamsEx(Admin_Veh[Admin_Veh_Num], 0, 0, 0, 0, 0, 0, 0);

        new m[64];
        format(m, sizeof(m), "ADMIN VEHICLE\n(%i)", Admin_Veh[Admin_Veh_Num]);

        Admin_Veh_Label[Admin_Veh_Num] = Create3DTextLabel(m, COLOR_LIGHTBLUE, 0.0, 0.0, 0.0, 5.0, 0, 1);
        Attach3DTextLabelToVehicle(Admin_Veh_Label[Admin_Veh_Num], Admin_Veh[Admin_Veh_Num], 0.0, 0.0, 1.5);

        Admin_Veh_Num++;
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You have spawned a vehicle with model id %d!", modelid);
        return 1;
    }
    if( !strcmp(selection, "destroy", true) )
    {   
        new vehicleid;
        if( sscanf(selection_params, "i", vehicleid) ) 
        {
            SendClientMessageEx2(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/veh destroy [Vehicle ID]");  
            SendClientMessageEx2(playerid, COLOR_YELLOW, "[VEHICLE INFO]: "COL_WHITE"Use /dl to determine their vehicle ID(s).");
            return 1;
        }

        DestroyVehicle(vehicleid);
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[USAGE]: "COL_WHITE"The vehicle %d is destroyed.", vehicleid); 
        return 1;
    }
    if( !strcmp(selection, "respawn", true) )
    {   
        new vehicleid;
        if( sscanf(selection_params, "i", vehicleid) ) 
        {
            SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/veh respawn [Vehicle ID]");  
            SendClientMessageEx2(playerid, COLOR_YELLOW, "[VEHICLE INFO]: "COL_WHITE"Use /dl to determine their vehicle ID(s).");
            return 1;
        }

        SetVehicleToRespawn(vehicleid);
        return 1;
    }
    if( !strcmp(selection, "repairall", true) )
    {
        for(new i = 1, j = GetVehiclePoolSize(); i <= j; i++)
        {
            RepairVehicle(i);
        }
        foreach(new i : Player)
        {
            if(IsPlayerLoggedIn(i))
            {
                SendClientMessageEx2(i, COLOR_ORANGE, "[SERVER]: "COL_WHITE"All vehicles have been repaired.");
            }
        }
        return 1;
    }
    if( !strcmp(selection, "respawnall", true) )
    {
        new engine, lights, alarm, doors, bonnet, boot, objective;

        for(new i = GetVehiclePoolSize(); i > 0; i--)
        {
            if(isVehicleOccupied(i))
            {
                continue;
            }
            GetVehicleParamsEx(i, engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleToRespawn(i);
            
            if(GetVehicleModel(i) == 468 || GetVehicleModel(i) == 471)
            {
                continue;
            }

            SetVehicleParamsEx(i, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, alarm, VEHICLE_PARAMS_ON, bonnet, boot, objective);
        }
        foreach(new i : Player)
        {
            if(IsPlayerLoggedIn(i))
            {
                SendClientMessageEx2(i, COLOR_ORANGE, "[SERVER]: "COL_WHITE"All vehicles have been respawned.");
            }
        }
        return 1;
    }
    return 1;
}

// PLAYER COMMANDS

forward car(playerid, const params[]);
public car(playerid, const params[])
{
    new
        veh, drive;
    new
        engine, lights, alarm, doors, bonnet, boot, objective;
    new
        Float:vehX, Float:vehY, Float:vehZ;
        
    veh = GetPlayerVehicleID(playerid);
    drive = GetPlayerState(playerid);
    
    GetVehiclePos(veh, vehX, vehY, vehZ);

    GetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, boot, objective);

    if( !strcmp(params, "engine", true) )
    {
        if( drive != PLAYER_STATE_DRIVER )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not driving.");
            return 1;
        }
        if(engine == 0)
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has turned ON the engine of the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SetVehicleParamsEx(veh, 1, 1, alarm, doors, bonnet, boot, objective);
            return 1;
        }
        else
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has turned OFF the engine of the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SetVehicleParamsEx(veh, 0, 0, alarm, doors, bonnet, boot, objective);
            return 1;
        }
    }

    if( !strcmp(params, "lock", true) && (IsPlayerOnTraining[playerid] == false) )
    {
        new
            near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective;
        new 
            nearveh;

        nearveh = PlayerNearVehicle(playerid, GetPlayerClass(playerid));
        GetVehicleParamsEx(nearveh, near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective);
        if( GetPlayerClass(playerid) == 0 )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
            return 1;
        }

        if( nearveh != -1)
        {
            if(near_doors == 0)
            {
                SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has locked the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                SetVehicleParamsEx(nearveh, near_engine, near_lights, near_alarm, 1, near_bonnet, near_boot, near_objective);
                return 1;
            }
            else
            {
                SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has unlocked the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                SetVehicleParamsEx(nearveh, near_engine, near_lights, near_alarm, 0, near_bonnet, near_boot, near_objective);
                return 1;
            }
        }
        else
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not near any of your designated vehicle.");
            return 1;
        }
    }

    if( !strcmp(params, "lights", true) )
    {
        if( drive != PLAYER_STATE_DRIVER )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not driving.");
            return 1;
        }
        if(lights == 0)
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has turned ON the lights of the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SetVehicleParamsEx(veh, engine, 1, alarm, doors, bonnet, boot, objective);
            return 1;
        }
        else
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has turned OFF the lights of the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SetVehicleParamsEx(veh, engine, 0, alarm, doors, bonnet, boot, objective);
            return 1;
        }
    }
    if( !strcmp(params, "hood", true) )
    {
        if( drive != PLAYER_STATE_DRIVER )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not driving.");
            return 1;
        }
        if(bonnet == 0)
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has OPENED the hood of the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SetVehicleParamsEx(veh, engine, lights, alarm, doors, 1, boot, objective);
            return 1;
        }
        else
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has CLOSED the hood of the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SetVehicleParamsEx(veh, engine, lights, alarm, doors, 0, boot, objective);
            return 1;
        }
    }
    if( !strcmp(params, "trunk", true) ) 
    {
        if( drive != PLAYER_STATE_DRIVER )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not driving.");
            return 1;
        }
        if(boot == 0)
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has OPENED the trunk of the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, 1, objective);
            return 1;
        }
        else
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has CLOSED the trunk of the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, 0, objective);
            return 1;
        }
    }
    if( !strcmp(params, "alarm", true) ) 
    {
        if( GetPlayerClass(playerid) == 0 )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
            return 1;
        }
        if( drive != PLAYER_STATE_DRIVER )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not driving.");
            return 1;
        }
        if(alarm == 0)
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " The alarm is currently OFF.");
            return 1;
        }
        else
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has turned OFF the alarm of the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SetVehicleParamsEx(veh, engine, lights, 0, doors, bonnet, boot, objective);
            return 1;
        }
    }
    if( !strcmp(params, "repair", true) && (IsPlayerOnTraining[playerid] == false) ) 
    {
        new 
            nearveh, Float:nearveh_health;
        new
            near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective;

        if( GetPlayerClass(playerid) == 0 )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not authorized to use this command!");
            return 1;
        }
        if( drive == PLAYER_STATE_DRIVER )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are driving.");
            return 1;
        }

        // CHECK ANY NEAR VEHICLE
        nearveh = PlayerNearAnyVehicle(playerid);
        GetVehicleParamsEx(nearveh, near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective);
        GetVehicleHealth(nearveh, nearveh_health);

        if( nearveh == -1 )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not near any vehicle.");
            return 1;
        }

        if( near_bonnet != 1 )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " The hood of the vehicle is not open.");
            return 1;
        }

        if( nearveh_health == 1000 )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " The vehicle is not damaged.");
            return 1;
        }

        ApplyAnimation(playerid, "BD_FIRE", "WASH_UP", 4.1, 1, 0, 0, 0, 0, 1);

        SendClientMessageEx2(playerid, COLOR_ORANGE, "[VEHICLE INFO]: "COL_WHITE"You are now repairing the vehicle, please wait 10 seconds to finish.");
        SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s is repairing the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
        IsPlayerRepairing[playerid] = true;
        SetTimerEx("EndRepair", 10000, false, "ii", playerid, nearveh, near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective);
        return 1;
    }
    return 1;
}

forward EndRepair(playerid, nearveh, near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective);
public EndRepair(playerid, nearveh, near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective)
{
    SetVehicleParamsEx(nearveh, near_engine, near_lights, near_alarm, near_doors, 0, near_boot, near_objective);
    IsPlayerRepairing[playerid] = false;
    ClearAnimations(playerid);
    RepairVehicle(nearveh);
    SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has repaired the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
    return 1;
}