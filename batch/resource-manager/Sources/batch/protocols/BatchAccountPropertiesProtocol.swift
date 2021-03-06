// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// BatchAccountPropertiesProtocol is account specific properties.
public protocol BatchAccountPropertiesProtocol : Codable {
     var accountEndpoint: String? { get set }
     var provisioningState: ProvisioningStateEnum? { get set }
     var poolAllocationMode: PoolAllocationModeEnum? { get set }
     var keyVaultReference: KeyVaultReferenceProtocol? { get set }
     var autoStorage: AutoStoragePropertiesProtocol? { get set }
     var dedicatedCoreQuota: Int32? { get set }
     var lowPriorityCoreQuota: Int32? { get set }
     var poolQuota: Int32? { get set }
     var activeJobAndJobScheduleQuota: Int32? { get set }
}
