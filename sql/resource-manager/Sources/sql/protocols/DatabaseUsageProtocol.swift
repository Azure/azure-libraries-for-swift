// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// DatabaseUsageProtocol is the database usages.
public protocol DatabaseUsageProtocol : Codable {
     var name: String? { get set }
     var resourceName: String? { get set }
     var displayName: String? { get set }
     var currentValue: Double? { get set }
     var limit: Double? { get set }
     var unit: String? { get set }
     var nextResetTime: Date? { get set }
}
