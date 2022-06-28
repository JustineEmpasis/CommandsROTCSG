#include <YSI_Coding\y_hooks>

new
    PlayerText:header_box[MAX_PLAYERS],
    PlayerText:register_header[MAX_PLAYERS],
    PlayerText:details_container[MAX_PLAYERS],
    PlayerText:footer_box[MAX_PLAYERS],
    PlayerText:skin_box[MAX_PLAYERS],
    PlayerText:skin_title[MAX_PLAYERS],
    PlayerText:arrow_left[MAX_PLAYERS],
    PlayerText:arrow_right[MAX_PLAYERS],
    PlayerText:skin_model[MAX_PLAYERS],
    PlayerText:name_title[MAX_PLAYERS],
    PlayerText:password_title[MAX_PLAYERS],
    PlayerText:confirm_password_title[MAX_PLAYERS],
    PlayerText:email_title[MAX_PLAYERS],
    PlayerText:gender_title[MAX_PLAYERS],
    PlayerText:register_box[MAX_PLAYERS],
    PlayerText:exit_box[MAX_PLAYERS],
    PlayerText:register_button[MAX_PLAYERS],
    PlayerText:exit_button[MAX_PLAYERS],
    PlayerText:name_input_box[MAX_PLAYERS],
    PlayerText:password_input_box[MAX_PLAYERS],
    PlayerText:confirm_password_input_box[MAX_PLAYERS],
    PlayerText:email_input_box[MAX_PLAYERS],
    PlayerText:gender_input_box[MAX_PLAYERS],
    PlayerText:name_input[MAX_PLAYERS],
    PlayerText:password_input[MAX_PLAYERS],
    PlayerText:confirm_password_input[MAX_PLAYERS],
    PlayerText:email_input[MAX_PLAYERS],
    PlayerText:gender_input[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    header_box[playerid] = CreatePlayerTextDraw(playerid, 320.000000, 0.000000, "_");
    PlayerTextDrawFont(playerid, header_box[playerid], 1);
    PlayerTextDrawLetterSize(playerid, header_box[playerid], 0.600000, 8.800003);
    PlayerTextDrawTextSize(playerid, header_box[playerid], 298.500000, 639.000000);
    PlayerTextDrawSetOutline(playerid, header_box[playerid], 1);
    PlayerTextDrawSetShadow(playerid, header_box[playerid], 0);
    PlayerTextDrawAlignment(playerid, header_box[playerid], 2);
    PlayerTextDrawColor(playerid, header_box[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, header_box[playerid], 255);
    PlayerTextDrawBoxColor(playerid, header_box[playerid], 255);
    PlayerTextDrawUseBox(playerid, header_box[playerid], 1);
    PlayerTextDrawSetProportional(playerid, header_box[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, header_box[playerid], 0);

    register_header[playerid] = CreatePlayerTextDraw(playerid, 320.000000, 47.000000, "Register_Account");
    PlayerTextDrawFont(playerid, register_header[playerid], 3);
    PlayerTextDrawLetterSize(playerid, register_header[playerid], 0.762498, 2.500000);
    PlayerTextDrawTextSize(playerid, register_header[playerid], 400.000000, -33.000000);
    PlayerTextDrawSetOutline(playerid, register_header[playerid], 1);
    PlayerTextDrawSetShadow(playerid, register_header[playerid], 0);
    PlayerTextDrawAlignment(playerid, register_header[playerid], 2);
    PlayerTextDrawColor(playerid, register_header[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, register_header[playerid], 255);
    PlayerTextDrawBoxColor(playerid, register_header[playerid], 50);
    PlayerTextDrawUseBox(playerid, register_header[playerid], 0);
    PlayerTextDrawSetProportional(playerid, register_header[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, register_header[playerid], 0);

    details_container[playerid] = CreatePlayerTextDraw(playerid, 412.000000, 88.000000, "_");
    PlayerTextDrawFont(playerid, details_container[playerid], 1);
    PlayerTextDrawLetterSize(playerid, details_container[playerid], 0.600000, 32.349979);
    PlayerTextDrawTextSize(playerid, details_container[playerid], 298.500000, 445.000000);
    PlayerTextDrawSetOutline(playerid, details_container[playerid], 1);
    PlayerTextDrawSetShadow(playerid, details_container[playerid], 0);
    PlayerTextDrawAlignment(playerid, details_container[playerid], 2);
    PlayerTextDrawColor(playerid, details_container[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, details_container[playerid], 255);
    PlayerTextDrawBoxColor(playerid, details_container[playerid], 135);
    PlayerTextDrawUseBox(playerid, details_container[playerid], 1);
    PlayerTextDrawSetProportional(playerid, details_container[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, details_container[playerid], 0);

    footer_box[playerid] = CreatePlayerTextDraw(playerid, 320.000000, 386.000000, "_");
    PlayerTextDrawFont(playerid, footer_box[playerid], 1);
    PlayerTextDrawLetterSize(playerid, footer_box[playerid], 0.600000, 6.800003);
    PlayerTextDrawTextSize(playerid, footer_box[playerid], 298.500000, 638.000000);
    PlayerTextDrawSetOutline(playerid, footer_box[playerid], 1);
    PlayerTextDrawSetShadow(playerid, footer_box[playerid], 0);
    PlayerTextDrawAlignment(playerid, footer_box[playerid], 2);
    PlayerTextDrawColor(playerid, footer_box[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, footer_box[playerid], 255);
    PlayerTextDrawBoxColor(playerid, footer_box[playerid], 255);
    PlayerTextDrawUseBox(playerid, footer_box[playerid], 1);
    PlayerTextDrawSetProportional(playerid, footer_box[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, footer_box[playerid], 0);

    skin_box[playerid] = CreatePlayerTextDraw(playerid, 96.000000, 88.000000, "_");
    PlayerTextDrawFont(playerid, skin_box[playerid], 1);
    PlayerTextDrawLetterSize(playerid, skin_box[playerid], 0.600000, 32.349979);
    PlayerTextDrawTextSize(playerid, skin_box[playerid], 298.500000, 180.500000);
    PlayerTextDrawSetOutline(playerid, skin_box[playerid], 1);
    PlayerTextDrawSetShadow(playerid, skin_box[playerid], 0);
    PlayerTextDrawAlignment(playerid, skin_box[playerid], 2);
    PlayerTextDrawColor(playerid, skin_box[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, skin_box[playerid], 255);
    PlayerTextDrawBoxColor(playerid, skin_box[playerid], 135);
    PlayerTextDrawUseBox(playerid, skin_box[playerid], 1);
    PlayerTextDrawSetProportional(playerid, skin_box[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, skin_box[playerid], 0);

    skin_title[playerid] = CreatePlayerTextDraw(playerid, 97.000000, 358.000000, "Skin");
    PlayerTextDrawFont(playerid, skin_title[playerid], 2);
    PlayerTextDrawLetterSize(playerid, skin_title[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, skin_title[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, skin_title[playerid], 1);
    PlayerTextDrawSetShadow(playerid, skin_title[playerid], 0);
    PlayerTextDrawAlignment(playerid, skin_title[playerid], 2);
    PlayerTextDrawColor(playerid, skin_title[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, skin_title[playerid], 255);
    PlayerTextDrawBoxColor(playerid, skin_title[playerid], 50);
    PlayerTextDrawUseBox(playerid, skin_title[playerid], 0);
    PlayerTextDrawSetProportional(playerid, skin_title[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, skin_title[playerid], 0);

    arrow_left[playerid] = CreatePlayerTextDraw(playerid, 15.000000, 360.000000, "ld_beat:left");
    PlayerTextDrawFont(playerid, arrow_left[playerid], 4);
    PlayerTextDrawLetterSize(playerid, arrow_left[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, arrow_left[playerid], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, arrow_left[playerid], 1);
    PlayerTextDrawSetShadow(playerid, arrow_left[playerid], 0);
    PlayerTextDrawAlignment(playerid, arrow_left[playerid], 2);
    PlayerTextDrawColor(playerid, arrow_left[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, arrow_left[playerid], 255);
    PlayerTextDrawBoxColor(playerid, arrow_left[playerid], 50);
    PlayerTextDrawUseBox(playerid, arrow_left[playerid], 1);
    PlayerTextDrawSetProportional(playerid, arrow_left[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, arrow_left[playerid], 1);

    arrow_right[playerid] = CreatePlayerTextDraw(playerid, 160.000000, 360.000000, "ld_beat:right");
    PlayerTextDrawFont(playerid, arrow_right[playerid], 4);
    PlayerTextDrawLetterSize(playerid, arrow_right[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, arrow_right[playerid], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, arrow_right[playerid], 1);
    PlayerTextDrawSetShadow(playerid, arrow_right[playerid], 0);
    PlayerTextDrawAlignment(playerid, arrow_right[playerid], 2);
    PlayerTextDrawColor(playerid, arrow_right[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, arrow_right[playerid], 255);
    PlayerTextDrawBoxColor(playerid, arrow_right[playerid], 50);
    PlayerTextDrawUseBox(playerid, arrow_right[playerid], 1);
    PlayerTextDrawSetProportional(playerid, arrow_right[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, arrow_right[playerid], 1);

    skin_model[playerid] = CreatePlayerTextDraw(playerid, -11.000000, 85.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, skin_model[playerid], 5);
    PlayerTextDrawLetterSize(playerid, skin_model[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, skin_model[playerid], 203.500000, 258.000000);
    PlayerTextDrawSetOutline(playerid, skin_model[playerid], 0);
    PlayerTextDrawSetShadow(playerid, skin_model[playerid], 0);
    PlayerTextDrawAlignment(playerid, skin_model[playerid], 1);
    PlayerTextDrawColor(playerid, skin_model[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, skin_model[playerid], 0);
    PlayerTextDrawBoxColor(playerid, skin_model[playerid], 255);
    PlayerTextDrawUseBox(playerid, skin_model[playerid], 0);
    PlayerTextDrawSetProportional(playerid, skin_model[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, skin_model[playerid], 0);
    PlayerTextDrawSetPreviewModel(playerid, skin_model[playerid], 2);
    PlayerTextDrawSetPreviewRot(playerid, skin_model[playerid], 6.000000, 0.000000, 23.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, skin_model[playerid], 1, 1);

    name_title[playerid] = CreatePlayerTextDraw(playerid, 340.000000, 146.000000, "Name");
    PlayerTextDrawFont(playerid, name_title[playerid], 2);
    PlayerTextDrawLetterSize(playerid, name_title[playerid], 0.330000, 2.000000);
    PlayerTextDrawTextSize(playerid, name_title[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, name_title[playerid], 1);
    PlayerTextDrawSetShadow(playerid, name_title[playerid], 0);
    PlayerTextDrawAlignment(playerid, name_title[playerid], 3);
    PlayerTextDrawColor(playerid, name_title[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, name_title[playerid], 255);
    PlayerTextDrawBoxColor(playerid, name_title[playerid], 50);
    PlayerTextDrawUseBox(playerid, name_title[playerid], 0);
    PlayerTextDrawSetProportional(playerid, name_title[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, name_title[playerid], 0);

    password_title[playerid] = CreatePlayerTextDraw(playerid, 340.000000, 176.000000, "Password");
    PlayerTextDrawFont(playerid, password_title[playerid], 2);
    PlayerTextDrawLetterSize(playerid, password_title[playerid], 0.330000, 2.000000);
    PlayerTextDrawTextSize(playerid, password_title[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, password_title[playerid], 1);
    PlayerTextDrawSetShadow(playerid, password_title[playerid], 0);
    PlayerTextDrawAlignment(playerid, password_title[playerid], 3);
    PlayerTextDrawColor(playerid, password_title[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, password_title[playerid], 255);
    PlayerTextDrawBoxColor(playerid, password_title[playerid], 50);
    PlayerTextDrawUseBox(playerid, password_title[playerid], 0);
    PlayerTextDrawSetProportional(playerid, password_title[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, password_title[playerid], 0);

    confirm_password_title[playerid] = CreatePlayerTextDraw(playerid, 340.000000, 206.000000, "Confirm_Password");
    PlayerTextDrawFont(playerid, confirm_password_title[playerid], 2);
    PlayerTextDrawLetterSize(playerid, confirm_password_title[playerid], 0.330000, 2.000000);
    PlayerTextDrawTextSize(playerid, confirm_password_title[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, confirm_password_title[playerid], 1);
    PlayerTextDrawSetShadow(playerid, confirm_password_title[playerid], 0);
    PlayerTextDrawAlignment(playerid, confirm_password_title[playerid], 3);
    PlayerTextDrawColor(playerid, confirm_password_title[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, confirm_password_title[playerid], 255);
    PlayerTextDrawBoxColor(playerid, confirm_password_title[playerid], 50);
    PlayerTextDrawUseBox(playerid, confirm_password_title[playerid], 0);
    PlayerTextDrawSetProportional(playerid, confirm_password_title[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, confirm_password_title[playerid], 0);

    email_title[playerid] = CreatePlayerTextDraw(playerid, 340.000000, 235.000000, "Email");
    PlayerTextDrawFont(playerid, email_title[playerid], 2);
    PlayerTextDrawLetterSize(playerid, email_title[playerid], 0.330000, 2.000000);
    PlayerTextDrawTextSize(playerid, email_title[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, email_title[playerid], 1);
    PlayerTextDrawSetShadow(playerid, email_title[playerid], 0);
    PlayerTextDrawAlignment(playerid, email_title[playerid], 3);
    PlayerTextDrawColor(playerid, email_title[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, email_title[playerid], 255);
    PlayerTextDrawBoxColor(playerid, email_title[playerid], 50);
    PlayerTextDrawUseBox(playerid, email_title[playerid], 0);
    PlayerTextDrawSetProportional(playerid, email_title[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, email_title[playerid], 0);

    gender_title[playerid] = CreatePlayerTextDraw(playerid, 340.000000, 264.000000, "Gender");
    PlayerTextDrawFont(playerid, gender_title[playerid], 2);
    PlayerTextDrawLetterSize(playerid, gender_title[playerid], 0.330000, 2.000000);
    PlayerTextDrawTextSize(playerid, gender_title[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, gender_title[playerid], 1);
    PlayerTextDrawSetShadow(playerid, gender_title[playerid], 0);
    PlayerTextDrawAlignment(playerid, gender_title[playerid], 3);
    PlayerTextDrawColor(playerid, gender_title[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, gender_title[playerid], 255);
    PlayerTextDrawBoxColor(playerid, gender_title[playerid], 50);
    PlayerTextDrawUseBox(playerid, gender_title[playerid], 0);
    PlayerTextDrawSetProportional(playerid, gender_title[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, gender_title[playerid], 0);

    register_box[playerid] = CreatePlayerTextDraw(playerid, 247.000000, 336.000000, "_");
    PlayerTextDrawFont(playerid, register_box[playerid], 2);
    PlayerTextDrawLetterSize(playerid, register_box[playerid], 0.600000, 4.800003);
    PlayerTextDrawTextSize(playerid, register_box[playerid], 298.500000, 115.500000);
    PlayerTextDrawSetOutline(playerid, register_box[playerid], 1);
    PlayerTextDrawSetShadow(playerid, register_box[playerid], 0);
    PlayerTextDrawAlignment(playerid, register_box[playerid], 2);
    PlayerTextDrawColor(playerid, register_box[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, register_box[playerid], 255);
    PlayerTextDrawBoxColor(playerid, register_box[playerid], 16711815);
    PlayerTextDrawUseBox(playerid, register_box[playerid], 1);
    PlayerTextDrawSetProportional(playerid, register_box[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, register_box[playerid], 0);

    exit_box[playerid] = CreatePlayerTextDraw(playerid, 577.000000, 336.000000, "_");
    PlayerTextDrawFont(playerid, exit_box[playerid], 1);
    PlayerTextDrawLetterSize(playerid, exit_box[playerid], 0.600000, 4.800000);
    PlayerTextDrawTextSize(playerid, exit_box[playerid], 298.500000, 115.500000);
    PlayerTextDrawSetOutline(playerid, exit_box[playerid], 1);
    PlayerTextDrawSetShadow(playerid, exit_box[playerid], 0);
    PlayerTextDrawAlignment(playerid, exit_box[playerid], 2);
    PlayerTextDrawColor(playerid, exit_box[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, exit_box[playerid], 255);
    PlayerTextDrawBoxColor(playerid, exit_box[playerid], -16777081);
    PlayerTextDrawUseBox(playerid, exit_box[playerid], 1);
    PlayerTextDrawSetProportional(playerid, exit_box[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, exit_box[playerid], 0);

    register_button[playerid] = CreatePlayerTextDraw(playerid, 247.000000, 345.000000, "Register");
    PlayerTextDrawFont(playerid, register_button[playerid], 2);
    PlayerTextDrawLetterSize(playerid, register_button[playerid], 0.404166, 2.599997);
    PlayerTextDrawTextSize(playerid, register_button[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, register_button[playerid], 1);
    PlayerTextDrawSetShadow(playerid, register_button[playerid], 0);
    PlayerTextDrawAlignment(playerid, register_button[playerid], 2);
    PlayerTextDrawColor(playerid, register_button[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, register_button[playerid], 255);
    PlayerTextDrawBoxColor(playerid, register_button[playerid], 50);
    PlayerTextDrawUseBox(playerid, register_button[playerid], 0);
    PlayerTextDrawSetProportional(playerid, register_button[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, register_button[playerid], 1);

    exit_button[playerid] = CreatePlayerTextDraw(playerid, 577.000000, 345.000000, "Exit");
    PlayerTextDrawFont(playerid, exit_button[playerid], 2);
    PlayerTextDrawLetterSize(playerid, exit_button[playerid], 0.404166, 2.599997);
    PlayerTextDrawTextSize(playerid, exit_button[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, exit_button[playerid], 1);
    PlayerTextDrawSetShadow(playerid, exit_button[playerid], 0);
    PlayerTextDrawAlignment(playerid, exit_button[playerid], 2);
    PlayerTextDrawColor(playerid, exit_button[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, exit_button[playerid], 255);
    PlayerTextDrawBoxColor(playerid, exit_button[playerid], 50);
    PlayerTextDrawUseBox(playerid, exit_button[playerid], 0);
    PlayerTextDrawSetProportional(playerid, exit_button[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, exit_button[playerid], 1);

    name_input_box[playerid] = CreatePlayerTextDraw(playerid, 461.000000, 149.000000, "_");
    PlayerTextDrawFont(playerid, name_input_box[playerid], 1);
    PlayerTextDrawLetterSize(playerid, name_input_box[playerid], 0.600000, 1.700003);
    PlayerTextDrawTextSize(playerid, name_input_box[playerid], 298.500000, 223.500000);
    PlayerTextDrawSetOutline(playerid, name_input_box[playerid], 1);
    PlayerTextDrawSetShadow(playerid, name_input_box[playerid], 0);
    PlayerTextDrawAlignment(playerid, name_input_box[playerid], 2);
    PlayerTextDrawColor(playerid, name_input_box[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, name_input_box[playerid], 255);
    PlayerTextDrawBoxColor(playerid, name_input_box[playerid], 135);
    PlayerTextDrawUseBox(playerid, name_input_box[playerid], 1);
    PlayerTextDrawSetProportional(playerid, name_input_box[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, name_input_box[playerid], 0);

    password_input_box[playerid] = CreatePlayerTextDraw(playerid, 461.000000, 179.000000, "_");
    PlayerTextDrawFont(playerid, password_input_box[playerid], 1);
    PlayerTextDrawLetterSize(playerid, password_input_box[playerid], 0.600000, 1.700003);
    PlayerTextDrawTextSize(playerid, password_input_box[playerid], 298.500000, 223.500000);
    PlayerTextDrawSetOutline(playerid, password_input_box[playerid], 1);
    PlayerTextDrawSetShadow(playerid, password_input_box[playerid], 0);
    PlayerTextDrawAlignment(playerid, password_input_box[playerid], 2);
    PlayerTextDrawColor(playerid, password_input_box[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, password_input_box[playerid], 255);
    PlayerTextDrawBoxColor(playerid, password_input_box[playerid], 135);
    PlayerTextDrawUseBox(playerid, password_input_box[playerid], 1);
    PlayerTextDrawSetProportional(playerid, password_input_box[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, password_input_box[playerid], 0);

    confirm_password_input_box[playerid] = CreatePlayerTextDraw(playerid, 461.000000, 210.000000, "_");
    PlayerTextDrawFont(playerid, confirm_password_input_box[playerid], 1);
    PlayerTextDrawLetterSize(playerid, confirm_password_input_box[playerid], 0.600000, 1.700003);
    PlayerTextDrawTextSize(playerid, confirm_password_input_box[playerid], 298.500000, 223.500000);
    PlayerTextDrawSetOutline(playerid, confirm_password_input_box[playerid], 1);
    PlayerTextDrawSetShadow(playerid, confirm_password_input_box[playerid], 0);
    PlayerTextDrawAlignment(playerid, confirm_password_input_box[playerid], 2);
    PlayerTextDrawColor(playerid, confirm_password_input_box[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, confirm_password_input_box[playerid], 255);
    PlayerTextDrawBoxColor(playerid, confirm_password_input_box[playerid], 135);
    PlayerTextDrawUseBox(playerid, confirm_password_input_box[playerid], 1);
    PlayerTextDrawSetProportional(playerid, confirm_password_input_box[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, confirm_password_input_box[playerid], 0);

    email_input_box[playerid] = CreatePlayerTextDraw(playerid, 461.000000, 238.000000, "_");
    PlayerTextDrawFont(playerid, email_input_box[playerid], 1);
    PlayerTextDrawLetterSize(playerid, email_input_box[playerid], 0.600000, 1.700003);
    PlayerTextDrawTextSize(playerid, email_input_box[playerid], 298.500000, 223.500000);
    PlayerTextDrawSetOutline(playerid, email_input_box[playerid], 1);
    PlayerTextDrawSetShadow(playerid, email_input_box[playerid], 0);
    PlayerTextDrawAlignment(playerid, email_input_box[playerid], 2);
    PlayerTextDrawColor(playerid, email_input_box[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, email_input_box[playerid], 255);
    PlayerTextDrawBoxColor(playerid, email_input_box[playerid], 135);
    PlayerTextDrawUseBox(playerid, email_input_box[playerid], 1);
    PlayerTextDrawSetProportional(playerid, email_input_box[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, email_input_box[playerid], 0);

    gender_input_box[playerid] = CreatePlayerTextDraw(playerid, 461.000000, 267.000000, "_");
    PlayerTextDrawFont(playerid, gender_input_box[playerid], 1);
    PlayerTextDrawLetterSize(playerid, gender_input_box[playerid], 0.600000, 1.700003);
    PlayerTextDrawTextSize(playerid, gender_input_box[playerid], 298.500000, 223.500000);
    PlayerTextDrawSetOutline(playerid, gender_input_box[playerid], 1);
    PlayerTextDrawSetShadow(playerid, gender_input_box[playerid], 0);
    PlayerTextDrawAlignment(playerid, gender_input_box[playerid], 2);
    PlayerTextDrawColor(playerid, gender_input_box[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, gender_input_box[playerid], 255);
    PlayerTextDrawBoxColor(playerid, gender_input_box[playerid], 135);
    PlayerTextDrawUseBox(playerid, gender_input_box[playerid], 1);
    PlayerTextDrawSetProportional(playerid, gender_input_box[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, gender_input_box[playerid], 0);

    name_input[playerid] = CreatePlayerTextDraw(playerid, 353.000000, 148.000000, GetPlayerNameEx(playerid));
    PlayerTextDrawFont(playerid, name_input[playerid], 1);
    PlayerTextDrawLetterSize(playerid, name_input[playerid], 0.375000, 1.700000);
    PlayerTextDrawTextSize(playerid, name_input[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, name_input[playerid], 1);
    PlayerTextDrawSetShadow(playerid, name_input[playerid], 0);
    PlayerTextDrawAlignment(playerid, name_input[playerid], 1);
    PlayerTextDrawColor(playerid, name_input[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, name_input[playerid], 255);
    PlayerTextDrawBoxColor(playerid, name_input[playerid], 50);
    PlayerTextDrawUseBox(playerid, name_input[playerid], 0);
    PlayerTextDrawSetProportional(playerid, name_input[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, name_input[playerid], 1);

    password_input[playerid] = CreatePlayerTextDraw(playerid, 353.000000, 178.000000, "xxxxxxxxxxxxxxxx");
    PlayerTextDrawFont(playerid, password_input[playerid], 1);
    PlayerTextDrawLetterSize(playerid, password_input[playerid], 0.375000, 1.700000);
    PlayerTextDrawTextSize(playerid, password_input[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, password_input[playerid], 1);
    PlayerTextDrawSetShadow(playerid, password_input[playerid], 0);
    PlayerTextDrawAlignment(playerid, password_input[playerid], 1);
    PlayerTextDrawColor(playerid, password_input[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, password_input[playerid], 255);
    PlayerTextDrawBoxColor(playerid, password_input[playerid], 50);
    PlayerTextDrawUseBox(playerid, password_input[playerid], 0);
    PlayerTextDrawSetProportional(playerid, password_input[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, password_input[playerid], 1);

    confirm_password_input[playerid] = CreatePlayerTextDraw(playerid, 353.000000, 207.000000, "xxxxxxxxxxxxxxxx");
    PlayerTextDrawFont(playerid, confirm_password_input[playerid], 1);
    PlayerTextDrawLetterSize(playerid, confirm_password_input[playerid], 0.375000, 1.700000);
    PlayerTextDrawTextSize(playerid, confirm_password_input[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, confirm_password_input[playerid], 1);
    PlayerTextDrawSetShadow(playerid, confirm_password_input[playerid], 0);
    PlayerTextDrawAlignment(playerid, confirm_password_input[playerid], 1);
    PlayerTextDrawColor(playerid, confirm_password_input[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, confirm_password_input[playerid], 255);
    PlayerTextDrawBoxColor(playerid, confirm_password_input[playerid], 50);
    PlayerTextDrawUseBox(playerid, confirm_password_input[playerid], 0);
    PlayerTextDrawSetProportional(playerid, confirm_password_input[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, confirm_password_input[playerid], 1);

    email_input[playerid] = CreatePlayerTextDraw(playerid, 353.000000, 236.000000, "Email_Input");
    PlayerTextDrawFont(playerid, email_input[playerid], 1);
    PlayerTextDrawLetterSize(playerid, email_input[playerid], 0.375000, 1.700000);
    PlayerTextDrawTextSize(playerid, email_input[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, email_input[playerid], 1);
    PlayerTextDrawSetShadow(playerid, email_input[playerid], 0);
    PlayerTextDrawAlignment(playerid, email_input[playerid], 1);
    PlayerTextDrawColor(playerid, email_input[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, email_input[playerid], 255);
    PlayerTextDrawBoxColor(playerid, email_input[playerid], 50);
    PlayerTextDrawUseBox(playerid, email_input[playerid], 0);
    PlayerTextDrawSetProportional(playerid, email_input[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, email_input[playerid], 1);

    gender_input[playerid] = CreatePlayerTextDraw(playerid, 353.000000, 265.000000, "Male");
    PlayerTextDrawFont(playerid, gender_input[playerid], 1);
    PlayerTextDrawLetterSize(playerid, gender_input[playerid], 0.375000, 1.700000);
    PlayerTextDrawTextSize(playerid, gender_input[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, gender_input[playerid], 1);
    PlayerTextDrawSetShadow(playerid, gender_input[playerid], 0);
    PlayerTextDrawAlignment(playerid, gender_input[playerid], 1);
    PlayerTextDrawColor(playerid, gender_input[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, gender_input[playerid], 255);
    PlayerTextDrawBoxColor(playerid, gender_input[playerid], 50);
    PlayerTextDrawUseBox(playerid, gender_input[playerid], 0);
    PlayerTextDrawSetProportional(playerid, gender_input[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, gender_input[playerid], 1);

    return 1;
}

RegistrationTD(playerid, toggle=true) {
    if(toggle) {
        PlayerTextDrawShow(playerid, header_box[playerid]);
        PlayerTextDrawShow(playerid, register_header[playerid]);
        PlayerTextDrawShow(playerid, details_container[playerid]);
        PlayerTextDrawShow(playerid, footer_box[playerid]);
        PlayerTextDrawShow(playerid, skin_box[playerid]);
        PlayerTextDrawShow(playerid, skin_title[playerid]);
        PlayerTextDrawShow(playerid, arrow_left[playerid]);
        PlayerTextDrawShow(playerid, arrow_right[playerid]);
        PlayerTextDrawShow(playerid, skin_model[playerid]);
        PlayerTextDrawShow(playerid, name_title[playerid]);
        PlayerTextDrawShow(playerid, password_title[playerid]);
        PlayerTextDrawShow(playerid, confirm_password_title[playerid]);
        PlayerTextDrawShow(playerid, email_title[playerid]);
        PlayerTextDrawShow(playerid, gender_title[playerid]);
        PlayerTextDrawShow(playerid, register_box[playerid]);
        PlayerTextDrawShow(playerid, exit_box[playerid]);
        PlayerTextDrawShow(playerid, register_button[playerid]);
        PlayerTextDrawShow(playerid, exit_button[playerid]);
        PlayerTextDrawShow(playerid, name_input_box[playerid]);
        PlayerTextDrawShow(playerid, password_input_box[playerid]);
        PlayerTextDrawShow(playerid, confirm_password_input_box[playerid]);
        PlayerTextDrawShow(playerid, email_input_box[playerid]);
        PlayerTextDrawShow(playerid, gender_input_box[playerid]);
        PlayerTextDrawShow(playerid, name_input[playerid]);
        PlayerTextDrawShow(playerid, password_input[playerid]);
        PlayerTextDrawShow(playerid, confirm_password_input[playerid]);
        PlayerTextDrawShow(playerid, email_input[playerid]);
        PlayerTextDrawShow(playerid, gender_input[playerid]);
        SelectTextDraw(playerid, 0xFF0000FF);
    } else {
        PlayerTextDrawHide(playerid, header_box[playerid]);
        PlayerTextDrawHide(playerid, register_header[playerid]);
        PlayerTextDrawHide(playerid, details_container[playerid]);
        PlayerTextDrawHide(playerid, footer_box[playerid]);
        PlayerTextDrawHide(playerid, skin_box[playerid]);
        PlayerTextDrawHide(playerid, skin_title[playerid]);
        PlayerTextDrawHide(playerid, arrow_left[playerid]);
        PlayerTextDrawHide(playerid, arrow_right[playerid]);
        PlayerTextDrawHide(playerid, skin_model[playerid]);
        PlayerTextDrawHide(playerid, name_title[playerid]);
        PlayerTextDrawHide(playerid, password_title[playerid]);
        PlayerTextDrawHide(playerid, confirm_password_title[playerid]);
        PlayerTextDrawHide(playerid, email_title[playerid]);
        PlayerTextDrawHide(playerid, gender_title[playerid]);
        PlayerTextDrawHide(playerid, register_box[playerid]);
        PlayerTextDrawHide(playerid, exit_box[playerid]);
        PlayerTextDrawHide(playerid, register_button[playerid]);
        PlayerTextDrawHide(playerid, exit_button[playerid]);
        PlayerTextDrawHide(playerid, name_input_box[playerid]);
        PlayerTextDrawHide(playerid, password_input_box[playerid]);
        PlayerTextDrawHide(playerid, confirm_password_input_box[playerid]);
        PlayerTextDrawHide(playerid, email_input_box[playerid]);
        PlayerTextDrawHide(playerid, gender_input_box[playerid]);
        PlayerTextDrawHide(playerid, name_input[playerid]);
        PlayerTextDrawHide(playerid, password_input[playerid]);
        PlayerTextDrawHide(playerid, confirm_password_input[playerid]);
        PlayerTextDrawHide(playerid, email_input[playerid]);
        PlayerTextDrawHide(playerid, gender_input[playerid]);
        CancelSelectTextDraw(playerid);
    }
}

YCMD:show_td(playerid, params[], help) 
{
    RegistrationTD(playerid);
    return 1;
}