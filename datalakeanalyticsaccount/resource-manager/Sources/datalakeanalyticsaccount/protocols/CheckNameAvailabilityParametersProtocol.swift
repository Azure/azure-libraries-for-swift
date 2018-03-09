// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// CheckNameAvailabilityParametersProtocol is data Lake Analytics account name availability check parameters.
public protocol CheckNameAvailabilityParametersProtocol : Codable {
     var name: String { get set }
     var type: String { get set }
}