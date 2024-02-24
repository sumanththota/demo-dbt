
##
## Validate runner configuration variables
##

if [ -z "${DBT_PROJECT_NAME}" ]; then
  echo "Environment variable DBT_PROJECT_NAME is not set"
  exit 1
fi

if [ -z "${DBT_WAREHOUSE_PROVIDER}" ]; then
  echo "Environment variable DBT_WAREHOUSE_PROVIDER is not set"
  exit 1
fi

##
## Perform Environment-Specific variable subtitutions
## 

if [ "$DBT_WAREHOUSE_PROVIDER" = "snowflake" ]; then
  cp dbt_profiles.snowflake.yml profiles.yml

  sed -i "s/__SNOWFLAKE_ACCOUNT__/${SNOWFLAKE_ACCOUNT}/g" profiles.yml
  sed -i "s/__SNOWFLAKE_DATABASE__/${SNOWFLAKE_DATABASE}/g" profiles.yml
  sed -i "s/__SNOWFLAKE_PASSWORD__/${SNOWFLAKE_PASSWORD}/g" profiles.yml
  sed -i "s/__SNOWFLAKE_ROLE__/${SNOWFLAKE_ROLE}/g" profiles.yml
  sed -i "s/__SNOWFLAKE_USER__/${SNOWFLAKE_USER}/g" profiles.yml
  sed -i "s/__SNOWFLAKE_WAREHOUSE__/${SNOWFLAKE_WAREHOUSE}/g" profiles.yml

elif [ "$DBT_WAREHOUSE_PROVIDER" = "bigquery" ]; then
  cp dbt_profiles.bigquery.yml profiles.yml

  # TODO:
  # sed -i "s/__SNOWFLAKE_ACCOUNT__/${SNOWFLAKE_ACCOUNT}/g" profiles.yml
  # sed -i "s/__SNOWFLAKE_DATABASE__/${SNOWFLAKE_DATABASE}/g" profiles.yml
  # sed -i "s/__SNOWFLAKE_PASSWORD__/${SNOWFLAKE_PASSWORD}/g" profiles.yml
  # sed -i "s/__SNOWFLAKE_ROLE__/${SNOWFLAKE_ROLE}/g" profiles.yml
  # sed -i "s/__SNOWFLAKE_USER__/${SNOWFLAKE_USER}/g" profiles.yml
  # sed -i "s/__SNOWFLAKE_WAREHOUSE__/${SNOWFLAKE_WAREHOUSE}/g" profiles.yml
fi

##
## Install system dependencies
##

# Upgrade pip
python -m pip install --upgrade pip

pip --version

# Install virtualenv
# pip install virtualenv

# Create a virtual environment
python -m venv .venv

# Activate virtual environment
source .venv/bin/activate

##
## Install project dependencies
##

## Install dbt adapter package

if [ "$DBT_WAREHOUSE_PROVIDER" = "snowflake" ]; then
  pip install dbt-snowflake
elif [ "$DBT_WAREHOUSE_PROVIDER" = "bigquery" ]; then
  pip install dbt-bigquery
fi

# Confirm that the dbt installation was successful.
dbt --version

python -m pip install -r requirements.txt

# dbt init $DBT_PROJECT_NAME

##
## Setup dbt connection profile to data warehouse
##

# TODO
# ...

# Verify dbt connection profile to data warehouse
dbt debug