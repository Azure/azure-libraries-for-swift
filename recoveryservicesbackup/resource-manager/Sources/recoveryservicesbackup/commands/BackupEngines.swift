// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// BackupEngines is the open API 2.0 Specs for Azure RecoveryServices Backup service
import Foundation
import azureSwiftRuntime
extension Commands {
public struct BackupEngines {
    public static func Get(vaultName: String, resourceGroupName: String, subscriptionId: String, backupEngineName: String) -> BackupEnginesGet {
        return GetCommand(vaultName: vaultName, resourceGroupName: resourceGroupName, subscriptionId: subscriptionId, backupEngineName: backupEngineName)
    }
    public static func List(vaultName: String, resourceGroupName: String, subscriptionId: String) -> BackupEnginesList {
        return ListCommand(vaultName: vaultName, resourceGroupName: resourceGroupName, subscriptionId: subscriptionId)
    }
}
}