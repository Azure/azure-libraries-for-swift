// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// AuthorizationPolicyProtocol is the authorization policy.
public protocol AuthorizationPolicyProtocol : Codable {
     var policyName: String? { get set }
     var permissions: [PermissionTypesEnum] { get set }
     var primaryKey: String? { get set }
     var secondaryKey: String? { get set }
}