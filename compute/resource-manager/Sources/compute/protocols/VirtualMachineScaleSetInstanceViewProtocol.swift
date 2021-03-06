// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// VirtualMachineScaleSetInstanceViewProtocol is the instance view of a virtual machine scale set.
public protocol VirtualMachineScaleSetInstanceViewProtocol : Codable {
     var virtualMachine: VirtualMachineScaleSetInstanceViewStatusesSummaryProtocol? { get set }
     var extensions: [VirtualMachineScaleSetVMExtensionsSummaryProtocol?]? { get set }
     var statuses: [InstanceViewStatusProtocol?]? { get set }
}
