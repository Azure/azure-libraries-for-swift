// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// Profiles is the the Azure Customer Insights management API provides a RESTful set of web services that interact with
// Azure Customer Insights service to manage your resources. The API has entities that capture the relationship between
// an end user and the Azure Customer Insights service.
import Foundation
import azureSwiftRuntime
extension Commands {
public struct Profiles {
    public static func CreateOrUpdate(resourceGroupName: String, hubName: String, profileName: String, subscriptionId: String, parameters: ProfileResourceFormatProtocol) -> ProfilesCreateOrUpdate {
        return CreateOrUpdateCommand(resourceGroupName: resourceGroupName, hubName: hubName, profileName: profileName, subscriptionId: subscriptionId, parameters: parameters)
    }
    public static func Delete(resourceGroupName: String, hubName: String, profileName: String, subscriptionId: String) -> ProfilesDelete {
        return DeleteCommand(resourceGroupName: resourceGroupName, hubName: hubName, profileName: profileName, subscriptionId: subscriptionId)
    }
    public static func Get(resourceGroupName: String, hubName: String, profileName: String, subscriptionId: String) -> ProfilesGet {
        return GetCommand(resourceGroupName: resourceGroupName, hubName: hubName, profileName: profileName, subscriptionId: subscriptionId)
    }
    public static func GetEnrichingKpis(resourceGroupName: String, hubName: String, profileName: String, subscriptionId: String) -> ProfilesGetEnrichingKpis {
        return GetEnrichingKpisCommand(resourceGroupName: resourceGroupName, hubName: hubName, profileName: profileName, subscriptionId: subscriptionId)
    }
    public static func ListByHub(resourceGroupName: String, hubName: String, subscriptionId: String) -> ProfilesListByHub {
        return ListByHubCommand(resourceGroupName: resourceGroupName, hubName: hubName, subscriptionId: subscriptionId)
    }
}
}