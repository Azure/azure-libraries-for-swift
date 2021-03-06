// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// SubnetProtocol is subnets of the network.
public protocol SubnetProtocol : Codable {
     var name: String? { get set }
     var friendlyName: String? { get set }
     var addressList: [String]? { get set }
}
