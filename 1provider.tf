#version block 
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.56.0"
    }
  }
}


# provider block 
provider "azurerm" {
  features {}
    # configuration options
    client_id = "Client_ID"
    client_secret = "client_secret"
    tenant_id = "tenant_id"
    subscription_id = "Subscription_ID"
}

/*
# backend block 
terraform {
  backend "azurerm" {
    access_key = "Access_key_from_storage_account"
    storage_account_name = "Storage_account_name"
    container_name = "Containername"
    key = "prod.terraform.tfstate"
  }
}
*/