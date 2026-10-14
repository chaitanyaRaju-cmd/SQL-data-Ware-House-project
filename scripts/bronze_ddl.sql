-- we are working on bronze layer
-- we are creaing tables from the sources
-- crm and erp

use datawarehouse

create table bronze.crm_cust_info(
	cst_id int,
	cst_key nvarchar(50),
	cst_firstname nvarchar(50),
	cst_lastname nvarchar(50),
	cst_marital_status nvarchar(50),
	cst_gndr nvarchar(10),
	cst_create_date date
)

create table bronze.crm_prd_info(
	prd_id int ,
	prd_key nvarchar(50),
	prd_nm nvarchar(50),
	prd_cost int,
	prd_line nvarchar(50),
	prd_start_dt datetime,
	prd_end_dt datetime
)

create table bronze.crm_sales_details(
	sls_ord_num nvarchar(50),
	sls_prd_key nvarchar(50),
	sls_cust_id int,
	sls_order_dt int,
	sls_ship_dt int,
	sls_due_dt int,
	sls_sales int,
	sls_quantity int,
	sls_price int
)

-- 3 crm tables are got created now 3 erp tables

create table bronze.erp_LOC_A101(
	CID nvarchar(50),
	CNTRY nvarchar(50)
)

create table bronze.erp_CUST_AZ12(
	CID nvarchar(50),
	BDATE nvarchar(50),
	GEN nvarchar(10)
)

if object_id('bronze.erp_PX_CAT_G1V2', 'u') is not null
	drop table bronze.erp_PX_CAT_G1V2;
go
create table bronze.erp_PX_CAT_G1V2(
	ID nvarchar(50),
	CAT nvarchar(50),
	SUBCAT nvarchar(50),
	MAINTENANCE nvarchar(50)
)

-- if any updates have to be done like changing names
-- or adding columns, type this on top of that table:
--if object_id('particular_table_name', 'u') is not null
--	drop table particular_table_name;
--go

--here 'u' stand for user defined table, similar to CTAS
-- 'v' is for views

/* now we are inserting data into the tables
we are using bulk insert which helps us to insert
huge data in a single shot */

bulk insert bronze.crm_cust_info
from 'C:\Users\lenovo\OneDrive\Desktop\SQL Practise\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
)

-- check it

select* from bronze.crm_cust_info

/* if at all while inserting any mistakes arise
and data is not entered into appropriate columns
we have to reload the table but before we should
write this at the top of bulk insert query:

truncate table particular_table_name

if at all we reloaded data without this
duplicates can arise and things get messed up */

bulk insert bronze.crm_prd_info
from 'C:\Users\lenovo\OneDrive\Desktop\SQL Practise\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
)

-- check

select* from bronze.crm_prd_info

-- 2 crm source tables data inserted successfully

bulk insert bronze.crm_sales_details
from 'C:\Users\lenovo\OneDrive\Desktop\SQL Practise\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
)

-- check

select * from bronze.crm_sales_details

/* now we are inserting 3 erp source tables data 
all 3 crm source table data is successfully inserted above */

bulk insert bronze.erp_LOC_A101
from 'C:\Users\lenovo\OneDrive\Desktop\SQL Practise\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
)

-- check

select * from bronze.erp_LOC_A101

--

bulk insert bronze.erp_CUST_AZ12
from 'C:\Users\lenovo\OneDrive\Desktop\SQL Practise\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
)

-- check

select * from bronze.erp_CUST_AZ12

--

bulk insert bronze.erp_PX_CAT_G1V2
from 'C:\Users\lenovo\OneDrive\Desktop\SQL Practise\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
)

--check 

select * from bronze.erp_PX_CAT_G1V2

-- all insertions finished

/* we can keep everything in load procedure by:

create or replace procedure bronze.load_bronze as
begin
	.....
	.....           -- code
	.....
end

when we want to execute the procedure we do:

exec bronze.load_bronze   */

-- pushed into git rep
