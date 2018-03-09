// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// ReplicationVaultHealth is the client for the ReplicationVaultHealth methods of the SiteRecoveryManagementClient
// service.
import Foundation
import azureSwiftRuntime
extension Commands {
public struct ReplicationVaultHealth {
    public static func Get(resourceName: String, resourceGroupName: String, subscriptionId: String) -> ReplicationVaultHealthGet {
        return GetCommand(resourceName: resourceName, resourceGroupName: resourceGroupName, subscriptionId: subscriptionId)
    }
    public static func Refresh(resourceName: String, resourceGroupName: String, subscriptionId: String) -> ReplicationVaultHealthRefresh {
        return RefreshCommand(resourceName: resourceName, resourceGroupName: resourceGroupName, subscriptionId: subscriptionId)
    }
}
}
