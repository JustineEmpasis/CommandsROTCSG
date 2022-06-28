#include <YSI_Coding\y_hooks>

#define HOLDING(%0) \
    ((newkeys & (%0)) == (%0))

new starttimer[MAX_PLAYERS];
YCMD:tutorial(playerid, params[], help)
{ 
    SetPlayerPos(playerid, 1412.639892, -1.787510, 1000.924377);
    SetPlayerInterior(playerid, 1);
    SetPlayerVirtualWorld(playerid, GetPlayerBuffer(playerid));
    
    BasicsTraining(playerid);
    
    return 1;
}

forward BasicsTraining(playerid);
public BasicsTraining(playerid) 
{
    IsPlayerOnTraining[playerid] = true;
    DestroyDynamicActor(RegistrationActor[playerid]);
    DestroyDynamic3DTextLabel(RegistrationActorNameTag[playerid]);
    
    ShowPlayerDialog(playerid, PLATFORM_DIALOG, DIALOG_STYLE_MSGBOX, "Platform", "Which device are you currently using right now?", "Mobile", "Desktop");
    
    RegistrationActor[playerid] = CreateDynamicActor(73, 1410.9109, 5.1014, 1000.9255,  180.0, .worldid = GetPlayerBuffer(playerid), .interiorid = 1);
    RegistrationActorNameTag[playerid] = CreateDynamic3DTextLabel("Commanding Officer\n"COL_BEIGE"Albrent Ranido", COLOR_LIGHTGREEN, 1410.9109, 5.1014, 1000.9255, 10.0, .worldid = GetPlayerBuffer(playerid), .interiorid = 1);

    ClearChat(playerid);
    SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Welcome to the first training course, our lesson for today: "COL_LIGHTGREEN"Basic Movements 101!");

    starttimer[playerid] = SetTimerEx("StartTraining", 5000, false, "ii", playerid, MOVE_FORWARD);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    for(new i; i < 20; i++)
    {
        AwaitMovement[playerid][i] = true;
    }
    return 1;
}

