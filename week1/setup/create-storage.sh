#!/bin/bash

RESOURCE_GROUP="ResourceGroup1"
LOCATION="uksouth"
STORAGE_ACCOUNT="datalaked700chgptweek1"

az group create --name $RESOURCE_GROUP --location $LOCATION
az storage account create \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS

echo "Storage account created: $STORAGE_ACCOUNT"
