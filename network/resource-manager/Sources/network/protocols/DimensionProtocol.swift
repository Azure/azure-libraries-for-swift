// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// DimensionProtocol is dimension of the metric.
public protocol DimensionProtocol : Codable {
     var name: String? { get set }
     var displayName: String? { get set }
     var internalName: String? { get set }
}