new training_transition = 5000; // 5seconds
new training_time = 300000; // 5minutes
forward StartTraining(playerid, stage);
public StartTraining(playerid, stage)
{
    switch(stage)
    {
        case MOVE_FORWARD: //0 x
        {
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 1 "COL_WHITE"HOW TO MOVE FORWARD "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 0);
            CallAwaitMovement[playerid][0] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, MOVE_SIDEWARD_LEFT);
            return 1;
        }
        case MOVE_SIDEWARD_LEFT: //1 x
        {
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 2 "COL_WHITE"HOW TO FACE LEFT "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 1);
            CallAwaitMovement[playerid][1] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, MOVE_BACKWARD);
            return 1;
        }
        case MOVE_BACKWARD: //2 x
        {
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 3 "COL_WHITE"HOW TO MOVE BACKWARD "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 2);
            CallAwaitMovement[playerid][2] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, MOVE_SIDEWARD_RIGHT);
            return 1;
        }
        case MOVE_SIDEWARD_RIGHT: //3 x
        {
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 4 "COL_WHITE"HOW TO FACE RIGHT "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 3);
            CallAwaitMovement[playerid][3] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, MOVE_JUMP);
            return 1;
        }
        case MOVE_JUMP: //4 x
        {
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 5 "COL_WHITE"HOW TO JUMP "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 4);

            AwaitMovement[playerid][3] = false;
            CallAwaitMovement[playerid][4] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, MOVE_WALK);
            return 1;
        }
        case MOVE_WALK: //5 x
        {
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 6 "COL_WHITE"HOW TO WALK "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 5);

            AwaitMovement[playerid][5] = false;
            CallAwaitMovement[playerid][6] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, MOVE_CROUCH);
            return 1;
        }
        case MOVE_CROUCH: //6 x
        {
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 7 "COL_WHITE"HOW TO SNEAK "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 6);

            AwaitMovement[playerid][4] = false;
            CallAwaitMovement[playerid][5] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, HOW_TO_CHAT);
            return 1;
        }
        case HOW_TO_CHAT: //7 x
        {
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 8 "COL_WHITE"HOW TO USE THE CHATBOX "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 7);

            AwaitMovement[playerid][6] = false;
            CallAwaitMovement[playerid][7] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, HOW_TO_EXECUTE_COMMANDS);
            return 1;
        }
        case HOW_TO_EXECUTE_COMMANDS: //8 x
        {
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 9 "COL_WHITE"HOW TO EXECUTE COMMANDS "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 8);

            AwaitMovement[playerid][7] = false;
            CallAwaitMovement[playerid][8] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, HOW_TO_USE_ANIMATION);
            return 1;
        }
        case HOW_TO_USE_ANIMATION: //9 x
        {
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 10 "COL_WHITE"HOW TO EXECUTE ANIMATIONS "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 9);

            AwaitMovement[playerid][8] = false;
            CallAwaitMovement[playerid][9] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, HOW_TO_AIM);
            return 1;
        }
        case HOW_TO_AIM: //10 x
        {
            ClearChat(playerid);
            ResetPlayerWeapons(playerid);
            GivePlayerWeapon(playerid, 23, 17);
            SetWeaponTwo(playerid, 23);
            SetWeaponTwoAmmo(playerid, 17);

            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 11 "COL_WHITE"HOW TO AIM YOUR WEAPON "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 10);

            AwaitMovement[playerid][9] = false;
            CallAwaitMovement[playerid][10] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, HOW_TO_SHOOT);
            return 1;
        }
        case HOW_TO_SHOOT: //11 x
        {
            ClearChat(playerid);
            ResetPlayerWeapons(playerid);
            GivePlayerWeapon(playerid, 23, 17);
            SetWeaponTwo(playerid, 23);
            SetWeaponTwoAmmo(playerid, 17);

            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 12 "COL_WHITE"HOW TO SHOOT YOUR WEAPON "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 11);

            AwaitMovement[playerid][10] = false;
            CallAwaitMovement[playerid][11] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, HOW_TO_SEE_INVENTORY);
            return 1;
        }
        case HOW_TO_SEE_INVENTORY: //12 x
        {
            ClearChat(playerid);
            ResetPlayerWeapons(playerid);
            GivePlayerWeapon(playerid, 23, 17);
            SetWeaponTwo(playerid, 23);
            SetWeaponTwoAmmo(playerid, 17);

            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 13 "COL_WHITE"HOW TO OPEN YOUR INVENTORY "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 12);

            AwaitMovement[playerid][11] = false;
            CallAwaitMovement[playerid][12] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, HOW_TO_ENTER_DRIVER_VEHICLE);
            return 1;
        }
        case HOW_TO_ENTER_DRIVER_VEHICLE: //13 x
        {
            // 1389.2057, -21.1528, 1000.9126, 358.8925
            DemoVehicle[playerid] = CreateVehicle(400, 1389.2057, -21.1528, 1000.9126, 358.8925, 110, 110, -1);
            SetVehicleParamsEx(DemoVehicle[playerid], 0, 0, 0, 0, 0, 0, 0);

            LinkVehicleToInterior(DemoVehicle[playerid], GetPlayerInterior(playerid));
            SetVehicleVirtualWorld(DemoVehicle[playerid], GetPlayerBuffer(playerid));

            ClearChat(playerid);
            
            ResetPlayerWeapons(playerid);
            GivePlayerWeapon(playerid, 0, 0);
            SetWeaponTwo(playerid, 0);
            SetWeaponTwoAmmo(playerid, 0);
            
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 14 "COL_WHITE"HOW TO ENTER VEHICLE AS A DRIVER "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 13);

            AwaitMovement[playerid][12] = false;
            CallAwaitMovement[playerid][13] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, HOW_TO_START_ENGINE_VEHICLE);
            return 1;
        }
        case HOW_TO_START_ENGINE_VEHICLE: //14 x
        {
            ClearChat(playerid);

            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 15 "COL_WHITE"HOW TO START THE ENGINE OF THE VEHICLE "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 14);

            AwaitMovement[playerid][13] = false;
            CallAwaitMovement[playerid][14] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, HOW_TO_ENTER_PASSENGER_VEHICLE);
            return 1;
        }
        case HOW_TO_ENTER_PASSENGER_VEHICLE: //15
        {
            DestroyVehicle(DemoVehicle[playerid]);
            DemoVehicle[playerid] = CreateVehicle(400, 1389.2057, -21.1528, 1000.9126, 358.8925, 110, 110, 60);
            SetVehicleParamsEx(DemoVehicle[playerid], 0, 0, 0, 0, 0, 0, 0);
            SetVehicleVirtualWorld(DemoVehicle[playerid], GetPlayerBuffer(playerid));
            LinkVehicleToInterior(DemoVehicle[playerid], GetPlayerInterior(playerid));

            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 16 "COL_WHITE"HOW TO ENTER VEHICLE AS A PASSENGER "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 15);

            AwaitMovement[playerid][14] = false;
            CallAwaitMovement[playerid][15] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, HOW_TO_UNLOCK_VEHICLE);
            return 1;
        }
        case HOW_TO_UNLOCK_VEHICLE: //16
        {
            DestroyVehicle(DemoVehicle[playerid]);
            DemoVehicle[playerid] = CreateVehicle(400, 1389.2057, -21.1528, 1000.9126, 358.8925, 110, 110, 60);
            SetVehicleParamsEx(DemoVehicle[playerid], 0, 0, 0, 1, 0, 0, 0);
            SetVehicleVirtualWorld(DemoVehicle[playerid], GetPlayerBuffer(playerid));
            LinkVehicleToInterior(DemoVehicle[playerid], GetPlayerInterior(playerid));

            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 17 "COL_WHITE"HOW TO UNLOCK A VEHICLE "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 16);

            AwaitMovement[playerid][15] = false;
            CallAwaitMovement[playerid][16] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, HOW_TO_LOCK_VEHICLE);
            return 1;
        }
        case HOW_TO_LOCK_VEHICLE: //17
        {
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 18 "COL_WHITE"HOW TO LOCK A VEHICLE "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 17);

            AwaitMovement[playerid][16] = false;
            CallAwaitMovement[playerid][17] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, HOW_TO_REPAIR_VEHICLE);
            return 1;
        }
        case HOW_TO_REPAIR_VEHICLE: //18
        {
            DestroyVehicle(DemoVehicle[playerid]);
            DemoVehicle[playerid] = CreateVehicle(400, 1389.2057, -21.1528, 1000.9126, 358.8925, 110, 110, 60);
            SetVehicleParamsEx(DemoVehicle[playerid], 0, 0, 0, 1, 1, 0, 0);
            SetVehicleVirtualWorld(DemoVehicle[playerid], GetPlayerBuffer(playerid));
            LinkVehicleToInterior(DemoVehicle[playerid], GetPlayerInterior(playerid));

            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING 19 "COL_WHITE"HOW TO REPAIR A VEHICLE "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 18);

            AwaitMovement[playerid][17] = false;
            CallAwaitMovement[playerid][18] = SetTimerEx("StartTraining", training_time, false, "ii", playerid, TRAINING_FINISH);
            return 1;
        }
        case TRAINING_FINISH: //19
        {
            DestroyVehicle(DemoVehicle[playerid]);
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_LIGHTGREEN, "- - - - - - - - - - - - - - - - - TRAINING "COL_WHITE"COMPLETE "COL_LIGHTGREEN"- - - - - - - - - - - - - - - - -");
            SetTimerEx("statement", 2000, false, "ii", playerid, 19);

            CallAwaitMovement[playerid][19] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, TELEPORT);
        
            return 1;
        }
        case TELEPORT:
        {
            SendClientMessageEx2(playerid, COLOR_YELLOW, "\n ");
            SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Welcome to MSU-IIT, if you need help just type "COL_LIGHTGREEN"/help ...");
            SendClientMessageEx2(playerid, COLOR_WHITE, "...and if you need an assistance, just "COL_LIGHTGREEN"/requesthelp.");
            SetPlayerPos(playerid, 330.9532, 3137.2578, 2.4100);
            SetPlayerFacingAngle(playerid, 180);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, NULL_ZERO);
            SetPlayerVirtualWorld(playerid, NULL_ZERO);
            
            FreezePlayer(playerid, true, 5000);

            IsPlayerOnTraining[playerid] = false;
            for(new i = 1; i < sizeof(AwaitMovement); i++)
            {
                AwaitMovement[playerid][i] = true;
            }
            return 1;
        }
    }
    return 1;
}

