// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// NetworkMappingPropertiesProtocol is network Mapping Properties.
public protocol NetworkMappingPropertiesProtocol : Codable {
     var state: String? { get set }
     var primaryNetworkFriendlyName: String? { get set }
     var primaryNetworkId: String? { get set }
     var primaryFabricFriendlyName: String? { get set }
     var recoveryNetworkFriendlyName: String? { get set }
     var recoveryNetworkId: String? { get set }
     var recoveryFabricArmId: String? { get set }
     var recoveryFabricFriendlyName: String? { get set }
     var fabricSpecificSettings: NetworkMappingFabricSpecificSettingsProtocol? { get set }
}