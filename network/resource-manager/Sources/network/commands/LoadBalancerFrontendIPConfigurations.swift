// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// LoadBalancerFrontendIPConfigurations is the network Client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct LoadBalancerFrontendIPConfigurations {
    public static func Get(resourceGroupName: String, loadBalancerName: String, frontendIPConfigurationName: String, subscriptionId: String) -> LoadBalancerFrontendIPConfigurationsGet {
        return GetCommand(resourceGroupName: resourceGroupName, loadBalancerName: loadBalancerName, frontendIPConfigurationName: frontendIPConfigurationName, subscriptionId: subscriptionId)
    }
    public static func List(resourceGroupName: String, loadBalancerName: String, subscriptionId: String) -> LoadBalancerFrontendIPConfigurationsList {
        return ListCommand(resourceGroupName: resourceGroupName, loadBalancerName: loadBalancerName, subscriptionId: subscriptionId)
    }
}
}