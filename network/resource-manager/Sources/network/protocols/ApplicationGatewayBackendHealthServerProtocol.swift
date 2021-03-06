// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ApplicationGatewayBackendHealthServerProtocol is application gateway backendhealth http settings.
public protocol ApplicationGatewayBackendHealthServerProtocol : Codable {
     var address: String? { get set }
     var ipConfiguration: NetworkInterfaceIPConfigurationProtocol? { get set }
     var health: ApplicationGatewayBackendHealthServerHealthEnum? { get set }
}
