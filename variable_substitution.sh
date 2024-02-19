cp dbt_profiles.yml profiles.yml
sed -i "s/__SNOWFLAKE_ACCOUNT__/${SNOWFLAKE_ACCOUNT}/g" profiles.yml
sed -i "s/__SNOWFLAKE_DATABASE__/${SNOWFLAKE_DATABASE}/g" profiles.yml
sed -i "s/__SNOWFLAKE_PASSWORD__/${SNOWFLAKE_PASSWORD}/g" profiles.yml
sed -i "s/__SNOWFLAKE_ROLE__/${SNOWFLAKE_ROLE}/g" profiles.yml
sed -i "s/__SNOWFLAKE_USER__/${SNOWFLAKE_USER}/g" profiles.yml
sed -i "s/__SNOWFLAKE_WAREHOUSE__/${SNOWFLAKE_WAREHOUSE}/g" profiles.yml

