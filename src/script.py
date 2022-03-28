# import libs and configs
import MySQLdb
import config

# Creating a connection to Mysql DB
DB = MySQLdb.connect(
    host   = config.MysqlConnection.HOST,
    user   = config.MysqlConnection.USER,
    passwd = config.MysqlConnection.PASSWD,
    db     = config.MysqlConnection.DB
)

# Main database cursor class
class CURSOR:
    def __init__(self):
        self.DB_CURSOR = DB.cursor()

    def return_results(self):
        return self.DB_CURSOR.fetchall()

    def print_results(self):
        for row in self.DB_CURSOR.fetchall():
            print(row)

    def execute_command(self, cmd):
        self.DB_CURSOR.execute(cmd)
        
# Erp database cursor instance
ERP_DB = CURSOR()
ERP_DB.execute_command("SHOW TABLES")
res = ERP_DB.return_results()
for x in res:
    ERP_DB.execute_command(f"DESCRIBE {x[0]}")
    ERP_DB.print_results()

DB.close()
