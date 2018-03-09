// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ProcessServerProtocol is details of the Process Server.
public protocol ProcessServerProtocol : Codable {
     var friendlyName: String? { get set }
     var id: String? { get set }
     var ipAddress: String? { get set }
     var osType: String? { get set }
     var agentVersion: String? { get set }
     var lastHeartbeat: Date? { get set }
     var versionStatus: String? { get set }
     var mobilityServiceUpdates: [MobilityServiceUpdateProtocol?]? { get set }
     var hostId: String? { get set }
     var machineCount: String? { get set }
     var replicationPairCount: String? { get set }
     var systemLoad: String? { get set }
     var systemLoadStatus: String? { get set }
     var cpuLoad: String? { get set }
     var cpuLoadStatus: String? { get set }
     var totalMemoryInBytes: Int64? { get set }
     var availableMemoryInBytes: Int64? { get set }
     var memoryUsageStatus: String? { get set }
     var totalSpaceInBytes: Int64? { get set }
     var availableSpaceInBytes: Int64? { get set }
     var spaceUsageStatus: String? { get set }
     var psServiceStatus: String? { get set }
     var sslCertExpiryDate: Date? { get set }
     var sslCertExpiryRemainingDays: Int32? { get set }
     var osVersion: String? { get set }
     var healthErrors: [HealthErrorProtocol?]? { get set }
     var agentExpiryDate: Date? { get set }
     var agentVersionDetails: VersionDetailsProtocol? { get set }
}