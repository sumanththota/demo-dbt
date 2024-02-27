
##
## Validate runner configuration variables
##

if [ -z "${DBT_PROJECT_NAME}" ]; then
  echo "[Error] Environment variable DBT_PROJECT_NAME is not set"
  exit 1
fi

if [ -z "${DBT_WAREHOUSE_PROVIDER}" ]; then
  echo "[Error] Environment vartarget='dev'iable DBT_WAREHOUSE_PROVIDER is not set"
  exit 1
fi

##
## Perform Environment-Specific variable subtitutions
## 

if [ "$DBT_WAREHOUSE_PROVIDER" = "snowflake" ]; then
  cp dbt_profiles.snowflake.yml profiles.yml
elif [ "$DBT_WAREHOUSE_PROVIDER" = "bigquery" ]; then
  cp dbt_profiles.bigquery.yml profiles.yml
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

# Install dbt packages specified in package.yml
dbt deps

# Install Python packages
python -m pip install -r requirements.txt

# Verify dbt connection profile to data warehouse
dbt debug
