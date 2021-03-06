// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// ActionGroups is the monitor Management Client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct ActionGroups {
    public static func CreateOrUpdate(resourceGroupName: String, actionGroupName: String, subscriptionId: String, actionGroup: ActionGroupResourceProtocol) -> ActionGroupsCreateOrUpdate {
        return CreateOrUpdateCommand(resourceGroupName: resourceGroupName, actionGroupName: actionGroupName, subscriptionId: subscriptionId, actionGroup: actionGroup)
    }
    public static func Delete(resourceGroupName: String, actionGroupName: String, subscriptionId: String) -> ActionGroupsDelete {
        return DeleteCommand(resourceGroupName: resourceGroupName, actionGroupName: actionGroupName, subscriptionId: subscriptionId)
    }
    public static func EnableReceiver(resourceGroupName: String, actionGroupName: String, subscriptionId: String, enableRequest: EnableRequestProtocol) -> ActionGroupsEnableReceiver {
        return EnableReceiverCommand(resourceGroupName: resourceGroupName, actionGroupName: actionGroupName, subscriptionId: subscriptionId, enableRequest: enableRequest)
    }
    public static func Get(resourceGroupName: String, actionGroupName: String, subscriptionId: String) -> ActionGroupsGet {
        return GetCommand(resourceGroupName: resourceGroupName, actionGroupName: actionGroupName, subscriptionId: subscriptionId)
    }
    public static func ListByResourceGroup(resourceGroupName: String, subscriptionId: String) -> ActionGroupsListByResourceGroup {
        return ListByResourceGroupCommand(resourceGroupName: resourceGroupName, subscriptionId: subscriptionId)
    }
    public static func ListBySubscriptionId(subscriptionId: String) -> ActionGroupsListBySubscriptionId {
        return ListBySubscriptionIdCommand(subscriptionId: subscriptionId)
    }
    public static func Update(subscriptionId: String, resourceGroupName: String, actionGroupName: String, actionGroupPatch: ActionGroupPatchBodyProtocol) -> ActionGroupsUpdate {
        return UpdateCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, actionGroupName: actionGroupName, actionGroupPatch: actionGroupPatch)
    }
}
}