forward statement(playerid, training_num);
public statement(playerid, training_num)
{
    if(training_num == 0)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"\n[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Move forward by pressing "COL_LIGHTGREEN"W");
        return 1;
    }
    if(training_num == 1)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Move to left by pressing "COL_LIGHTGREEN"A");
        return 1;
    }
    if(training_num == 2)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Move backward by pressing "COL_LIGHTGREEN"S");
        return 1;
    }
    if(training_num == 3)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Move to right by pressing "COL_LIGHTGREEN"D");
        return 1;
    }
    if(training_num == 4)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Jump by pressing "COL_LIGHTGREEN"~k~~PED_JUMPING~!");
        return 1;
    }
    if(training_num == 5)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Walk by holding "COL_LIGHTGREEN"~k~~SNEAK_ABOUT~ "COL_WHITE"and start pressing forward botton.");
        return 1;
    }
    if(training_num == 6)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Crouch by pressing "COL_LIGHTGREEN"~k~~PED_DUCK~");
        return 1;
    }
    if(training_num == 7)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"To access the chatbox, just click "COL_LIGHTGREEN"T "COL_WHITE"to open the chatbox and ...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "... type "COL_LIGHTGREEN"\"Done\" "COL_WHITE"to proceed to the next training.");
        return 1;
    }
    if(training_num == 8)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"To execute command, just click "COL_LIGHTGREEN"T "COL_WHITE"to open the chatbox and ...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "... type "COL_LIGHTGREEN"/stats "COL_WHITE"to open your character's statistics");
        return 1;
    }
    if(training_num == 9)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"To execute animations, click "COL_LIGHTGREEN"T "COL_WHITE"to open the chatbox and ...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "... type "COL_LIGHTGREEN"/animations "COL_WHITE"to see variety of animations and try to execute "COL_LIGHTGREEN"salute "COL_WHITE"...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "... under "COL_LIGHTGREEN"ROTC "COL_WHITE"animations.");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "\n ");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "\n[TRAINING TIPS]: "COL_WHITE"Type \"/animations ROTC\" to see the animation of salute.");
        return 1;
    }
    if(training_num == 10)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"I have given you a weapon. To aim your weapon, just ...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "... hold "COL_LIGHTGREEN"~k~~PED_LOCK_TARGET~ "COL_WHITE"(Right Mouse Button).");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "\n ");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[TRAINING TIPS]: "COL_WHITE"If you are not holding any weapon, try to scroll "COL_LIGHTGREEN"~k~~PED_LOOKBEHIND~ "COL_WHITE" or ...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "... click "COL_LIGHTGREEN"Q "COL_WHITE"to unholster/holster your weapons ");
        return 1;
    }
    if(training_num == 11)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"I have given you a weapon. To shoot your weapon, hold ...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "first "COL_LIGHTGREEN"~k~~PED_LOCK_TARGET~ "COL_WHITE"to aim and click "COL_LIGHTGREEN"~k~~PED_FIREWEAPON~ "COL_WHITE"(Left Mouse Button)");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "\n ");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[TRAINING TIPS]: "COL_WHITE"If you are not holding any weapon, try to scroll "COL_LIGHTGREEN"~k~~PED_LOOKBEHIND~ "COL_WHITE" or ...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "... click "COL_LIGHTGREEN"Q "COL_WHITE"to unholster/holster your weapons ");
        return 1;
    }
    if(training_num == 12)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"To open your inventory, just type "COL_LIGHTGREEN"\"/inventory\" "COL_WHITE"to open your inventory.");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "\n ");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[TRAINING TIPS]: "COL_WHITE"You can drop your item(s) anytime through the use of this command. Just type /dropweapon.");
        return 1;
    }
    if(training_num == 13)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"To enter a vehicle as a driver, just click "COL_LIGHTGREEN"~k~~VEHICLE_ENTER_EXIT~, ENTER or F...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "... to a nearby vehicle.");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "\n ");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[TRAINING TIPS]: "COL_WHITE"This is just a demo vehicle, most of the vehicles in the game are limited depending on your rank.");
        return 1;
    }
    if(training_num == 14)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"To start the engine of the vehicle, you must be on the driver seat and ...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "click "COL_LIGHTGREEN"~k~~CONVERSATION_NO~ "COL_WHITE"to utilize the modes and select "COL_LIGHTGREEN"ENGINE.");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "\n ");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[TRAINING TIPS]: "COL_WHITE"This is just a demo vehicle, most of the vehicles in the game are limited depending on your rank ...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "... including this vehicle modes.");
        return 1;
    }
    if(training_num == 15)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"To enter a vehicle as a passenger, just click "COL_LIGHTGREEN"~k~~GROUP_CONTROL_FWD~ ...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "... to a nearby vehicle.");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "\n ");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[TRAINING TIPS]: "COL_WHITE"You can only enter vehicles that are unlocked.");
        return 1;
    }
    if(training_num == 16)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"To unlock a vehicle, just click "COL_LIGHTGREEN"N ...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "... to a nearby vehicle.");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "\n ");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[TRAINING TIPS]: "COL_WHITE"You can only unlock vehicles that are designated to your rank.");
        return 1;
    }
    if(training_num == 17)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"To lock a vehicle, just click "COL_LIGHTGREEN"N "COL_WHITE"...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "... to a nearby vehicle.");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "\n ");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[TRAINING TIPS]: "COL_WHITE"You can only lock vehicles that are designated to your rank.");
        return 1;
    }
    if(training_num == 18)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"To repair a vehicle, just click "COL_LIGHTGREEN"H "COL_WHITE"...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "in front of the damage vehicle.");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "\n ");
        SendClientMessageEx2(playerid, COLOR_YELLOW, "[TRAINING TIPS]: "COL_WHITE"The hood of the vehicle must be opened before repairing the vehicle ...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "... otherwise it will return an error.");
        return 1;
    }
    if(training_num == 19)
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Very well! You've finished the basic training. You are now ready to explore ...");
        SendClientMessageEx2(playerid, COLOR_WHITE, "MSU-IIT ROTC Simulation Game, Good luck!");
        return 1;
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if( ( newkeys == KEY_JUMP ) && ( AwaitMovement[playerid][3] == false ) && ( IsPlayerOnTraining[playerid] == true) ) //4 JUMP x
    {
        AwaitMovement[playerid][3] = true;
        KillTimer( CallAwaitMovement[playerid][4] );

        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to JUMP your character! Let's proceed to the next training procedure!");
        CallAwaitMovement[playerid][4] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, MOVE_WALK);
        return 1;
    }
    if( ( newkeys == KEY_CROUCH ) && ( AwaitMovement[playerid][4] == false ) && ( IsPlayerOnTraining[playerid] == true) ) //5 CROUCH x
    {
        AwaitMovement[playerid][4] = true;
        KillTimer( CallAwaitMovement[playerid][5] );

        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to CROUCH your character! Let's proceed to the next training procedure!");
        CallAwaitMovement[playerid][5] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, HOW_TO_CHAT);
        return 1;
    }
    if( ( HOLDING( KEY_WALK ) ) && ( AwaitMovement[playerid][5] == false ) && ( IsPlayerOnTraining[playerid] == true) ) //6 WALK x
    {
        AwaitMovement[playerid][5] = true;
        KillTimer( CallAwaitMovement[playerid][6] );

        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to WALK your character! Let's proceed to the next training procedure!");
        CallAwaitMovement[playerid][6] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, MOVE_CROUCH);
        return 1;
    }
    if( ( HOLDING( 128 ) ) && ( AwaitMovement[playerid][9] == false ) && ( IsPlayerOnTraining[playerid] == true) ) //10 AIM x
    {
        AwaitMovement[playerid][9] = true;
        KillTimer( CallAwaitMovement[playerid][10] );

        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to AIM your weapon! Let's proceed to the next training procedure!");
        CallAwaitMovement[playerid][10] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, HOW_TO_SHOOT);
        return 1;
    }
    if( ( HOLDING( 128 | 4 ) ) && ( AwaitMovement[playerid][10] == false ) && ( IsPlayerOnTraining[playerid] == true) ) //11 INVENTORY x
    {
        AwaitMovement[playerid][10] = true;
        KillTimer( CallAwaitMovement[playerid][11] );

        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to SHOOT your weapon! Let's proceed to the next training procedure!");
        CallAwaitMovement[playerid][11] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, HOW_TO_SEE_INVENTORY);
        return 1;
    }
    new vehicleId = GetPlayerVehicleID(playerid);
    if ( ( newkeys == KEY_NO ) && (vehicleId == DemoVehicle[playerid]) && ( AwaitMovement[playerid][13] == false ) && ( IsPlayerOnTraining[playerid] == true) ) // 14 START ENGINE
    {
        new selection[512];
        format( selection, sizeof( selection ), "Selection\tAvailability\nEngine\t"COL_LIMEGREEN"Accessible\nLights\t"COL_LIMEGREEN"Accessible\nHood\t"COL_LIMEGREEN"Accessible\nTrunk\t"COL_LIMEGREEN"Accessible\nAlarm\t"COL_RED"Inaccessible\nLock\t"COL_RED"Inaccessible");
        ShowPlayerDialog(playerid, DEMO_VEHICLE_SELECTION_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Options", selection, "Select", "Close");
    }
    new
        Float: vehX, Float: vehY, Float: vehZ;

    GetVehiclePos(DemoVehicle[playerid], vehX, vehY, vehZ); // 16 UNLOCK
    if ( ( newkeys == KEY_NO ) && ( AwaitMovement[playerid][15] == false ) && ( IsPlayerOnTraining[playerid] == true) ) // 16 UNLOCK
    {
        DemoVehCmds(playerid, "lock");
        return 1;
    }
    if ( ( newkeys == KEY_NO ) && ( AwaitMovement[playerid][16] == false ) && ( IsPlayerOnTraining[playerid] == true) ) // 17 UNLOCK
    {
        DemoVehCmds(playerid, "lock");
        return 1;
    }

    if( ( newkeys == KEY_CTRL_BACK ) && ( AwaitMovement[playerid][17] == false ) && ( IsPlayerOnTraining[playerid] == true) ) // 18
    {
        DemoVehCmds(playerid, "repair");
        return 1;
    }

    return 1;
}

