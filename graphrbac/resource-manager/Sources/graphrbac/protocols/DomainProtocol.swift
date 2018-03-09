// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// DomainProtocol is active Directory Domain information.
public protocol DomainProtocol : Codable {
     var additionalProperties: [String:[String: String?]]? { get set }
     var authenticationType: String? { get set }
     var isDefault: Bool? { get set }
     var isVerified: Bool? { get set }
     var name: String { get set }
}