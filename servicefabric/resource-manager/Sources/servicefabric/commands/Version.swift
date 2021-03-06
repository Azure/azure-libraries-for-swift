// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// Version is the azure Service Fabric Resource Provider API Client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct Version {
    public static func Delete(subscriptionId: String, resourceGroupName: String, clusterName: String, applicationTypeName: String, version: String) -> VersionDelete {
        return DeleteCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, clusterName: clusterName, applicationTypeName: applicationTypeName, version: version)
    }
    public static func Get(subscriptionId: String, resourceGroupName: String, clusterName: String, applicationTypeName: String, version: String) -> VersionGet {
        return GetCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, clusterName: clusterName, applicationTypeName: applicationTypeName, version: version)
    }
    public static func List(subscriptionId: String, resourceGroupName: String, clusterName: String, applicationTypeName: String) -> VersionList {
        return ListCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, clusterName: clusterName, applicationTypeName: applicationTypeName)
    }
    public static func Put(subscriptionId: String, resourceGroupName: String, clusterName: String, applicationTypeName: String, version: String, parameters: VersionResourceProtocol) -> VersionPut {
        return PutCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, clusterName: clusterName, applicationTypeName: applicationTypeName, version: version, parameters: parameters)
    }
}
}