hook OnPlayerText(playerid, text[])
{
    if( (IsPlayerOnTraining[playerid] == true) ) //7 HOW TO CHAT x
    {
        if( !strcmp(text, "Done", true) )
        {
            AwaitMovement[playerid][6] = true;
            KillTimer( CallAwaitMovement[playerid][7] );

            SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to use the chatbox! Let's proceed to the next training procedure!");
            CallAwaitMovement[playerid][7] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, HOW_TO_EXECUTE_COMMANDS);

            return 1;
        }
    }
    return 0;
}

hook OnPlayerCommandText(playerid, cmdtext[])
{
    if( (IsPlayerOnTraining[playerid] == true) ) 
    {
        if( !strcmp(cmdtext, "/stats", true) && ( AwaitMovement[playerid][7] == false ) ) //8 HOW TO EXECUTE COMMANDS x
        {
            AwaitMovement[playerid][7] = true;
            KillTimer( CallAwaitMovement[playerid][8] );

            SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to execute commands! Let's proceed to the next training procedure!");
            CallAwaitMovement[playerid][8] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, HOW_TO_USE_ANIMATION);

            return 1;
        }
        if( !strcmp(cmdtext, "/salute", true) && ( AwaitMovement[playerid][8] == false ) ) //9 HOW TO EXECUTE ANIMATIONS x
        {
            AwaitMovement[playerid][8] = true;
            KillTimer( CallAwaitMovement[playerid][9] );

            SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to execute animations! Let's proceed to the next training procedure!");
            CallAwaitMovement[playerid][9] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, HOW_TO_AIM);

            return 1;
        }
        if( !strcmp(cmdtext, "/inventory", true) && ( AwaitMovement[playerid][11] == false ) ) //12 INVENTORY x
        {
            AwaitMovement[playerid][11] = true;
            KillTimer( CallAwaitMovement[playerid][12] );

            SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to open your inventory! Let's proceed to the next training procedure!");
            CallAwaitMovement[playerid][12] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, HOW_TO_ENTER_DRIVER_VEHICLE);
            
            return 1;
        }
    }
    return 0;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if ( (oldstate == PLAYER_STATE_ONFOOT) && (newstate == PLAYER_STATE_DRIVER) && ( AwaitMovement[playerid][12] == false ) && ( IsPlayerOnTraining[playerid] == true) ) //13 ENTER VEHICLE
    {
        AwaitMovement[playerid][12] = true;
        KillTimer( CallAwaitMovement[playerid][13] );

        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to enter a vehicle! Let's proceed to the next training procedure!");
        CallAwaitMovement[playerid][13] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, HOW_TO_START_ENGINE_VEHICLE);
        return 1;
    }
    if ( (oldstate == PLAYER_STATE_ONFOOT) && (newstate == PLAYER_STATE_PASSENGER) && ( AwaitMovement[playerid][14] == false ) && ( IsPlayerOnTraining[playerid] == true) ) //15 ENTER VEHICLE
    {
        AwaitMovement[playerid][14] = true;
        KillTimer( CallAwaitMovement[playerid][15] );

        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to enter a vehicle! Let's proceed to the next training procedure!");
        CallAwaitMovement[playerid][15] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, HOW_TO_UNLOCK_VEHICLE);
        return 1;
    }

    return 0;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DEMO_VEHICLE_SELECTION_DIALOG)
    {
        if(response)
        {
            if(listitem == 0) // 14 ENGINE
            {
                DemoVehCmds(playerid, "engine");
                return 1;
            }
        }
    }

    if(dialogid == PLATFORM_DIALOG) // MOBILE PLATFORM
    {
        if(response)
        {
            SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[GAME]: "COL_WHITE"Your game settings has been adjusted to Mobile platform");
            SendClientMessageEx2(playerid, COLOR_YELLOW, "\n ");
            SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_LIGHTGREEN"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Welcome to MSU-IIT, if you need help just type "COL_LIGHTGREEN"/help ...");
            SendClientMessageEx2(playerid, COLOR_WHITE, "...and if you need an assistance, just "COL_LIGHTGREEN"/requesthelp.");
            SetPlayerPos(playerid, 330.9532, 3137.2578, 2.4100);
            SetPlayerFacingAngle(playerid, 180);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, NULL_ZERO);
            SetPlayerVirtualWorld(playerid, NULL_ZERO);

            SetPlayerColor(playerid, COLOR_LIGHTBLUE);
            
            FreezePlayer(playerid, true, 5000);

            KillTimer(starttimer[playerid]);

            IsPlayerOnTraining[playerid] = false;
            for(new i = 1; i < sizeof(AwaitMovement); i++)
            {
                AwaitMovement[playerid][i] = true;
            }
            return 1;
        }
        else
        {
            SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[GAME]: "COL_WHITE"Your game settings has been adjusted to Desktop platform");
            SetPlayerColor(playerid, COLOR_LIGHTGREEN);
            return 1;
        }
    }
    return 0;
}

