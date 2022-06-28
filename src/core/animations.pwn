#include <YSI_Coding\y_hooks>

new Text:lshift;

static
    bool:IsInAnimationLoop[MAX_PLAYERS],
    bool:PlayerFirstSpawn[MAX_PLAYERS];

hook OnGameModeInit()
{
    // LSHIFT FOR ANIMATION
    lshift = TextDrawCreate(318.000000, 408.800201, "LSHIFT_TO_STOP_THE_ANIMATION");
    
    TextDrawLetterSize(lshift, 0.449999, 1.600000);
    TextDrawTextSize(lshift, -9.500000, 20.533325);
    TextDrawAlignment(lshift, 1);
    TextDrawColor(lshift, -5963521);
    TextDrawSetShadow(lshift, 0);
    TextDrawSetOutline(lshift, 1);
    TextDrawBackgroundColor(lshift, 51);
    TextDrawFont(lshift, 2);
    TextDrawSetProportional(lshift, 1);

    return 1;
}

hook OnPlayerConnect(playerid) {
    ApplyAnimation(playerid, "CRACK", "CRCKIDLE1", 4.1, 0, 1, 1, 1, 0, 1);
    ApplyAnimation(playerid, "PED", "KO_SHOT_FRONT", 4.1, 0, 1, 1, 1, 0, 1);
    ApplyAnimation(playerid, "MEDIC", "CPR", 4.1, 0, 1, 1, 1, 0, 1);
    ApplyAnimation(playerid, "BD_FIRE", "WASH_UP", 4.1, 1, 0, 0, 0, 0, 1);
    ApplyAnimation(playerid, "HEIST9", "USE_SWIPECARD", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = false;
    PlayerFirstSpawn[playerid] = false;
    IsPlayerInjured[playerid] = false;
    IsPlayerRepairing[playerid] = false;
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_SPRINT)
    {
        if(IsPlayerInjured[playerid] == true)
        {
            return 1;
        }
        if(IsPlayerReviving[playerid] == true)
        {
            return 1;
        }
        if(IsPlayerRepairing[playerid] == true)
        {
            return 1;
        }
        if(IsInAnimationLoop[playerid])
        {
            ClearAnimations(playerid);
            TextDrawHideForPlayer(playerid, lshift);
            IsInAnimationLoop[playerid] = false;
            return 1;
        }
    }
    return 1;
}

hook OnPlayerSpawn(playerid) {
    if(PlayerFirstSpawn[playerid] == false)
    {
        ApplyAnimation(playerid, "GHANDS", "gsign5LH", 4.1, 0, 0, 0, 0, 0, 0);
        ApplyAnimation(playerid, "SHOP", "ROB_loop", 4.1, 1, 0, 0, 0, 0, 0);
        ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);

        PlayerFirstSpawn[playerid] = true;
    }

    ClearAnimations(playerid);
    SetPVarInt(playerid, "WepState", GetPlayerWeaponState(playerid));
    return 1;
}

YCMD:animations(playerid, params[], help)
{
    new option[128];
    if(sscanf(params, "s[16]S()[256]", option))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/animations [ ROTC / Military / Normal ]");
        return 1;
    }
    animations(playerid, option);
    return 1;
}

