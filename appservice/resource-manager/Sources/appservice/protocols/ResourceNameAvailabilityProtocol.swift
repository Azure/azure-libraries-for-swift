// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ResourceNameAvailabilityProtocol is information regarding availbility of a resource name.
public protocol ResourceNameAvailabilityProtocol : Codable {
     var nameAvailable: Bool? { get set }
     var reason: InAvailabilityReasonTypeEnum? { get set }
     var message: String? { get set }
}
