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

# Set DB Cursor
CURSOR = DB.cursor()

CURSOR.execute("show tables")
# CURSOR.execute("SELECT * FROM table...")

print(CURSOR.__dict__)

for row in CURSOR.fetchall():
    print(row[0])

DB.close()
