#include <YSI_Coding\y_hooks>

#define MODEL_SELECTION_SKIN_MENU 1020

ShowSkinModelMenu(playerid, location)
{
    // create a dynamic PawnPlus list to populate with models.
    // you don't need to worry about deleting this list, it's handled by the include once it's passed to it
    new List:skins = list_new();

    // 1 = advanced
    // 2 = medic
    // 3 = cadet

    if( location == 4)
    {
        AddModelMenuItem(skins, 179);
        AddModelMenuItem(skins, 250);
        AddModelMenuItem(skins, 191);
        AddModelMenuItem(skins, 151);
    }

    if( location == 3)
    {
        AddModelMenuItem(skins, 302, "FOR MALE ONLY");
        AddModelMenuItem(skins, 309, "FOR FEMALE ONLY");
    }

    if( location == 2 )
    {
        AddModelMenuItem(skins, 274);
        AddModelMenuItem(skins, 275);
        AddModelMenuItem(skins, 276);
        AddModelMenuItem(skins, 70);
        AddModelMenuItem(skins, 308);
    }
    if( location == 1 )
    {
        AddModelMenuItem(skins, 287);
        AddModelMenuItem(skins, 265);
        AddModelMenuItem(skins, 266);
        AddModelMenuItem(skins, 267);
        AddModelMenuItem(skins, 280);
        AddModelMenuItem(skins, 281);
        AddModelMenuItem(skins, 282);
        AddModelMenuItem(skins, 283);
        AddModelMenuItem(skins, 284);
        AddModelMenuItem(skins, 286);
        AddModelMenuItem(skins, 288);
        AddModelMenuItem(skins, 306);
        AddModelMenuItem(skins, 307);
        AddModelMenuItem(skins, 309);
    }


    ShowModelSelectionMenu(playerid, "Skins", MODEL_SELECTION_SKIN_MENU, skins);
    return 1;
}

// model selection response
public OnModelSelectionResponse(playerid, extraid, index, modelid, response)
{
    // make sure the extraid matches the skin menu ID
    if(extraid == MODEL_SELECTION_SKIN_MENU)
    {
        // make sure the player actually clicked on a model and not the close button
        if(response == MODEL_RESPONSE_SELECT)
        {
            // assign the player the skin of their choosing
            SetPlayerSkin(playerid, modelid);
            SendClientMessageEx(playerid, COLOR_PLUM, MESSAGE_LOCAL, "  "COL_ORANGE"** "COL_PLUM"%s has withdrawn a uniform from locker. "COL_ORANGE"**", GetPlayerNameEx2(playerid));
            return 1;
        }
    }
    return 1;
}