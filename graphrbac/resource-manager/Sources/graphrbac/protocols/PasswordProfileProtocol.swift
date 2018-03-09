// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// PasswordProfileProtocol is the password profile associated with a user.
public protocol PasswordProfileProtocol : Codable {
     var additionalProperties: [String:[String: String?]]? { get set }
     var password: String { get set }
     var forceChangePasswordNextLogin: Bool? { get set }
}