#data "databricks_node_type" "smallest" {
#  local_disk = true
#}

data "databricks_spark_version" "latest_genomics_runtimes" {
  genomics          = true
  long_term_support = true
  depends_on        = [azurerm_databricks_workspace.db_workspace]
}

resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = "${var.prefix}-cluster"
  spark_version           = data.databricks_spark_version.latest_genomics_runtimes.id
  node_type_id            = "Standard_DS3_v2" # data.databricks_node_type.smallest.id
  autotermination_minutes = 30
  autoscale {
    min_workers = 1
    max_workers = 5
  }
  spark_conf = {
    "spark.databricks.io.cache.enabled" : true,
    "spark.databricks.io.cache.maxDiskUsage" : "50g",
    "spark.databricks.io.cache.maxMetaDataCache" : "1g"
  }

  depends_on = [
    azurerm_databricks_workspace.db_workspace
  ]

}

#resource "databricks_library" "gatk" {
#  cluster_id = databricks_cluster.shared_autoscaling.id
#  maven {
#    coordinates = "org.broadinstitute:gatk:4.4.0.0"
#  }
#}