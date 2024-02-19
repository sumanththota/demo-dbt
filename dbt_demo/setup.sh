
##
## Setup and validate runner configuration
##

# if [[ -z "${DBT_PROJECT_NAME}" ]]; then
#   echo "Environment variable DBT_PROJECT_NAME is not set"
#   exit 1
# fi

# if [[ -z "${DBT_PROFILES_DIR}" ]]; then
#   # Note: the value used by dbt when --profiles-dir is not is "/Users/<USER>/.dbt"
#   echo "Environment variable DBT_PROFILES_DIR is not set"
#   exit 1
# fi

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

## Install dbt packages

# Install the dbt-<warehouse_provider> library using pip
pip install dbt-snowflake

# Confirm that the dbt installation was successful.
dbt --version

dbt init $DBT_PROJECT_NAME --profiles-dir=$DBT_PROFILES_DIR

##
## Setup dbt connection profile to data warehouse
##

# TODO
# ...

# Verify dbt connection profile to data warehouse
dbt debug