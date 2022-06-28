enum {
    DIMENSION_X,
    DIMENSION_Y,
    DIMENSION_Z,
    DIMENSION_A,
}

// COMMANDS.PWN
new
    bool:aduty[MAX_PLAYERS];

// REGISTRATION.PWN

new selectmusic[MAX_PLAYERS];

// DEATH.PWN
new
    bool:IsPlayerForceFreeze[MAX_PLAYERS],
    bool:IsPlayerInjured[MAX_PLAYERS],
    bool:IsPlayerReviving[MAX_PLAYERS],
    bool:IsPlayerHospitalized[MAX_PLAYERS],
    Text3D:InjuredLabel[MAX_PLAYERS];

// VEHICLE.PWN
new 
    Bus[3],
    Officer_Veh[30],
    Medic_Veh[20],
    Cadet_Veh[20],
    Admin_Veh[100],
    Admin_Veh_Num,
    Text3D:Admin_Veh_Label[100],
    bool:IsPlayerRepairing[MAX_PLAYERS];


// BASICS.PWN
enum {
    MOVE_FORWARD,                       //0 x
    MOVE_SIDEWARD_LEFT,                 //1 x
    MOVE_SIDEWARD_RIGHT,                //2 x
    MOVE_BACKWARD,                      //3 x
    MOVE_JUMP,                          //4 x
    MOVE_CROUCH,                        //5 x
    MOVE_WALK,                          //6 x
    HOW_TO_CHAT,                        //7 x
    HOW_TO_EXECUTE_COMMANDS,            //8 x
    HOW_TO_SEE_INVENTORY,               //9
    HOW_TO_USE_ANIMATION,               //10
    HOW_TO_AIM,                         //11 
    HOW_TO_SHOOT,                       //12
    HOW_TO_ENTER_DRIVER_VEHICLE,        //13 
    HOW_TO_START_ENGINE_VEHICLE,        //14 
    HOW_TO_ENTER_PASSENGER_VEHICLE,     //15 
    HOW_TO_UNLOCK_VEHICLE,              //16 
    HOW_TO_LOCK_VEHICLE,                //17 
    HOW_TO_REPAIR_VEHICLE,              //18 
    TRAINING_FINISH,                    //19
    TELEPORT                            //20
}

new
    bool:IsPlayerOnTraining[MAX_PLAYERS],
    bool:AwaitMovement[MAX_PLAYERS][21],
    DemoVehicle[MAX_PLAYERS],
    CallAwaitMovement[MAX_PLAYERS][21];


// OTHERS

Float:GetPlayerPosition(playerid, dimension){
    static Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    if(dimension == DIMENSION_X){
        return x;
    }
    else if(dimension == DIMENSION_Y){
        return y;
    }
    else if(dimension == DIMENSION_Z){
        return z;
    }
    else if(dimension == DIMENSION_A){
        return a;
    }
    
    return Float:0;
}

GetPlayerNameEx(playerid){
    static name[MAX_PLAYER_NAME+1];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME+1);
    return name;
}

GetPlayerNameEx2(playerid)
{
    static name[MAX_PLAYER_NAME+1];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME+1);

    new d = strfind(name, "_", true);

    strdel(name, d, d+1);
    strins(name, " ", d);

    return name;
}


GetPlayerIPAddress(playerid){
    static ip[MAX_STRING];
    GetPlayerIp(playerid, ip);
    return ip;
}
