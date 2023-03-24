data "databricks_current_user" "me" {
  depends_on = [azurerm_databricks_workspace.db_workspace]
}

resource "databricks_notebook" "this" {
  path           = "${data.databricks_current_user.me.home}/Genomics-ETL"
  language       = "PYTHON"
  content_base64 = base64encode(<<-EOT

    containerName = '${var.container_name_landing_raw_data}'
    storageAccountName = '${var.storage_account_name}'
    sas_token = '${var.landing_container_sas_token}'
    mount_point = f"/mnt/{containerName}"

    config = {
        f"fs.azure.account.auth.type.{storageAccountName}.dfs.core.windows.net": "SAS",
        f"fs.azure.sas.token.provider.type.{storageAccountName}.dfs.core.windows.net": "org.apache.hadoop.fs.azurebfs.sas.FixedSASTokenProvider",
        f"fs.azure.sas.{containerName}.{storageAccountName}.blob.core.windows.net": sas_token
    }


    dbutils.fs.mount(source = f"wasbs://{containerName}@{storageAccountName}.blob.core.windows.net/",
                     mount_point = mount_point,
                     extra_configs = config
                    )

    # COMMAND ----------
    dbutils.fs.ls("/mnt/1-landing-raw-data")

    # COMMAND ----------
    path ="/mnt/1-landing-raw-data/hg19/hybrid/hg19.hybrid.vcf.gz"
    df = spark.read.format("vcf").load(path)

    # COMMAND ----------
    display(df)

    # COMMAND ----------
    mode = "overwrite"
    url = "jdbc:postgresql://'${var.postgres_fqdn}':5432/postgres"
    properties = {"user": "'${var.admin_username}'","password": "'${var.postgres_admin_password}'","driver": "org.postgresql.Driver"}

    df.write.jdbc(url=url, table="hg19", mode=mode, properties=properties)


    EOT
  )
}
