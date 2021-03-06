// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// Provider is the webSite Management Client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct Provider {
    public static func GetAvailableStacks() -> ProviderGetAvailableStacks {
        return GetAvailableStacksCommand()
    }
    public static func GetAvailableStacksOnPrem(subscriptionId: String) -> ProviderGetAvailableStacksOnPrem {
        return GetAvailableStacksOnPremCommand(subscriptionId: subscriptionId)
    }
    public static func ListOperations() -> ProviderListOperations {
        return ListOperationsCommand()
    }
}
}
