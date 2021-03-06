// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// VirtualMachineScaleSetUpdateProtocol is describes a Virtual Machine Scale Set.
public protocol VirtualMachineScaleSetUpdateProtocol : UpdateResourceProtocol {
     var sku: SkuProtocol? { get set }
     var plan: PlanProtocol? { get set }
     var properties: VirtualMachineScaleSetUpdatePropertiesProtocol? { get set }
     var identity: VirtualMachineScaleSetIdentityProtocol? { get set }
}
