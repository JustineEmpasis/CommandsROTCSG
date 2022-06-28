#define NULL_NEGATIVE           -1
#define NULL_ZERO               0
#define PLAYER_BUFFER           1000

#define MAX_STRING              2048

GetPlayerBuffer(playerid) {
    return playerid+PLAYER_BUFFER;
}