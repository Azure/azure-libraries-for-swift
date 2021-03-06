// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// VirtualMachineScaleSetListResultProtocol is the List Virtual Machine operation response.
public protocol VirtualMachineScaleSetListResultProtocol : Codable {
     var value: [VirtualMachineScaleSetProtocol] { get set }
     var _nextLink: String? { get set }
}
