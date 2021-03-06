// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// AzureFileshareProtectedItemProtocol is azure File Share workload-specific backup item.
public protocol AzureFileshareProtectedItemProtocol : ProtectedItemProtocol {
     var friendlyName: String? { get set }
     var protectionStatus: String? { get set }
     var protectionState: ProtectionStateEnum? { get set }
     var healthStatus: HealthStatusEnum? { get set }
     var lastBackupStatus: String? { get set }
     var lastBackupTime: Date? { get set }
     var extendedInfo: AzureFileshareProtectedItemExtendedInfoProtocol? { get set }
}
