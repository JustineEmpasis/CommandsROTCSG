#include <YSI_Coding\y_hooks>

#define MAX_TEAMS                   20
#define MAX_TEAM_NAME               32
#define MAX_TEAM_DESC               64

#define INVALID_CLASS               0xFF
#define INVALID_TEAM                0

enum E_Team {
    E_TeamID,
    E_TeamName[MAX_TEAM_NAME],
    E_TeamDesc[MAX_TEAM_DESC],
    bool:E_TeamTogRadio,
}

new
    Iterator:Team<MAX_TEAMS>,
    TeamData[MAX_TEAMS][E_Team],
    TeamInvited[MAX_PLAYERS][3],
    TeamLeaveConfirm[MAX_PLAYERS],
    TeamDeleteConfirm[MAX_PLAYERS];

hook OnGameModeInit() {
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT * FROM teams");
    mysql_tquery(SQL_Handle, SQL_Buffer, "OnTeamsLoad");
    return 1;
}

hook OnPlayerConnect(playerid) {
    TeamInvited[playerid][0] = false;
    TeamInvited[playerid][1] = INVALID_TEAM;
    TeamInvited[playerid][2] = INVALID_PLAYER_ID;
    TeamLeaveConfirm[playerid] = false;
    TeamDeleteConfirm[playerid] = false;
    return 1;
}

forward OnTeamsLoad();
public OnTeamsLoad() {
    if(cache_num_rows() == 0) {
        print("[MYSQL INFO]: There are currently no teams in the database.");
        return 1;
    }
    
    for(new i; i < cache_num_rows(); i++) {
        Iter_Alloc(Team);

        cache_get_value_name_int(i, "team_id", TeamData[i][E_TeamID]);
        cache_get_value_name(i, "team_name", TeamData[i][E_TeamName]);
        cache_get_value_name(i, "team_desc", TeamData[i][E_TeamDesc]);
        cache_get_value_name_int(i, "team_togradio", TeamData[i][E_TeamTogRadio]);

        printf("[MYSQL INFO]: Team [(%d) %s] has been loaded.", TeamData[i][E_TeamID], TeamData[i][E_TeamName]);
    }
    
    printf("[MYSQL INFO]: Teams Table has been loaded and fetched %d row%s.", cache_num_rows(), cache_num_rows() == 1 ? "" : "s");
    return 1;
}

