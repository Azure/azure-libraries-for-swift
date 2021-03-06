// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// IaasVMILRRegistrationRequestProtocol is restore files/folders from a backup copy of IaaS VM.
public protocol IaasVMILRRegistrationRequestProtocol : ILRRequestProtocol {
     var recoveryPointId: String? { get set }
     var virtualMachineId: String? { get set }
     var initiatorName: String? { get set }
     var renewExistingRegistration: Bool? { get set }
}
