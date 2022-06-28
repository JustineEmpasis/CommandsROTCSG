#include <YSI_Coding\y_hooks>

forward OnPlayerClickRegister(playerid);
forward OnPlayerHashPassword(playerid);
forward EnterCollege(playerid, dialogid, response, listitem, string:inputtext[]);

#define MAX_RESPONSE_TYPE               1

enum
{
    RESPONSE_FULL_NAME,
}

enum
{
    COLLEGE_CCS = 1,
    COLLEGE_SM,
    COLLEGE_ET,
    COLLEGE_NUR,
    COLLEGE_BAA,
    COLLEGE_ED,
    COLLEGE_ASS,
}

enum
{
    GENDER_MALE = 0,
    GENDER_FEMALE,
}

static
    TempPlayerName[MAX_PLAYERS][MAX_PLAYER_NAME],
    TempPlayerEmail[MAX_PLAYERS][64],
    TempPlayerSkin[MAX_PLAYERS][MAX_PLAYERS],
    TempPlayerGender[MAX_PLAYERS],
    TempPasswordHolder[MAX_PLAYERS][2][MAX_STRING];

new
    RegistrationActor[MAX_PLAYERS],
    Text3D:RegistrationActorNameTag[MAX_PLAYERS];

static
    bool:AwaitResponse[MAX_PLAYERS][MAX_RESPONSE_TYPE];