stock GetPlayerRank(playerid)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT user_rank FROM users WHERE user_id = %d", GetPlayerUserID(playerid));
    new
        Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer),
        SQL_Result;

    cache_get_value_name_int(0, "user_rank", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

GetPlayerClass(playerid)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT user_class FROM users WHERE user_id = %d", GetPlayerUserID(playerid));
    new
        Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer),
        SQL_Result;

    cache_get_value_name_int(0, "user_class", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

GetPlayerClassTeam(playerid) 
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT user_team FROM users WHERE user_id = %d", GetPlayerUserID(playerid));
    new
        Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer),
        SQL_Result;

    cache_get_value_name_int(0, "user_team", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

GetPlayerClassTeamName(playerid) 
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT team_name FROM teams WHERE team_id = %d", GetPlayerClassTeam(playerid));
    new
        Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer),
        SQL_Result[144];

    cache_get_value_name(0, "team_name", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

bool:IsPlayerTeamLeader(playerid)
{
    mysql_format( SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT team_leader FROM teams WHERE team_leader = '%d'", GetPlayerUserID(playerid) );

    new
        Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer),
        SQL_Result,
        bool:IsLeader;

    cache_get_value_name_int(0, "team_leader", SQL_Result);

    if(SQL_Result == GetPlayerUserID(playerid))
    {
        IsLeader = true;
    }
    else
    {
        IsLeader = false;
    }

    cache_delete(SQL_Cache);
    return IsLeader;
}

stock bool:IsPlayerCombatMedic(playerid)
{
    #pragma unused playerid
    return false;
}

bool:IsPlayerTeamMuted(playerid) {
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT user_muted FROM users WHERE user_id = %d", GetPlayerUserID(playerid));
    new
        Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer),
        bool:SQL_Result;

    cache_get_value_name_int(0, "user_muted", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

TeamSetLeader(playerid, teamid) {
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE teams SET team_leader = %d WHERE team_id = %d", GetPlayerUserID(playerid), teamid);
    mysql_tquery(SQL_Handle, SQL_Buffer);
    
    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SERVER]: "COL_WHITE"You are now the leader of the team %s", TeamData[teamid-1][E_TeamName]);
}

YCMD:team(playerid, params[], help)
{
    new
        option[16],
        option_param[256];
    
    if(sscanf(params, "s[16]S()[256]", option, option_param))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/team [create / edit / invite / kick / mute / radio / leave / delete]");
        return 1;
    }

    if(!strcmp(option, "create", true))
    {
        if(GetPlayerClass(playerid) == INVALID_CLASS || GetPlayerClass(playerid) > 4)
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You can not use this command as you are not at least class 4!");
            return 1;
        }

        if(GetPlayerClassTeam(playerid) != INVALID_TEAM)
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You already have a team, to create a new one you have to delete your current team!");
            return 1;
        }
    
        new
            name[MAX_TEAM_NAME];

        if(sscanf(option_param, "s[32]", name))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/team create [name]");
            return 1;
        }

        if(strlen(name) > MAX_TEAM_NAME || strlen(name) <= 2)
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " The team name length must be less than 32 and greater than 2!");
            return 1;
        }

        new
            bool:match;

        foreach(new i : Team)
        {
            if(!strcmp(TeamData[i][E_TeamName], name))
            {
                match = true;
            }
        }

        if(match)
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " That team name is taken!");
            return 1;
        }

        if(Iter_Alloc(Team) != -1)
        {
            format(TeamData[Iter_Last(Team)][E_TeamName], MAX_TEAM_NAME, name);
            format(TeamData[Iter_Last(Team)][E_TeamDesc], MAX_TEAM_NAME, "None");

            mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "INSERT INTO teams(team_name, team_description) VALUES('%e', '%e')", TeamData[Iter_Last(Team)][E_TeamName], TeamData[Iter_Last(Team)][E_TeamDesc]);
            mysql_tquery(SQL_Handle, SQL_Buffer, "OnTeamCreate", "ii", Iter_Last(Team), playerid);
        }
        else
        {
            SendClientMessage(playerid, COLOR_LIGHTRED, "[TEAM INFO]: "COL_WHITE"Error while creating a new team, the maximum team creation limit is reached.");
        }
    }

    else if(!strcmp(option, "edit", true)) {
        if(GetPlayerClassTeam(playerid) == INVALID_TEAM)
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You are not part of a team!");
            return 1;
        }

        if(!IsPlayerTeamLeader(playerid)) 
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You do not have the permission to edit this team!");
            return 1;
        }

        new
            edit_option[16],
            edit_option2[16];

        if(sscanf(option_param, "s[16]S()[16]", edit_option, edit_option2))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/team edit [name / description / togradio]");
            return 1;
        }

        if(!strcmp(edit_option, "name"))
        {
            new
                name[MAX_TEAM_NAME];
            
            if(sscanf(edit_option2, "s[32]", name))
            {
                SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/team edit name [name]");
                return 1;
            }

            foreach(new i : Team) {
                if(TeamData[i][E_TeamID] == GetPlayerClassTeam(playerid)) {
                    format(TeamData[i][E_TeamName], MAX_TEAM_NAME, name);

                    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE teams SET team_name = '%e' WHERE team_id = %d", TeamData[i][E_TeamName], TeamData[i][E_TeamID]);
                    mysql_tquery(SQL_Handle, SQL_Buffer);

                    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[TEAM INFO]: "COL_WHITE"You have changed your team name into %s", TeamData[i][E_TeamName]);
                }
            }
        }

        else if(!strcmp(edit_option, "description"))
        {
            new
                description[MAX_TEAM_DESC];
            
            if(sscanf(edit_option2, "s[255]", description)) {
                SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/team edit description [message]");
                return 1;
            }

            foreach(new i : Team) {
                if(TeamData[i][E_TeamID] == GetPlayerClassTeam(playerid)) {
                    format(TeamData[i][E_TeamDesc], MAX_TEAM_DESC, description);

                    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE teams SET team_description = '%e' WHERE team_id = %d", TeamData[i][E_TeamDesc], TeamData[i][E_TeamID]);
                    mysql_tquery(SQL_Handle, SQL_Buffer);

                    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[TEAM INFO]: "COL_WHITE"You have changed your team description into %s", TeamData[i][E_TeamDesc]);
                }
            }
        }

        else if(!strcmp(edit_option, "togradio")) {
            foreach(new i : Team) {
                if(TeamData[i][E_TeamID] == GetPlayerClassTeam(playerid)) {
                    TeamData[i][E_TeamTogRadio] = TeamData[i][E_TeamTogRadio] ? false : true;

                    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE teams SET team_togradio = %d", TeamData[i][E_TeamTogRadio]);
                    mysql_tquery(SQL_Handle, SQL_Buffer);

                    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[TEAM INFO]: "COL_WHITE"Your team radio is toggled %s", TeamData[i][E_TeamTogRadio] ? ""COL_LIMEGREEN"ON" : ""COL_ORANGE"OFF");
                }
            }
        }

        else {
            SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/team edit [name / description / togradio]");
        }
    }

    else if(!strcmp(option, "invite", true)) {
        if(GetPlayerClassTeam(playerid) == INVALID_TEAM) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You are not part of a team!");
            return 1;
        }

        if(!IsPlayerTeamLeader(playerid))
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You don't have the permission to invite someone to a team!");
            return 1;
        }

        new
            targetid;

        if(sscanf(option_param, "u", targetid)) {
            SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/team invite [playerid]");
            return 1;
        }

        if(targetid == playerid) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You can not invite yourself!");
            return 1;
        }

        if(!IsPlayerLoggedIn(targetid)) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " That player has not yet logged in or not connected!");
            return 1;
        }

        if(GetPlayerClassTeam(targetid) != INVALID_TEAM) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " That player is already in a team!");
            return 1;
        }

        foreach(new i : Team) {
            if(TeamData[i][E_TeamID] == GetPlayerClassTeam(playerid)) {
                TeamInvited[targetid][0] = true;
                TeamInvited[targetid][1] = GetPlayerClassTeam(playerid);
                TeamInvited[targetid][2] = playerid;
                
                SendClientMessageEx2(targetid, COLOR_AQUA, "[TEAM INFO]: "COL_WHITE"You have been invited by %s to join their team %s", GetPlayerNameEx2(playerid), TeamData[i][E_TeamName]);
                SendClientMessage(targetid, COLOR_AQUA, "[GUIDE]: "COL_WHITE"Execute the command [/team accept] to accept this invitation");
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[TEAM INFO]: "COL_WHITE"You have invited %s to join your team!", GetPlayerNameEx2(targetid));
            }
        }
    }

    else if(!strcmp(option, "accept", true)) {
        if(!TeamInvited[playerid][0]) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You don't have a team invitation!");
            return 1;
        }

        mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_team = %d WHERE user_id = %d", TeamInvited[playerid][1], GetPlayerUserID(playerid));
        mysql_tquery(SQL_Handle, SQL_Buffer);

        foreach(new i : Team) {
            if(TeamData[i][E_TeamID] == GetPlayerClassTeam(TeamInvited[playerid][2])) {
                SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[TEAM INFO]: "COL_WHITE"You have accepted the invitation! You are now part of %s team!", TeamData[i][E_TeamName]);
                SendClientMessageEx2(TeamInvited[playerid][2], COLOR_AQUA, "[TEAM INFO]: "COL_WHITE"%s has accepted your team invitation!", GetPlayerNameEx2(playerid));

                TeamInvited[playerid][0] = false;
                TeamInvited[playerid][1] = INVALID_TEAM;
                TeamInvited[playerid][2] = INVALID_PLAYER_ID;
            }
        }
    }

    else if(!strcmp(option, "kick", true)) {
        if(GetPlayerClassTeam(playerid) == INVALID_TEAM) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You are not part of a team!");
            return 1;
        }

        if(!IsPlayerTeamLeader(playerid)) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You do not have the permission to kick someone from the team!");
            return 1;
        }

        new
            targetid;

        if(sscanf(option_param, "u", targetid)) {
            SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/team kick [playerid]");
            return 1;
        }

        if(targetid == playerid) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You can not kick yourself, use [/team leave] to leave the team");
            return 1;
        }

        if(!IsPlayerLoggedIn(targetid)) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " That player has not yet logged in or not connected!");
            return 1;
        }

        if(GetPlayerClassTeam(playerid) != GetPlayerClassTeam(targetid))
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " That player is not part of your team!");
            return 1;
        }

        mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_team = %d WHERE user_id = %d", INVALID_TEAM, GetPlayerUserID(targetid));
        mysql_tquery(SQL_Handle, SQL_Buffer);

        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[TEAM INFO]: "COL_WHITE"You have kicked %s from your team.", GetPlayerNameEx2(targetid));
        SendClientMessageEx2(targetid, COLOR_ORANGE, "[TEAM INFO]: "COL_WHITE"You have been kicked from the team %s!", TeamData[GetPlayerClassTeam(playerid)][E_TeamName]);
    }

    else if(!strcmp(option, "mute", true)) {
        if(GetPlayerClassTeam(playerid) == INVALID_TEAM) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You are not part of a team!");
            return 1;
        }

        if(!IsPlayerTeamLeader(playerid)) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You don't have the permission to mute someone from the team!");
            return 1;
        }

        new
            targetid;

        if(sscanf(option_param, "u", targetid))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/team mute [playerid]");
            return 1;
        }

        if(targetid == playerid) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You can not mute yourself!");
            return 1;
        }

        if(!IsPlayerLoggedIn(targetid)) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " That player has not yet logged in or not connected!");
            return 1;
        }

        if(GetPlayerClassTeam(playerid) != GetPlayerClassTeam(targetid))
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " That player is not part of your team!");
            return 1;
        }

        mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_muted = %d WHERE user_id = %d", IsPlayerTeamMuted(targetid) ? false : true, GetPlayerUserID(targetid) );
        mysql_tquery(SQL_Handle, SQL_Buffer);

        if( IsPlayerTeamMuted(targetid) ) // 1
        {
            SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[TEAM INFO]: "COL_WHITE"You have unmuted %s from using the team radio.", GetPlayerNameEx2(targetid) );
            SendClientMessage(targetid, COLOR_AQUA, "[TEAM INFO]: "COL_WHITE"You have been unmuted from using the team radio.");
        }
        else
        {
            SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[TEAM INFO]: "COL_WHITE"You have muted %s from using the team radio.", GetPlayerNameEx2(targetid));
            SendClientMessage(targetid, COLOR_LIGHTRED, "[TEAM INFO]: "COL_WHITE"You have been muted from using the team radio.");
        }
    }

    else if(!strcmp(option, "chat", true) || !strcmp(option, "radio", true)) 
    {
        if(GetPlayerClassTeam(playerid) == INVALID_TEAM) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You are not part of a team!");
            return 1;
        }

        if( IsPlayerTeamMuted(playerid) )
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You are muted from using team radio!");
            return 1;
        }

        foreach(new i : Team) {
            if(TeamData[i][E_TeamID] == GetPlayerClassTeam(playerid)) {
                if(!TeamData[i][E_TeamTogRadio]) {
                    SendClientMessage(playerid, COLOR_DARKERGREY, " team radio is currently toggled OFF by the leader.");
                    return 1;
                }

                new
                    message[144];
                
                if(sscanf(option_param, "s[144]", message)) {
                    SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/team radio [message]");
                    return 1;
                }


                foreach(new x : Player) {
                    if(TeamData[i][E_TeamID] == GetPlayerClassTeam(x)) {
                        SendClientMessageEx2(x, COLOR_LIGHTGREEN, "[Team Radio] "COL_AZURE"%s: "COL_WHITE"%s", GetPlayerNameEx2(playerid), message);
                    }
                }
            }
        }
        return 1;
    }

    else if(!strcmp(option, "leave", true)) { // Team Member
        if(TeamLeaveConfirm[playerid]) {
            new
                confirm[16];

            if(sscanf(option_param, "s[16]", confirm)) {
                SendClientMessage(playerid, COLOR_ORANGE, "[TEAM INFO]: "COL_WHITE"You are already trying to leave your team, type [/team leave confirm] to continue.");
                return 1;
            }

            if(!strcmp(confirm, "confirm")) {
                TeamLeaveConfirm[playerid] = false;

                foreach(new i : Team) {
                    if(TeamData[i][E_TeamID] == GetPlayerClassTeam(playerid)) {
                        SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[TEAM INFO]: "COL_WHITE"You have left %s", TeamData[i][E_TeamName]);
                    }
                }

                mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_team = %d WHERE user_id = %d", INVALID_TEAM, GetPlayerUserID(playerid));
                mysql_tquery(SQL_Handle, SQL_Buffer);

                foreach(new i : Player) {
                    if(i == playerid) {
                        continue;
                    }

                    if(GetPlayerClassTeam(i) == GetPlayerClassTeam(playerid)) {
                        SendClientMessageEx2(i, COLOR_ORANGE, "[TEAM INFO]: "COL_PEACHPUFF"%s "COL_WHITE"has left the team.", GetPlayerNameEx2(playerid));
                    }
                }
            }
            return 1;
        }
    
        if(GetPlayerClassTeam(playerid) == INVALID_TEAM) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You are not part of a team!");
            return 1;
        }

        if(IsPlayerTeamLeader(playerid)) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You can't leave your team as a leader!");
            return 1;
        }

        TeamLeaveConfirm[playerid] = true;
        SendClientMessage(playerid, COLOR_ORANGE, "[TEAM INFO]: "COL_WHITE"You are now trying to leave your team, type [/team leave confirm] to continue.");
    }

    else if(!strcmp(option, "delete", true)) {
        if(GetPlayerClassTeam(playerid) == INVALID_TEAM)
        {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You are not part of a team!");
            return 1;
        }

        if(!IsPlayerTeamLeader(playerid)) {
            SendClientMessage(playerid, COLOR_DARKERGREY, " You don't have the permission to delete your team!");
            return 1;
        }

        if(TeamDeleteConfirm[playerid]) {
            new
                confirm[16];

            if(sscanf(option_param, "s[16]", confirm)) {
                SendClientMessage(playerid, COLOR_ORANGE, "[TEAM INFO]: "COL_WHITE"You are already trying to delete your team, type [/team delete confirm] to continue.");
                return 1;
            }

            if(!strcmp(confirm, "confirm")) {
                TeamDeleteConfirm[playerid] = false;


                foreach(new i : Player) {
                    if(GetPlayerClassTeam(i) == GetPlayerClassTeam(playerid)) {
                    
                        SendClientMessageEx2(i, COLOR_LIGHTRED, "[TEAM INFO]: "COL_WHITE"Your team has been disbanded by %s.", GetPlayerNameEx2(playerid));
                    }
                }

                mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "DELETE FROM teams WHERE team_id = %d", GetPlayerClassTeam(playerid));
                mysql_tquery(SQL_Handle, SQL_Buffer);

                mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_team = %d WHERE user_team = %d", INVALID_TEAM, GetPlayerClassTeam(playerid));
                mysql_tquery(SQL_Handle, SQL_Buffer);
            }

            return 1;
        }

        TeamDeleteConfirm[playerid] = true;
        SendClientMessage(playerid, COLOR_ORANGE, "[TEAM INFO]: "COL_WHITE"You are now trying to delete your team, type [/team delete confirm] to continue.");
    }
    return 1;
}

