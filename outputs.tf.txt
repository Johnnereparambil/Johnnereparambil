output "storage_account_name" {
  value = azurerm_storage_account.data_storage.name
}

output "function_app_url" {
  value = azurerm_function_app.data_processing_function.default_hostname
}
