# import libs and configs
import MySQLdb
import config


# Programmer error class
class ProgERROR(Exception):
    def __init__(self, *args) -> None:
        self.msg = args[0] if args else None

    def __str__(self) -> str:
        return f"Programmer ERROR: {self.msg}"


# Main database cursor class
class CURSOR():
    # Creating a connection to Mysql DB
    DB = MySQLdb.connect(
        host   = config.MysqlConnection.HOST,
        user   = config.MysqlConnection.USER,
        passwd = config.MysqlConnection.PASSWD,
        db     = config.MysqlConnection.DB
    )

    # Instantiate a DB cursor for every CURSOR instance
    def __init__(self) -> None:
        self.DB = self.DB
        self.DB_CURSOR = self.DB.cursor()

    def restart(self) -> None:
        self.DB_CURSOR.close()
        self.DB = self.DB
        self.DB_CURSOR = self.DB.cursor()

    # Let function decide what to extract from res
    def return_results(self) -> set:
        return self.DB_CURSOR.fetchall()

    # Print all res output from mysql db
    def print_results(self) -> None:
        for row in self.DB_CURSOR.fetchall():
            print(row)

    # Execute input cmd at current DB CURSOR
    def execute_command(self, cmd) -> None:
        self.DB_CURSOR.execute(cmd)
        self.DB.commit()

    # Close connection
    def exit(self) -> None:
        self.DB.close()
        

# Erp database cursor instance
ERP_DB = CURSOR()

# Test executions ---------------------------
# ERP_DB.execute_command("SHOW TABLES")
# res = ERP_DB.return_results()
# for x in res:
#     ERP_DB.execute_command(f"DESCRIBE {x[0]}")
#     ERP_DB.print_results()
# --------------- ---------------------------
