// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// NetworkConfigurationProtocol is the network configuration for a pool.
public protocol NetworkConfigurationProtocol : Codable {
     var subnetId: String? { get set }
     var endpointConfiguration: PoolEndpointConfigurationProtocol? { get set }
}