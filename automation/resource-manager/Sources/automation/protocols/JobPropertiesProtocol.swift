// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// JobPropertiesProtocol is definition of job properties.
public protocol JobPropertiesProtocol : Codable {
     var runbook: RunbookAssociationPropertyProtocol? { get set }
     var startedBy: String? { get set }
     var runOn: String? { get set }
     var jobId: String? { get set }
     var creationTime: Date? { get set }
     var status: JobStatusEnum? { get set }
     var statusDetails: String? { get set }
     var startTime: Date? { get set }
     var endTime: Date? { get set }
     var exception: String? { get set }
     var lastModifiedTime: Date? { get set }
     var lastStatusModifiedTime: Date? { get set }
     var parameters: [String:String]? { get set }
     var provisioningState: JobProvisioningStatePropertyProtocol? { get set }
}
