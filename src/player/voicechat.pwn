#include <sampvoice>

#define VOICE_KEY_B     0x42

new
    SV_LSTREAM:PlayerLocalStream[MAX_PLAYERS];

#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid) {
    if(SvGetVersion(playerid) != SV_NULL && SvGetVersion(playerid) != SV_VERSION) {
        SendClientMessageEx2(playerid, COLOR_RED, "[ERROR]: "COL_WHITE"Your voice chat version (v%d) does not match the server's voice chat version (v%d).", SvGetVersion(playerid), SV_VERSION);
        return 1;
    }
    if(SvGetVersion(playerid) == SV_NULL) {
        SendClientMessageEx2(playerid, COLOR_ORANGE, "[WARNING]: "COL_WHITE"You do not have a voice chat plugin installed!");
        return 1;
    }
    if(!SvHasMicro(playerid)) {
        SendClientMessageEx2(playerid, COLOR_ORANGE, "[WARNING]: "COL_WHITE"You do not have a microphone plugged in!");
        return 1;
    }

    PlayerLocalStream[playerid] = SvCreateDLStreamAtPlayer(50.0, SV_INFINITY, playerid, COLOR_ORANGE);
    SvAddKey(playerid, VOICE_KEY_B);

    SendClientMessageEx2(playerid, COLOR_LIMEGREEN, "[SUCCESS]: "COL_WHITE"A voice chat local stream is now attached to you, Press & Hold B to speak.");

    return 1;
}

public SV_VOID:OnPlayerActivationKeyPress(SV_UINT:playerid, SV_UINT:keyid) {
    if(keyid == VOICE_KEY_B) {
        SvAttachSpeakerToStream(PlayerLocalStream[playerid], playerid);
    }
    return 1;
}

public SV_VOID:OnPlayerActivationKeyRelease(SV_UINT:playerid, SV_UINT:keyid) {
    if(keyid == VOICE_KEY_B) {
        SvDetachSpeakerFromStream(PlayerLocalStream[playerid], playerid);
    }
    return 1;
}