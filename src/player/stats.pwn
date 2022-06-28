#include <YSI_Coding\y_hooks>

IsPlayerLoggedIn(playerid) {
    return TempPlayerSession[playerid];
}

new
    cur_name[MAX_PLAYERS][64],
    cur_gender[MAX_PLAYERS][64],
    cur_studentid[MAX_PLAYERS][64],
    cur_college[MAX_PLAYERS][64],
    cur_email[MAX_PLAYERS][64],
    cur_rank[MAX_PLAYERS][64],
    cur_class[MAX_PLAYERS][64],
    cur_teamname[MAX_PLAYERS][64],
    cur_teamleader[MAX_PLAYERS][64],
    bool:cur_stats[MAX_PLAYERS];

GetGender(playerid)
{
    static SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT user_gender FROM users WHERE user_id='%d'", GetPlayerUserID(playerid));
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_int(0, "user_gender", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

GetEmail(playerid)
{
    new SQL_Result[64];
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT email FROM users WHERE user_id='%d'", GetPlayerUserID(playerid));
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name(0, "email", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

GetStudentID(playerid)
{
    new SQL_Result[64];
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT student_id FROM users WHERE user_id='%d'", GetPlayerUserID(playerid));
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name(0, "student_id", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

GetUserName(playerid) // 10
{
    new SQL_Result[64];
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT user_name FROM users WHERE user_id='%d'", playerid);
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name(0, "user_name", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

GetTeamLeader(playerid)
{
    static SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT team_leader FROM teams WHERE team_id='%d'", GetPlayerClassTeam(playerid));
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_int(0, "team_leader", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

hook OnPlayerDisconnect(playerid, reason)
{
    new Float:health;
    new Float:armour;
    new newname[21];
    GetPlayerHealth(playerid, health);
    GetPlayerArmour(playerid, armour);
    GetPlayerName(playerid, newname, sizeof(newname));

    if( IsPlayerLoggedIn(playerid) )
    {
        if(aduty[playerid] == true )
        {
            mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_pos_x=%f, user_pos_y=%f, user_pos_z=%f, user_pos_a=%f, user_pos_world=%d, user_pos_interior=%d, user_skin=%d, weapon_1=%d, weapon_1_ammo=%d, weapon_2=%d, weapon_2_ammo=%d, health=%f, armor=%f, fightstyle='%d' WHERE user_id = %d", GetPlayerPosition(playerid, DIMENSION_X), GetPlayerPosition(playerid, DIMENSION_Y), GetPlayerPosition(playerid, DIMENSION_Z), GetPlayerPosition(playerid, DIMENSION_A), GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), GetPlayerSkin(playerid), GetWeaponOne(playerid), GetWeaponOneAmmo(playerid), GetWeaponTwo(playerid), GetWeaponTwoAmmo(playerid), health, armour, GetPlayerFightingStyle(playerid), GetPlayerUserID(playerid) );
            return 1;
        }
        if(IsPlayerInjured[playerid] == true)
        {
            mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_name='%s', user_pos_x=%f, user_pos_y=%f, user_pos_z=%f, user_pos_a=%f, user_pos_world=%d, user_pos_interior=%d, user_skin=%d, weapon_1=%d, weapon_1_ammo=%d, weapon_2=%d, weapon_2_ammo=%d, health=%f, armor=%f, fightstyle='%d' WHERE user_id = %d", newname, GetPlayerPosition(playerid, DIMENSION_X), GetPlayerPosition(playerid, DIMENSION_Y), GetPlayerPosition(playerid, DIMENSION_Z), GetPlayerPosition(playerid, DIMENSION_A), GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), GetPlayerSkin(playerid), GetWeaponOne(playerid), GetWeaponOneAmmo(playerid), GetWeaponTwo(playerid), GetWeaponTwoAmmo(playerid), 0, 0, GetPlayerFightingStyle(playerid), GetPlayerUserID(playerid) );
        }
        else
        {
            mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_name='%s', user_pos_x=%f, user_pos_y=%f, user_pos_z=%f, user_pos_a=%f, user_pos_world=%d, user_pos_interior=%d, user_skin=%d, weapon_1=%d, weapon_1_ammo=%d, weapon_2=%d, weapon_2_ammo=%d, health=%f, armor=%f, fightstyle='%d' WHERE user_id = %d", newname, GetPlayerPosition(playerid, DIMENSION_X), GetPlayerPosition(playerid, DIMENSION_Y), GetPlayerPosition(playerid, DIMENSION_Z), GetPlayerPosition(playerid, DIMENSION_A), GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), GetPlayerSkin(playerid), GetWeaponOne(playerid), GetWeaponOneAmmo(playerid), GetWeaponTwo(playerid), GetWeaponTwoAmmo(playerid), health, armour, GetPlayerFightingStyle(playerid), GetPlayerUserID(playerid) );
        }

        mysql_tquery(SQL_Handle, SQL_Buffer);

        TempPlayerSession[playerid] = false;

        cur_name[playerid] = NULL;
        cur_gender[playerid] = NULL;
        cur_studentid[playerid] = NULL;
        cur_college[playerid] = NULL;
        cur_email[playerid] = NULL;
        cur_rank[playerid] = NULL;
        cur_class[playerid] = NULL;
        cur_teamname[playerid] = NULL;
        cur_teamleader[playerid] = NULL;

        aduty[playerid] = false;
        SetPlayerName(playerid, GetPlayerRealName(playerid));
    }

    Delete3DTextLabel(InjuredLabel[playerid]);
    DestroyDynamic3DTextLabel(statusLabel[playerid]);

    return 1;
}

ShowPlayerLabel(playerid)
{
    new r[144];
    format(r, sizeof(r), "%s", RankName[GetPlayerRank(playerid)-1][1]);

    new fulltext[144];
    new c = GetPlayerClass(playerid);
    if (c == 0)
    {
        format(fulltext, sizeof(fulltext), "%s\nElement", r);
    }
    else if(c == 1)
    {
        format(fulltext, sizeof(fulltext), "%s\n%dst Class", r, c);
    }
    else if(c == 2)
    {
        format(fulltext, sizeof(fulltext), "%s\n%dnd Class", r, c);
    }
    else if(c == 3)
    {
        format(fulltext, sizeof(fulltext), "%s\n%drd Class", r, c);
    }
    else if(c == 4)
    {
        format(fulltext, sizeof(fulltext), "%s\n%dth Class", r, c);
    }
    else
    {
        format(fulltext, sizeof(fulltext), "%s\nCombat Medic", r);
    }
    
    return fulltext;
}

hook OnPlayerSpawn(playerid)
{
    new text[145];
    format(text, sizeof(text), "%s", ShowPlayerLabel(playerid));
    UpdateDynamic3DTextLabelText(statusLabel[playerid], newcolorset, text);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 40);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 50);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 200);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 300);
    cur_stats[playerid] = false;
    statusLabel[playerid] = CreateDynamic3DTextLabel(ShowPlayerLabel(playerid), newcolorset, 0, 0, 0, 3.0, .attachedplayer = playerid);
    return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    //statusLabel[playerid] = CreateDynamic3DTextLabel(ShowPlayerLabel(playerid), newcolorset, 0, 0, 0, 3.0, .attachedplayer = playerid);
    new text[145];
    format(text, sizeof(text), "%s", ShowPlayerLabel(playerid));
    UpdateDynamic3DTextLabelText(statusLabel[playerid], newcolorset, text);
    UpdatePlayerTD(playerid);
    return 1;
}


YCMD:stats(playerid, params[], help) 
{
    // UPDATE THE 3D TEXT OF THE PLAYER
    new text[145];
    format(text, sizeof(text), "%s", ShowPlayerLabel(playerid));
    UpdateDynamic3DTextLabelText(statusLabel[playerid], newcolorset, text);

    // UPDATE THE DIALOG OF THE PLAYER
    UpdatePlayerTD(playerid);

    format( cur_name[playerid], sizeof( cur_name ), "%s", GetPlayerNameEx2(playerid) );
    format( cur_gender[playerid], sizeof( cur_gender ), "%s", GetGender(playerid) );
    format( cur_studentid[playerid], sizeof( cur_studentid ), "%s", GetStudentID(playerid) );
    format( cur_college[playerid], sizeof( cur_college ), "%s", GetCollegeName(GetPlayerCollege(playerid)) );
    format( cur_email[playerid], sizeof( cur_email ), "%s", GetEmail(playerid) );

    cur_stats[playerid] = true;

    // TEXT DRAW //

    //BACKGROUND
    PlayerTextDrawShow(playerid, Box1[playerid]);
    PlayerTextDrawShow(playerid, Box2[playerid]);
    PlayerTextDrawShow(playerid, Borderline1[playerid]);
    PlayerTextDrawShow(playerid, Borderline2[playerid]);
    PlayerTextDrawShow(playerid, Borderline3[playerid]);
    PlayerTextDrawShow(playerid, CloseBox[playerid]);
    PlayerTextDrawShow(playerid, CloseLabel_Selection[playerid]);
    PlayerTextDrawShow(playerid, StatsLabel[playerid]);

    //PLAYER SELECTION
    PlayerTextDrawDestroy(playerid, HierarchyLabel_Selection[playerid]);
    PlayerTextDrawDestroy(playerid, ProfileLabel_Selection[playerid]);
    PlayerTextDrawDestroy(playerid, TeamLabel_Selection[playerid]);

    ProfileUpdate(playerid, -1);
    HierarchyUpdate(playerid, newcolorset);
    TeamUpdate(playerid, newcolorset);

    PlayerTextDrawShow(playerid, ProfileLabel_Selection[playerid]);
    PlayerTextDrawShow(playerid, HierarchyLabel_Selection[playerid]);
    PlayerTextDrawShow(playerid, TeamLabel_Selection[playerid]);

    //PLAYER LABEL    
    PlayerTextDrawShow(playerid, NameLabel[playerid]);
    PlayerTextDrawShow(playerid, GenderLabel[playerid]);
    PlayerTextDrawShow(playerid, StudentIDLabel[playerid]);
    PlayerTextDrawShow(playerid, CollegeLabel[playerid]);
    PlayerTextDrawShow(playerid, EmailLabel[playerid]);

    //PLAYER INPUT:
    PlayerTextDrawShow(playerid, name_show[playerid]);
    PlayerTextDrawShow(playerid, gender_show[playerid]);
    PlayerTextDrawShow(playerid, studentid_show[playerid]);
    PlayerTextDrawShow(playerid, college_show[playerid]);
    PlayerTextDrawShow(playerid, email_show[playerid]);

    if(GetGender(playerid) == 0)
    {
        format(cur_gender[playerid], 7, "Male");
    }
    else
    {
        format(cur_gender[playerid], 7, "Female");
    }

    PlayerTextDrawSetString( playerid, name_show[playerid], cur_name[playerid] );
    PlayerTextDrawSetString( playerid, gender_show[playerid], cur_gender[playerid] );
    PlayerTextDrawSetString( playerid, studentid_show[playerid], cur_studentid[playerid] );
    PlayerTextDrawSetString( playerid, college_show[playerid], cur_college[playerid] );
    PlayerTextDrawSetString( playerid, email_show[playerid], cur_email[playerid] );
    SelectTextDraw(playerid, -1);
    return 1;
}


public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if( (clickedid == INVALID_TEXT_DRAW) && (cur_stats[playerid] == true) )
    {
        cur_stats[playerid] = false;
        PlayerTextDrawHide(playerid, Box1[playerid]);
        PlayerTextDrawHide(playerid, Box2[playerid]);
        PlayerTextDrawHide(playerid, Borderline1[playerid]);
        PlayerTextDrawHide(playerid, Borderline2[playerid]);
        PlayerTextDrawHide(playerid, Borderline3[playerid]);
        PlayerTextDrawHide(playerid, CloseBox[playerid]);
        PlayerTextDrawHide(playerid, CloseLabel_Selection[playerid]);
        PlayerTextDrawHide(playerid, StatsLabel[playerid]);

        //PLAYER SELECTION
        PlayerTextDrawHide(playerid, ProfileLabel_Selection[playerid]);
        PlayerTextDrawHide(playerid, HierarchyLabel_Selection[playerid]);
        PlayerTextDrawHide(playerid, TeamLabel_Selection[playerid]);

        //PLAYER LABEL //
        //PROFILE
        PlayerTextDrawHide(playerid, NameLabel[playerid]);
        PlayerTextDrawHide(playerid, GenderLabel[playerid]);
        PlayerTextDrawHide(playerid, StudentIDLabel[playerid]);
        PlayerTextDrawHide(playerid, CollegeLabel[playerid]);
        PlayerTextDrawHide(playerid, EmailLabel[playerid]);

        //HIERARCHY
        PlayerTextDrawHide(playerid, RankLabel[playerid]);
        PlayerTextDrawHide(playerid, rank_show[playerid]);
        PlayerTextDrawHide(playerid, ClassLabel[playerid]);
        PlayerTextDrawHide(playerid, class_show[playerid]);

        //TEAM
        PlayerTextDrawHide(playerid, TeamNameLabel[playerid]);
        PlayerTextDrawHide(playerid, teamname_show[playerid]);
        PlayerTextDrawHide(playerid, TeamleaderLabel[playerid]);
        PlayerTextDrawHide(playerid, teamleader_show[playerid]);

        //PLAYER INPUT:
        PlayerTextDrawHide(playerid, name_show[playerid]);
        PlayerTextDrawHide(playerid, gender_show[playerid]);
        PlayerTextDrawHide(playerid, studentid_show[playerid]);
        PlayerTextDrawHide(playerid, college_show[playerid]);
        PlayerTextDrawHide(playerid, email_show[playerid]);
        CancelSelectTextDraw(playerid);
        return 1;
    }
    return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid) 
{
    if(playertextid == CloseLabel_Selection[playerid])
    {
        // BACKGROUND
        PlayerTextDrawHide(playerid, Box1[playerid]);
        PlayerTextDrawHide(playerid, Box2[playerid]);
        PlayerTextDrawHide(playerid, Borderline1[playerid]);
        PlayerTextDrawHide(playerid, Borderline2[playerid]);
        PlayerTextDrawHide(playerid, Borderline3[playerid]);
        PlayerTextDrawHide(playerid, CloseBox[playerid]);
        PlayerTextDrawHide(playerid, CloseLabel_Selection[playerid]);
        PlayerTextDrawHide(playerid, StatsLabel[playerid]);

        //PLAYER SELECTION
        PlayerTextDrawHide(playerid, ProfileLabel_Selection[playerid]);
        PlayerTextDrawHide(playerid, HierarchyLabel_Selection[playerid]);
        PlayerTextDrawHide(playerid, TeamLabel_Selection[playerid]);

        //PLAYER LABEL //
        //PROFILE
        PlayerTextDrawHide(playerid, NameLabel[playerid]);
        PlayerTextDrawHide(playerid, GenderLabel[playerid]);
        PlayerTextDrawHide(playerid, StudentIDLabel[playerid]);
        PlayerTextDrawHide(playerid, CollegeLabel[playerid]);
        PlayerTextDrawHide(playerid, EmailLabel[playerid]);

        //HIERARCHY
        PlayerTextDrawHide(playerid, RankLabel[playerid]);
        PlayerTextDrawHide(playerid, rank_show[playerid]);
        PlayerTextDrawHide(playerid, ClassLabel[playerid]);
        PlayerTextDrawHide(playerid, class_show[playerid]);

        //TEAM
        PlayerTextDrawHide(playerid, TeamNameLabel[playerid]);
        PlayerTextDrawHide(playerid, teamname_show[playerid]);
        PlayerTextDrawHide(playerid, TeamleaderLabel[playerid]);
        PlayerTextDrawHide(playerid, teamleader_show[playerid]);

        //PLAYER INPUT:
        PlayerTextDrawHide(playerid, name_show[playerid]);
        PlayerTextDrawHide(playerid, gender_show[playerid]);
        PlayerTextDrawHide(playerid, studentid_show[playerid]);
        PlayerTextDrawHide(playerid, college_show[playerid]);
        PlayerTextDrawHide(playerid, email_show[playerid]);
        CancelSelectTextDraw(playerid);
        cur_stats[playerid] = false;
        return 1;
    }
    if(playertextid == ProfileLabel_Selection[playerid])
    {
        //HIDE
        PlayerTextDrawHide(playerid, RankLabel[playerid]);
        PlayerTextDrawHide(playerid, rank_show[playerid]);
        PlayerTextDrawHide(playerid, ClassLabel[playerid]);
        PlayerTextDrawHide(playerid, class_show[playerid]);

        PlayerTextDrawHide(playerid, TeamNameLabel[playerid]);
        PlayerTextDrawHide(playerid, teamname_show[playerid]);
        PlayerTextDrawHide(playerid, TeamleaderLabel[playerid]);
        PlayerTextDrawHide(playerid, teamleader_show[playerid]);

        //PLAYER LABEL
        PlayerTextDrawShow(playerid, NameLabel[playerid]);
        PlayerTextDrawShow(playerid, GenderLabel[playerid]);
        PlayerTextDrawShow(playerid, StudentIDLabel[playerid]);
        PlayerTextDrawShow(playerid, CollegeLabel[playerid]);
        PlayerTextDrawShow(playerid, EmailLabel[playerid]);

        //PLAYER INPUT:
        PlayerTextDrawShow(playerid, name_show[playerid]);
        PlayerTextDrawShow(playerid, gender_show[playerid]);
        PlayerTextDrawShow(playerid, studentid_show[playerid]);
        PlayerTextDrawShow(playerid, college_show[playerid]);
        PlayerTextDrawShow(playerid, email_show[playerid]);

        PlayerTextDrawDestroy(playerid, HierarchyLabel_Selection[playerid]);
        PlayerTextDrawDestroy(playerid, ProfileLabel_Selection[playerid]);
        PlayerTextDrawDestroy(playerid, TeamLabel_Selection[playerid]);

        ProfileUpdate(playerid, -1);
        HierarchyUpdate(playerid, newcolorset);
        TeamUpdate(playerid, newcolorset);

        PlayerTextDrawShow(playerid, ProfileLabel_Selection[playerid]);
        PlayerTextDrawShow(playerid, HierarchyLabel_Selection[playerid]);
        PlayerTextDrawShow(playerid, TeamLabel_Selection[playerid]);
        return 1;
    }
    if(playertextid == HierarchyLabel_Selection[playerid])
    {
        //HIDE
        PlayerTextDrawHide(playerid, name_show[playerid]);
        PlayerTextDrawHide(playerid, gender_show[playerid]);
        PlayerTextDrawHide(playerid, studentid_show[playerid]);
        PlayerTextDrawHide(playerid, college_show[playerid]);
        PlayerTextDrawHide(playerid, email_show[playerid]);
        
        PlayerTextDrawHide(playerid, NameLabel[playerid]);
        PlayerTextDrawHide(playerid, GenderLabel[playerid]);
        PlayerTextDrawHide(playerid, StudentIDLabel[playerid]);
        PlayerTextDrawHide(playerid, CollegeLabel[playerid]);
        PlayerTextDrawHide(playerid, EmailLabel[playerid]);

        PlayerTextDrawHide(playerid, TeamNameLabel[playerid]);
        PlayerTextDrawHide(playerid, teamname_show[playerid]);
        PlayerTextDrawHide(playerid, TeamleaderLabel[playerid]);
        PlayerTextDrawHide(playerid, teamleader_show[playerid]);

        //SHOW
        PlayerTextDrawShow(playerid, RankLabel[playerid]);
        PlayerTextDrawShow(playerid, rank_show[playerid]);
        PlayerTextDrawShow(playerid, ClassLabel[playerid]);
        PlayerTextDrawShow(playerid, class_show[playerid]);

        //UPDATE

        format( cur_rank[playerid], sizeof( cur_rank ), "%s", RankName[GetPlayerRank(playerid)-1][1] );
        
        if( (GetPlayerClass(playerid) > 0) && (GetPlayerClass(playerid) < 5) )
        {
            format( cur_class[playerid], sizeof( cur_class ), "%d", GetPlayerClass(playerid) );
        }
        if( GetPlayerClass(playerid) == 0)
        {
            format( cur_class[playerid], sizeof( cur_class ), "Element");
        }
        if (GetPlayerClass(playerid) == 5)
        {
            format( cur_class[playerid], sizeof( cur_class ), "Combat Medic");
        }
        
        PlayerTextDrawSetString( playerid, rank_show[playerid], cur_rank[playerid] );
        PlayerTextDrawSetString( playerid, class_show[playerid], cur_class[playerid] );


        //SELECTION UPDATE
        PlayerTextDrawDestroy(playerid, HierarchyLabel_Selection[playerid]);
        PlayerTextDrawDestroy(playerid, ProfileLabel_Selection[playerid]);
        PlayerTextDrawDestroy(playerid, TeamLabel_Selection[playerid]);

        ProfileUpdate(playerid, newcolorset);
        HierarchyUpdate(playerid, -1);
        TeamUpdate(playerid, newcolorset);

        PlayerTextDrawShow(playerid, ProfileLabel_Selection[playerid]);
        PlayerTextDrawShow(playerid, HierarchyLabel_Selection[playerid]);
        PlayerTextDrawShow(playerid, TeamLabel_Selection[playerid]);
        return 1;
    }
    if(playertextid == TeamLabel_Selection[playerid])
    {
        //HIDE
        PlayerTextDrawHide(playerid, name_show[playerid]);
        PlayerTextDrawHide(playerid, gender_show[playerid]);
        PlayerTextDrawHide(playerid, studentid_show[playerid]);
        PlayerTextDrawHide(playerid, college_show[playerid]);
        PlayerTextDrawHide(playerid, email_show[playerid]);
        
        PlayerTextDrawHide(playerid, NameLabel[playerid]);
        PlayerTextDrawHide(playerid, GenderLabel[playerid]);
        PlayerTextDrawHide(playerid, StudentIDLabel[playerid]);
        PlayerTextDrawHide(playerid, CollegeLabel[playerid]);
        PlayerTextDrawHide(playerid, EmailLabel[playerid]);

        PlayerTextDrawHide(playerid, RankLabel[playerid]);
        PlayerTextDrawHide(playerid, rank_show[playerid]);
        PlayerTextDrawHide(playerid, ClassLabel[playerid]);
        PlayerTextDrawHide(playerid, class_show[playerid]);

        //SHOW
        PlayerTextDrawShow(playerid, TeamNameLabel[playerid]);
        PlayerTextDrawShow(playerid, teamname_show[playerid]);
        PlayerTextDrawShow(playerid, TeamleaderLabel[playerid]);
        PlayerTextDrawShow(playerid, teamleader_show[playerid]);
        
        new tl = GetTeamLeader(playerid);

        //UPDATE

        if (GetPlayerClassTeam(playerid) == 0)
        {
            format( cur_teamname[playerid], sizeof( cur_teamname ), "None" );
            format( cur_teamleader[playerid], sizeof( cur_teamleader ), "None");
        }
        else
        {
            format( cur_teamname[playerid], sizeof( cur_teamname ), "%s", GetPlayerClassTeamName(playerid) );
            format( cur_teamleader[playerid], sizeof( cur_teamleader ), "%s", GetUserName(tl) );
        }

        PlayerTextDrawSetString( playerid, teamname_show[playerid], cur_teamname[playerid] );
        PlayerTextDrawSetString( playerid, teamleader_show[playerid], cur_teamleader[playerid] );

        //SELECTION UPDATE
        PlayerTextDrawDestroy(playerid, HierarchyLabel_Selection[playerid]);
        PlayerTextDrawDestroy(playerid, ProfileLabel_Selection[playerid]);
        PlayerTextDrawDestroy(playerid, TeamLabel_Selection[playerid]);

        ProfileUpdate(playerid, newcolorset);
        HierarchyUpdate(playerid, newcolorset);
        TeamUpdate(playerid, -1);

        PlayerTextDrawShow(playerid, ProfileLabel_Selection[playerid]);
        PlayerTextDrawShow(playerid, HierarchyLabel_Selection[playerid]);
        PlayerTextDrawShow(playerid, TeamLabel_Selection[playerid]);
        return 1;
    }
    return 1;
}

forward ShowStats(playerid, dialogid, response, listitem, string:inputtext[]);
public ShowStats(playerid, dialogid, response, listitem, string:inputtext[])
{
    // Saving for pagination
    return 1;
}