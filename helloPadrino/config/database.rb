##
# A MySQL connection:
# DataMapper.setup(:default, 'mysql://user:password@localhost/the_database_name')
#
# # A Postgres connection:
# DataMapper.setup(:default, 'postgres://user:password@localhost/the_database_name')
#
# # A Sqlite3 connection
# DataMapper.setup(:default, "sqlite3://" + Padrino.root('db', "development.db"))
#

DataMapper.logger = logger
DataMapper::Property::String.length(255)

case Padrino.env
  when :development then DataMapper.setup(:default, "mysql://root@localhost/hello_padrino_development")
  when :production  then DataMapper.setup(:default, "mysql://root@localhost/hello_padrino_production")
  when :test        then DataMapper.setup(:default, "mysql://root@localhost/hello_padrino_test")
end
