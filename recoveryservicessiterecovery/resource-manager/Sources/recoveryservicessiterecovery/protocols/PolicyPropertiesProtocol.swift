// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// PolicyPropertiesProtocol is protection profile custom data details.
public protocol PolicyPropertiesProtocol : Codable {
     var friendlyName: String? { get set }
     var providerSpecificDetails: PolicyProviderSpecificDetailsProtocol? { get set }
}