forward animations(playerid, const params[]);
public animations(playerid, const params[]) // MAG SALUTE NI SIYA
{
    new option[128];
    new option_params[256];
    if(sscanf(params, "s[16]S()[256]", option, option_params))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "[USAGE]: "COL_WHITE"/animations [ ROTC / Military / Normal ]");
        return 1;
    }

    if(!strcmp(option, "rotc", true))
    {
        SendClientMessageEx2(playerid, COLOR_YELLOW, "- - - - - - - - - - - - - - ROTC ANIMATION COMMANDS - - - - - - - - - - - - - - ");
        SendClientMessageEx2(playerid, COLOR_WHITE, "/salute /aim /flashcard /follow /stop /attention /callformation /crossarms /march");
        SendClientMessageEx2(playerid, COLOR_WHITE, "/handsforward /rightsideward /leftsideward /attWeapon1 /attWeapon2 /holdweapo");
        return 1;
    }

    if(!strcmp(option, "military", true))
    {
        SendClientMessageEx2(playerid, COLOR_YELLOW, "- - - - - - - - - - - - - - MILITARY ANIMATION COMMANDS - - - - - - - - - - - - - - ");
        SendClientMessageEx2(playerid, COLOR_WHITE, "/liftinweapon /liftweapon1 /liftweapon2 /giveesomething /acceptsomething /gunliftout /militarystay /militarygo /militarylkt /pointgun");
        SendClientMessageEx2(playerid, COLOR_WHITE, "/handsuparrest1 /handsuparrest2 /armduck /duckhide /raisehand1 /raisehand2 /standup1 /standup /duckcover /comeon");
        SendClientMessageEx2(playerid, COLOR_WHITE, "/attention2 /attention3 /bomberplant /bombplant2idle /bombplantcrouchin /bombplantcrouchout /bombplantin /bombplantloop /laydown /hitdown");
        SendClientMessageEx2(playerid, COLOR_WHITE, "/firehand /corpbrowsein1 /corpbrowsein2 /nod /handsup1 /handsup2 /handsup3 /handsup4 /triggerbomb /throw1 /throw2");
        return 1;
    }

    if(!strcmp(option, "normal", true))
    {
        SendClientMessageEx2(playerid, COLOR_YELLOW, "- - - - - - - - - - - - - - NORMAL ANIMATION COMMANDS - - - - - - - - - - - - - - ");
        SendClientMessageEx2(playerid, COLOR_WHITE, "/dooropen /warmup /ghand /giveme /handsupinstpect /disagree /liftup1 /liftup2 /death1 /death2");
        SendClientMessageEx2(playerid, COLOR_WHITE, "/death3 /death4 /dance1 /dance2 /dance3 /dance4 /dance5 /dance6 /dance7 /parksit");
        SendClientMessageEx2(playerid, COLOR_WHITE, "/sit /sitchill /sit1 /sit2 /sit3 /sit4 /sittyping /wave /waveout /washhand");
        SendClientMessageEx2(playerid, COLOR_WHITE, "/injured /calmdown /noway /come /bugsay /turnaround /phoneout /tired /hitch /forwardstop");
        SendClientMessageEx2(playerid, COLOR_WHITE, "/standchill /pointup /buysomething /handshake1 /handshake2 /handshake3 /handshake4 /ghands2 /ghands3");
        SendClientMessageEx2(playerid, COLOR_WHITE, "/pissoff /operateatm /betslp1 /betslp2 /betslp3 /win /watchrace /point /panicshout");
        SendClientMessageEx2(playerid, COLOR_WHITE, "/panicpoint /shout /onlooker /shakehead /challenging");
        return 1;
    }
    return 1;
}

// ROTC Animations Commands

YCMD:salute(playerid, params[], help) // MAG SALUTE NI SIYA
{
    ApplyAnimation(playerid, "GHANDS", "gsign5LH", 4.1, 0, 0, 0, 0, 0, 1);

    
    return 1;
}

