service mariadb start

if [ -n "$MARIADB_ROOT_PASSWORD" ]
then
  (echo "ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('$MARIADB_ROOT_PASSWORD');"; echo "exit";) | mariadb
else
  echo "MARIADB_ROOT_PASSWORD 환경변수가 없으므로 수행되지 않음."
fi