GetPlayerUserID(playerid)
{
    static SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT user_id FROM users WHERE user_name='%e'", GetPlayerNameEx(playerid));
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_int(0, "user_id", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

GetPlayerCollege(playerid)
{
    static SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT user_college FROM users WHERE user_id=%d", GetPlayerUserID(playerid));
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_int(0, "user_college", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

SetPlayerCollege(playerid, value)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_college=%d WHERE user_id=%d", value, GetPlayerUserID(playerid));
    mysql_tquery(SQL_Handle, SQL_Buffer);
}

GetCollegeName(collegeid)
{
    static college_name[MAX_STRING];

    switch(collegeid)
    {
        case COLLEGE_CCS: format(college_name, MAX_STRING, "College of Computer Studies");
        case COLLEGE_SM:  format(college_name, MAX_STRING, "College of Science and Mathematics");
        case COLLEGE_ET:  format(college_name, MAX_STRING, "College of Engineering and Technology");
        case COLLEGE_NUR: format(college_name, MAX_STRING, "College of Nursing");
        case COLLEGE_BAA: format(college_name, MAX_STRING, "College of Business, Accountancy, & Administration");
        case COLLEGE_ED:  format(college_name, MAX_STRING, "College of Education");
        case COLLEGE_ASS: format(college_name, MAX_STRING, "College of Art & Social Sciences");  
        default: format(college_name, MAX_STRING, "Unenrolled");
    }

    return college_name;
}

hook OnPlayerConnect(playerid)
{
    if( !IsValidName2(GetPlayerNameEx(playerid)) )
    {
        return 1;
    }
    ClearChat(playerid);
    
    AwaitResponse[playerid][RESPONSE_FULL_NAME] = false;
    TempPlayerSession[playerid] = false;
    TempPlayerGender[playerid] = GENDER_MALE;

    format(TempPlayerName[playerid][0], MAX_STRING, GetPlayerNameEx(playerid));
    format(TempPlayerEmail[playerid][0], MAX_STRING, "firstname.lastname@g.msuiit.edu.ph");
    format(TempPasswordHolder[playerid][0], MAX_STRING, "password");
    format(TempPasswordHolder[playerid][1], MAX_STRING, "confirmpassword");

    TempPlayerSkin[playerid][0] = 0;
    TempPlayerSkin[playerid][1] = GenderSkins[GENDER_FEMALE][0];
    return 1;
}

forward StartMusic(playerid);
public StartMusic(playerid)
{
    selectmusic[playerid] = random(5);

    if(selectmusic[playerid] == 0)
    {
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[MUSIC]: "COL_WHITE"Cheap Thrills by Sia ft. Sean Paul");
        PlayAudioStreamForPlayer(playerid, "https://dl19.cxco.cc/v1/youtube/download/?file_id=UG9uVVM4N1llcXc6YXVkaW86MjUxOjEyOGs6bXAz");
        return 1;
    }
    else if(selectmusic[playerid] == 1)
    {
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[MUSIC]: "COL_WHITE"Cold by NEFFEX");
        PlayAudioStreamForPlayer(playerid, "https://dl17.cxco.cc/v1/youtube/download/?file_id=V3pRQkFjOGk3M0U6YXVkaW86MjUxOjEyOGs6bXAz");
        return 1;
    }
    else if(selectmusic[playerid] == 2)
    {
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[MUSIC]: "COL_WHITE"All Time Low - Dear Maria, Count Me In");
        PlayAudioStreamForPlayer(playerid, "https://dl18.cxco.cc/v1/youtube/download/?file_id=U3o5OTNlMnVDVGc6YXVkaW86MjUxOjEyOGs6bXAz");
        return 1;
    }
    else if(selectmusic[playerid] == 3)
    {
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[MUSIC]: "COL_WHITE"Demon Slayer: Kimetsu no Yaiba Opening");
        PlayAudioStreamForPlayer(playerid, "https://dl5.cxco.cc/v1/youtube/download/?file_id=SUdXdE5xZVpNcDA6YXVkaW86MjUxOjEyOGs6bXAz");
        return 1;
    }
    else if(selectmusic[playerid] == 4)
    {
        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[MUSIC]: "COL_WHITE"GTA LCS Theme Dark March");
        PlayAudioStreamForPlayer(playerid, "https://c12.iiiijjjjij.com/xbase/eusf30.iiiijjjjij.com/xcfiles//files/2020/10/3/gta_lcs_theme_dark_march_cover_5677149291381259089.mp3");
        return 1;
    }
    return 1;
}

public OnPlayerRegister(playerid)
{
    RegistrationTD(playerid);

    TogglePlayerSpectating(playerid, true);
    TogglePlayerControllable(playerid, false);
    
    InterpolateCameraPos(playerid, 371.0125, -1645.9259, 43.4794, 377.8773, -2105.8926, 48.4593, 30000, CAMERA_CUT);
    InterpolateCameraLookAt(playerid, 371.0125, -1682.9600, 40.2754, 374.2192, -2014.0829, 7.7521, 10000, CAMERA_CUT);

    StartMusic(playerid);
    return 1;
}


hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
    if(playertextid == arrow_left[playerid])
    {
        TempPlayerSkin[playerid][0]--;
        if(TempPlayerSkin[playerid][0] == -1)
        {
            TempPlayerSkin[playerid][0] = (TempPlayerGender[playerid] == GENDER_MALE ? MAX_MALE_SKINS : MAX_FEMALE_SKINS)-1;
        }
        PlayerTextDrawHide(playerid, skin_model[playerid]);
        PlayerTextDrawSetPreviewModel(playerid, skin_model[playerid], GenderSkins[TempPlayerGender[playerid]][TempPlayerSkin[playerid][0]]);
        PlayerTextDrawShow(playerid, skin_model[playerid]);

        TempPlayerSkin[playerid][1] = GenderSkins[TempPlayerGender[playerid]][TempPlayerSkin[playerid][0]];
    }
    else if(playertextid == arrow_right[playerid])
    {
        TempPlayerSkin[playerid][0]++;
        if(TempPlayerSkin[playerid][0] == (TempPlayerGender[playerid] == GENDER_MALE ? MAX_MALE_SKINS : MAX_FEMALE_SKINS))
        {
            TempPlayerSkin[playerid][0] = 0;
        }
        PlayerTextDrawHide(playerid, skin_model[playerid]);
        PlayerTextDrawSetPreviewModel(playerid, skin_model[playerid], GenderSkins[TempPlayerGender[playerid]][TempPlayerSkin[playerid][0]]);
        PlayerTextDrawShow(playerid, skin_model[playerid]);

        TempPlayerSkin[playerid][1] = GenderSkins[TempPlayerGender[playerid]][TempPlayerSkin[playerid][0]];
    }
    else if(playertextid == name_input[playerid])
    {
        inline EnterName(response, listitem, string:inputtext[])
        {
            #pragma unused listitem
            if(response)
            {
                if( !IsValidName(inputtext) )
                {
                    SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"You have entered an invalid name! Use your first and last name and put underscore between your names. (Example: Jat_Baudelaire)");
                    return 1;
                }

                PlayerTextDrawSetString(playerid, name_input[playerid], inputtext);
                format(TempPlayerName[playerid], MAX_PLAYER_NAME+1, inputtext);
            }
        }
        Dialog_ShowCallback(playerid, using inline EnterName, DIALOG_STYLE_INPUT, "Enter your name", ""COL_WHITE"Valid name example: (Jat_Baudelaire)", "Enter", "Back");
    }
    else if(playertextid == password_input[playerid]) {
        inline EnterPassword(response, listitem, string:inputtext[]) {
            #pragma unused listitem
            if(response) {
                new string[256] = "";
                for(new i; i < strlen(inputtext); i++) {
                    strcat(string, "x");
                }
                PlayerTextDrawSetString(playerid, password_input[playerid], string);
                format(TempPasswordHolder[playerid][0], MAX_STRING, inputtext);
            }
        }
        Dialog_ShowCallback(playerid, using inline EnterPassword, DIALOG_STYLE_PASSWORD, "Enter your password", " ", "Enter", "Back");
    }
    else if(playertextid == confirm_password_input[playerid]) {
        inline EnterConfirmPassword(response, listitem, string:inputtext[]) {
            #pragma unused listitem
            if(response) {
                new string[256] = "";
                for(new i; i < strlen(inputtext); i++) {
                    strcat(string, "x");
                }
                PlayerTextDrawSetString(playerid, confirm_password_input[playerid], string);
                format(TempPasswordHolder[playerid][1], MAX_STRING, inputtext);
            }
        }
        Dialog_ShowCallback(playerid, using inline EnterConfirmPassword, DIALOG_STYLE_PASSWORD, "Confirm your password", " ", "Enter", "Back");
    }
    else if(playertextid == email_input[playerid])
    {
        inline EnterEmail(response, listitem, string:inputtext[])
        {
            #pragma unused listitem
            if(response)
            {
                if(!IsValidEmail(inputtext))
                {
                    SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"You have entered an invalid email!");
                    return 1;
                }

                format(TempPlayerEmail[playerid], 144, inputtext);
                PlayerTextDrawSetString(playerid, email_input[playerid], inputtext);
            }
        }
        
        Dialog_ShowCallback(playerid, using inline EnterEmail, DIALOG_STYLE_INPUT, "Enter your email", ""COL_WHITE"Valid email example: firstname.lastname@g.msuiit.edu.ph", "Enter", "Back");
    }
    else if(playertextid == gender_input[playerid]) {
        inline EnterGender(response, listitem, string:inputtext[]) 
        {
            #pragma unused listitem
            if(response) 
            {
                if(listitem == 0) {
                    TempPlayerGender[playerid] = GENDER_MALE;
                    TempPlayerSkin[playerid][0] = 0;
                    TempPlayerSkin[playerid][1] = GenderSkins[GENDER_MALE][0];

                    PlayerTextDrawHide(playerid, skin_model[playerid]);
                    PlayerTextDrawSetPreviewModel(playerid, skin_model[playerid], GenderSkins[GENDER_MALE][0]);
                    PlayerTextDrawShow(playerid, skin_model[playerid]);
                    
                } else if(listitem == 1) {
                    TempPlayerGender[playerid] = GENDER_FEMALE;
                    TempPlayerSkin[playerid][0] = 0;
                    TempPlayerSkin[playerid][1] = GenderSkins[GENDER_FEMALE][0];

                    PlayerTextDrawHide(playerid, skin_model[playerid]);
                    PlayerTextDrawSetPreviewModel(playerid, skin_model[playerid], GenderSkins[GENDER_FEMALE][0]);
                    PlayerTextDrawShow(playerid, skin_model[playerid]);
                }
                PlayerTextDrawSetString(playerid, gender_input[playerid], inputtext);
            }
        }

        Dialog_ShowCallback(playerid, using inline EnterGender, DIALOG_STYLE_LIST, "Enter your email", "Male\nFemale", "Enter", "Back");
    }
    else if(playertextid == register_button[playerid]) {
        if(strcmp(TempPasswordHolder[playerid][0], TempPasswordHolder[playerid][1]))
        {
            SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"The passwords doesn't match!");
            return 1;
        }

        if(!strcmp(TempPlayerEmail[playerid], "firstname.lastname@g.msuiit.edu.ph"))
        {
            SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"You have to change your email!");
            return 1;
        }
        if( !IsValidName(TempPlayerName[playerid]) )
        {
            SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: "COL_WHITE"You have entered an invalid name! Use your first and last name and put underscore between your names. (Example: Jat_Baudelaire)");
            return 1;
        }

        SetPlayerName(playerid, TempPlayerName[playerid]);

        bcrypt_hash(playerid, "OnPlayerHashPassword", TempPasswordHolder[playerid][0], BCRYPT_COST, "d", playerid);
        // SetTimerEx("OnPlayerClickRegister", 1000, false, "i", playerid);
    }
    return 1;
}

