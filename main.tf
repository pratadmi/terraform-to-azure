terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}


provider "azurerm" {
  features {}
}


resource "azurerm_service_plan" "sndbx12_plan" {
  name                = "sandbox12-sp"
  resource_group_name = "Sandbox12"
  location            = "North Europe"
  os_type             = "Linux" 
  sku_name            = "F1"   
}

resource "azurerm_linux_web_app" "sndbx12_app" {
  name                = "dmipro"
  resource_group_name = azurerm_service_plan.sndbx12_plan.resource_group_name
  location            = azurerm_service_plan.sndbx12_plan.location
  service_plan_id     = azurerm_service_plan.sndbx12_plan.id

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"          = "https://index.docker.io"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = ""
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = ""
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  site_config {
    always_on = false
    application_stack {

      docker_image     = "httpd"
      docker_image_tag = "latest"


    }

  }



}