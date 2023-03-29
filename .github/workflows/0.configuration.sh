#!/bin/bash
set -xe

TARGET_ENVIRONMENT_SUFFIX="prod"

export PROD_ADF_RESOURCE_GROUP="GENOMICS-RG-${TARGET_ENVIRONMENT_SUFFIX}"
export PROD_ADF_DEPLOYMENT_NAME="adf-deployment-${TARGET_ENVIRONMENT_SUFFIX}"
export TEMPLATE_URI="${GITHUB_WORKSPACE}/genomics-etl-2-adf-dev"
export PROD_TARGET_FACTORY_NAME="genomics-etl-2-adf-${TARGET_ENVIRONMENT_SUFFIX}"

export PROD_KEYVAULT_URL="https://genomics-etl-2-kv-${TARGET_ENVIRONMENT_SUFFIX}-2.vault.azure.net/"
export PROD_POSTGRES_CONNECTION_STRING_SECRET_NAME="genomics-etl-2-postgres-admin-connection-string-${TARGET_ENVIRONMENT_SUFFIX}"
export ILLUMINA_DATASET_SAS_URI_SECRET_NAME="genomics-etl-2-illumina-dataset-sas-uri-${TARGET_ENVIRONMENT_SUFFIX}"
