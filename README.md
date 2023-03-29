# Genomics ETL

This is a demo data engineering project built on Azure cloud. ETL pipeline implemented in Azure Data Factory is
ingesting and transforming  [Illumina Platinum Genomes dataset](https://learn.microsoft.com/en-us/azure/open-datasets/dataset-illumina-platinum-genomes?tabs=azure-storage).
Terraform is used for provisioning infrastructure.
Deployment pipelines are implemented in GitHub actions in accordance with
[official Microsoft guidelines](https://learn.microsoft.com/en-us/azure/data-factory/continuous-integration-delivery), 
with working CICD process between DEV and PROD environments. DEV ADF is connected to git repository, and ARM templates
are propagated to PROD environment through GitHub action.

System components are:

- Azure Data Factory
- ADLS
- Azure Database for PostgreSQL Single Server
- Databricks
- KeyVault



Databricks visualization:
![Bubble chart](docs/bubble-chart-hg19.PNG)

ADF view:
![Azure Data Factory executions](docs/pipeline-executions.PNG)

![Azure Data Factory pipelines](docs/pipeline.PNG)

CICD:
![ADF CICD](docs/adf-cicd.png)

Postgres:
![Data in postgres](docs/data-in-postgres.PNG)

