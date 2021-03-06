// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ProtectionIntentProtocol is base class for backup ProtectionIntent.
public protocol ProtectionIntentProtocol : Codable {
     var backupManagementType: BackupManagementTypeEnum? { get set }
     var sourceResourceId: String? { get set }
     var itemId: String? { get set }
     var policyId: String? { get set }
     var protectionState: ProtectionStatusEnum? { get set }
}
