import logging
import azure.functions as func
from azure.storage.blob import BlobServiceClient
import json

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info("Processing data and storing in Azure Blob Storage")

    # Azure Storage connection details
    connection_string = "your_storage_connection_string"
    container_name = "raw-data"
    blob_name = "processed_data.json"

    blob_service_client = BlobServiceClient.from_connection_string(connection_string)
    blob_client = blob_service_client.get_blob_client(container=container_name, blob=blob_name)

    # Process data (Example transformation)
    transformed_data = json.dumps({"message": "Hello from Azure Function!"})

    # Upload processed data to Azure Blob Storage
    blob_client.upload_blob(transformed_data, overwrite=True)

    return func.HttpResponse("Data successfully processed and stored!", status_code=200)
