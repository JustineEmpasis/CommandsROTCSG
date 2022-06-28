#include <a_samp>
#include <a_mysql>
#include <env>
#include <samp_bcrypt>
#include <streamer>
#include <PawnPlus>
#include <sscanf2>
#include <eSelection>

#define CGEN_MEMORY 20000
#define YSI_NO_HEAP_MALLOC

#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_inline>
#include <YSI_Data\y_iterate>
#include <YSI_Visual\y_dialog>
#include <YSI_Visual\y_commands>
#include <YSI_Extra\y_inline_mysql>
#include <YSI_Extra\y_inline_bcrypt>


new Text:GameTitle;

hook OnGameModeInit() {
    print("Loading gamemode modules...");

    DisableInteriorEnterExits();
    EnableStuntBonusForAll(0);
    
    ShowPlayerMarkers(PLAYER_MARKERS_MODE_STREAMED);

    GameTitle = TextDrawCreate(550.000000, 8.088973, "COMMANDS.ROTCSG");
    TextDrawLetterSize(GameTitle, 0.267998, 1.151996);
    TextDrawAlignment(GameTitle, 1);
    TextDrawColor(GameTitle, -1430619137);
    TextDrawSetShadow(GameTitle, 0);
    TextDrawSetOutline(GameTitle, 1);
    TextDrawBackgroundColor(GameTitle, 51);
    TextDrawFont(GameTitle, 3);
    TextDrawSetProportional(GameTitle, 1);

    return 1;
}


#include "authentication/connection.pwn"

#include "utils/constants.pwn"
#include "utils/colors.pwn"
#include "utils/getter.pwn"
#include "utils/message.pwn"
#include "utils/checker.pwn"
#include "utils/dialogs.pwn"

#include "utils/visual/render_freeze.pwn"

#include "mappings/exterior/academy.pwn"
#include "mappings/exterior/training.pwn"
#include "mappings/interior/clinic.pwn"
#include "mappings/interior/clinic_office.pwn"
#include "mappings/interior/ax_cadetroom.pwn"
#include "mappings/interior/ax_cafeteria.pwn"
#include "mappings/interior/ax_office.pwn"
#include "mappings/interior/ax_sleepingroom.pwn"
#include "mappings/interior/ax_lobby.pwn"

#include "authentication/checking.pwn"

#include "authentication/register_td.pwn"
#include "authentication/registration.pwn"

#include "core/gate.pwn"
#include "core/campus/lockers.pwn"
#include "core/campus/busstop.pwn"
#include "core/campus/paintball.pwn"
#include "core/basics.pwn"

#include "core/admin/commands.pwn"
#include "core/admin/players.pwn"
#include "core/admin/skin.pwn"
#include "core/admin/help.pwn"

#include "core/ranking/default.pwn"
#include "core/ranking/classes.pwn"

#include "authentication/login.pwn"

#include "player/wep_getter.pwn"
#include "player/weaponholster.pwn"
#include "player/voicechat.pwn"
#include "player/roleplay.pwn"
#include "player/rankings.pwn"
#include "player/death.pwn"
#include "player/stats_td.pwn"
#include "player/stats.pwn"
#include "player/fightstyle.pwn"
#include "core/vehicle.pwn"
#include "core/animations.pwn"

main() {
    print("\n\n");
    print("---------------------------------");
    print("SAMP ROTC GAMEMODE HAS STARTED...");
    print("---------------------------------");
    print("\n\n");

    SetGameModeText("ROTCSG v0.1");

    return 1;
}

public OnPlayerConnect(playerid)
{
    SetNameTagDrawDistance(15.0);
    TextDrawShowForPlayer(playerid, GameTitle);
    //ClearChat(playerid);
    //Global Textdraws:

    return 1;
}

public OnPlayerDisconnect(playerid, reason) {
    SendClientMessageEx(playerid, COLOR_YELLOW, MESSAGE_LOCAL, "%s has left the server (%s).", GetPlayerNameEx(playerid), (reason == 1) ? "Quit" : "Crash/Kick");
    return 1;
}
