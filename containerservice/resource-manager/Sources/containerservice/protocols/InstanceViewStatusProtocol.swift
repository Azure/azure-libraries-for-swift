// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// InstanceViewStatusProtocol is instance view status.
public protocol InstanceViewStatusProtocol : Codable {
     var code: String? { get set }
     var level: StatusLevelTypesEnum? { get set }
     var displayStatus: String? { get set }
     var message: String? { get set }
     var time: Date? { get set }
}