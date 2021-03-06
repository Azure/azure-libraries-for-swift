// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ScaleSettingsProtocol is at least one of manual or autoScale settings must be specified. Only one of manual or
// autoScale settings can be specified. If autoScale settings are specified, the system automatically scales the
// cluster up and down (within the supplied limits) based on the pending jobs on the cluster.
public protocol ScaleSettingsProtocol : Codable {
     var manual: ManualScaleSettingsProtocol? { get set }
     var autoScale: AutoScaleSettingsProtocol? { get set }
}
