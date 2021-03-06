// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// SecurityRulePropertiesFormatProtocol is security rule resource.
public protocol SecurityRulePropertiesFormatProtocol : Codable {
     var description: String? { get set }
     var _protocol: SecurityRuleProtocolEnum { get set }
     var sourcePortRange: String? { get set }
     var destinationPortRange: String? { get set }
     var sourceAddressPrefix: String? { get set }
     var sourceAddressPrefixes: [String]? { get set }
     var sourceApplicationSecurityGroups: [ApplicationSecurityGroupProtocol?]? { get set }
     var destinationAddressPrefix: String? { get set }
     var destinationAddressPrefixes: [String]? { get set }
     var destinationApplicationSecurityGroups: [ApplicationSecurityGroupProtocol?]? { get set }
     var sourcePortRanges: [String]? { get set }
     var destinationPortRanges: [String]? { get set }
     var access: SecurityRuleAccessEnum { get set }
     var priority: Int32? { get set }
     var direction: SecurityRuleDirectionEnum { get set }
     var provisioningState: String? { get set }
}
