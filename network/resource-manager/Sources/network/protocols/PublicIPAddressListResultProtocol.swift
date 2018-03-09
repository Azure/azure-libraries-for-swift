// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// PublicIPAddressListResultProtocol is response for ListPublicIpAddresses API service call.
public protocol PublicIPAddressListResultProtocol : Codable {
     var value: [PublicIPAddressProtocol?]? { get set }
     var _nextLink: String? { get set }
}