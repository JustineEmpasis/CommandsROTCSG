#include <YSI_Coding\y_hooks>

//Global Textdraws:

new
    PlayerText:Box1[MAX_PLAYERS],
    PlayerText:Box2[MAX_PLAYERS],
    PlayerText:Borderline1[MAX_PLAYERS],
    PlayerText:Borderline2[MAX_PLAYERS],
    PlayerText:Borderline3[MAX_PLAYERS],
    PlayerText:ProfileLabel_Selection[MAX_PLAYERS],
    PlayerText:NameLabel[MAX_PLAYERS],
    PlayerText:GenderLabel[MAX_PLAYERS],
    PlayerText:StudentIDLabel[MAX_PLAYERS],
    PlayerText:CollegeLabel[MAX_PLAYERS],
    PlayerText:EmailLabel[MAX_PLAYERS],
    PlayerText:HierarchyLabel_Selection[MAX_PLAYERS],
    PlayerText:TeamLabel_Selection[MAX_PLAYERS],
    PlayerText:CloseBox[MAX_PLAYERS],
    PlayerText:CloseLabel_Selection[MAX_PLAYERS],
    PlayerText:StatsLabel[MAX_PLAYERS],
    PlayerText:name_show[MAX_PLAYERS],
    PlayerText:gender_show[MAX_PLAYERS],
    PlayerText:studentid_show[MAX_PLAYERS],
    PlayerText:college_show[MAX_PLAYERS],
    PlayerText:email_show[MAX_PLAYERS],
    PlayerText:RankLabel[MAX_PLAYERS],
    PlayerText:rank_show[MAX_PLAYERS],
    PlayerText:ClassLabel[MAX_PLAYERS],
    PlayerText:class_show[MAX_PLAYERS],
    PlayerText:TeamNameLabel[MAX_PLAYERS],
    PlayerText:teamname_show[MAX_PLAYERS],
    PlayerText:TeamleaderLabel[MAX_PLAYERS],
    PlayerText:teamleader_show[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    new colorset = 0x8a9a5bFF;

    new Float:show_x = 233.500000;
    new Float:show_y = 170;
    new Float:show_y_plus = 35;

    new Float:labelsize_x = 0.2;
    new Float:labelsize_y = 1;
        
    Box1[playerid] = CreatePlayerTextDraw(playerid, 544.000000, 157.677764, "usebox");
    PlayerTextDrawLetterSize(playerid, Box1[playerid], 0.000000, 23.950002);
    PlayerTextDrawTextSize(playerid, Box1[playerid], 213.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, Box1[playerid], 1);
    PlayerTextDrawColor(playerid, Box1[playerid], 0);
    PlayerTextDrawUseBox(playerid, Box1[playerid], true);
    PlayerTextDrawBoxColor(playerid, Box1[playerid], 102);
    PlayerTextDrawSetShadow(playerid, Box1[playerid], 0);
    PlayerTextDrawSetOutline(playerid, Box1[playerid], 0);
    PlayerTextDrawFont(playerid, Box1[playerid], 0);

    Box2[playerid] = CreatePlayerTextDraw(playerid, 92.500000, 157.055541, "usebox");
    PlayerTextDrawLetterSize(playerid, Box2[playerid], 0.000000, 24.019138);
    PlayerTextDrawTextSize(playerid, Box2[playerid], 202.500000, 0.000000);
    PlayerTextDrawAlignment(playerid, Box2[playerid], 1);
    PlayerTextDrawColor(playerid, Box2[playerid], 0);
    PlayerTextDrawUseBox(playerid, Box2[playerid], true);
    PlayerTextDrawBoxColor(playerid, Box2[playerid], 102);
    PlayerTextDrawSetShadow(playerid, Box2[playerid], 0);
    PlayerTextDrawSetOutline(playerid, Box2[playerid], 0);
    PlayerTextDrawFont(playerid, Box2[playerid], 0);

    Borderline1[playerid] = CreatePlayerTextDraw(playerid, 88.500000, 375.822204, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, Borderline1[playerid], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Borderline1[playerid], 4.000000, -220.888870);
    PlayerTextDrawAlignment(playerid, Borderline1[playerid], 1);
    PlayerTextDrawColor(playerid, Borderline1[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, Borderline1[playerid], 0);
    PlayerTextDrawSetOutline(playerid, Borderline1[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, Borderline1[playerid], -1);
    PlayerTextDrawFont(playerid, Borderline1[playerid], 4);

    Borderline2[playerid] = CreatePlayerTextDraw(playerid, 206.500000, 154.933334, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, Borderline2[playerid], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Borderline2[playerid], -4.000000, 220.888870);
    PlayerTextDrawAlignment(playerid, Borderline2[playerid], 1);
    PlayerTextDrawColor(playerid, Borderline2[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, Borderline2[playerid], 0);
    PlayerTextDrawSetOutline(playerid, Borderline2[playerid], 0);
    PlayerTextDrawFont(playerid, Borderline2[playerid], 4);

    Borderline3[playerid] = CreatePlayerTextDraw(playerid, 89.000000, 130.666671, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, Borderline3[playerid], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Borderline3[playerid], 399.000000, 17.422224);
    PlayerTextDrawAlignment(playerid, Borderline3[playerid], 1);
    PlayerTextDrawColor(playerid, Borderline3[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, Borderline3[playerid], 0);
    PlayerTextDrawSetOutline(playerid, Borderline3[playerid], 0);
    PlayerTextDrawFont(playerid, Borderline3[playerid], 4);

    ProfileUpdate(playerid, -1);
    HierarchyUpdate(playerid, colorset);
    TeamUpdate(playerid, colorset);

    CloseBox[playerid] = CreatePlayerTextDraw(playerid, 490.500000, 148.088867, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, CloseBox[playerid], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, CloseBox[playerid], 52.000000, -17.422208);
    PlayerTextDrawAlignment(playerid, CloseBox[playerid], 1);
    PlayerTextDrawColor(playerid, CloseBox[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, CloseBox[playerid], 0);
    PlayerTextDrawSetOutline(playerid, CloseBox[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, CloseBox[playerid], -1);
    PlayerTextDrawFont(playerid, CloseBox[playerid], 4);

    CloseLabel_Selection[playerid] = CreatePlayerTextDraw(playerid, 493.000000, 131.288848, "CLOSE"); // SELECTABLE
    PlayerTextDrawTextSize(playerid, CloseLabel_Selection[playerid], 540.000000, 20);
    PlayerTextDrawLetterSize(playerid, CloseLabel_Selection[playerid], 0.449999, 1.600000);
    PlayerTextDrawAlignment(playerid, CloseLabel_Selection[playerid], 1);
    PlayerTextDrawColor(playerid, CloseLabel_Selection[playerid], COLOR_RED);
    PlayerTextDrawSetShadow(playerid, CloseLabel_Selection[playerid], 0);
    PlayerTextDrawSetOutline(playerid, CloseLabel_Selection[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, CloseLabel_Selection[playerid], 51);
    PlayerTextDrawFont(playerid, CloseLabel_Selection[playerid], 1);
    PlayerTextDrawSetProportional(playerid, CloseLabel_Selection[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, CloseLabel_Selection[playerid], true);

    NameLabel[playerid] = CreatePlayerTextDraw(playerid, show_x, show_y, "NAME");
    PlayerTextDrawLetterSize(playerid, NameLabel[playerid], labelsize_x, labelsize_y);
    PlayerTextDrawTextSize(playerid, NameLabel[playerid], 100.000000, -51.022224);
    PlayerTextDrawAlignment(playerid, NameLabel[playerid], 1);
    PlayerTextDrawColor(playerid, NameLabel[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, NameLabel[playerid], 0);
    PlayerTextDrawSetOutline(playerid, NameLabel[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, NameLabel[playerid], 51);
    PlayerTextDrawFont(playerid, NameLabel[playerid], 2);
    PlayerTextDrawSetProportional(playerid, NameLabel[playerid], 1);

    GenderLabel[playerid] = CreatePlayerTextDraw(playerid, show_x, show_y + (show_y_plus*1), "GENDER");
    PlayerTextDrawLetterSize(playerid, GenderLabel[playerid], labelsize_x, labelsize_y);
    PlayerTextDrawAlignment(playerid, GenderLabel[playerid], 1);
    PlayerTextDrawColor(playerid, GenderLabel[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, GenderLabel[playerid], 0);
    PlayerTextDrawSetOutline(playerid, GenderLabel[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, GenderLabel[playerid], 51);
    PlayerTextDrawFont(playerid, GenderLabel[playerid], 2);
    PlayerTextDrawSetProportional(playerid, GenderLabel[playerid], 1);

    StudentIDLabel[playerid] = CreatePlayerTextDraw(playerid, show_x, show_y + (show_y_plus*2), "STUDENT_ID");
    PlayerTextDrawLetterSize(playerid, StudentIDLabel[playerid], labelsize_x, labelsize_y);
    PlayerTextDrawTextSize(playerid, StudentIDLabel[playerid], -145.500000, -47.288883);
    PlayerTextDrawAlignment(playerid, StudentIDLabel[playerid], 1);
    PlayerTextDrawColor(playerid, StudentIDLabel[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, StudentIDLabel[playerid], 0);
    PlayerTextDrawSetOutline(playerid, StudentIDLabel[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, StudentIDLabel[playerid], 51);
    PlayerTextDrawFont(playerid, StudentIDLabel[playerid], 2);
    PlayerTextDrawSetProportional(playerid, StudentIDLabel[playerid], 1);

    CollegeLabel[playerid] = CreatePlayerTextDraw(playerid, show_x, show_y + (show_y_plus*3), "COLLEGE");
    PlayerTextDrawLetterSize(playerid, CollegeLabel[playerid], labelsize_x, labelsize_y);
    PlayerTextDrawAlignment(playerid, CollegeLabel[playerid], 1);
    PlayerTextDrawColor(playerid, CollegeLabel[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, CollegeLabel[playerid], 0);
    PlayerTextDrawSetOutline(playerid, CollegeLabel[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, CollegeLabel[playerid], 51);
    PlayerTextDrawFont(playerid, CollegeLabel[playerid], 2);
    PlayerTextDrawSetProportional(playerid, CollegeLabel[playerid], 1);

    EmailLabel[playerid] = CreatePlayerTextDraw(playerid, show_x, show_y + (show_y_plus*4), "EMAIL");
    PlayerTextDrawLetterSize(playerid, EmailLabel[playerid], labelsize_x, labelsize_y);
    PlayerTextDrawAlignment(playerid, EmailLabel[playerid], 1);
    PlayerTextDrawColor(playerid, EmailLabel[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, EmailLabel[playerid], 0);
    PlayerTextDrawSetOutline(playerid, EmailLabel[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, EmailLabel[playerid], 51);
    PlayerTextDrawFont(playerid, EmailLabel[playerid], 2);
    PlayerTextDrawSetProportional(playerid, EmailLabel[playerid], 1);

    name_show[playerid] = CreatePlayerTextDraw(playerid, show_x, show_y+10, "NAME INPUT");
    PlayerTextDrawLetterSize(playerid, name_show[playerid], 0.4, 1.600000);
    PlayerTextDrawAlignment(playerid, name_show[playerid], 1);
    PlayerTextDrawColor(playerid, name_show[playerid], COLOR_WHITE);
    PlayerTextDrawSetShadow(playerid, name_show[playerid], 0);
    PlayerTextDrawSetOutline(playerid, name_show[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, name_show[playerid], 51);
    PlayerTextDrawFont(playerid, name_show[playerid], 1);
    PlayerTextDrawSetProportional(playerid, name_show[playerid], 1);

    gender_show[playerid] = CreatePlayerTextDraw(playerid, show_x, (show_y+10) + (show_y_plus*1), "GENDER INPUT");
    PlayerTextDrawLetterSize(playerid, gender_show[playerid], 0.4, 1.600000);
    PlayerTextDrawAlignment(playerid, gender_show[playerid], 1);
    PlayerTextDrawColor(playerid, gender_show[playerid], COLOR_WHITE);
    PlayerTextDrawSetShadow(playerid, gender_show[playerid], 0);
    PlayerTextDrawSetOutline(playerid, gender_show[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, gender_show[playerid], 51);
    PlayerTextDrawFont(playerid, gender_show[playerid], 1);
    PlayerTextDrawSetProportional(playerid, gender_show[playerid], 1);

    studentid_show[playerid] = CreatePlayerTextDraw(playerid, show_x, (show_y+10) + (show_y_plus*2), "STUDENTID INPUT");
    PlayerTextDrawLetterSize(playerid, studentid_show[playerid], 0.4, 1.600000);
    PlayerTextDrawAlignment(playerid, studentid_show[playerid], 1);
    PlayerTextDrawColor(playerid, studentid_show[playerid], COLOR_WHITE);
    PlayerTextDrawSetShadow(playerid, studentid_show[playerid], 0);
    PlayerTextDrawSetOutline(playerid, studentid_show[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, studentid_show[playerid], 51);
    PlayerTextDrawFont(playerid, studentid_show[playerid], 1);
    PlayerTextDrawSetProportional(playerid, studentid_show[playerid], 1);

    college_show[playerid] = CreatePlayerTextDraw(playerid, show_x, (show_y+10) + (show_y_plus*3), "COLLEGE INPUT");
    PlayerTextDrawLetterSize(playerid, college_show[playerid], 0.4, 1.600000);
    PlayerTextDrawAlignment(playerid, college_show[playerid], 1);
    PlayerTextDrawColor(playerid, college_show[playerid], COLOR_WHITE);
    PlayerTextDrawSetShadow(playerid, college_show[playerid], 0);
    PlayerTextDrawSetOutline(playerid, college_show[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, college_show[playerid], 51);
    PlayerTextDrawFont(playerid, college_show[playerid], 1);
    PlayerTextDrawSetProportional(playerid, college_show[playerid], 1);

    email_show[playerid] = CreatePlayerTextDraw(playerid, show_x, (show_y+10) + (show_y_plus*4), "EMAIL INPUT");
    PlayerTextDrawLetterSize(playerid, email_show[playerid], 0.4, 1.600000);
    PlayerTextDrawAlignment(playerid, email_show[playerid], 1);
    PlayerTextDrawColor(playerid, email_show[playerid], COLOR_WHITE);
    PlayerTextDrawSetShadow(playerid, email_show[playerid], 0);
    PlayerTextDrawSetOutline(playerid, email_show[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, email_show[playerid], 51);
    PlayerTextDrawFont(playerid, email_show[playerid], 1);
    PlayerTextDrawSetProportional(playerid, email_show[playerid], 1);

    StatsLabel[playerid] = CreatePlayerTextDraw(playerid, 91.000000, 131.288879, "CHARACTER_STATISTICS");
    PlayerTextDrawLetterSize(playerid, StatsLabel[playerid], 0.449999, 1.600000);
    PlayerTextDrawTextSize(playerid, StatsLabel[playerid], 201.500000, 7.466659);
    PlayerTextDrawAlignment(playerid, StatsLabel[playerid], 1);
    PlayerTextDrawColor(playerid, StatsLabel[playerid], -1);
    PlayerTextDrawSetShadow(playerid, StatsLabel[playerid], 0);
    PlayerTextDrawSetOutline(playerid, StatsLabel[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, StatsLabel[playerid], 255);
    PlayerTextDrawFont(playerid, StatsLabel[playerid], 2);
    PlayerTextDrawSetProportional(playerid, StatsLabel[playerid], 1);

    // HIERARCHY
    RankLabel[playerid] = CreatePlayerTextDraw(playerid, show_x, show_y, "RANK");
    PlayerTextDrawLetterSize(playerid, RankLabel[playerid], labelsize_x, labelsize_y);
    PlayerTextDrawTextSize(playerid, RankLabel[playerid], 100.000000, -51.022224);
    PlayerTextDrawAlignment(playerid, RankLabel[playerid], 1);
    PlayerTextDrawColor(playerid, RankLabel[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, RankLabel[playerid], 0);
    PlayerTextDrawSetOutline(playerid, RankLabel[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, RankLabel[playerid], 51);
    PlayerTextDrawFont(playerid, RankLabel[playerid], 2);
    PlayerTextDrawSetProportional(playerid, RankLabel[playerid], 1);

    rank_show[playerid] = CreatePlayerTextDraw(playerid, show_x, show_y+10, "RANK_INPUT");
    PlayerTextDrawLetterSize(playerid, rank_show[playerid], 0.4, 1.600000);
    PlayerTextDrawAlignment(playerid, rank_show[playerid], 1);
    PlayerTextDrawColor(playerid, rank_show[playerid], COLOR_WHITE);
    PlayerTextDrawSetShadow(playerid, rank_show[playerid], 0);
    PlayerTextDrawSetOutline(playerid, rank_show[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, rank_show[playerid], 51);
    PlayerTextDrawFont(playerid, rank_show[playerid], 1);
    PlayerTextDrawSetProportional(playerid, rank_show[playerid], 1);

    ClassLabel[playerid] = CreatePlayerTextDraw(playerid, show_x, show_y + (show_y_plus*1), "CLASS");
    PlayerTextDrawLetterSize(playerid, ClassLabel[playerid], labelsize_x, labelsize_y);
    PlayerTextDrawAlignment(playerid, ClassLabel[playerid], 1);
    PlayerTextDrawColor(playerid, ClassLabel[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, ClassLabel[playerid], 0);
    PlayerTextDrawSetOutline(playerid, ClassLabel[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, ClassLabel[playerid], 51);
    PlayerTextDrawFont(playerid, ClassLabel[playerid], 2);
    PlayerTextDrawSetProportional(playerid, ClassLabel[playerid], 1);

    class_show[playerid] = CreatePlayerTextDraw(playerid, show_x, (show_y+10) + (show_y_plus*1), "CLASS_INPUT");
    PlayerTextDrawLetterSize(playerid, class_show[playerid], 0.4, 1.600000);
    PlayerTextDrawAlignment(playerid, class_show[playerid], 1);
    PlayerTextDrawColor(playerid, class_show[playerid], COLOR_WHITE);
    PlayerTextDrawSetShadow(playerid, class_show[playerid], 0);
    PlayerTextDrawSetOutline(playerid, class_show[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, class_show[playerid], 51);
    PlayerTextDrawFont(playerid, class_show[playerid], 1);
    PlayerTextDrawSetProportional(playerid, class_show[playerid], 1);

    // TEAM
    TeamNameLabel[playerid] = CreatePlayerTextDraw(playerid, show_x, show_y, "TEAM_NAME");
    PlayerTextDrawLetterSize(playerid, TeamNameLabel[playerid], labelsize_x, labelsize_y);
    PlayerTextDrawTextSize(playerid, TeamNameLabel[playerid], 100.000000, -51.022224);
    PlayerTextDrawAlignment(playerid, TeamNameLabel[playerid], 1);
    PlayerTextDrawColor(playerid, TeamNameLabel[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, TeamNameLabel[playerid], 0);
    PlayerTextDrawSetOutline(playerid, TeamNameLabel[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, TeamNameLabel[playerid], 51);
    PlayerTextDrawFont(playerid, TeamNameLabel[playerid], 2);
    PlayerTextDrawSetProportional(playerid, TeamNameLabel[playerid], 1);

    teamname_show[playerid] = CreatePlayerTextDraw(playerid, show_x, show_y+10, "TEAM_NAME_INPUT");
    PlayerTextDrawLetterSize(playerid, teamname_show[playerid], 0.4, 1.600000);
    PlayerTextDrawAlignment(playerid, teamname_show[playerid], 1);
    PlayerTextDrawColor(playerid, teamname_show[playerid], COLOR_WHITE);
    PlayerTextDrawSetShadow(playerid, teamname_show[playerid], 0);
    PlayerTextDrawSetOutline(playerid, teamname_show[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, teamname_show[playerid], 51);
    PlayerTextDrawFont(playerid, teamname_show[playerid], 1);
    PlayerTextDrawSetProportional(playerid, teamname_show[playerid], 1);

    TeamleaderLabel[playerid] = CreatePlayerTextDraw(playerid, show_x, show_y + (show_y_plus*1), "TEAM_LEADER");
    PlayerTextDrawLetterSize(playerid, TeamleaderLabel[playerid], labelsize_x, labelsize_y);
    PlayerTextDrawAlignment(playerid, TeamleaderLabel[playerid], 1);
    PlayerTextDrawColor(playerid, TeamleaderLabel[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, TeamleaderLabel[playerid], 0);
    PlayerTextDrawSetOutline(playerid, TeamleaderLabel[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, TeamleaderLabel[playerid], 51);
    PlayerTextDrawFont(playerid, TeamleaderLabel[playerid], 2);
    PlayerTextDrawSetProportional(playerid, TeamleaderLabel[playerid], 1);

    teamleader_show[playerid] = CreatePlayerTextDraw(playerid, show_x, (show_y+10) + (show_y_plus*1), "TEAM_LEADER_INPUT");
    PlayerTextDrawLetterSize(playerid, teamleader_show[playerid], 0.4, 1.600000);
    PlayerTextDrawAlignment(playerid, teamleader_show[playerid], 1);
    PlayerTextDrawColor(playerid, teamleader_show[playerid], COLOR_WHITE);
    PlayerTextDrawSetShadow(playerid, teamleader_show[playerid], 0);
    PlayerTextDrawSetOutline(playerid, teamleader_show[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, teamleader_show[playerid], 51);
    PlayerTextDrawFont(playerid, teamleader_show[playerid], 1);
    PlayerTextDrawSetProportional(playerid, teamleader_show[playerid], 1);
    return 1;
}

ProfileUpdate(playerid, colorset)
{
    ProfileLabel_Selection[playerid] = CreatePlayerTextDraw(playerid, 122.000000, 177.955566, "PROFILE"); // SELECTABLE
    //PlayerTextDrawUseBox(playerid, ProfileLabel_Selection[playerid], 1);
    PlayerTextDrawTextSize(playerid, ProfileLabel_Selection[playerid], 176.000000, 20);
    PlayerTextDrawLetterSize(playerid, ProfileLabel_Selection[playerid], 0.449999, 1.600000);
    PlayerTextDrawAlignment(playerid, ProfileLabel_Selection[playerid], 1);
    PlayerTextDrawColor(playerid, ProfileLabel_Selection[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, ProfileLabel_Selection[playerid], 0);
    PlayerTextDrawSetOutline(playerid, ProfileLabel_Selection[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, ProfileLabel_Selection[playerid], 51);
    PlayerTextDrawFont(playerid, ProfileLabel_Selection[playerid], 3);
    PlayerTextDrawSetProportional(playerid, ProfileLabel_Selection[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, ProfileLabel_Selection[playerid], true);
    return 1;
}

HierarchyUpdate(playerid, colorset)
{
    HierarchyLabel_Selection[playerid] = CreatePlayerTextDraw(playerid, 111.000000, 226.488937, "HIERARCHY"); // SELECTABLE
    PlayerTextDrawTextSize(playerid, HierarchyLabel_Selection[playerid], 187.500000, 20);
    PlayerTextDrawLetterSize(playerid, HierarchyLabel_Selection[playerid], 0.449999, 1.600000);
    PlayerTextDrawAlignment(playerid, HierarchyLabel_Selection[playerid], 1);
    PlayerTextDrawColor(playerid, HierarchyLabel_Selection[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, HierarchyLabel_Selection[playerid], 0);
    PlayerTextDrawSetOutline(playerid, HierarchyLabel_Selection[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, HierarchyLabel_Selection[playerid], 51);
    PlayerTextDrawFont(playerid, HierarchyLabel_Selection[playerid], 3);
    PlayerTextDrawSetProportional(playerid, HierarchyLabel_Selection[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, HierarchyLabel_Selection[playerid], true);
    return 1;
}

TeamUpdate(playerid, colorset)
{
    TeamLabel_Selection[playerid] = CreatePlayerTextDraw(playerid, 129.000000, 276.266693, "TEAM"); // SELECTABLE
    PlayerTextDrawTextSize(playerid, TeamLabel_Selection[playerid], 170.000000, 20);
    PlayerTextDrawLetterSize(playerid, TeamLabel_Selection[playerid], 0.449999, 1.600000);
    PlayerTextDrawAlignment(playerid, TeamLabel_Selection[playerid], 1);
    PlayerTextDrawColor(playerid, TeamLabel_Selection[playerid], colorset);
    PlayerTextDrawSetShadow(playerid, TeamLabel_Selection[playerid], 0);
    PlayerTextDrawSetOutline(playerid, TeamLabel_Selection[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, TeamLabel_Selection[playerid], 51);
    PlayerTextDrawFont(playerid, TeamLabel_Selection[playerid], 3);
    PlayerTextDrawSetProportional(playerid, TeamLabel_Selection[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, TeamLabel_Selection[playerid], true);
    return 1;
}