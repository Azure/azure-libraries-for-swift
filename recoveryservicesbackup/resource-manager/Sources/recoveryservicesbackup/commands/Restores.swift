// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// Restores is the open API 2.0 Specs for Azure RecoveryServices Backup service
import Foundation
import azureSwiftRuntime
extension Commands {
public struct Restores {
    public static func Trigger(vaultName: String, resourceGroupName: String, subscriptionId: String, fabricName: String, containerName: String, protectedItemName: String, recoveryPointId: String, parameters: RestoreRequestResourceProtocol) -> RestoresTrigger {
        return TriggerCommand(vaultName: vaultName, resourceGroupName: resourceGroupName, subscriptionId: subscriptionId, fabricName: fabricName, containerName: containerName, protectedItemName: protectedItemName, recoveryPointId: recoveryPointId, parameters: parameters)
    }
}
}
