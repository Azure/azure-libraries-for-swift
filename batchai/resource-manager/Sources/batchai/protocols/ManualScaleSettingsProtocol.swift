// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ManualScaleSettingsProtocol is manual scale settings for the cluster.
public protocol ManualScaleSettingsProtocol : Codable {
     var targetNodeCount: Int32 { get set }
     var nodeDeallocationOption: DeallocationOptionEnum? { get set }
}