YCMD:tr(playerid, params[], help) = teamradio;
YCMD:tradio(playerid, params[], help) = teamradio;
YCMD:tc(playerid, params[], help) = teamradio;
YCMD:tchat(playerid, params[], help) = teamradio;

YCMD:teamradio(playerid, params[], help) {
    if(GetPlayerClassTeam(playerid) == INVALID_TEAM) {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are not part of a team!");
        return 1;
    }

    if( IsPlayerTeamMuted(playerid) )
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You are muted from using team radio!");
        return 1;
    }

    foreach(new i : Team)
    {
        if(TeamData[i][E_TeamID] == GetPlayerClassTeam(playerid))
        {
            if(!TeamData[i][E_TeamTogRadio])
            {
                SendClientMessage(playerid, COLOR_DARKERGREY, " Team radio is currently toggled OFF by the leader.");
                return 1;
            }

            new
                message[144];
            
            if(sscanf(params, "s[144]", message))
            {
                SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/teamradio [message]");
                return 1;
            }


            foreach(new x : Player)
            {
                if(TeamData[i][E_TeamID] == GetPlayerClassTeam(x))
                {
                    SendClientMessageEx2( x, COLOR_LIGHTGREEN, "[Team Radio] "COL_AZURE"%s : "COL_WHITE"%s", GetPlayerNameEx2(playerid), message );
                }
            }
        }
    }
    return 1;
}

