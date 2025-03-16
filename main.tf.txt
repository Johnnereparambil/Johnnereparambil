provider "azurerm" {
  features {}
}

# Create a Resource Group
resource "azurerm_resource_group" "data_pipeline_rg" {
  name     = "DataPipelineResourceGroup"
  location = "West Europe"
}

# Create a Storage Account for data storage
resource "azurerm_storage_account" "data_storage" {
  name                     = "datapipelinedemo"
  resource_group_name      = azurerm_resource_group.data_pipeline_rg.name
  location                 = azurerm_resource_group.data_pipeline_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a Storage Container
resource "azurerm_storage_container" "data_container" {
  name                  = "raw-data"
  storage_account_name  = azurerm_storage_account.data_storage.name
  container_access_type = "private"
}

# Create an Azure Function App
resource "azurerm_app_service_plan" "app_service" {
  name                = "FunctionAppServicePlan"
  location            = azurerm_resource_group.data_pipeline_rg.location
  resource_group_name = azurerm_resource_group.data_pipeline_rg.name
  kind                = "FunctionApp"
  reserved            = true
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "data_processing_function" {
  name                = "DataProcessingFunction"
  location            = azurerm_resource_group.data_pipeline_rg.location
  resource_group_name = azurerm_resource_group.data_pipeline_rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service.id
  storage_account_name = azurerm_storage_account.data_storage.name
  storage_account_access_key = azurerm_storage_account.data_storage.primary_access_key
}