YCMD:aim(playerid, params[], help)
{
    ApplyAnimation(playerid, "SHOP", "ROB_loop", 4.1, 1, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:flashcard(playerid, params[], help)
{
    ApplyAnimation(playerid, "BD_FIRE", "BD_PANIC_03", 4.1, 1, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:follow(playerid, params[], help)
{
    ApplyAnimation(playerid, "WUZI", "WUZI_FOLLOW", 4.1, 1, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:stop(playerid, params[], help)
{
    ApplyAnimation(playerid, "POLICE", "COPTRAF_STOP", 4.1, 1, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:attention(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "IDLE_GANG1", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:callformation(playerid, params[], help)
{
    ApplyAnimation(playerid, "ON_LOOKERS", "WAVE_LOOP", 4.1, 1, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:crossarms(playerid, params[], help)
{
    ApplyAnimation(playerid, "DEALER", "DEALER_IDLE", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:march(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "TURN_L", 4.1, 1, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:handsforward(playerid, params[], help)
{
    ApplyAnimation(playerid, "MISC", "BMX_IDLELOOP_01", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:rightsideward(playerid, params[], help)
{
    ApplyAnimation(playerid, "MISC", "HIKER_POSE", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:leftsideward(playerid, params[], help)
{
    ApplyAnimation(playerid, "MISC", "HIKER_POSE_L", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:attWeapon1(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "IDLE_ARMED", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:attWeapon2(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "GUN_2_IDLE", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}


// MILITARY COMMANDS

YCMD:liftinweapon(playerid, params[], help)
{
    ApplyAnimation(playerid, "WEAPONS", "SHP_G_LIFT_IN", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:liftweapon2(playerid, params[], help)
{
    ApplyAnimation(playerid, "WEAPONS", "SHP_2H_LIFT", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:liftweapon1(playerid, params[], help)
{
    ApplyAnimation(playerid, "WEAPONS", "SHP_2H_LIFT", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:givesomething(playerid, params[], help)
{
    ApplyAnimation(playerid, "WEAPONS", "SHP_AR_LIFT", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:acceptsomething(playerid, params[], help)
{ 
    ApplyAnimation(playerid, "WEAPONS", "SHP_AR_RET_S", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:gunliftout(playerid, params[], help)
{
    ApplyAnimation(playerid, "WEAPONS", "SHP_G_LIFT_OUT", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:militarystay(playerid, params[], help)
{
    ApplyAnimation(playerid, "SWAT", "SWT_STY", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:militarygo(playerid, params[], help)
{
    ApplyAnimation(playerid, "SWAT", "SWT_GO", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:militarylkt(playerid, params[], help)
{
    ApplyAnimation(playerid, "SWAT", "SWT_LKT", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:handsup1(playerid, params[], help)
{
    ApplyAnimation(playerid, "SHOP", "SHP_HANDSUP_SCR", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:handsup2(playerid, params[], help)
{
    ApplyAnimation(playerid, "SHOP", "SHP_ROB_HANDSUP", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:armduck(playerid, params[], help)
{
    ApplyAnimation(playerid, "SHOP", "SHP_GUN_DUCK", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:duckhide(playerid, params[], help)
{
    ApplyAnimation(playerid, "SHOP", "SHP_DUCK", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:raisehand1(playerid, params[], help)
{
    ApplyAnimation(playerid, "SCRATCHING", "SCDLULP", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:raisehand2(playerid, params[], help)
{
    ApplyAnimation(playerid, "SCRATCHING", "SCDRULP", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:standup1(playerid, params[], help)
{
    ApplyAnimation(playerid, "RYDER", "RYD_BECKON_01", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:standup2(playerid, params[], help)
{
    ApplyAnimation(playerid, "RYDER", "RYD_BECKON_02", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}


YCMD:duckcover(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "DUCK_COWER", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:pointgun(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "ARRESTGUN", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:comeon(playerid, params[], help)
{
    ApplyAnimation(playerid, "MISC", "BMX_COMEON", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:attention2(playerid, params[], help)
{
    ApplyAnimation(playerid, "GRAVEYARD", "MRNM_LOOP", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:attention3(playerid, params[], help)
{
    ApplyAnimation(playerid, "GRAVEYARD", "PRST_LOOPA", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:bomberplant(playerid, params[], help)
{
    ApplyAnimation(playerid, "BOMBER", "BOM_PLANT", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:bombplant2idle(playerid, params[], help)
{
    ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_2IDLE", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:bombplantcrouchin(playerid, params[], help)
{
    ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_CROUCH_IN", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:bombplantcrouchout(playerid, params[], help)
{
    ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_CROUCH_OUT", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:bombplantin(playerid, params[], help)
{
    ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_IN", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:bombplantloop(playerid, params[], help)
{
    ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:laydown(playerid, params[], help)
{
    ApplyAnimation(playerid, "CRACK", "CRCKIDLE4", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:hitdown(playerid, params[], help)
{
    ApplyAnimation(playerid, "CRACK", "CRCKIDLE1", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:firehand(playerid, params[], help)
{
    ApplyAnimation(playerid, "COLT45", "COLT45_FIRE_2HANDS", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:corpbrowsein1(playerid, params[], help)
{
    ApplyAnimation(playerid, "COP_AMBIENT", "COPBROWSE_IN", 4.1, 0, 0, 0, 0, 0, 1);	
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:corpbrowsein2(playerid, params[], help)
{
    ApplyAnimation(playerid, "COP_AMBIENT", "COPBROWSE_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:nod(playerid, params[], help)
{
    ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_01", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:handsup3(playerid, params[], help)
{
    ApplyAnimation(playerid, "RIOT", "RIOT_ANGRY", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:handsup4(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "HANDSUP", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:triggerbomb(playerid, params[], help)
{
    ApplyAnimation(playerid, "MISC", "PLUNGER_01", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:throw1(playerid, params[], help)
{
    ApplyAnimation(playerid, "GRENADE", "WEAPON_THROW", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:throw2(playerid, params[], help)
{
    ApplyAnimation(playerid, "GRENADE", "WEAPON_THROWU", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

// Normal Animations Commands

YCMD:dooropen(playerid, params[], help)
{
    ApplyAnimation(playerid, "AIRPORT", "THRW_BARL_THRW", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;
    return 1;
}

YCMD:warmup(playerid, params[], help)
{
    ApplyAnimation(playerid, "BENCHPRESS", "GYM_BP_CELEBRATE", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:ghand(playerid, params[], help)
{
    ApplyAnimation(playerid, "GHANDS", "GSIGN4", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:giveme(playerid, params[], help)
{
    ApplyAnimation(playerid, "GANGS", "DEALER_DEAL", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:handsupinstpect(playerid, params[], help)
{
    ApplyAnimation(playerid, "GHANDS", "GSIGN1", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:disagree(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "ENDCHAT_02", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:liftup1(playerid, params[], help)
{
    ApplyAnimation(playerid, "CARRY", "LIFTUP", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

YCMD:liftup2(playerid, params[], help)
{
    ApplyAnimation(playerid, "CARRY", "LIFTUP05", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:death1(playerid, params[], help)
{
    ApplyAnimation(playerid, "CRACK", "CRCKDETH1", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:death2(playerid, params[], help)
{
    ApplyAnimation(playerid, "CRACK", "CRCKDETH2", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:death3(playerid, params[], help)
{
    ApplyAnimation(playerid, "CRACK", "CRCKDETH3", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:death4(playerid, params[], help)
{
    ApplyAnimation(playerid, "CRACK", "CRCKDETH4", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:dance1(playerid, params[], help)
{
    ApplyAnimation(playerid, "DANCING", "BD_CLAP", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:dance2(playerid, params[], help)
{
    ApplyAnimation(playerid, "DANCING", "DAN_LOOP_A", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:dance3(playerid, params[], help)
{
    ApplyAnimation(playerid, "DANCING", "DNCE_M_A", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:dance4(playerid, params[], help)
{
    ApplyAnimation(playerid, "DANCING", "DNCE_M_B", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:dance5(playerid, params[], help)
{
    ApplyAnimation(playerid, "DANCING", "DNCE_M_C", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:dance6(playerid, params[], help)
{
    ApplyAnimation(playerid, "DANCING", "DNCE_M_D", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:dance7(playerid, params[], help)
{
    ApplyAnimation(playerid, "DANCING", "DNCE_M_E", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:parksit(playerid, params[], help)
{
    ApplyAnimation(playerid, "BEACH", "PARKSIT_M_LOOP", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:sit(playerid, params[], help)
{
    ApplyAnimation(playerid, "INT_OFFICE", "OFF_SIT_IDLE_LOOP", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:sitchill(playerid, params[], help)
{
    ApplyAnimation(playerid, "INT_HOUSE", "LOU_LOOP", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:sit1(playerid, params[], help)
{
    ApplyAnimation(playerid, "MISC", "SEAT_TALK_01", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:sit2(playerid, params[], help)
{
    ApplyAnimation(playerid, "MISC", "SEAT_TALK_02", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:sit3(playerid, params[], help)
{
    ApplyAnimation(playerid, "MISC", "SEAT_WATCH", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:sit4(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "SEAT_IDLE", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:sittyping(playerid, params[], help)
{
    ApplyAnimation(playerid, "INT_OFFICE", "OFF_SIT_TYPE_LOOP", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:wave(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "ENDCHAT_03", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:waveout(playerid, params[], help)
{
    ApplyAnimation(playerid, "ON_LOOKERS", "WAVE_OUT", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:washhand(playerid, params[], help)
{
    ApplyAnimation(playerid, "BD_FIRE", "WASH_UP", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:injured(playerid, params[], help)
{
    ApplyAnimation(playerid, "SWAT", "GNSTWALL_INJURD", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:calmdown(playerid, params[], help)
{
    ApplyAnimation(playerid, "SHOP", "SHP_SERVE_START", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:noway(playerid, params[], help)
{
    ApplyAnimation(playerid, "SCRATCHING", "SCLNG_R", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:come(playerid, params[], help)
{
    ApplyAnimation(playerid, "POLICE", "COPTRAF_COME", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:bugsay(playerid, params[], help)
{
    ApplyAnimation(playerid, "POLICE", "COPTRAF_LEFT", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:turnaround(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "TURN_180", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:phoneout(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "PHONE_OUT", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:phonein(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "PHONE_IN", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:tired(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "IDLE_TIRED", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:hitch(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "IDLE_TAXI", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:forwardstop(playerid, params[], help)
{
    ApplyAnimation(playerid, "WUZI", "CS_WUZI_PT1", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:standchill(playerid, params[], help)
{
    ApplyAnimation(playerid, "OTB", "WTCHRACE_LOOP", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:pointup(playerid, params[], help)
{
    ApplyAnimation(playerid, "ON_LOOKERS", "POINTUP_OUT", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:cashier(playerid, params[], help)
{
    ApplyAnimation(playerid, "INT_SHOP", "SHOP_CASHIER", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:sleepright(playerid, params[], help)
{
    ApplyAnimation(playerid, "INT_HOUSE", "BED_LOOP_R", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:sleepleft(playerid, params[], help)
{
    ApplyAnimation(playerid, "INT_HOUSE", "BED_LOOP_L", 4.1, 0, 0, 0, 1, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:chat(playerid, params[], help)
{
    ApplyAnimation(playerid, "GANGS", "PRTIAL_GNGTLKG", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:acceptin(playerid, params[], help)
{
    ApplyAnimation(playerid, "GANGS", "DEALER_DEAL", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:think(playerid, params[], help)
{
    ApplyAnimation(playerid, "COP_AMBIENT", "COPLOOK_THINK", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:corpbrowse(playerid, params[], help)
{
    ApplyAnimation(playerid, "COP_AMBIENT", "COPBROWSE_SHAKE", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:holdpulpit(playerid, params[], help)
{
    ApplyAnimation(playerid, "BD_FIRE", "BD_PANIC_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:drink(playerid, params[], help)
{
    ApplyAnimation(playerid, "GANGS", "DRNKBR_PRTL", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:buysomething(playerid, params[], help)
{
    ApplyAnimation(playerid, "GANGS", "DRUGS_BUY", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:handshake1(playerid, params[], help)
{
    ApplyAnimation(playerid, "GANGS", "PRTIAL_HNDSHK_BIZ_01", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:handshake2(playerid, params[], help)
{
    ApplyAnimation(playerid, "GANGS", "HNDSHKAA", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:handshaka3(playerid, params[], help)
{
    ApplyAnimation(playerid, "GANGS", "HNDSHKBA", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:handshake4(playerid, params[], help)
{
    ApplyAnimation(playerid, "GANGS", "HNDSHKCA", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:ghand2(playerid, params[], help)
{
    ApplyAnimation(playerid, "GHANDS", "GSIGN1", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:ghand3(playerid, params[], help)
{
    ApplyAnimation(playerid, "GHANDS", "GSIGN5", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:pissoff(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "PASS_SMOKE_IN_CAR", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:operateatm(playerid, params[], help)
{
    ApplyAnimation(playerid, "PED", "ATM", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:betslp1(playerid, params[], help)
{
    ApplyAnimation(playerid, "OTB", "BETSLP_IN", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:betslp2(playerid, params[], help)
{
    ApplyAnimation(playerid, "OTB", "BETSLP_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:betslp3(playerid, params[], help)
{
    ApplyAnimation(playerid, "OTB", "BETSLP_TNK", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:win(playerid, params[], help)
{
    ApplyAnimation(playerid, "OTB", "WTCHRACE_WIN", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:watchrace(playerid, params[], help)
{
    ApplyAnimation(playerid, "OTB", "WTCHRACE_CMON", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:point(playerid, params[], help)
{
    ApplyAnimation(playerid, "ON_LOOKERS", "POINT_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:panicpoint(playerid, params[], help)
{
    ApplyAnimation(playerid, "ON_LOOKERS", "PANIC_POINT", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:panicshout(playerid, params[], help)
{
    ApplyAnimation(playerid, "ON_LOOKERS", "PANIC_SHOUT", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:shouting(playerid, params[], help)
{
    ApplyAnimation(playerid, "ON_LOOKERS", "SHOUT_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:onlooker(playerid, params[], help)
{
    ApplyAnimation(playerid, "ON_LOOKERS", "PANIC_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:shakehead(playerid, params[], help)
{
    ApplyAnimation(playerid, "MISC", "PLYR_SHKHEAD", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}
YCMD:challenging(playerid, params[], help)
{
    ApplyAnimation(playerid, "MISC", "KAT_THROW_K", 4.1, 0, 0, 0, 0, 0, 1);
    IsInAnimationLoop[playerid] = true;

    TextDrawShowForPlayer(playerid, lshift);
    return 1;
}

// OTHERS

YCMD:stopanim(playerid, params[], help)
{
    if( IsPlayerInjured[playerid] == true )
    {
        return 1;
    }

    ClearAnimations(playerid);
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}