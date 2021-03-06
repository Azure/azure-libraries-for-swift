// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// VirtualMachineScaleSetNetworkConfigurationProtocol is describes a virtual machine scale set network profile's
// network configurations.
public protocol VirtualMachineScaleSetNetworkConfigurationProtocol : SubResourceProtocol {
     var name: String { get set }
     var properties: VirtualMachineScaleSetNetworkConfigurationPropertiesProtocol? { get set }
}
