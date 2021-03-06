// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// CheckNameAvailabilityRequestProtocol is a request to check whether the specified name for a resource is available.
public protocol CheckNameAvailabilityRequestProtocol : Codable {
     var name: String { get set }
     var type: String { get set }
}