public OnPlayerHashPassword(playerid) {
    RegistrationTD(playerid, false);
    
    static HashedPass[BCRYPT_HASH_LENGTH];
    bcrypt_get_hash(HashedPass);

    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "INSERT INTO users(user_name, user_password, user_ip, email, user_rank, user_class, user_gender, user_skin, student_id, weapon_1, weapon_2, weapon_1_ammo, weapon_2_ammo, health, armor, user_muted, user_banned) VALUES('%e', '%e', '%e', '%e', %d, %d, %d, %d, 'None', 0, 0, 0, 0, 100, 0, 0, 0);", GetPlayerNameEx(playerid), HashedPass, GetPlayerIPAddress(playerid), TempPlayerEmail[playerid][0], 1, 0, TempPlayerGender[playerid], TempPlayerSkin[playerid][0]);
    
    mysql_tquery(SQL_Handle, SQL_Buffer);

    RegistrationActor[playerid] = CreateDynamicActor(73, 312.7469, -168.5933, 999.5938,  0.0, .worldid = GetPlayerBuffer(playerid), .interiorid = 6);
    RegistrationActorNameTag[playerid] = CreateDynamic3DTextLabel("Commanding Officer\n"COL_BEIGE"Albrent Ranido", COLOR_LIGHTGREEN, 312.7469, -168.5933, 999.5938, 10.0, .worldid = GetPlayerBuffer(playerid), .interiorid = 6);

    ClearChat(playerid);

    TogglePlayerSpectating(playerid, false);
    SetPlayerInterior(playerid, 6); 
    SetPlayerVirtualWorld(playerid, GetPlayerBuffer(playerid));
    SetSpawnInfo(playerid, NULL_ZERO, GenderSkins[TempPlayerGender[playerid]][TempPlayerSkin[playerid][0]], 312.7469, -166.1403, 999.6010, 180.0, NULL_ZERO, NULL_ZERO, NULL_ZERO, NULL_ZERO, NULL_ZERO, NULL_ZERO);
    SpawnPlayer(playerid);

    TempPlayerSession[playerid] = true;
    
    SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Hello there, welcome %s!", GetPlayerNameEx2(playerid));
    SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Before we proceed, I would like to ask you a few questions...");
    
    SetTimerEx("Interview", 3000, false, "ii", playerid, 1);
}

