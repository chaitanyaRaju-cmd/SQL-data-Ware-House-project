/* we are doing a warehouse project now 
we have created a database and aschemas*/


use master

create database datawarehouse -- created a new database

use datawarehouse

-- we are creating schemas now

create schema bronze

create schema silver

create schema gold

-- if we want to create all three at a time
--use 'go' in between them

--pushed this into git rep into scripts
