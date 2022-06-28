#include <YSI_Coding\y_hooks>

new MySQL:SQL_Handle;
new SQL_Buffer[2046];

static
    SQL_Host[64],
    SQL_User[64],
    SQL_Password[64],
    SQL_Database[64];

hook OnGameModeInit() {
    Env_Get("MYSQL_HOST", SQL_Host);
    Env_Get("MYSQL_USER", SQL_User);
    Env_Get("MYSQL_PASSWORD", SQL_Password);
    Env_Get("MYSQL_DATABASE", SQL_Database);

    SQL_Handle = mysql_connect(SQL_Host, SQL_User, SQL_Password, SQL_Database);

    if(mysql_errno(SQL_Handle)) {
        static SQL_Error[256];
        mysql_error(SQL_Error);

        printf("There is a problem connecting to the database:\nError Details: %s", SQL_Error);
        SendRconCommand("exit");
        return 1;
    } else {
        print("MySQL Connection has been successfuly established!");
    }
    return 1;
}

hook OnGameModeExit() {
    mysql_close(SQL_Handle);
    return 1;
}

hook OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle) {
    printf("[MYSQL ERROR]: %s", error);
    return 1;
}