forward Interview(playerid, stage);
public Interview(playerid, stage) {
    switch(stage) {
        case 1: {
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Okay! What college are you in right now?");

            Dialog_ShowCallback(playerid, using callback EnterCollege<iiiis>, DIALOG_STYLE_LIST, "Choose a college", "College of Computer Studies\nCollege of Science and Mathematics\nCollege of Engineering and Technology\nCollege of Nursing\nCollege of Business, Accountancy, & Administration\nCollege of Education\nCollege of Art & Social Sciences", "Choose", "Back");
        }
        case 2: {
            ClearChat(playerid);
            SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"What was your student number?");

            Dialog_ShowCallback(playerid, using callback EnterStudentNum<iiiis>, DIALOG_STYLE_INPUT, "Enter student number", "Ex: 2022-6245", "Enter", "Back");
        }
    }
    return 1;
}

forward EnterCollege(playerid, dialogid, response, listitem, string:inputtext[]);
public EnterCollege(playerid, dialogid, response, listitem, string:inputtext[]) {
    if(response) 
    {
        SetPlayerCollege(playerid, listitem + 1);
        
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Oh so you're from %s, nice choice.", GetCollegeName(listitem + 1));
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Okay, let's proceed to the next question...");
        SetTimerEx("Interview", 3000, false, "ii", playerid, 2);
    } 
    else 
    {
        SendClientMessageEx2(playerid, COLOR_WHITE, ""COL_AQUA"[C.O] "COL_BEIGE"Ranido: "COL_WHITE"Sorry what was your college again?");
        Dialog_ShowCallback(playerid, using callback EnterCollege<iiiis>, DIALOG_STYLE_LIST, "Choose a college", "College of Computer Studies\nCollege of Science and Mathematics\nCollege of Engineering and Technology\nCollege of Nursing\nCollege of Business, Accountancy, & Administration\nCollege of Education\nCollege of Art & Social Sciences", "Choose", "Back");
    }
    return 1;
}

forward EnterStudentNum(playerid, dialogid, response, listitem, string:inputtext[]);
public EnterStudentNum(playerid, dialogid, response, listitem, string:inputtext[])
{
    if(response)
    {
        // STUDENT NUM
        new t[64];
        format(t, sizeof(t), "%s", inputtext);
        mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET student_id = '%s' WHERE user_id =%d", inputtext, GetPlayerUserID(playerid));

        mysql_tquery(SQL_Handle, SQL_Buffer);
        
        StopAudioStreamForPlayer(playerid);

        SetPlayerPos(playerid, 1412.639892, -1.787510, 1000.924377);
        SetPlayerInterior(playerid, 1);
        SetPlayerVirtualWorld(playerid, GetPlayerBuffer(playerid));

        CallRemoteFunction("BasicsTraining", "i", playerid);
    } else {
        Dialog_ShowCallback(playerid, using callback EnterCollege<iiiis>, DIALOG_STYLE_LIST, "Choose a college", "College of Computer Studies\nCollege of Science and Mathematics\nCollege of Engineering and Technology\nCollege of Nursing\nCollege of Business, Accountancy, & Administration\nCollege of Education\nCollege of Art & Social Sciences", "Choose", "Back");
    }
    return 1;
}