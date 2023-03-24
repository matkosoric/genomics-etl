data "databricks_current_user" "me" {
  depends_on = [azurerm_databricks_workspace.db_workspace]
}

#data "databricks_spark_version" "latest" {
#  long_term_support = true
#  depends_on        = [azurerm_databricks_workspace.db_workspace]
#}

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

    EOT
  )
}

#resource "databricks_job" "this" {
#  name = "Genomics (${data.databricks_current_user.me.alphanumeric})"
#
#  new_cluster {
#    num_workers   = 1
#    spark_version = data.databricks_spark_version.latest.id
#    node_type_id  = data.databricks_node_type.smallest.id
#  }
#
#  notebook_task {
#    notebook_path = databricks_notebook.this.path
#  }
#}

