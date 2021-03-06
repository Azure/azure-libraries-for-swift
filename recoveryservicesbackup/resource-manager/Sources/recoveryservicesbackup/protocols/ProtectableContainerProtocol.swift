// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ProtectableContainerProtocol is protectable Container Class.
public protocol ProtectableContainerProtocol : Codable {
     var friendlyName: String? { get set }
     var backupManagementType: BackupManagementTypeEnum? { get set }
     var healthStatus: String? { get set }
     var containerId: String? { get set }
}
