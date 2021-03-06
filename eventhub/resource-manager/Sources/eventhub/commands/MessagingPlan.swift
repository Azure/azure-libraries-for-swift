// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// MessagingPlan is the azure Event Hubs client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct MessagingPlan {
    public static func Get(resourceGroupName: String, namespaceName: String, subscriptionId: String) -> MessagingPlanGet {
        return GetCommand(resourceGroupName: resourceGroupName, namespaceName: namespaceName, subscriptionId: subscriptionId)
    }
}
}
