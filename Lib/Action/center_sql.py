# -*- coding:utf-8 -*-
import MySQLdb

def main():
 file_obj = open("code.txt")
 try:
  all_text = file_obj.read()
 finally:
  file_obj.close()
 sql_conn = MySQLdb.connect( host = "localhost", user='root',passwd='0000', db='vote',charset='utf8')
 cur = sql_conn.cursor()
 if( all_text is not None ):
  cur.execute("truncate table user")
  cur.execute("insert into user (name, code, auth) values ('zm', 'sysu', 0)")
  for line in all_text.split('\n'):
   if( line.strip() == '' ):
    continue
   char_arr = line.split(' ')
   if( len(char_arr) == 3 ):
    print str(char_arr[2]), str(char_arr[1])
    #cur.execute( "update user set name = %s where code = %s", (char_arr[2], char_arr[1] ) )
    cur.execute( "insert into user ( name,code ) values ( %s, %s ) ", ( char_arr[2] ,char_arr[1] ) )
    #cur.execute("insert into user (name, code, auth) values ('zm', 'sysu', 0)")
    sql_conn.commit()
   else:
    continue
 
 sql_conn.close()


    

if __name__ == "__main__":
 main()
