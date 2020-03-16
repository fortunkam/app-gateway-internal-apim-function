#!/bin/bash
PREFIX=apimmf
RG=$PREFIX-rg
LOC=uksouth
APIM=$PREFIX-apim
PUBEMAIL="bob@test.com"
PUBNAME="PublisherName"
VNETNAME=$PREFIX-vnet
APPPLAN=$PREFIX-plan
FUNC=$PREFIX-funcs
STORAGE=$(echo $PREFIX)store

az group create -n $RG --location $LOC

az network vnet create -g $RG -n $VNETNAME

az network vnet subnet create -g $RG --name functions --vnet-name $VNETNAME --address-prefixes 10.0.0.0/24

az network vnet subnet create -g $RG --name apim --vnet-name $VNETNAME --address-prefixes 10.0.1.0/24

az appservice plan create -g $RG -n $APPPLAN \
    --sku S1
    
az storage account create -n $STORAGE -g $RG

az functionapp create \
    --name $FUNC \
    -g $RG \
    --storage-account $STORAGE \
    --plan $APPPLAN \
    --runtime dotnet \
    --runtime-version 2

az apim create \
    -n $APIM \
    -g $RG \
    --publisher-email $PUBEMAIL \
    --publisher-name $PUBNAME \
    --sku-name Developer \
    --no-wait