forward OnTeamCreate(idx, playerid);
public OnTeamCreate(idx, playerid)
{
    TeamData[idx][E_TeamID] = cache_insert_id();
    
    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[TEAM INFO]: "COL_WHITE"You have created a team named %s.", TeamData[idx][E_TeamName]);

    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE users SET user_team = %d WHERE user_id =%d", TeamData[idx][E_TeamID], GetPlayerUserID(playerid));
    mysql_tquery(SQL_Handle, SQL_Buffer);
    
    TeamSetLeader(playerid, TeamData[idx][E_TeamID]);
    return 1;
}

YCMD:m(playerid, params[], help) = megaphone;

YCMD:megaphone(playerid, params[], help)
{
    if(GetPlayerClass(playerid) == INVALID_CLASS)
    {
        SendClientMessage(playerid, COLOR_DARKERGREY, " You do not have permission to use this command!");
        return 1;
    }
    
    new
        message[256],
        fstring[256];

    if(sscanf(params, "s[256]", message)){
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/megaphone [message]");
        return 1;
    }
    format(fstring, 256, "(megaphone) %s: %s", GetPlayerNameEx2(playerid), message);
    
    foreach(new i : Player){
        if(IsPlayerInRangeOfPoint(i, MESSAGE_LOCAL*2.5, GetPlayerPosition(playerid, DIMENSION_X), GetPlayerPosition(playerid, DIMENSION_Y), GetPlayerPosition(playerid, DIMENSION_Z))){
            SendClientMessage(i, COLOR_YELLOW, fstring);
        }
    }
    return 1;
}