bool:HasNumeric(const string[])
{
    for(new i = 0; string[i] != EOS; i++)
    {
        if('0' <= string[i] <= '9')
        {
            return true;
        }
    }
    return false;
}

stock HasCharacters(const string[])
{
    static valid_chars[] = 
    {
        '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '~', '`', '-', '=', '+', '.', ',', '/', ';', ''', '"', '\\', '[', ']', '{', '}'
    };
    for(new i; i < strlen(string); i++)
    {
        for(new x; x < sizeof(valid_chars); x++)
        {
            if(string[i] == valid_chars[x])
            {
                return true;
            }
        }
    }
    return false;
}


bool:IsValidName(const name[])
{
    if(!strlen(name))
    {
        return false;
    }
    if(strlen(name) < 4 || strlen(name) > 21)
    {
        return false;
    }
    if(HasNumeric(name))
    {
        return false;
    }
    new d = strfind(name, "_", true);

    if(d == -1)
    {
        return false;
    }
    if(d == strlen(name)-1)
    {
        return false;
    }
    return true;
}

bool:IsValidName2(const name[])
{
    if(!strlen(name))
    {
        return false;
    }
    if(strlen(name) < 4 || strlen(name) > 32)
    {
        return false;
    }
    if(HasNumeric(name))
    {
        return false;
    }
    return true;
}

bool:IsValidEmail(const email[])
{
    new bool:atSign = false;

    for(new i; i < strlen(email); i++){
        if(email[i] == '@'){
            if(i == 0){
                return false;
            }
            if(i == strlen(email)-1){
                return false;
            }
            atSign = true;
        }
    }
    if(!atSign) {
        return false;
    }
    return true;
}

IsInBetween(value, min, max){
    return clamp(value, min, max) == value;
}