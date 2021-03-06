// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// BaselineProtocol is the baseline values for a single sensitivity value.
public protocol BaselineProtocol : Codable {
     var sensitivity: SensitivityEnum { get set }
     var lowThresholds: [Double] { get set }
     var highThresholds: [Double] { get set }
}
