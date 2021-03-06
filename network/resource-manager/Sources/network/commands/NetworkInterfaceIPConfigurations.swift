// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// NetworkInterfaceIPConfigurations is the network Client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct NetworkInterfaceIPConfigurations {
    public static func Get(resourceGroupName: String, networkInterfaceName: String, ipConfigurationName: String, subscriptionId: String) -> NetworkInterfaceIPConfigurationsGet {
        return GetCommand(resourceGroupName: resourceGroupName, networkInterfaceName: networkInterfaceName, ipConfigurationName: ipConfigurationName, subscriptionId: subscriptionId)
    }
    public static func List(resourceGroupName: String, networkInterfaceName: String, subscriptionId: String) -> NetworkInterfaceIPConfigurationsList {
        return ListCommand(resourceGroupName: resourceGroupName, networkInterfaceName: networkInterfaceName, subscriptionId: subscriptionId)
    }
}
}
