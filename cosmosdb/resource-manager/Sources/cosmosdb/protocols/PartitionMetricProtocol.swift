// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// PartitionMetricProtocol is the metric values for a single partition.
public protocol PartitionMetricProtocol : MetricProtocol {
     var partitionId: String? { get set }
     var partitionKeyRangeId: String? { get set }
}
