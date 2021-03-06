// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// IaasVMRestoreRequestProtocol is iaaS VM workload-specific restore.
public protocol IaasVMRestoreRequestProtocol : RestoreRequestProtocol {
     var recoveryPointId: String? { get set }
     var recoveryType: RecoveryTypeEnum? { get set }
     var sourceResourceId: String? { get set }
     var targetVirtualMachineId: String? { get set }
     var targetResourceGroupId: String? { get set }
     var storageAccountId: String? { get set }
     var virtualNetworkId: String? { get set }
     var subnetId: String? { get set }
     var targetDomainNameId: String? { get set }
     var region: String? { get set }
     var affinityGroup: String? { get set }
     var createNewCloudService: Bool? { get set }
     var originalStorageAccountOption: Bool? { get set }
     var encryptionDetails: EncryptionDetailsProtocol? { get set }
}
