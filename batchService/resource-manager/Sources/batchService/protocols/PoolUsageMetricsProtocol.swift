// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// PoolUsageMetricsProtocol is
public protocol PoolUsageMetricsProtocol : Codable {
     var poolId: String { get set }
     var startTime: Date { get set }
     var endTime: Date { get set }
     var vmSize: String { get set }
     var totalCoreHours: Double { get set }
     var dataIngressGiB: Double { get set }
     var dataEgressGiB: Double { get set }
}