// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// JobProtocol is defines workload agnostic properties for a job.
public protocol JobProtocol : Codable {
     var entityFriendlyName: String? { get set }
     var backupManagementType: BackupManagementTypeEnum? { get set }
     var operation: String? { get set }
     var status: String? { get set }
     var startTime: Date? { get set }
     var endTime: Date? { get set }
     var activityId: String? { get set }
}