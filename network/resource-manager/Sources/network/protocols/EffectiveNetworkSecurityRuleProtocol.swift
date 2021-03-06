// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// EffectiveNetworkSecurityRuleProtocol is effective network security rules.
public protocol EffectiveNetworkSecurityRuleProtocol : Codable {
     var name: String? { get set }
     var _protocol: EffectiveSecurityRuleProtocolEnum? { get set }
     var sourcePortRange: String? { get set }
     var destinationPortRange: String? { get set }
     var sourcePortRanges: [String]? { get set }
     var destinationPortRanges: [String]? { get set }
     var sourceAddressPrefix: String? { get set }
     var destinationAddressPrefix: String? { get set }
     var sourceAddressPrefixes: [String]? { get set }
     var destinationAddressPrefixes: [String]? { get set }
     var expandedSourceAddressPrefix: [String]? { get set }
     var expandedDestinationAddressPrefix: [String]? { get set }
     var access: SecurityRuleAccessEnum? { get set }
     var priority: Int32? { get set }
     var direction: SecurityRuleDirectionEnum? { get set }
}
