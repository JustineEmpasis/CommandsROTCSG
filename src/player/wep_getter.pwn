#include <YSI_Coding\y_hooks>

// ---------------------------------- S E T T E R ---------------------------------- //

Set_bone(modelid, value)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE weapon_placement SET bone = %d WHERE modelid = %d", value, modelid);
    mysql_tquery(SQL_Handle, SQL_Buffer);
    return 1;
}

// OFFSET
Set_fOffsetX(modelid, Float:value)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE weapon_placement SET fOffsetX = %f WHERE modelid = %d", value, modelid);
    mysql_tquery(SQL_Handle, SQL_Buffer);
    return 1;
}

Set_fOffsetY(modelid, Float:value)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE weapon_placement SET fOffsetY = %f WHERE modelid = %d", value, modelid);
    mysql_tquery(SQL_Handle, SQL_Buffer);
    return 1;
}

Set_fOffsetZ(modelid, Float:value)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE weapon_placement SET fOffsetZ = %f WHERE modelid = %d", value, modelid);
    mysql_tquery(SQL_Handle, SQL_Buffer);
    return 1;
}

// ROTATION
Set_fRotX(modelid, Float:value)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE weapon_placement SET fRotX = %f WHERE modelid = %d", value, modelid);
    mysql_tquery(SQL_Handle, SQL_Buffer);
    return 1;
}

Set_fRotY(modelid, Float:value)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE weapon_placement SET fRotY = %f WHERE modelid = %d", value, modelid);
    mysql_tquery(SQL_Handle, SQL_Buffer);
    return 1;
}

Set_fRotZ(modelid, Float:value)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE weapon_placement SET fRotZ = %f WHERE modelid = %d", value, modelid);
    mysql_tquery(SQL_Handle, SQL_Buffer);
    return 1;
}

// SCALE
Set_fScaleX(modelid, Float:value)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE weapon_placement SET fScaleX = %f WHERE modelid = %d", value, modelid);
    mysql_tquery(SQL_Handle, SQL_Buffer);
    return 1;
}

Set_fScaleY(modelid, Float:value)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE weapon_placement SET fScaleY = %f WHERE modelid = %d", value, modelid);
    mysql_tquery(SQL_Handle, SQL_Buffer);
    return 1;
}

Set_fScaleZ(modelid, Float:value)
{
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "UPDATE weapon_placement SET fScaleZ = %f WHERE modelid = %d", value, modelid);
    mysql_tquery(SQL_Handle, SQL_Buffer);
    return 1;
}

// ---------------------------------- G E T T E R ---------------------------------- //

stock Get_bone(modelid)
{
    static SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT bone FROM weapon_placement WHERE modelid = %d", modelid);
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_int(0, "bone", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

// OFFSET
stock Float:Get_fOffsetX(modelid)
{
    static Float:SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT fOffsetX FROM weapon_placement WHERE modelid = %d", modelid);
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_float(0, "fOffsetX", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

stock Float:Get_fOffsetY(modelid)
{
    static Float:SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT fOffsetY FROM weapon_placement WHERE modelid = %d", modelid);
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_float(0, "fOffsetY", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

stock Float:Get_fOffsetZ(modelid)
{
    static Float:SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT fOffsetZ FROM weapon_placement WHERE modelid = %d", modelid);
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_float(0, "fOffsetZ", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

// ROTATION
stock Float:Get_fRotX(modelid)
{
    static Float:SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT fRotX FROM weapon_placement WHERE modelid = %d", modelid);
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_float(0, "fRotX", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

stock Float:Get_fRotY(modelid)
{
    static Float:SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT fRotY FROM weapon_placement WHERE modelid = %d", modelid);
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_float(0, "fRotY", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

stock Float:Get_fRotZ(modelid)
{
    static Float:SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT fRotZ FROM weapon_placement WHERE modelid = %d", modelid);
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_float(0, "fRotZ", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

// SCALE
stock Float:Get_fScaleX(modelid)
{
    static Float:SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT fScaleX FROM weapon_placement WHERE modelid = %d", modelid);
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_float(0, "fScaleX", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

stock Float:Get_fScaleY(modelid)
{
    static Float:SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT fScaleY FROM weapon_placement WHERE modelid = %d", modelid);
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_float(0, "fScaleY", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}

stock Float:Get_fScaleZ(modelid)
{
    static Float:SQL_Result;
    mysql_format(SQL_Handle, SQL_Buffer, sizeof(SQL_Buffer), "SELECT fScaleZ FROM weapon_placement WHERE modelid = %d", modelid);
    new Cache:SQL_Cache = mysql_query(SQL_Handle, SQL_Buffer);
    cache_get_value_name_float(0, "fScaleZ", SQL_Result);
    cache_delete(SQL_Cache);
    return SQL_Result;
}