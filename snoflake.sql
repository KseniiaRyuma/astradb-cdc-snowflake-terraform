CREATE USER "tf-snow" RSA_PUBLIC_KEY='RSA_PUBLIC_KEY_HERE' DEFAULT_ROLE=PUBLIC MUST_CHANGE_PASSWORD=FALSE;

-- SELECT current_account() as YOUR_ACCOUNT_LOCATOR, current_region() as YOUR_SNOWFLAKE_REGION_ID;

alter user "tf-snow" set default_warehouse = astra_demo2;

use role accountadmin;
-- Create a Snowflake role with the privileges to work with the connector.
create role kafka_connector_role_1;
create role astra_sink_role_1;

-- Grant privileges on the database.
grant usage on warehouse ASTRA_DEMO2 to role astra_sink_role_1;
grant ownership on database ASTRA_DEMO2 to role astra_sink_role_1;

use role astra_sink_role_1;

show grants to role astra_sink_role_1;


-- REVOKE usage
-- on database ASTRA_DEMO2
-- from role accountadmin;

-- REVOKE usage
-- on schema ASTRA_DEMO2.astra_demo2
-- from role accountadmin;

-- Grant privileges on the schema.
grant ownership on schema ASTRA_DEMO2.astra_demo2 to role astra_sink_role_1;
grant all privileges on schema ASTRA_DEMO2.astra_demo2 to role astra_sink_role_1;
grant all on all tables in schema ASTRA_DEMO2.astra_demo2 to role astra_sink_role_1;
grant all on future tables in schema ASTRA_DEMO2.astra_demo2 to role astra_sink_role_1;


-- grant create table on schema ASTRA_DEMO2.astra_demo2 to role astra_sink_role_1;
-- grant create stage on schema ASTRA_DEMO2.astra_demo2 to role astra_sink_role_1;
-- grant create pipe on schema ASTRA_DEMO2.astra_demo2 to role astra_sink_role_1;



grant all privileges on schema ASTRA_DEMO2.astra_demo2 to role sysadmin;
grant all on all tables in schema ASTRA_DEMO2.astra_demo2 to role sysadmin;
grant all on future tables in schema ASTRA_DEMO2.astra_demo2 to role sysadmin;


-- Grant the custom role to user.
grant role astra_sink_role_1 to user "tf-snow";
grant role astra_sink_role_1 to role sysadmin;

-- Set the custom role as the default role for the user.
-- If you encounter an 'Insufficient privileges' error, verify the role that has the OWNERSHIP privilege on the user.
alter user "tf-snow" set default_role = astra_sink_role_1;

--to confirm your grants use:
show grants;
show users;
show roles;


use role astra_sink_role_1;
use schema ASTRA_DEMO2.ASTRA_DEMO2;


--update with your own names for tables that got created:
select count(*) from (
select
       record_metadata:key:a as a,
       record_metadata:key:b as b
    from PERSISTENT___TERRAFORMTEST_ASTRACDC_DATA_85E502AD_410B_43FC_B886_7D25920415D2_PUPPIES_MYTABLE_PARTITION_0_1689078252 natural full outer join PERSISTENT___TERRAFORMTEST_ASTRACDC_DATA_85E502AD_410B_43FC_B886_7D25920415D2_PUPPIES_MYTABLE_PARTITION_1_1689078251);