forward DemoVehCmds(playerid, const params[]);
public DemoVehCmds(playerid, const params[])
{
    if( !strcmp(params, "engine", true) && (IsPlayerOnTraining[playerid] == true) ) // 14 ENGINE
    {
        new
            near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective;
        new
            Float: vehX, Float: vehY, Float: vehZ;

        GetVehiclePos(DemoVehicle[playerid], vehX, vehY, vehZ);

        GetVehicleParamsEx(DemoVehicle[playerid], near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective);
        if( (!IsPlayerInVehicle(playerid, DemoVehicle[playerid]) ) )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not driving the demo vehicle.");
            return 1;
        }
        
        if(near_engine == 0)
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has turned ON the engine of the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SetVehicleParamsEx(DemoVehicle[playerid], 1, 1, near_alarm, near_doors, near_bonnet, near_boot, near_objective);
            if( AwaitMovement[playerid][13] == false )
            {
                AwaitMovement[playerid][13] = true;
                KillTimer( CallAwaitMovement[playerid][14] );

                SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to start the engine! Let's proceed to the next training procedure!");
                CallAwaitMovement[playerid][14] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, HOW_TO_ENTER_PASSENGER_VEHICLE);
            }
            return 1;
        }
        else
        {
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has turned OFF the engine of the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            SetVehicleParamsEx(DemoVehicle[playerid], 0, 0, near_alarm, near_doors, near_bonnet, near_boot, near_objective);
            return 1;
        }
    }

    if( !strcmp(params, "lock", true) && (IsPlayerOnTraining[playerid] == true) ) // LOCK 17
    {
        new
            near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective;
        new
            Float: vehX, Float: vehY, Float: vehZ;

        GetVehiclePos(DemoVehicle[playerid], vehX, vehY, vehZ);

        GetVehicleParamsEx(DemoVehicle[playerid], near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective);

        if( IsPlayerInRangeOfPoint(playerid, 3.0, vehX, vehY, vehZ) )
        {
            if(near_doors == 0)
            {
                if( AwaitMovement[playerid][16] == false ) // 17
                {
                    AwaitMovement[playerid][16] = true;
                    KillTimer( CallAwaitMovement[playerid][17] );

                    SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to lock! Let's proceed to the next training procedure!");
                    CallAwaitMovement[playerid][17] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, HOW_TO_REPAIR_VEHICLE);
                }
                SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has locked the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                SetVehicleParamsEx(DemoVehicle[playerid], near_engine, near_lights, near_alarm, 1, near_bonnet, near_boot, near_objective);
                return 1;
            }
            else
            {
                if( AwaitMovement[playerid][15] == false ) // 16
                {
                    AwaitMovement[playerid][15] = true;
                    KillTimer( CallAwaitMovement[playerid][16] );

                    SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to unlock! Let's proceed to the next training procedure!");
                    CallAwaitMovement[playerid][16] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, HOW_TO_LOCK_VEHICLE);
                }
                SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has unlocked the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
                SetVehicleParamsEx(DemoVehicle[playerid], near_engine, near_lights, near_alarm, 0, near_bonnet, near_boot, near_objective);
                return 1;
            }
        }
        else
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not near the demo vehicle.");
            return 1;
        }
    }
    if( !strcmp(params, "repair", true) && (IsPlayerOnTraining[playerid] == true) && ( AwaitMovement[playerid][17] == false ) )  // 18 REPAIR
    {
        AwaitMovement[playerid][17] = true;
        new
            near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective;
        new
            Float: vehX, Float: vehY, Float: vehZ;

        if( GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are inside the vehicle.");
            return 1;
        }

        GetVehiclePos(DemoVehicle[playerid], vehX, vehY, vehZ);

        if( !IsPlayerInRangeOfPoint(playerid, 3.0, vehX, vehY, vehZ) )
        {
            SendClientMessageEx2(playerid, COLOR_DARKERGREY, " You are not near the demo vehicle!");
            return 1;
        }

        ApplyAnimation(playerid, "BD_FIRE", "WASH_UP", 4.1, 1, 0, 0, 0, 0, 1);

        SendClientMessageEx2(playerid, COLOR_ORANGE, "[VEHICLE INFO]: "COL_WHITE"You are now repairing the vehicle, please wait 10 seconds to finish.");
        SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s is repairing the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
        IsPlayerRepairing[playerid] = true;
        SetTimerEx("EndRepairDemo", 10000, false, "ii", playerid, DemoVehicle[playerid], near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective);
        return 1;
    }
    return 1;
}

forward EndRepairDemo(playerid, nearveh, near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective);
public EndRepairDemo(playerid, nearveh, near_engine, near_lights, near_alarm, near_doors, near_bonnet, near_boot, near_objective)
{
    SetVehicleParamsEx(nearveh, near_engine, near_lights, near_alarm, near_doors, 0, near_boot, near_objective);
    IsPlayerRepairing[playerid] = false;
    ClearAnimations(playerid);
    RepairVehicle(nearveh);
    SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has repaired the vehicle. "COL_ORANGE"**", GetPlayerNameEx2(playerid));

    AwaitMovement[playerid][17] = true;
    KillTimer( CallAwaitMovement[playerid][18] );

    SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Congratulation, you learned how to repair a vehicle! Let's proceed to the next training procedure!");
    CallAwaitMovement[playerid][18] = SetTimerEx("StartTraining", training_transition, false, "ii", playerid, TRAINING_FINISH);
    return 1;
}