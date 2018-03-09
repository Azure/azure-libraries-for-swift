// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// VirtualMachineScaleSetRollingUpgrades is the compute Client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct VirtualMachineScaleSetRollingUpgrades {
    public static func Cancel(resourceGroupName: String, vmScaleSetName: String, subscriptionId: String) -> VirtualMachineScaleSetRollingUpgradesCancel {
        return CancelCommand(resourceGroupName: resourceGroupName, vmScaleSetName: vmScaleSetName, subscriptionId: subscriptionId)
    }
    public static func GetLatest(resourceGroupName: String, vmScaleSetName: String, subscriptionId: String) -> VirtualMachineScaleSetRollingUpgradesGetLatest {
        return GetLatestCommand(resourceGroupName: resourceGroupName, vmScaleSetName: vmScaleSetName, subscriptionId: subscriptionId)
    }
    public static func StartOSUpgrade(resourceGroupName: String, vmScaleSetName: String, subscriptionId: String) -> VirtualMachineScaleSetRollingUpgradesStartOSUpgrade {
        return StartOSUpgradeCommand(resourceGroupName: resourceGroupName, vmScaleSetName: vmScaleSetName, subscriptionId: subscriptionId)
    }
}
}