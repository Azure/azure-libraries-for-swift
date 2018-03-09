// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ResourceMetricDefinitionPropertiesProtocol is resourceMetricDefinition resource specific properties
public protocol ResourceMetricDefinitionPropertiesProtocol : Codable {
     var name: ResourceMetricNameProtocol? { get set }
     var unit: String? { get set }
     var primaryAggregationType: String? { get set }
     var metricAvailabilities: [ResourceMetricAvailabilityProtocol?]? { get set }
     var resourceUri: String? { get set }
     var id: String? { get set }
     var properties: [String:String]? { get set }
}