#data "databricks_current_user" "me" {
#  depends_on = [azurerm_databricks_workspace.db_workspace]
#}
#
#resource "databricks_notebook" "this" {
#  path           = "${data.databricks_current_user.me.home}/Genomics-ETL"
#  language       = "PYTHON"
#  content_base64 = base64encode(<<-EOT
#
#    containerName = '${var.container_name_landing_raw_data}'
#    storageAccountName = '${var.storage_account_name}'
#    sas_token = '${var.landing_container_sas_token}'
#    mount_point = f"/mnt/{containerName}"
#
#    config = {
#        f"fs.azure.account.auth.type.{storageAccountName}.dfs.core.windows.net": "SAS",
#        f"fs.azure.sas.token.provider.type.{storageAccountName}.dfs.core.windows.net": "org.apache.hadoop.fs.azurebfs.sas.FixedSASTokenProvider",
#        f"fs.azure.sas.{containerName}.{storageAccountName}.blob.core.windows.net": sas_token
#    }
#
#
#    dbutils.fs.mount(source = f"wasbs://{containerName}@{storageAccountName}.blob.core.windows.net/",
#                     mount_point = mount_point,
#                     extra_configs = config
#                    )
#
#    # COMMAND ----------
#    dbutils.fs.ls("/mnt/1-landing-raw-data")
#
#    # COMMAND ----------
#    hg19_df = spark.read.format("vcf").load("/mnt/1-landing-raw-data/hg19/hybrid/hg19.hybrid.vcf.gz")
#    hg38_df = spark.read.format("vcf").load("/mnt/1-landing-raw-data/hg38/hybrid/hg38.hybrid.vcf.gz")
#
#    # COMMAND ----------
#    display(hg19_df)
#
#    # COMMAND ----------
#    import psycopg2
#    import pandas as pd
#    from sqlalchemy import create_engine
#
#    engine = create_engine("postgresql+psycopg2://${var.admin_username}:${var.postgres_admin_password}@${var.postgres_fqdn}:5432/postgres?client_encoding=utf8")
#
#    hg19_df_pandas = hg19_df.toPandas()
#    hg19_df_pandas.to_sql('hg19', engine, index=False, if_exists='replace')
#
#    hg38_df_pandas = hg38_df.toPandas()
#    hg38_df_df_pandas.to_sql('hg38', engine, index=False, if_exists='replace')
#
#    EOT
#  )
#}
