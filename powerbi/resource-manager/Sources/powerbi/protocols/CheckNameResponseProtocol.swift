// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// CheckNameResponseProtocol is
public protocol CheckNameResponseProtocol : Codable {
     var nameAvailable: Bool? { get set }
     var reason: CheckNameReasonEnum? { get set }
     var message: String? { get set }
}
